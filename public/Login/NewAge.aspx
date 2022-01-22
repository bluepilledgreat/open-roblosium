<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
if (!empty($_POST))
{
	// THATS RIGHT! THIS IS ANOTHER REDIRECT! REKT!
	header("Location: /Login/Signup.aspx");
}
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css","/CSS/Base/CSS/AdFormatClasses.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/GenericConfirmation.js","/js/jquery.simplemodal-1.3.5.js","/js/GenericModal.js"], ["/js/GPTAdScript.js"]));
require_once($_SERVER["STATIC"]."/header.php");
?>
        <div id="BodyWrapper">
            <div id="RepositionBody"><div id="Body" style=''>
                
<div style="float: left; width: 620px; margin-top: 10px;">
    <div class="StandardBoxHeader" style="width: 620px;"><span>Create a Free ROBLOX Account</span></div>
    <div class="StandardBox" style="width: 620px;">
		<h3>For a personalized experience, enter your birthday:</h3><br />
		<center>
		<select name="ctl00$cphRoblox$lstMonths" id="lstMonths" style="font-size: 18px;">
	<option value="0">Select Month</option>
	<option value="1">January</option>
	<option value="2">February</option>
	<option value="3">March</option>
	<option value="4">April</option>
	<option value="5">May</option>
	<option value="6">June</option>
	<option value="7">July</option>
	<option value="8">August</option>
	<option value="9">September</option>
	<option value="10">October</option>
	<option value="11">November</option>
	<option value="12">December</option>

</select>
        &nbsp;&nbsp;
		<select name="ctl00$cphRoblox$lstDays" id="lstDays" style="font-size: 18px;">
	<option value="0">Select Day</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	<option value="14">14</option>
	<option value="15">15</option>
	<option value="16">16</option>
	<option value="17">17</option>
	<option value="18">18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
	<option value="24">24</option>
	<option value="25">25</option>
	<option value="26">26</option>
	<option value="27">27</option>
	<option value="28">28</option>
	<option value="29">29</option>
	<option value="30">30</option>
	<option value="31">31</option>

</select>
		&nbsp;&nbsp;
		<select name="ctl00$cphRoblox$lstYears" id="lstYears" style="font-size: 18px;">
	<option value="0">Select Year</option>
	<option value="2012">2012</option>
	<option value="2011">2011</option>
	<option value="2010">2010</option>
	<option value="2009">2009</option>
	<option value="2008">2008</option>
	<option value="2007">2007</option>
	<option value="2006">2006</option>
	<option value="2005">2005</option>
	<option value="2004">2004</option>
	<option value="2003">2003</option>
	<option value="2002">2002</option>
	<option value="2001">2001</option>
	<option value="2000">2000</option>
	<option value="1999">1999</option>
	<option value="1998">1998</option>
	<option value="1997">1997</option>
	<option value="1996">1996</option>
	<option value="1995">1995</option>
	<option value="1994">1994</option>
	<option value="1993">1993</option>
	<option value="1992">1992</option>
	<option value="1991">1991</option>
	<option value="1990">1990</option>
	<option value="1989">1989</option>
	<option value="1988">1988</option>
	<option value="1987">1987</option>
	<option value="1986">1986</option>
	<option value="1985">1985</option>
	<option value="1984">1984</option>
	<option value="1983">1983</option>
	<option value="1982">1982</option>
	<option value="1981">1981</option>
	<option value="1980">1980</option>
	<option value="1979">1979</option>
	<option value="1978">1978</option>
	<option value="1977">1977</option>
	<option value="1976">1976</option>
	<option value="1975">1975</option>
	<option value="1974">1974</option>
	<option value="1973">1973</option>
	<option value="1972">1972</option>
	<option value="1971">1971</option>
	<option value="1970">1970</option>
	<option value="1969">1969</option>
	<option value="1968">1968</option>
	<option value="1967">1967</option>
	<option value="1966">1966</option>
	<option value="1965">1965</option>
	<option value="1964">1964</option>
	<option value="1963">1963</option>
	<option value="1962">1962</option>
	<option value="1961">1961</option>
	<option value="1960">1960</option>
	<option value="1959">1959</option>
	<option value="1958">1958</option>
	<option value="1957">1957</option>
	<option value="1956">1956</option>
	<option value="1955">1955</option>
	<option value="1954">1954</option>
	<option value="1953">1953</option>
	<option value="1952">1952</option>
	<option value="1951">1951</option>
	<option value="1950">1950</option>
	<option value="1949">1949</option>
	<option value="1948">1948</option>
	<option value="1947">1947</option>
	<option value="1946">1946</option>
	<option value="1945">1945</option>
	<option value="1944">1944</option>
	<option value="1943">1943</option>
	<option value="1942">1942</option>
	<option value="1941">1941</option>
	<option value="1940">1940</option>
	<option value="1939">1939</option>
	<option value="1938">1938</option>
	<option value="1937">1937</option>
	<option value="1936">1936</option>
	<option value="1935">1935</option>
	<option value="1934">1934</option>
	<option value="1933">1933</option>
	<option value="1932">1932</option>
	<option value="1931">1931</option>
	<option value="1930">1930</option>
	<option value="1929">1929</option>
	<option value="1928">1928</option>
	<option value="1927">1927</option>
	<option value="1926">1926</option>
	<option value="1925">1925</option>
	<option value="1924">1924</option>
	<option value="1923">1923</option>
	<option value="1922">1922</option>
	<option value="1921">1921</option>
	<option value="1920">1920</option>
	<option value="1919">1919</option>
	<option value="1918">1918</option>
	<option value="1917">1917</option>
	<option value="1916">1916</option>
	<option value="1915">1915</option>
	<option value="1914">1914</option>
	<option value="1913">1913</option>

