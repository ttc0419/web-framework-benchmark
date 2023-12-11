<?php
try {
    $pdo = new PDO('mysql:dbname=wbm;host=127.0.0.1', 'wbm', 'wbm');
} catch (Exception $e) {
    http_response_code(500);
    readfile('../errors/500.html');
	echo $e->getMessage();
    exit();
}
