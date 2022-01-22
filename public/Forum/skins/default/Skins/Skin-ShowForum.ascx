<%@ Import Namespace="AspNetForums.Controls" %>
<%@ Import Namespace="AspNetForums.Components" %>
<%@ Register TagPrefix="AspNetForums" Namespace="AspNetForums.Controls" Assembly="AspNetForums" %>
<%@ Control Language="C#" %>
<table cellPadding="0" width="100%">
	<tr>
		<td colspan="2" align="left"><AspNetForums:WhereAmI id="Whereami1" runat="server" NAME="Whereami1" /></td>
	</tr>
	<tr>
		<td>
			&nbsp;
		</td>
	</tr>
	<tr>
		<td vAlign="bottom" align="left"><asp:hyperlink id="NewThreadLinkTop" Runat="server">
				<asp:Image runat="server" ID="NewThreadImageTop"></asp:Image>
			</asp:hyperlink></td>
		<TD align="right"><SPAN class="normalTextSmallBold">ÔÚ±¾À¸Ä¿ËÑË÷: </SPAN>
			<asp:TextBox id="Search" runat="server"></asp:TextBox>
			<asp:Button id="SearchButton" runat="server" Text="ËÑË÷"></asp:Button></TD>
	</tr>
	<tr>
		<td vAlign="top" colSpan="2"><AspNetForums:ThreadList id="ThreadList" CssClass="tableBorder" Width="100%" CellPadding="3" Cellspacing="1" runat="server" /><ASPNETFORUMS:Paging id="Pager" runat="server" /><asp:Label CssClass="normalTextSmall" ID="NoThreads" Runat="server" Visible="False">Sorry, there are no posts in this forum yet.</asp:Label><asp:Label CssClass="normalTextSmall" id="NoPostsDueToFilter" runat="server" Visible="false">There are posts available, but your current display options prevent them from being displayed. Please change the settings below to display these posts. Most likely you have 'Hide Read Threads' selected which hides posts you've already read.</asp:Label></td>
	</tr>
	<tr>
		<td colspan="2">
			&nbsp;
		</td>
	</tr>
	<tr>
		<td align="left" valign="top">
			<AspNetForums:WhereAmI ShowHome="true" DynamicMenu="false" id="Whereami2" runat="server" NAME="Whereami2" />
			<%--
      <AspNetForums:JumpDropDownList runat="server" ID="Jumpdropdownlist1" />
--%>
		</td>
		<TD align="right">
			<span class="normalTextSmallBold">Display threads for: </span><asp:dropdownlist id="DisplayByDays" runat="server"></asp:dropdownlist>
			<br>
			<asp:linkbutton id="MarkAllRead" CssClass="linkSmallBold" Runat="server">Mark all threads as read</asp:linkbutton>
			<br>
			<span class="normalTextSmallBold">
				<asp:checkbox id="HideReadThreads" runat="server" Text="Hide read threads"></asp:checkbox>
			</span>
		</TD>
	</tr>
	<tr>
		<td colSpan="2">&nbsp;
		</td>
	</tr>
</table>
