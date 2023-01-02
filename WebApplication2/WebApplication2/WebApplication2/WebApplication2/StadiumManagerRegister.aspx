<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManagerRegister.aspx.cs" Inherits="WebApplication2.WebForm9" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Stadium Manager Register</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="name"  ></asp:Label>
            <br />
            <asp:TextBox ID="TextBox1" runat="server" required=""></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="username"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox2" runat="server" required=""></asp:TextBox>
            <br />
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="password"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox3" runat="server" required=""></asp:TextBox>
            <br />
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Please Specify Your Stadium Name"></asp:Label>
        
            <br />
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Name">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT s1.Name FROM Stadium s1 WHERE NOT EXISTS(SELECT * FROM Stadium s,StadiumManager sm WHERE s.ID = sm.Stadium_ID AND s.Name = s1.Name) "></asp:SqlDataSource>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Register" OnClick="SMRegister"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="login" runat="server" OnClick="login_Click">login</asp:LinkButton>
        </p>
            <p>
                &nbsp;</p>
        </div>
    </form>
</body>
</html>
