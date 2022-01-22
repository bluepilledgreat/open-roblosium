<%@ Import Namespace="AspNetForums.Controls" %>
<%@ Import Namespace="AspNetForums.Components" %>
<%@ Control Language="C#" %>
<table cellspacing="1" cellpadding="3" width="600" Class="tableBorder">
    <tr>
        <th class="tableHeaderText" align="left">
            &nbsp;注册新用户
        </th>
    </tr>
    <tr>
        <td class="forumRow">
            <table cellpadding="3" cellspacing="1" border="0">
                <tr>
                    <td colspan="3">
                        <span class="normalTextSmall">
              如果你已经注册成功，请 <A href="<%=Globals.UrlLogin%>">登录</A>.
              <P>
              用户名将作为你在本站点活动的署名，填好用户名和Email后，我们会将密码发送到你填写的Email信箱。收到密码后以此登录。
              <P>
                                注意: 为了安全，请<b>不要</b>填写公用信箱，此信箱在本站点也是唯一的。
            </span>
                    </td>
                </tr>
                <tr>
                    <td align="right" nowrap>
                        <span class="normalTextSmallBold">
              用户名:
            </span>
                    </td>
                    <td align="left">
                        <asp:textbox id="Username" runat="server" columns="20"></asp:textbox>
                    </td>
                    <td align="left" width="100%">
                        <asp:RequiredFieldValidator id="usernameValidator" runat="server" ErrorMessage="" ControlToValidate="Username" CssClass="validationWarningSmall">Username is required.</asp:RequiredFieldValidator>
                        <br>
                        <asp:RegularExpressionValidator id="RegularExpressionValidator1" ErrorMessage="" runat="server" ControlToValidate="Username" ValidationExpression="^[A-Za-z].*" CssClass="validationWarningSmall">Username must start with a-z/A-Z character.</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <span id="InstantSignUp" Visible="true" runat="server">
                    <tr>
                        <td align="right" nowrap>
                            <span class="normalTextSmallBold">
              密码:
            </span>
                        </td>
                        <td align="left">
                            <asp:textbox id="Password" runat="server" columns="20"></asp:textbox>
                        </td>
                        <td align="left">
                            <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ErrorMessage="" ControlToValidate="Password" CssClass="validationWarningSmall">Password is required.</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </span>
                <tr>
                    <td align="right" nowrap>
                        <span class="normalTextSmallBold">
              Email:
            </span>
                    </td>
                    <td align="left">
                        <asp:textbox id="Email" runat="server" columns="20"></asp:textbox>
                    </td>
                    <td align="left">
                        <asp:RequiredFieldValidator id="emailValidator" runat="server" ErrorMessage="" ControlToValidate="Email" CssClass="validationWarningSmall">Email is required.</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" ErrorMessage="" ControlToValidate="Email" CssClass="validationWarningSmall" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">Must be a valid email address.</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right" nowrap>
                    </td>
                    <td align="left">
                        <asp:button ID="CreateAccount" Runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right" nowrap>
                    </td>
                    <td align="left">
                        <span class="normalTextSmall">
            &nbsp;
            <br>
            <a href="<%=Globals.UrlForgotPassword%>">忘记密码点此找回>></a>
            </span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<P>
