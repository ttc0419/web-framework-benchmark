<?php
use Swoole\Http\Server;
use Swoole\Http\Request;
use Swoole\Http\Response;

const ADDRESS = '127.0.0.1';
const PORT = 8080;
define("SESSION_PATH", sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'swoole-session');

Co::set(['hook_flags' => SWOOLE_HOOK_ALL]);
$server = new Server(ADDRESS, PORT, SWOOLE_BASE);
$server->set([
    'enable_coroutine' => true,
    'enable_static_handler' => false,
    'document_root' =>  __DIR__ . DIRECTORY_SEPARATOR . 'public'
]);

if (!is_dir(SESSION_PATH)) {
	unlink(SESSION_PATH);
	if (!mkdir(SESSION_PATH)) {
		echo "Cannot create session folder!" . PHP_EOL;
		return;
	}
}

$server->on('start', function () {
    echo "Server started on http://" . ADDRESS . ':' . PORT . PHP_EOL;
	echo "Session data is stored in " . SESSION_PATH . PHP_EOL;
});

$server->on('request', function (Request $request, Response $response) {
    if ($request->server['request_uri'] === '/') {
        $response->setStatusCode(302);
        $response->header('Location', '/record/index.php');
        $response->end();
    } else if (is_file("pages{$request->server['request_uri']}")) {
        require "pages{$request->server['request_uri']}";
    } else {
        $response->setStatusCode(404);
        $response->header('Content-Type', 'text/html; charset=utf-8');
        $response->end(file_get_contents("pages/errors/404.html"));
    }
});

$server->start();
