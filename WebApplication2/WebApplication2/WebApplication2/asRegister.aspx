<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="asRegister.aspx.cs" Inherits="WebApplication2.WebForm4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title> Sports Association Manager Register</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <label for="html">name</label><br />
                 <asp:TextBox ID="nameText" runat="server" required=""></asp:TextBox><br><br />
            <div>
                <label for="html">username</label><br />
                 <asp:TextBox ID="usernameText" runat="server" required=""></asp:TextBox><br><br />
            </div>
            <div>
                 <label for="html">password</label><br />
                 <asp:TextBox ID="password" runat="server" required=""></asp:TextBox><br><br />
            </div>
            <div>
                <asp:Button ID="Button1" runat="server" Text="Register" OnClick="fanRegister" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="login" runat="server" OnClick="login_Click">login</asp:LinkButton>
            </div>
        </div>
    </form>
</body>
</html>
