
<!DOCTYPE html>

<html>
<head>
    <title>Style Guide</title>
    <script type="text/javascript" src="/js/jquery/jquery-1.7.2.min.js"></script> 
    <link rel="stylesheet" href="/CSS/Base/CSS/StyleGuide.css" >
</head>
    <body>
        <script type="text/javascript" src="/js/roblox.js"></script>  
        <!-- Text Styles -->
        <h1>Standard Header Top Level </h1>  
        <h2>Standard Header Second Level </h2>   
        <h2 class="light">Standard Header Second Level Light Text</h2>
        <h3>Standard Header 3rd Lvl</h3>   
        <div class="text"> Standard  Text Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut eros vel mi posuere laoreet vitae et lectus. Quisque in mauris vulputate dolor adipiscing viverra vel at tellus. Sed massa nulla, tristique vel tristique in, bibendum eu erat. Cras id tellus ac purus pharetra malesuada. Integer non nunc nec magna aliquam sagittis at id diam. Mauris est leo, dapibus sed ultricies iaculis, facilisis ac tellus. Maecenas ultricies tempor orci, ac pretium ipsum pharetra sed. Nullam nulla ipsum, commodo eu lobortis sed, lobortis vitae urna. Donec libero nisl, placerat eget fermentum in, molestie id elit. Donec scelerisque tempor nunc id feugiat. Sed ultrices, est nec tristique laoreet, velit urna fringilla nibh, sed bibendum enim nulla nec tortor. </div>
       
    <br /> 
        <div style="float:left;">
            <a class="StandardInTextLink">Standard Text in Link</a> <div class="tool_tip"><img src="/images/UI/img-tail-left.png" class="left"/>tool_tip left.<div>Multiline!</div><div>Amazing!</div></div> 
            <a class="text-link">Standard Text in Link</a> <div class="tool-tip"><img src="/images/UI/img-tail-left.png" class="right"/>tool-tip left.<div>Multiline!</div><div>Amazing!</div></div> 
            <a class="text-link">Standard Text in Link</a> <div class="tool-tip"><img src="/images/UI/img-tail-left.png" class="left"/>tool-tip left.<div>Multiline!</div><div>Amazing!</div></div> 
            <a disabled>Disabled link</a><br />
            <span class="footnote">Footnote text</span><br/>
            <span>Search <span class="search-match">match</span></span><br/>
            <span class="hint-text">Hint text, such as is used in search bars and the comments text area</span><br/>
            <span class="robux">##</span> Robux display<br/>
            <span class="tickets">##</span> Tickets display<br/>
            <span class="robux-text">Robux text</span> display, for when we have free items or don't want to use the picture<br/>
            <br/>
            <br/>
            <!-- Form Styles -->   
            <div style="width:400px;height:50px">
                <span class="FormLableText" style="float:left;padding-top:2px;margin-right:5px;">Form Lable Text</span>   
                <div style="float: left; width: 183px; text-align:left;">
                    <select class="form-select">
                        <option value="Anixamenes">Anixamenes</option>
                        <option value="Pythagoras">Pythagoras</option>
                        <option value="Thales">Thales</option>
                        <option value="Anaximander">Anaximander</option>
                    </select> 
                </div>

            </div> 
            <div style="width:400px;height:50px">
                <span class="FormLableText" style="float:left;padding-top:5px;margin-right:5px;">Form Lable Text</span>   
                <div style="float: left; width: 183px; text-align:left;">
                    <input type="text"class="text-box text-box-small" value="Form Text Box" TabIndex="1" style="width:183px;"/>
                </div>
            </div>
            <div style="width:400px;height:50px">
                <span class="FormLableText" style="float:left;padding-top:5px;margin-right:5px;">Form Lable Text</span>   
                <div style="float: left; width: 183px; text-align:left;">
                    <input type="text"class="text-box text-box-medium" value="Form Text Box" TabIndex="1" style="width:183px;"/>
                    <span class="tip-text" style="padding-top:5px;">(Form) Tip Text</span>
                </div>
            </div>
            <div style="width:400px;height:50px">
                <span class="FormLableText" style="float:left;padding-top:5px;margin-right:5px;">Form Lable Text</span>   
                <div style="float: left; width: 183px; text-align:left;">
                    <input type="text" class="text-box text-box-large" value="Form Text Box" TabIndex="1" style="width:183px;"/>
                </div>
                <div style="float:left;margin-left:5px;">
                    <div class="validator-checkmark" style="display:block;position:relative;top:5px;"></div>
                </div>
            </div> 
            <br />
            <br /> 
            
            <!-- Table Styles -->
            <table class="text"  cellpadding="0" cellspacing="0" border="0" >
                <tr class="table-header">
                    <td class="first">Categories</td>
                    <td >Credit</td>
                </tr>
                <tr class="StandardTableRow">
                    <td >Builders Club Stipend</td>
                    <td >&nbsp; Standard Table Row</td>
                </tr>
                <tr class="StandardTableRow">
                    <td >Builders Club Stipend Bonus</td>
                    <td >&nbsp;Standard Table Row</td>
                </tr>
                <tr class="StandardTableRow">
                    <td>Sale of Goods</td>
                    <td>&nbsp;Standard Table Row</td>
                </tr>
                <tr class="StandardTableRow">
                    <td>Currency Purchase</td>
                    <td>&nbsp;Standard Table Row</td>
                </tr>               
            </table> 
            <br /> 

            <!-- Dividers -->
            <div class="divider-top" style="float:left;margin:15px;width:100px;">A div with standard divider top</div> 
            <div class="divider-bottom"  style="float:left;margin:15px;width:100px;">A div with standard divider bottom</div> 
            <div class="divider-left"  style="float:left;margin:15px;width:100px;">A div with standard divider left</div> 
            <div class="divider-right"  style="float:left;margin:15px;width:100px;">A div with standard divider right</div>   
            <div class="blank-box"  style="float:left;margin:15px;width:100px;">Standard Blank Box</div>
            <div class="dark-box"  style="float:left;margin:15px;width:100px;">Standard Blank Box</div>    
            <div style="clear:both;"></div>
            
            <!-- Dropdowns -->
            <br />
            <br />
            <div style="float:left;">
                <div class="dropdown">
                    <div class="button">Arrow Text</div>
                    <ul class="dropdown-list">
                        <li>
                            <a >Widgets Page</a>
                        </li>
                        <li>
                            <a>Reference Page</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div style="float:left;margin-left:20px;"> 
                <div class="dropdown">
                    <div class="button button gear"></div>
                    <ul class="dropdown-list">
                        <li>
                            <a>Widgets Page</a>
                        </li>
                        <li>
                            <a>Buttons Reference Page</a>
                        </li>
                    </ul>
                </div> 
            </div>
            <script type="text/javascript">
                Roblox.require('Widgets.DropdownMenu', function (dropdown) {
                    dropdown.InitializeDropdown();
                });
            </script>
        </div> 

        <!-- Right Column -->
        <div class="text" style="float:right;">  
            <br />
            <!-- Buttons -->
            <span  class="btn-control btn-control-small">Small Active Control</span>
            <span  class="btn-control btn-control-small disabled" disabled>Small Disabled Control</span>
            <br />
            <span  class="btn-control btn-control-medium">Medium Active Control</span>
            <span  class="btn-control btn-control-medium disabled" disabled>Medium Disabled Control</span> 
            <br/>  
            <span  class="btn-control btn-control-large">Large Active Control</span>
            <span  class="btn-control btn-control-large disabled" disabled>Large Disabled Control</span>
            <div style="margin-top:20px;"></div>
            <br /> 
            <div>
                <a  class="btn-small btn-neutral">Small Neutral</a>
                <a  class="btn-small btn-disabled-neutral" disabled>Small Neutral Disabled</a>
            </div>
            <br />
            <div>
                <a  class="btn-small btn-primary">Small Primary</a>
                <a  class="btn-small btn-disabled-primary" disabled>Small Primary Disabled</a>
            </div>
            <br />
            <div>
                <a  class="btn-small btn-negative">Small Negative</a>
                <a  class="btn-small btn-disabled-negative" disabled>Small Negative Disabled</a>
            </div>
            <br />
            <div>
                <a  class="btn-medium btn-primary">Medium Primary</a>
                <a  class="btn-medium btn-disabled-primary" disabled>Medium Primary Disabled</a>
            </div>
            <br />
            <div>
                <a  class="btn-medium btn-neutral">Medium Neutral</a>
                <a  class="btn-medium btn-disabled-neutral" disabled>Medium Neutral Disabled</a>
            </div>
            <br />
            <div>
                <a  class="btn-medium btn-negative">Medium Negative</a>
                <a  class="btn-medium btn-disabled-negative" disabled>Medium Negative Disabled</a>
            </div>
            <br />
            <div>
                <a  class="btn-large btn-primary">Large Primary</a>
                <a  class="btn-large btn-disabled-primary" disabled>Large Primary Disabled</a>
            </div>
            <br />
            <div>
                <a  class="btn-large btn-neutral">Large Neutral</a>
                <a  class="btn-large btn-disabled-neutral" disabled>Large Neutral Disabled</a>
            </div>
            <br />
            <div>
                <a  class="btn-large btn-negative">Large Negative</a>
                <a  class="btn-large btn-disabled-negative" disabled>Large Negative Disabled</a>
            </div> 
            <br />
            <div>
                <a  class="btn-large btn-large-green-play" id="Play">Play</a>
            </div>
            <br />
            <div class="pager first"></div>
            <span class="pager previous"></span>
            <span class="pager previous disabled"></span>
            <span class="page text">Page Num</span> 
            <span class="pager next disabled"></span>
            <span class="pager next"></span>
            <div class="pager last"></div> 
            <br />
            
        </div>
    </body>
</html>
