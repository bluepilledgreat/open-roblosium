<%@ Import Namespace="AspNetForums.Controls" %>
<%@ Import Namespace="AspNetForums.Components" %>
<%@ Register TagPrefix="AspNetForums" Namespace="AspNetForums.Controls" Assembly="AspNetForums" %>
<%@ Control Language="C#" %>
<table class="tableBorder" cellSpacing="1" cellPadding="3" width="100%">
	<tr>
		<th class="tableHeaderText" align="left" colspan="2">
			&nbsp;在线用户
		</th>
	</tr>
	<tr>
		<td class="forumRow" valign="top">
			<P>
				<span class="normalTextSmaller">
      现在有:
      <br>
      <b>
						<asp:Label ID="AnonymousUsers" Runat="server" /></b> 匿名用户在线
      <br>
      <b>
						<asp:label id="UsersOnline" runat="server"></asp:label></b> of <b><asp:label id="TotalUsers" runat="server"></asp:label></b> 注册用户在线<asp:label id="Users" runat="server"></asp:label>
      <P>
						<span class="userOnlineLinkBold">用户</span>
						<br>
						<span class="moderatorOnlineLinkBold">版主</span>
      </span>
		</td>
	</tr>
</table>
