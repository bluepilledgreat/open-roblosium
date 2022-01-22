<?php
require_once($_SERVER["STATIC"]."/settings.php");

$conn;
try {
    $conn = new PDO("mysql:host=localhost;dbname=roblosium;charset=UTF8", $_S->DBUser, $_S->DBPass,
        [
            PDO::ATTR_EMULATE_PREPARES => false, // enable this and ill murder you
            PDO::ATTR_ERRMODE => ($_S->IsProduction ? PDO::ERRMODE_SILENT : PDO::ERRMODE_EXCEPTION)
        ]
    );
}
catch (PDOException $e)
{
    die("An error occured connecting to the database".($_S->IsProduction ? "" : ": ".$e->getMessage()));
}
?>