</select>
        <div id="lblError" style="display: none"><b>Please choose a valid date</b></div>
		<br /><br />
		<i>Your birthday will not be given out to any third party!</i>
		</center>
            <div style="text-align:center">
                

<div style="text-align:left">Are you a boy or a girl?</div>
<div style="text-align:center;position:relative;height:250px">
    <div style="position:absolute;left:50%;margin-left:-175px">
        <label for="MaleBtn"><img src="/images/boy_guest.png" id="ctl00_cphRoblox_SelectGenderPane_BoyThumbnail" style="cursor:pointer" /><br /></label>
        <input id="MaleBtn" type="radio" name="ctl00$cphRoblox$SelectGenderPane$Gender" value="MaleBtn" /><label for="MaleBtn">Boy</label>
    </div>
    <div style="position:absolute;left:50%;margin-left:25px">
        <label for="FemaleBtn"><img src="/images/girl_guest.png" id="ctl00_cphRoblox_SelectGenderPane_GirlThumbnail" style="cursor:pointer" /><br /></label>
        <input id="FemaleBtn" type="radio" name="ctl00$cphRoblox$SelectGenderPane$Gender" value="FemaleBtn" /><label for="FemaleBtn">Girl</label>
    </div>
</div>
                <div id="genderError" style="color:Red;font-weight:bold;margin-bottom:10px;display:none">Please select a gender</div>
		        <a id="btnSignup2" class="MediumButton" onclick="CheckDateAndGender()">Continue</a>
		        <input type="submit" name="ctl00$cphRoblox$btnHidden" value="" id="ctl00_cphRoblox_btnHidden" style="display: none" />
		    </div>
		<br />
	</div>
</div>
	<div id="Sidebars" style="margin-top: 10px;">
	<div class="StandardBoxHeader" style="width: 230px;"><span>Already Registered?</span></div>
		<div class="StandardBox" style="width:230px;">
			<p>If you just need to login, go to the <a id="ctl00_cphRoblox_HyperLinkLogin" href="../Login">Login</a> page.</p>
			<p>If you have already registered but you still need to download the game installer, go directly to <a id="ctl00_cphRoblox_HyperLinkDownload" href="../install/">download</a>.</p>
		</div>
		<div class="StandardBoxHeader" style="width: 230px;"><span>Hey Parents!</span></div>
		<div class="StandardBox" style="width:230px;">
			<p>Are you creating an account for your young child?</p>
			<p>If so, you should select "Under 13"</p>
			<p>ROBLOX has a variety of online safety features that help to prevent your child from disclosing personal information to other players. As a parent, you will have the option to override them later.</p>
			<p><a id="ctl00_cphRoblox_ParentsInfo" href="../Parents.aspx">More information for ROBLOX parents</a></p>
			<p><a id="ctl00_cphRoblox_hlTruste" href="http://www.truste.org/ivalidate.php?url=www.roblox.com&amp;sealid=105" style="display:inline-block;width:140px;"><img src="../images/truste_seal_kids.gif" alt="" style="border-width:0px;" /></a></p>
			<p><a target="_blank" href="https://www.bbb.org/online/consumer/cks.aspx?id=109111915116750"><img title="Click to verify BBB accreditation and to see a BBB report." border=0 src="../images/bbbsealh1US.gif" alt="Click to verify BBB accreditation and to see a BBB report." /></a>
                        </p>
		</div>
	</div><br clear="all" />

    <script type="text/javascript">
        function CheckDateAndGender() {
            $('#lblError').attr('style', 'display: none');
            var year = parseInt($('#lstYears option:selected').val());
            var month = parseInt($('#lstMonths option:selected').val());
            var day = parseInt($('#lstDays option:selected').val());

            var isValid = true;
            if (year <= 0 || month <= 0 || day <= 0 || day > new Date(year, month, 0).getDate()) {
                $('#lblError').attr('style', 'color: Red;');
                isValid = false;
            }

                if ($('#MaleBtn:checked').length == 0 && $('#FemaleBtn:checked').length == 0) {
                    $('#genderError').show();
                    isValid = false;
                }
                else {
                    $('#genderError').hide();
                }

            if (isValid) {
                $('#ctl00_cphRoblox_btnHidden').click();
            }
        }
    </script>


                <div style="clear:both"></div>
            </div>
        </div></div> 
        </div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>