<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="WebApplication2.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>admin page</title>
</head>
<body>
    <form id="adminForm" runat="server">
        <div>
            <asp:LinkButton ID="logout" runat="server" OnClick="logout_Click" style = "float : right">Logout</asp:LinkButton>
            <asp:Label ID="Label1" runat="server" Text="Admin" style ="font-weight:bold"></asp:Label>
            <br />
            <br />
            <asp:Label ID="clubNameLabel" runat="server" Text="clubName"></asp:Label>
            <br />
            <asp:TextBox ID="clubNameText" runat="server"  ></asp:TextBox><br /><br />
            <asp:Label ID="clubLocationLabel" runat="server" Text="location"></asp:Label><br />
            <asp:TextBox ID="locationText" runat="server"  ></asp:TextBox><br /><br />
      
            <asp:Button ID="addClubButton" runat="server" Text="addClub" OnClick="addClub" />
             <br />
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Name">
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Button ID="deleteClubButton" runat="server" Text="deleteClub" OnClick="deleteClub" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT [Name] FROM [Club]"></asp:SqlDataSource>
            <br />
            <br />
             <br /><br />
       </div>
       <div>
            <asp:Label ID="stadiumNameLabel" runat="server" Text="stadiumName"></asp:Label><br />
            <asp:TextBox ID="stadiumNameText" runat="server"></asp:TextBox><br /><br />

            <asp:Label ID="stadiumLocationLabel" runat="server" Text="Location"></asp:Label><br />
            <asp:TextBox ID="stadiumLocationText" runat="server"></asp:TextBox><br />


            <asp:Label ID="CapacityLabel" runat="server" Text="Capacity"></asp:Label><br />
            <asp:TextBox ID="stadiumCapacityText" runat="server" type="number"></asp:TextBox><br /><br />


            <asp:Button ID="addStadiumButton" runat="server" Text="addStadium" OnClick="addStadium" />
             <br />
            <br />
            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Name">
            </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Button ID="deleteStadiumButton" runat="server" Text="deleteStadium" OnClick="deleteStadium" /> 
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT [Name] FROM [Stadium]"></asp:SqlDataSource>
            <br />
            <br />
            <br /><br />
       </div>

        <div>
            <asp:Label ID="fanNIDLabel" runat="server" Text="fan_NationalID"></asp:Label><br />
            <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource3" DataTextField="National_ID" DataValueField="National_ID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT [National_ID] FROM [Fan] WHERE Status = 1"></asp:SqlDataSource>
            <br /><br />
      
            <asp:Button ID="blockFanButton" runat="server" Text="blockFan" OnClick="blockFan" /><br /><br />
       </div>
    </form>
</body>
</html>
