<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/connection.php");
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/authentication.php");
if (isset($_POST['ctl00$cphRoblox$SearchTextBox']))
	die(header("Location: /Browse.aspx?name=".$_POST['ctl00$cphRoblox$SearchTextBox']));
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css", "/CSS/Base/CSS/AdFormatClasses.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
// search
$input = $_GET["name"] ?? "";
$searchResults = [];
if (!empty($input))
{
	$stmt = $conn->prepare("SELECT * FROM users WHERE username LIKE :wildcard ORDER BY lastonline DESC");
	$stmt->bindValue(":wildcard", "%".$input."%");
	$stmt->execute();
	$searchResults = $stmt->fetchAll(PDO::FETCH_OBJ);
}
require_once($_SERVER["STATIC"]."/header.php");
?>
        <div id="BodyWrapper">
            <div id="RepositionBody"><div id="Body" style=''>
                
    

    <script type="text/javascript">
        function GroupsSearch() {
            var search_text = $("#ctl00_cphRoblox_SearchTextBox").val();
            window.location.href = "Groups/Search.aspx?sort=Member+Count&filter=All&val=" + search_text;
        }
    </script>

    <div id="ctl00_cphRoblox_ContainerPanel">
	
        <div id="BrowseContainer" style="text-align: left">
            <div style="width: 876px; height: 28px; margin-bottom: 10px; clear: both;">
                <span class="form-label" style="margin-right: 30px;">Search: </span>
                <span>
                    <span class="SearchBox">
                        <input name="ctl00$cphRoblox$SearchTextBox" type="text" <?php if (!empty($input)) echo 'value="'.htmlspecialchars($input).'"'; ?> maxlength="100" id="ctl00_cphRoblox_SearchTextBox" style="width: 400px;" /></span>
                    <span class="SearchButton">
                        <input type="submit" name="ctl00$cphRoblox$SearchButton" value="Search Users" id="ctl00_cphRoblox_SearchButton" class="translate" /></span>
                    <input name="ctl00$cphRoblox$Button1" type="button" id="ctl00_cphRoblox_Button1" class="translate" value="Search Groups" onclick="GroupsSearch()" onkeypress="GroupsSearch()" />
                    <input type="text" style="visibility: hidden; width:1px; position: absolute;" />
                    
                </span>
            </div>
            <div style="float:left;min-height:600px">
            <?php if (!empty($searchResults)) { ?>
            
                    
                    
                    <style type="text/css">
                        .table-header th {
                             border-left: none;
                             border-right:none;
                        }
                        .table table td {
                             border: none;
                        }
                    </style>
                    <div>
		<table class="table" cellspacing="0" cellpadding="4" border="0" id="ctl00_cphRoblox_gvUsersSearched" style="width:720px;border-collapse:collapse;">
			<tr class="table-header">
				<th scope="col">Avatar</th><th scope="col">&nbsp;</th><th scope="col">Name</th><th scope="col">Blurb</th><th scope="col">Location / Last Seen</th>
			</tr>
			<?php foreach ($searchResults as $user) {
				$mt = $user->membershiptype;
				$online = isTimeConsideredOnline($user->lastonline);
				$lastseen = date("n/j/Y g:i:s A", $user->lastonline);
			?>
			<tr>
				<td class="first" style="width:50px;">
                                    <a id="ctl00_cphRoblox_gvUsersSearched_ctl02_hlAvatar" class=" notranslate" title="<?php echo $user->username; ?>" class=" notranslate" href="/User.aspx?ID=<?php echo $user->id; ?>" style="display:inline-block;height:48px;width:48px;cursor:pointer;"><img src="/images/boy_guest.png" height="48" width="48" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="<?php echo $user->username; ?>" class=" notranslate" /><?php if ($mt != "None") echo '<img src="/images/icons/overlay_'.($mt == "OutrageousBuildersClub" ? 'obc' : ($mt == "TurboBuildersClub" ? "tbc" : "bc")).'_small.png" align="left" style="position:relative;top:-12px;" />'; ?></a>
                                </td><td class="first" style="width:7px;">
                                    <span class="OnlineStatus">
                                        <img id="ctl00_cphRoblox_gvUsersSearched_ctl02_iOnlineStatus" class="notranslate" src="images/<?php echo $online ? "online" : "offline"; ?>.png" alt="<?php echo $user->username; ?> is <?php echo $online ? "online at Website." : "offline (last seen at ".$lastseen."."; ?>" style="border-width:0px;" /></span>
                                </td><td>
                                    <a id="ctl00_cphRoblox_gvUsersSearched_ctl02_hlName" class="notranslate" href="User.aspx?ID=<?php echo $user->id; ?>"><?php echo $user->username; ?></a>
                                </td><td>
                                    <div style="width:400px;overflow:hidden;word-wrap:break-word;">
                                        <span id="ctl00_cphRoblox_gvUsersSearched_ctl02_lBlurb" class="notranslate"><?php echo $user->bio; ?></span>
                                    </div>
                                </td><td>
                                    <span id="ctl00_cphRoblox_gvUsersSearched_ctl02_lblUserLocationOrLastSeen" class="notranslate"><?php echo $online ? "Website" : $lastseen; ?></span>
                                </td>
			</tr>
			<?php } ?>
		</table>
			<?php } ?>
            </div>  
            <div style="float:right;width:160px;">
                
            </div>
            <br style="clear:both" />
        </div>
    
</div>
    <script type="text/javascript">
        $(function () {
            $("#ctl00_cphRoblox_SearchTextBox").focus();
        });
    </script>

                <div style="clear:both"></div>
            </div>
        </div></div> 
        </div>
<?php require_once($_SERVER["STATIC"]."/footer.php"); ?>