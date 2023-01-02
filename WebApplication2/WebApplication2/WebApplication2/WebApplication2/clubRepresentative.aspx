<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="clubRepresentative.aspx.cs" Inherits="WebApplication2.WebForm6" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Club Representative</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            
            <asp:LinkButton ID="logout" runat="server" OnClick="logout_Click" style = "float : right">Logout</asp:LinkButton>
            <asp:Label ID="Label5" runat="server" Text="Club Representative" style ="font-weight : bold"></asp:Label>
            <br />

        </div>
        <br />
        <asp:Button ID="ClubInfo" runat="server" Text="View Club Info" OnClick="ClubInfoClick"/> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Matches" runat="server" Text="View Upcomming Matches" OnClick="MatchesClick" />
        <br /><br />
        
        <asp:GridView ID="GridView12" visible="False" runat="server" DataSourceID="SqlDataSource2"></asp:GridView>
    <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT Club.* FROM Club where club.name = @name">
        <SelectParameters>
            <asp:SessionParameter SessionField="clubrepresentative" Name="name"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
        <br />
        <asp:GridView ID="GridView2" visible="False"  runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" DataKeyNames="match_ID,club_ID">
            <Columns>
                <asp:BoundField DataField="match_ID" HeaderText="match_ID" SortExpression="match_ID" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="Start_Time" HeaderText="Start_Time" SortExpression="Start_Time" />
                <asp:BoundField DataField="end_time" HeaderText="end_time" SortExpression="end_time" />
                <asp:BoundField DataField="Host_Club_ID" HeaderText="Host_Club_ID" SortExpression="Host_Club_ID" />
                <asp:BoundField DataField="Guest_Club_ID" HeaderText="Guest_Club_ID" SortExpression="Guest_Club_ID" />
                <asp:BoundField DataField="Stadium_ID" HeaderText="Stadium_ID" SortExpression="Stadium_ID" />
                <asp:BoundField DataField="club_ID" HeaderText="club_ID" InsertVisible="False" ReadOnly="True" SortExpression="club_ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="Select * From Match , Club
Where ( Club.Club_ID = Match.Host_Club_ID OR Club.Club_ID = Match.Guest_Club_ID ) AND @name = Club.name
">
            <SelectParameters>
                <asp:SessionParameter SessionField="clubrepresentative" Name="name"></asp:SessionParameter>
               
            </SelectParameters>
        </asp:SqlDataSource>
        <p>

            ______________________________________________________________</p>
        <p>

            <asp:Label ID="Label2" runat="server" Text="Please Specify a Date"></asp:Label>

        </p>
        <p>
            <asp:TextBox ID="Date" runat="server" type="datetime-local"  ></asp:TextBox>
        &nbsp;
        <asp:Button ID="Button3" runat="server" Text="View Available Stadiums" OnClick="StadiumsClick" />
            <asp:GridView ID="GridView3" Visible="False" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Capacity" HeaderText="Capacity" SortExpression="Capacity" />
                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="Select * From viewAvailableStadiumsOn (@D)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Date" DbType="DateTime" DefaultValue="" Name="D" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            </p>
        <p>
            _______________________________________________________________</p>
       
        <p>
            
            
        </p>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Choose a stadium"></asp:Label>
        </p>
        <p>
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource3" DataTextField="Name" DataValueField="Name">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT Name FROM Stadium WHERE Status = 1"></asp:SqlDataSource>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
        <p>
            <asp:Label ID="Label4" runat="server" Text="Specify Match Date "></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="MatchDate" runat="server" type="datetime-local"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button4" runat="server" Text="Send Request" OnClick="SendRequest" />
        </p>
    </form>
</body>

</html>