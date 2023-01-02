<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssociationManager.aspx.cs" Inherits="WebApplication2.WebForm5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sports Association Manager</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:LinkButton ID="logout" runat="server" OnClick="logout_Click" style ="float : right">Logout</asp:LinkButton>
            <asp:Label ID="Label1" runat="server" Text="Association Manager" style ="font-weight : bold"></asp:Label>
            <br />
            <br />
            <asp:Label ID="hclubNameLabel" runat="server" Text="HostclubName"></asp:Label><br />
            <asp:TextBox ID="hclubNameText" runat="server"></asp:TextBox><br /><br />

            <asp:Label ID="gclubNameLabel" runat="server" Text="GuestClubName"></asp:Label><br />
            <asp:TextBox ID="gclubNameText" runat="server"></asp:TextBox><br /><br />

            <asp:Label ID="startTimeLabel" runat="server" Text="start Time"></asp:Label><br />
            <asp:TextBox ID="startTimeText" runat="server"></asp:TextBox><br /><br />

            <asp:Label ID="endTimeLabel" runat="server" Text="end Time"></asp:Label><br />
            <asp:TextBox ID="endTimeText" runat="server"></asp:TextBox><br /><br />

            <asp:Button ID="Button1" runat="server" Text="Add New Match" OnClick="addMatch"/>
            <br />
            <br />
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server">
            </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" Text="delete Match" OnClick="deleteMatch"/>
            <br />
            <br />
            <br />
            <br />


            <asp:Label ID="upcomingMatches" runat="server" Text="upcoming matches"></asp:Label>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                <Columns>
                    <asp:BoundField DataField="HostClub" HeaderText="HostClub" SortExpression="HostClub"></asp:BoundField>
                    <asp:BoundField DataField="GuestClub" HeaderText="GuestClub" SortExpression="GuestClub"></asp:BoundField>
                    <asp:BoundField DataField="Start_Time" HeaderText="Start_Time" SortExpression="Start_Time"></asp:BoundField>
                    <asp:BoundField DataField="end_time" HeaderText="end_time" SortExpression="end_time" />
                </Columns>
            </asp:GridView><br />
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="select c1.name as HostClub ,c2.name as GuestClub , m.Start_Time ,m.end_time
from (((Club c1 inner join Match m on c1.club_ID=m.Host_Club_ID) inner join Club c2 on c2.club_ID=m.Guest_Club_ID) )"></asp:SqlDataSource><br /><br />


            <asp:Label ID="alreadyPlayed" runat="server" Text=" already played"></asp:Label>
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3">
                <Columns>
                    <asp:BoundField DataField="HostClub" HeaderText="HostClub" SortExpression="HostClub"></asp:BoundField>
                    <asp:BoundField DataField="GuestClub" HeaderText="GuestClub" SortExpression="GuestClub"></asp:BoundField>
                    <asp:BoundField DataField="Start_Time" HeaderText="Start_Time" SortExpression="Start_Time"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT [HostClub], [GuestClub], [Start_Time] FROM [allMatches] WHERE CURRENT_TIMESTAMP > [Start_Time]"></asp:SqlDataSource>

            <br /><br />
            <asp:Label ID="neverMatched" runat="server" Text="neverMatched"></asp:Label>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource10">
                <Columns>
                    <asp:BoundField DataField="CLUB1" HeaderText="CLUB1" SortExpression="CLUB1"></asp:BoundField>
                    <asp:BoundField DataField="CLUB2" HeaderText="CLUB2" SortExpression="CLUB2"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="SqlDataSource10" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT [CLUB1], [CLUB2] FROM [clubsNeverMatched]"></asp:SqlDataSource>



        </div>


    </form>
</body>
</html>
