<?php

class ProfanityFilter {
	private static $Filtered = [
		"nigger",
		"nigga",
		"niger",
		"niga",
		"negro",
		"faggot",
		"faggit",
		"fag"
	];
	private static $SignupFiltered = [
		"nigger",
		"nigga",
		"niger",
		"niga",
		"negro",
		"faggot",
		"faggit",
		"fag",
		"fuck",
		"shit",
		"sh1t",
		"dick",
		"d1ck",
		"retard",
		"ret4rd",
		"bitch",
		"b1tch",
		"cukesim",
		"cukejz",
		"qunjz",
		"alonso",
		"wagness",
		"izzypizzy"
	];
	
	public static function IsAppropriate($input)
	{
		$input = strtolower($input);
		foreach (self::$Filtered as $bad)
			if (str_contains($input, $bad))
				return false;
		return true;
	}
	
	public static function IsAppropriateForSignup($input)
	{
		$input = strtolower($input);
		foreach (self::$SignupFiltered as $bad)
			if (str_contains($input, $bad))
				return false;
		return true;
	}
	
	public static function Censor($input, $replaceWith = '#')
	{
		foreach (self::$Filtered as $bad)
			$input = str_ireplace($bad, str_pad("", strlen($bad), $replaceWith), $input);
		return $input;
	}
	
	public static function GetFilteredWordsInsideOfString($input)
	{
		$input = strtolower($input);
		$bads = [];
		foreach (self::$Filtered as $bad)
			if (str_contains($input, $bad))
				array_push($bads, $bad);
		return $bads;
	}
}

?>