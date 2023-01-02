<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fanRegister.aspx.cs" Inherits="WebApplication2.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>fan register</title>
</head>
<body>
   
    <form id="form1" runat="server">
        <div>
            <h2>Register</h2>
        </div>
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
                <label for="html">nationalid</label><br />
                 <asp:TextBox ID="nationalText" runat="server" required="" ></asp:TextBox><br><br />
            </div>
            <div>
                <label for="html">address</label><br />
                 <asp:TextBox ID="addressText" runat="server" required=""></asp:TextBox><br><br />
            </div>
            <div>
                <label for="html">phoneNumber</label><br />
                 <asp:TextBox ID="phoneNumberText" runat="server" required="" ></asp:TextBox><br><br />
            </div>
            <div>
                <label for="html">birtdate</label><br />
                 <asp:TextBox ID="birtdateText" runat="server" required=""></asp:TextBox><br><br/>
            </div>
        </div>
         <asp:Button runat="server" Text="register" onclick="fanRegister"></asp:Button>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:LinkButton ID="login" runat="server" OnClick="login_Click">login</asp:LinkButton>
        

    </form>
</body>
</html>
