<?php
/* @var Swoole\Http\Response $response */

try {
	$pdo = new PDO('mysql:dbname=wbm;host=127.0.0.1', 'wbm', 'wbm');
} catch (Exception $e) {
    $response->setStatusCode(500);
    $response->end(file_get_contents('pages/errors/500.html'));

    echo 'Cannot connect to MySQL server!' . PHP_EOL;
    echo 'Exception: ' . $e->getMessage() . PHP_EOL;
    exit();
}
