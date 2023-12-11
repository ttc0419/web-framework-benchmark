<?php
session_start();

if (empty($_SESSION['csrf'])) {
    try {
	    $_SESSION['csrf'] = base64_encode(random_bytes(15));
    } catch (Exception $e) {
        http_response_code(500);
        readfile('../errors/500.html');

        echo 'Cannot generate random values!' . PHP_EOL;
        echo 'Exception: ' . $e->getMessage() . PHP_EOL;
        exit();
    }
}
