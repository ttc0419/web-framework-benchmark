<?php
/**
 * @var Swoole\Http\Request $request
 * @var Swoole\Http\Response $response
 */

if ($request->server['request_method'] !== 'POST') {
    $response->setStatusCode(405);
    return;
}

require 'libs/verify-csrf.php';

echo "Deleting record {$request->post['id']}..." . PHP_EOL;
$response->setStatusCode(302);
$response->header('Location', '/record/index.php');
$response->end();
