<%@ Import Namespace="AspNetForums.Controls" %>
<%@ Import Namespace="AspNetForums.Components" %>
<%@ Register TagPrefix="AspNetForums" Namespace="AspNetForums.Controls" Assembly="AspNetForums" %>
<%@ Control Language="C#" %>
<table class="tableBorder" cellSpacing="1" cellPadding="3" width="100%">
	<tr>
		<th class="tableHeaderText" align="left" colspan="2">
			&nbsp;�����û�
		</th>
	</tr>
	<tr>
		<td class="forumRow" valign="top">
			<P>
				<span class="normalTextSmaller">
      ������:
      <br>
      <b>
						<asp:Label ID="AnonymousUsers" Runat="server" /></b> �����û�����
      <br>
      <b>
						<asp:label id="UsersOnline" runat="server"></asp:label></b> of <b><asp:label id="TotalUsers" runat="server"></asp:label></b> ע���û�����<asp:label id="Users" runat="server"></asp:label>
      <P>
						<span class="userOnlineLinkBold">�û�</span>
						<br>
						<span class="moderatorOnlineLinkBold">����</span>
      </span>
		</td>
	</tr>
</table>
