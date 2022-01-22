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
      <span class="menuTitle">�����ø��ٵ�����:</span>
      <AspNetForums:ThreadList id="ThreadTracking" CssClass="tableBorder" runat="server" CellSpacing="1" CellPadding="0" Width="100%">
      </AspNetForums:ThreadList>
      <br>
      <asp:Label visible="false" id="NoTrackedThreads" runat="server" CssClass="normalTextSmallBold">û������.</asp:Label>
    </td>
  </tr>
  <tr>
    <td align="left" colSpan="2">&nbsp;
    </td>
  </tr>
  <tr>
    <td colSpan="2">
      <span class="menuTitle">��������۵�25�������:</span>
      <AspNetForums:ThreadList id="ParticipatedThreads" CssClass="tableBorder" runat="server" CellSpacing="1" CellPadding="0" Width="100%">
      </AspNetForums:ThreadList>
      <br>
      <asp:Label visible="false" id="NoParticipatedThreads" runat="server" CssClass="normalTextSmallBold">û������.</asp:Label>
    </td>
  </tr>
  <tr>
    <td align="right" colSpan="2">
      <asp:HyperLink CssClass="linkSmallBold" id="FindMorePosts" runat="server">�鿴����������۵�����</asp:HyperLink>
    </td>
  </tr>
</table>
