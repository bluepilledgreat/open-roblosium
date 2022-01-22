<?php

define("LOGGING_PRINT", 1);
define("LOGGING_WARNING", 2);
define("LOGGING_ERROR", 3);

class Logging {
	public static function GenerateLogName()
	{
		return "log-".date("d.m.Y").".log"; // TODO: make file extensions with log lead to a 403
	}
	public static function Log($name, $message, $type, $logName = null)
	{
		$suffix = ($type === 3 ? "[".$name." - ERROR]" : ($type === 2 ? "[".$name." - WARNING]" : "[".$name."]"));
		$message = date("d/m/Y-H:s")." ".$suffix." ".$message."\n";
		self::Write($_SERVER["STATIC"]."/logs/global-log.log", $message);
		if ($logName)
			self::Write($_SERVER["STATIC"]."/logs/".$logName.".log", $message);
	}
	private static function Write($file, $input)
	{
		$fp = fopen($file, "a");
		fwrite($fp, $input);
		fclose($fp); 
	}
}

?>