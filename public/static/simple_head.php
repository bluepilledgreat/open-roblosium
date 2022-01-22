<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/settings.php");
?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
	<?php echo $_PS->Title; ?>
</title>
<?php
// CSS packages
foreach($_PS->CSS as $p)
{
	foreach($p["items"] as $css)
		echo "<link rel='stylesheet' href='".$css."' />\n";
	echo "\n";
}
?>
<script type='text/javascript' src='//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js'></script>
<script type='text/javascript'>window.jQuery || document.write("<script type='text/javascript' src='/js/jquery/jquery-1.7.2.min.js'><\/script>")</script>
<script type='text/javascript' src='//ajax.aspnetcdn.com/ajax/4.0/1/MicrosoftAjax.js'></script>
<script type='text/javascript'>window.Sys || document.write("<script type='text/javascript' src='/js/Microsoft/MicrosoftAjax.js'><\/script>")</script>

<?php
foreach($_PS->JS as $k => $p)
{
	foreach($p["items"] as $js)
		echo "<script type='text/javascript' src='".$js."'></script>\n";
	echo "\n";
}
?>

    <style>
        html 
        {
            background-color: #E1E1E1;
        }
    </style>
</head>