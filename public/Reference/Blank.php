<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
require_once($_SERVER["STATIC"]."/header.php");
?>
        <div id="BodyWrapper">
            <div id="RepositionBody">
                <div id="Body" style="width:970px">
                    <h2>This page intentionally left blank.</h2>

                    <div style="clear:both"></div>
                </div>
            </div>
        </div>
<?php require_once($_SERVER["STATIC"]."/footer.php"); ?>