<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManager.aspx.cs" Inherits="WebApplication2.WebForm8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Stadium Manager</title>
</head>
<body>
    <form id="form1" runat="server">
       <div>
             <div>
                 <asp:LinkButton ID="logout" runat="server" OnClick="logout_Click" style = "float : right">Logout</asp:LinkButton>
                 &nbsp;<asp:Label ID="Label1" runat="server" Text="Stadium Manager:" style ="font-weight : bold" ></asp:Label>
                 <br />
                 <br />
                 <asp:Button ID="viewstadium" runat="server" Text="View stadium info" OnClick="viewstadium_Click"/>
            <br />
                 <asp:GridView ID="GridView1" visible ="False" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1">
                     <Columns>
                         <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                         <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                         <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                         <asp:BoundField DataField="Capacity" HeaderText="Capacity" SortExpression="Capacity" />
                         <asp:CheckBoxField DataField="Status" HeaderText="Status" SortExpression="Status" />
                     </Columns>
                 </asp:GridView>
                 <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT * FROM Stadium WHERE Name = @stadiumname">
                     <SelectParameters>
                         <asp:SessionParameter Name="stadiumname" SessionField="stadiummanagerstadium" />
                     </SelectParameters>
                 </asp:SqlDataSource>
                 <br />
                 <br />
                 <asp:Button ID="view" runat="server" Text="View pending requests" OnClick="view_Click"/>
                 <br />
            <br />
                 <asp:GridView ID="GridView2" visible ="false" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                     <Columns>
                         <asp:BoundField DataField="ClubRepresentativeName" HeaderText="ClubRepresentativeName" SortExpression="ClubRepresentativeName" />
                         <asp:BoundField DataField="GuestClubName" HeaderText="GuestClubName" SortExpression="GuestClubName" />
                         <asp:BoundField DataField="Start_Time" HeaderText="Start_Time" SortExpression="Start_Time" />
                     </Columns>
                 </asp:GridView>
                 <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Milestone2ConnectionString %>" SelectCommand="SELECT * FROM allPendingRequests(@username)">
                     <SelectParameters>
                         <asp:SessionParameter Name="username" SessionField="stadiummanageruser" />
                     </SelectParameters>
                 </asp:SqlDataSource>
                 <br />
                 <br />
                 Please choose a request : <asp:DropDownList ID="DropDownList1" runat="server">
            </asp:DropDownList>
        </div>
        <p>
            <asp:Button ID="accept" runat="server" Text="accept request" OnClick ="accept_Click" Height="29px" Width="160px"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="reject" runat="server" Text="reject request" OnClick ="reject_Click" Height="29px" Width="160px" />
       
             </p>
             <p>
                 &nbsp;</p>
        <p>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   
        </p>
       
        </div>
    </form>
</body>
</html>
