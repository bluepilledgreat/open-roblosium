

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>

</title><link href="../CSS/Base/CSS/StyleGuide.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/roblox.js"></script>
</head>
<body>
    <div>Standard Gray Dropdown With text</div>
    <div class="dropdown">
        <div class="button">Arrow Text</div>
        <ul class="dropdown-list">
            <li>
                <a href="#">Widgets Page</a>
            </li>
            <li>
                <a href="Reference/buttons.cshtml">Buttons Reference Page</a>
            </li>
        </ul>
    </div>
    <br />
    <br />
    <br />
    <br />
    <div>Standard Gray Dropdown With Gear Icon</div>
    <div class="dropdown">
        <div class="button button gear"></div>
        <ul class="dropdown-list" data-align="right">
            <li>
                <a href="#">Widgets Page</a>
            </li>
            <li>
                <a href="Reference/buttons.cshtml">Buttons Reference Page</a>
            </li>
        </ul>
    </div>
</body>
</html>

 <script type="text/javascript">
     Roblox.require('Widgets.DropdownMenu', function (dropdown) {
         dropdown.InitializeDropdown();
     });
</script>