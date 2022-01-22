<%@ Control Language="C#" %>
<%@ Import Namespace="AspNetForums.Controls" %>
<%@ Import Namespace="AspNetForums.Components" %>
<%@ Register TagPrefix="AspNetForums" Namespace="AspNetForums.Controls" Assembly="AspNetForums" %>
<%@ Register TagPrefix="AspNetForumsModeration" Namespace="AspNetForums.Controls.Moderation" Assembly="AspNetForums" %>

<table cellPadding="0" width="100%">
  <tr>
    <td align="left" colSpan="2"><ASPNETFORUMS:WHEREAMI id="Whereami1" runat="server" NAME="Whereami1"></ASPNETFORUMS:WHEREAMI></td>
  </tr>
  <tr>
    <td align="left" colSpan="2">&nbsp;
    </td>
  </tr>
  <tr>
    <td colSpan="2">
      <span class="menuTitle">你设置跟踪的主题:</span>
      <AspNetForums:ThreadList id="ThreadTracking" CssClass="tableBorder" runat="server" CellSpacing="1" CellPadding="0" Width="100%">
      </AspNetForums:ThreadList>
      <br>
      <asp:Label visible="false" id="NoTrackedThreads" runat="server" CssClass="normalTextSmallBold">没有主题.</asp:Label>
    </td>
  </tr>
  <tr>
    <td align="left" colSpan="2">&nbsp;
    </td>
  </tr>
  <tr>
    <td colSpan="2">
      <span class="menuTitle">你参与讨论的25个活动主题:</span>
      <AspNetForums:ThreadList id="ParticipatedThreads" CssClass="tableBorder" runat="server" CellSpacing="1" CellPadding="0" Width="100%">
      </AspNetForums:ThreadList>
      <br>
      <asp:Label visible="false" id="NoParticipatedThreads" runat="server" CssClass="normalTextSmallBold">没有主题.</asp:Label>
    </td>
  </tr>
  <tr>
    <td align="right" colSpan="2">
      <asp:HyperLink CssClass="linkSmallBold" id="FindMorePosts" runat="server">查看更多参与讨论的主题</asp:HyperLink>
    </td>
  </tr>
</table>
