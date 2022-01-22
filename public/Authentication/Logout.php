<?php
if (isset($_COOKIE['_ROBLOSECURITY']))
{
	unset($_COOKIE['_ROBLOSECURITY']);
	setcookie(".ROBLOSECURITY", null, -1, '/', $_SERVER['HTTP_HOST']); 
}
header("Location: /");
?>