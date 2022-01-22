<%@ Control Language="C#" %>
<%@ Register TagPrefix="AspNetForums" Namespace="AspNetForums.Controls" Assembly="AspNetForums" %>
<%@ Import Namespace="AspNetForums.Components" %>
<%@ Import Namespace="AspNetForums.Controls" %>
<table cellPadding="0" width="100%">
	<tr>
		<td align="left" valign="top">
			<span class="forumName">用户列表</span>
		</td>
	</tr>
	<tr>
		<td align="middle">
			<AspNetForums:AlphaPicker id="AlphaPicker" runat="server" />
		</td>
		<td vAlign="bottom" align="right">
			&nbsp;<span class="normalTextSmall">排序: </span>
			<asp:DropDownList id="SortBy" runat="server"></asp:DropDownList>
			&nbsp;<span class="normalTextSmall">方式: </span>
			<asp:DropDownList id="SortDirection" runat="server"></asp:DropDownList>
		</td>
	</tr>
	<tr>
		<td vAlign="top" align="right" colspan="2">
			<AspNetForums:UserList width="100%" id="UserList" CssClass="tableBorder" CellPadding="3" CellSpacing="1" runat="server" />
			<AspNetForums:Paging id="Pager" runat="server" />
		</td>
	</tr>
	<tr>
		<td>
			&nbsp;
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			&nbsp;<span class="normalTextSmall">查找用户: </span>
			<asp:TextBox id="SeachForUser" runat="server" />
			<asp:Button id="SearchButton" Text="查找" runat="server" />
		</td>
	</tr>
</table>
<p><FONT face="宋体"></FONT>
	<%--
  <AspNetForums:JumpDropDownList runat="server" ID="Jumpdropdownlist1" />
--%>
</p>
