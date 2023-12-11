<?php
/**
 * @var array $session
 * @var Swoole\Http\Request $request
 * @var Swoole\Http\Response $response
 */

require 'libs/load-session.php';

if (!hash_equals($session['csrf'], $request->post['csrf'])) {
    $response->setStatusCode(403);
    $response->end();
    exit();
}
