<?php
session_start();

if (!hash_equals($_SESSION['csrf'], $_POST['csrf'])) {
    http_response_code(403);
    exit();
}
