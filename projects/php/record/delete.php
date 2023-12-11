<?php
if ($_SERVER['request_method'] !== 'POST') {
    http_response_code(405);
    return;
}

require 'libs/verify-csrf.php';

echo "Deleting record {$_POST['id']}..." . PHP_EOL;
http_response_code(302);
header('Location: /record/index.php');
