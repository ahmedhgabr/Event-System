<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="repRegister.aspx.cs" Inherits="WebApplication2.WebForm7" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Club Representative Register</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <label for="html">name</label><br />
                 <asp:TextBox ID="nameText" runat="server" required=""></asp:TextBox><br><br />
            <div>
                 <label for="html">username</label><br />
                 <asp:TextBox ID="usernameText" runat="server" required=""></asp:TextBox><br /><br />
            </div>
            <div>
                 <label for="html">password</label><br />
                 <asp:TextBox ID="password" runat="server" required=""></asp:TextBox><br /><br />
            </div>
                <label for="html">Club name</label><br />
                <br />
             <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Name">
             </asp:DropDownList>
             <br />
             <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT c1.Name FROM Club c1 WHERE NOT EXISTS(SELECT * FROM Club c,ClubRepresentative cr WHERE c.club_ID = cr.Club_ID AND c.Name = c1.Name)"></asp:SqlDataSource>
             <br />
            <asp:Button ID="Button1" runat="server" Text="Register" OnClick="clubRepRegister" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="login" runat="server" OnClick="login_Click">login</asp:LinkButton>
        </div>
    </form>
</body>
</html>
