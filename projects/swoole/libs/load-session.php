<?php
/**
 * @var Swoole\Http\Request $request
 * @var Swoole\Http\Response $response
 */

if (!isset($request->cookie['session_id'])) {
    try {
        $request->cookie['session_id'] = session_create_id();
        $response->setCookie('session_id', $request->cookie['session_id'], 3600);
        touch(SESSION_PATH . DIRECTORY_SEPARATOR . $request->cookie['session_id']);
    } catch (Exception $e) {
        $response->setStatusCode(500);
        $response->end(file_get_contents('pages/errors/500.html'));

        echo 'Cannot generate random values!' . PHP_EOL;
        echo 'Exception: ' . $e->getMessage() . PHP_EOL;
        exit();
    }
}

$session = json_decode(file_get_contents(SESSION_PATH . DIRECTORY_SEPARATOR . $request->cookie['session_id']), true);
