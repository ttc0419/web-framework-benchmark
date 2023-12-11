<?php
/**
 * @var array $session
 * @var Swoole\Http\Request $request
 */

require 'libs/load-session.php';

if (empty($session['csrf'])) {
    try {
        $session['csrf'] = base64_encode(random_bytes(15));
        file_put_contents(SESSION_PATH . DIRECTORY_SEPARATOR . $request->cookie['session_id'], json_encode($session));
    } catch (Exception $e) {
        $response->setStatusCode(500);
        $response->end(file_get_contents('pages/errors/500.html'));

        echo 'Cannot generate random values!' . PHP_EOL;
        echo 'Exception: ' . $e->getMessage() . PHP_EOL;
        exit();
    }
}

$csrf = $session['csrf'];
