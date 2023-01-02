using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace WebApplication2
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Session["stadiummanageruser"] as string))
            {
                Response.Redirect("login.aspx");
            }
        }

        protected void view_Click(object sender, EventArgs e)
        {
            if (DropDownList1.Items.Count == 0)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();
                // create new connection 
                SqlConnection conn = new SqlConnection(connStr);
                String username = Convert.ToString(Session["stadiummanageruser"]);
                GridView2.Visible = true;

                SqlCommand hostrequest = new SqlCommand("SELECT * FROM allPendingRequests(@username)", conn);
                hostrequest.Parameters.AddWithValue("@username", username);
                hostrequest.CommandType = CommandType.Text;
                //  Matches.Parameters.Add(new SqlParameter("@D", MatchDate));

                conn.Open();
                hostrequest.ExecuteNonQuery();
                SqlDataReader rdr = hostrequest.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    string represntative = rdr.GetString(rdr.GetOrdinal("ClubRepresentativeName"));
                    string GuestName = rdr.GetString(rdr.GetOrdinal("GuestClubName"));
                    DateTime date = rdr.GetDateTime(rdr.GetOrdinal("Start_Time"));
                    DropDownList1.Items.Add(represntative + "|" + GuestName + "|" + date);
                }


            }
        }

        protected void accept_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);
            SqlConnection conn1 = new SqlConnection(connStr);

            // dropdown list 
            String[] requests = DropDownList1.SelectedValue.Split('|');

            String username = Convert.ToString(Session["stadiummanageruser"]);
            String hostClub = "";
            String represntative = requests[0];
            String guestClub = requests[1];
            String startTime = requests[2];

            SqlCommand clubname = new SqlCommand("SELECT c.Name FROM Club c,ClubRepresentative cr WHERE c.club_ID = cr.Club_ID AND cr.Name = @rep", conn1);
            clubname.CommandType = CommandType.Text;
            clubname.Parameters.AddWithValue("@rep", represntative);
            conn1.Open();
            clubname.ExecuteNonQuery();
            SqlDataReader rdr = clubname.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                hostClub = rdr.GetString(rdr.GetOrdinal("Name"));
            }
            conn1.Close();

            SqlCommand accept = new SqlCommand("acceptRequest", conn);
            accept.CommandType = CommandType.StoredProcedure;
            accept.Parameters.Add(new SqlParameter("@StadiumManagerUserName", username));
            accept.Parameters.Add(new SqlParameter("@HostName", hostClub));
            accept.Parameters.Add(new SqlParameter("@GuestName", guestClub));
            accept.Parameters.Add(new SqlParameter("@time", startTime));

            conn.Open();
            accept.ExecuteNonQuery();
            GridView2.DataBind();
            DropDownList1.Items.Clear();
            if (DropDownList1.Items.Count == 0)
            {
                string connStr1 = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();
                // create new connection 
                SqlConnection conn2 = new SqlConnection(connStr);
                String username1 = Convert.ToString(Session["stadiummanageruser"]);
                GridView2.Visible = true;

                SqlCommand hostrequest1 = new SqlCommand("SELECT * FROM allPendingRequests(@username)", conn2);
                hostrequest1.Parameters.AddWithValue("@username", username1);
                hostrequest1.CommandType = CommandType.Text;
                //  Matches.Parameters.Add(new SqlParameter("@D", MatchDate));

                conn2.Open();
                hostrequest1.ExecuteNonQuery();
                SqlDataReader rdr1 = hostrequest1.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr1.Read())
                {
                    string represntative1 = rdr1.GetString(rdr1.GetOrdinal("ClubRepresentativeName"));
                    string GuestName1 = rdr1.GetString(rdr1.GetOrdinal("GuestClubName"));
                    DateTime date1 = rdr1.GetDateTime(rdr1.GetOrdinal("Start_Time"));
                    DropDownList1.Items.Add(represntative1 + "|" + GuestName1 + "|" + date1);
                }


            }
            conn.Close();


        }

        protected void reject_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);
            SqlConnection conn1 = new SqlConnection(connStr);

            // dropdown list 
            String[] requests = DropDownList1.SelectedValue.Split('|');

            String username = Convert.ToString(Session["stadiummanageruser"]);
            String hostClub = "";
            String represntative = requests[0];
            String guestClub = requests[1];
            String startTime = requests[2];

            SqlCommand clubname = new SqlCommand("SELECT c.Name FROM Club c,ClubRepresentative cr WHERE c.club_ID = cr.Club_ID AND cr.Name = @rep", conn1);
            clubname.CommandType = CommandType.Text;
            clubname.Parameters.AddWithValue("@rep", represntative);
            conn1.Open();
            clubname.ExecuteNonQuery();
            SqlDataReader rdr = clubname.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                hostClub = rdr.GetString(rdr.GetOrdinal("Name"));
            }
            conn1.Close();

            SqlCommand reject = new SqlCommand("rejectRequest", conn);
            reject.CommandType = CommandType.StoredProcedure;
            reject.Parameters.Add(new SqlParameter("@StadiumManagerName", username));
            reject.Parameters.Add(new SqlParameter("@HostName", hostClub));
            reject.Parameters.Add(new SqlParameter("@GuestName", guestClub));
            reject.Parameters.Add(new SqlParameter("@time", startTime));

            conn.Open();
            reject.ExecuteNonQuery();
            GridView2.DataBind();
            DropDownList1.Items.Clear();
            if (DropDownList1.Items.Count == 0)
            {
                string connStr1 = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();
                // create new connection 
                SqlConnection conn2 = new SqlConnection(connStr);
                String username1 = Convert.ToString(Session["stadiummanageruser"]);
                GridView2.Visible = true;

                SqlCommand hostrequest1 = new SqlCommand("SELECT * FROM allPendingRequests(@username)", conn2);
                hostrequest1.Parameters.AddWithValue("@username", username1);
                hostrequest1.CommandType = CommandType.Text;
                //  Matches.Parameters.Add(new SqlParameter("@D", MatchDate));

                conn2.Open();
                hostrequest1.ExecuteNonQuery();
                SqlDataReader rdr1 = hostrequest1.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr1.Read())
                {
                    string represntative1 = rdr1.GetString(rdr1.GetOrdinal("ClubRepresentativeName"));
                    string GuestName1 = rdr1.GetString(rdr1.GetOrdinal("GuestClubName"));
                    DateTime date1 = rdr1.GetDateTime(rdr1.GetOrdinal("Start_Time"));
                    DropDownList1.Items.Add(represntative1 + "|" + GuestName1 + "|" + date1);
                }


            }
            conn.Close();


        }


        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void viewstadium_Click(object sender, EventArgs e)
        {
            GridView1.Visible = true;
        }
        protected void logout_Click(object sender, EventArgs e)
        {
            Session.Remove("stadiummanageruser"); 
            Response.Redirect("login.aspx");
        }
    }
}