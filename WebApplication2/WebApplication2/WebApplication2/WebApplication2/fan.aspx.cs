using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using System.Xml.Linq;

namespace WebApplication2
{

    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Session["fan"] as string))
            {
                Response.Redirect("login.aspx");
            }
        }

            protected void buyTicket(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);

            // dropdown list 
            String[] matchText = DropDownList1.SelectedValue.Split('|');

            String nid = Convert.ToString(Session["fan"]);
            String hostClub = matchText[0];
            String guestClub = matchText[1];
            String startTime = matchText[2];


            SqlCommand purchaseTicketProc = new SqlCommand("purchaseTicket", conn);
            purchaseTicketProc.CommandType = CommandType.StoredProcedure;
            purchaseTicketProc.Parameters.Add(new SqlParameter("@n_id", nid));
            purchaseTicketProc.Parameters.Add(new SqlParameter("@hClubName", hostClub));
            purchaseTicketProc.Parameters.Add(new SqlParameter("@guestClubName", guestClub));
            purchaseTicketProc.Parameters.Add(new SqlParameter("@date", startTime));

            conn.Open();
            purchaseTicketProc.ExecuteNonQuery();
            GridView1.DataBind();
            DropDownList1.Items.Clear();
            if (DropDownList1.Items.Count == 0)
            {
                string connStr1 = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();
                // create new connection 
                SqlConnection conn1 = new SqlConnection(connStr);
                try
                {
                    DateTime date1 = Convert.ToDateTime(TextBox1.Text);

                    GridView1.Visible = true;
                    SqlCommand Matches = new SqlCommand("SELECT * FROM availableMatchesToAttend(@datetime)", conn1);
                    Matches.Parameters.AddWithValue("@datetime", date1);
                    Matches.CommandType = CommandType.Text;
                    //  Matches.Parameters.Add(new SqlParameter("@D", MatchDate));

                    conn1.Open();
                    Matches.ExecuteNonQuery();
                    SqlDataReader rdr = Matches.ExecuteReader(CommandBehavior.CloseConnection);
                    while (rdr.Read())
                    {
                        string HostName = rdr.GetString(rdr.GetOrdinal("HostClubName"));
                        string GuestName = rdr.GetString(rdr.GetOrdinal("GuestClubName"));
                        DateTime date = rdr.GetDateTime(rdr.GetOrdinal("Start_Time"));
                        string stadiumname = rdr.GetString(rdr.GetOrdinal("Name"));
                        DropDownList1.Items.Add(HostName + "|" + GuestName + "|" + date + "|Stadium: " + stadiumname);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Please enter a date");
                }
            }
                conn.Close();


        }


        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void view_Click(object sender, EventArgs e)
        {
            if (DropDownList1.Items.Count == 0)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();
                // create new connection 
                SqlConnection conn = new SqlConnection(connStr);
                try
                {
                    DateTime date1 = Convert.ToDateTime(TextBox1.Text);
                
                GridView1.Visible = true;
                SqlCommand Matches = new SqlCommand("SELECT * FROM availableMatchesToAttend(@datetime)", conn);
                Matches.Parameters.AddWithValue("@datetime", date1);
                Matches.CommandType = CommandType.Text;
                //  Matches.Parameters.Add(new SqlParameter("@D", MatchDate));

                conn.Open();
                Matches.ExecuteNonQuery();
                SqlDataReader rdr = Matches.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    string HostName = rdr.GetString(rdr.GetOrdinal("HostClubName"));
                    string GuestName = rdr.GetString(rdr.GetOrdinal("GuestClubName"));
                    DateTime date = rdr.GetDateTime(rdr.GetOrdinal("Start_Time"));
                    string stadiumname = rdr.GetString(rdr.GetOrdinal("Name"));
                    DropDownList1.Items.Add(HostName + "|" + GuestName + "|" + date + "|Stadium: " + stadiumname);
                }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Please enter a date");
                }

            }
        }
        protected void logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("login.aspx");
        }

    }



}