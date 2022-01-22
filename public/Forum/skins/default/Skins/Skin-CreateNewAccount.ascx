<%@ Import Namespace="AspNetForums.Controls" %>
<%@ Import Namespace="AspNetForums.Components" %>
<%@ Control Language="C#" %>
<table cellspacing="1" cellpadding="3" width="600" Class="tableBorder">
    <tr>
        <th class="tableHeaderText" align="left">
            &nbsp;ע�����û�
        </th>
    </tr>
    <tr>
        <td class="forumRow">
            <table cellpadding="3" cellspacing="1" border="0">
                <tr>
                    <td colspan="3">
                        <span class="normalTextSmall">
              ������Ѿ�ע��ɹ����� <A href="<%=Globals.UrlLogin%>">��¼</A>.
              <P>
              �û�������Ϊ���ڱ�վ��������������û�����Email�����ǻὫ���뷢�͵�����д��Email���䡣�յ�������Դ˵�¼��
              <P>
                                ע��: Ϊ�˰�ȫ����<b>��Ҫ</b>��д�������䣬�������ڱ�վ��Ҳ��Ψһ�ġ�
            </span>
                    </td>
                </tr>
                <tr>
                    <td align="right" nowrap>
                        <span class="normalTextSmallBold">
              �û���:
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
              �ܣ���:
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
            <a href="<%=Globals.UrlForgotPassword%>">�����������һ�>></a>
            </span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<P>
