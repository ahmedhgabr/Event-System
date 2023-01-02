<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication2.WebForm10" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             username :
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            <br />
            password :
            <asp:TextBox ID="password" runat="server" type ="password"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Login" runat="server" Text="Login" OnClick="Login_Click" /><br /><br />
            
            <a href="Register.aspx">Register</a>
           
        </div>
    </form>
</body>
</html>
