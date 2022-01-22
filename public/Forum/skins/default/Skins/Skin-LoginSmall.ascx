<%@ Control Language="C#" %>
<%@ Import Namespace="AspNetForums.Controls" %>
<%@ Import Namespace="AspNetForums.Components" %>
<%@ Register TagPrefix="AspNetForums" Namespace="AspNetForums.Controls" Assembly="AspNetForums" %>

<table Class="tableBorder" cellSpacing="1" cellPadding="3">
  <tr>
    <th class="tableHeaderText" align="left" colspan="2">
      &nbsp; 登录论坛
    </th>
  </tr>
  <tr>
    <td class="forumRow" align="left" valign="top" colspan="2">
      <table cellspacing="1" border="0" cellpadding="2">
        <tr>
          <td align="right">
            <span class="normalTextSmaller">用户名：</span>
          </td>
          <td>
            <asp:TextBox id="username" runat="server" size="10" maxlength="50" />
          </td>
        </tr>
        <tr>
          <td align="right">
            <span class="normalTextSmaller">密码：</span>
          </td>
          <td>
            <asp:TextBox TextMode="Password" id="password" runat="server" size="11" maxlength="20" />
          </td>
        </tr>
        <tr>
          <td align="left" colspan="2" nowrap>
            <span class="normalTextSmaller">
              <asp:CheckBox type="checkbox" Checked="true" Text="自动登录" runat="server" id="autoLogin" />
            </span>
          </td>
        </tr>

        <tr>
          <td align="right" colspan="2">
            <asp:Button id="loginButton" runat="server" text="登录" />
          </td>
        </tr>
      </table>
      <span class="normalTextSmall">
      &nbsp;
      <Br>
      <a href="<%=Globals.UrlRegister%>">注册新用户点此进入>></a>
      <br>
      <a href="<%=Globals.UrlForgotPassword%>">忘记登录密码点此找回>></a>
      </span>
    </td>
  </tr>
</table>
<br>



