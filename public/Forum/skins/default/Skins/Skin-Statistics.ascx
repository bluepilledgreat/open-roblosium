<%@ Control Language="C#" %>
<%@ Register TagPrefix="AspNetForums" Namespace="AspNetForums.Controls" Assembly="AspNetForums" %>
<%@ Import Namespace="AspNetForums.Components" %>
<%@ Import Namespace="AspNetForums.Controls" %>
<script runat="server">
  int i = 1;
</script>
<table class="tableBorder" cellSpacing="1" cellPadding="3" width="100%">
	<tr>
		<th class="tableHeaderText" align="left" colSpan="2">
			&nbsp;访问统计
		</th>
	</tr>
	<tr>
		<td class="forumRow" vAlign="top">
			<table CellPadding="2" CellSpacing="2">
				<TBODY>
					<tr>
						<td>
							<span class="normalTextSmaller">
            用户:<b>
									<asp:label id="TotalUsers" runat="server"></asp:label>&nbsp;</b> 
              主题: <b><asp:label id="TotalThreads" runat="server"></asp:label>&nbsp;</b> 
            文章: <b><asp:label id="TotalPosts" runat="server"></asp:label>&nbsp;</b>
            </span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="normalTextSmaller">
                  24小时统计:
              <br>
              -&nbsp; 新主题数: 
<asp:label id="NewThreadsInPast24Hours" runat="server"></asp:label> 
              <br>
-&nbsp;&nbsp;新文章数: 
								<asp:label id="NewPostsInPast24Hours" runat="server"></asp:label><BR>-&nbsp;&nbsp;新用户数: 
<asp:label id="NewUsersInPast24Hours" runat="server"></asp:label>
            </span>
						</td>
					</tr>
					<TR>
						<TD><SPAN class="normalTextSmaller">3天内统计:<BR>        -&nbsp;&nbsp;最大浏览主题&nbsp;: 
<asp:hyperlink id="MostViewedThread" runat="server"></asp:hyperlink>. 
            </SPAN></TD>
					</TR>
					<TR>
						<TD><SPAN class="normalTextSmaller">        
               -&nbsp;&nbsp;最大发贴主题&nbsp;: 
<asp:hyperlink id="MostActiveThread" runat="server"></asp:hyperlink>. 
            </SPAN></TD>
					</TR>
					<TR>
						<TD><SPAN class="normalTextSmaller">        
             -&nbsp;&nbsp;最大读贴主题&nbsp;: 
<asp:hyperlink id="MostReadThread" runat="server"></asp:hyperlink>. 
            </SPAN></TD>
					</TR>
					<TR>
						<TD><SPAN class="normalTextSmaller">发贴排行TOP3:<BR>
<asp:Repeater id="TopUsers" runat="server">
									<ItemTemplate>
										&nbsp;<%# (i++).ToString() %>. <a href='<%# Globals.UrlUserProfile + DataBinder.Eval(Container.DataItem, "Username") %>'>
											<%# DataBinder.Eval(Container.DataItem, "Username") %>
										</a>(<%# DataBinder.Eval(Container.DataItem, "TotalPosts") %>)<br>
									</ItemTemplate>
								</asp:Repeater></SPAN></TD>
					</TR>
					<TR>
						<TD><SPAN class="normalTextSmaller">最新注册用户: 
<asp:hyperlink id="NewestUser" runat="server"></asp:hyperlink>.</SPAN></TD>
			</SPAN>
		</td>
	</tr>
</table>
</TD></TR></TBODY></TABLE>
