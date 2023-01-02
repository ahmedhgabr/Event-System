<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fan.aspx.cs" Inherits="WebApplication2.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fan</title>
</head>
<body>
    <form id="form1" runat="server">

        <div>
           <asp:LinkButton ID="logout" runat="server" OnClick="logout_Click" style = "float : right">Logout</asp:LinkButton>
            &nbsp;<asp:Label ID="Label1" runat="server" Text="Fan Page" style ="font-weight : bold"></asp:Label>
            <br />
            <br />
            Please insert a datetime:<asp:TextBox ID="TextBox1" runat="server" type="datetime-local" Height="16px" required =""></asp:TextBox>
            <br />
            <br />
        <asp:Button ID="view" runat="server" Text="View Matches" OnClick ="view_Click"/>
            <br />

            <asp:GridView ID="GridView1" visible ="false" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="HostClubName" HeaderText="HostClubName" SortExpression="HostClubName" />
                    <asp:BoundField DataField="GuestClubName" HeaderText="GuestClubName" SortExpression="GuestClubName" />
                    <asp:BoundField DataField="Start_Time" HeaderText="Start_Time" SortExpression="Start_Time" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString%>" SelectCommand="SELECT * FROM availableMatchesToAttend(@datetime)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" DbType="DateTime" Name="datetime" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>

            <br />


        <br />

        <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>

        <br />

        <br />
        <br />
        <br />
            <div> 
             <br />
             <asp:Button ID="buyTicketButton" runat="server" Text="buy a ticket" OnClick="buyTicket" />

        </div>

            
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="select * from fan where National_ID = @id">
                <SelectParameters>
                    <asp:SessionParameter SessionField="fan" Name="id"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            </div>
    </form>
</body>
</html>
