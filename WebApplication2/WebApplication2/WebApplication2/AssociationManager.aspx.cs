using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace WebApplication2
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (DropDownList1.Items.Count == 0)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();
                // create new connection 
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand Matches = new SqlCommand("select c1.name as HostClub ,c2.name as GuestClub , m.Start_Time,m.end_time from (((Club c1 inner join Match m on c1.club_ID=m.Host_Club_ID) inner join Club c2 on c2.club_ID=m.Guest_Club_ID) )", conn);
                Matches.CommandType = CommandType.Text;
                //  Matches.Parameters.Add(new SqlParameter("@D", MatchDate));

                conn.Open();
                Matches.ExecuteNonQuery();
                SqlDataReader rdr = Matches.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    string HostName = rdr.GetString(rdr.GetOrdinal("HostClub"));
                    string GuestName = rdr.GetString(rdr.GetOrdinal("GuestClub"));
                    DateTime startdate = rdr.GetDateTime(rdr.GetOrdinal("Start_Time"));
                    DateTime enddate = rdr.GetDateTime(rdr.GetOrdinal("end_time"));
                    DropDownList1.Items.Add(HostName + "|" + GuestName + "|" + startdate + "|" + enddate);
                }



            }
            if (string.IsNullOrEmpty(Session["associationmanager"] as string))
            {
                Response.Redirect("login.aspx");
            }
        }

        protected void addMatch(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);

            //int id = Int16.Parse(username.Text);
            String hclubName = hclubNameText.Text;
            String gclubName = gclubNameText.Text;
            String startime = startTimeText.Text;
            String endtime = endTimeText.Text;


            if (hclubName == "")
            {
                Response.Write("hclubName can not be empty");
            }
            else if(gclubName == "")
            {
                Response.Write("gclubName can not be empty");
            }
            else if (startime == "")
            {
                Response.Write("startime can not be empty");
            }
            else if (endtime == "")
            {
                Response.Write("endtime can not be empty");
            }else {
                try
                {
                    SqlCommand addMatchProc = new SqlCommand("addNewMatch", conn);
                    addMatchProc.CommandType = CommandType.StoredProcedure;

                    addMatchProc.Parameters.Add(new SqlParameter("@hostclub", hclubName));
                    addMatchProc.Parameters.Add(new SqlParameter("@guestclub", gclubName));
                    addMatchProc.Parameters.Add(new SqlParameter("@starttime", startime));
                    addMatchProc.Parameters.Add(new SqlParameter("@endtime", endtime));

                    conn.Open();
                    addMatchProc.ExecuteNonQuery();
                    GridView2.DataBind();
                    GridView1.DataBind();
                    conn.Close();

                }catch(Exception ex)
                {
                    MessageBox.Show("there is already a match with this info");  
                }
                
            }
            
        }

        protected void deleteMatch(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);

            //int id = Int16.Parse(username.Text);
            


            String[] matchText = DropDownList1.SelectedValue.Split('|');

            String hostClub = matchText[0];
            String guestClub = matchText[1];
            String startTime = matchText[2];
            String endTime = matchText[3];

            try
            {
                SqlCommand deleteMatchProc = new SqlCommand("deleteMatch", conn);
                deleteMatchProc.CommandType = CommandType.StoredProcedure;

                deleteMatchProc.Parameters.Add(new SqlParameter("@hostclub", hostClub));
                deleteMatchProc.Parameters.Add(new SqlParameter("@guestclub", guestClub));
                //deleteMatchProc.Parameters.Add(new SqlParameter("@starttime", startime));
                //deleteMatchProc.Parameters.Add(new SqlParameter("@endtime", endtime));

                conn.Open();
                deleteMatchProc.ExecuteNonQuery();
                GridView2.DataBind();
                GridView1.DataBind();
                DropDownList1.Items.Clear();
                if (DropDownList1.Items.Count == 0)
                {
                    string connStr1 = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();
                    // create new connection 
                    SqlConnection conn1 = new SqlConnection(connStr);

                    SqlCommand Matches1 = new SqlCommand("select c1.name as HostClub ,c2.name as GuestClub , m.Start_Time,m.end_time from (((Club c1 inner join Match m on c1.club_ID=m.Host_Club_ID) inner join Club c2 on c2.club_ID=m.Guest_Club_ID) )", conn1);
                    Matches1.CommandType = CommandType.Text;
                    //  Matches.Parameters.Add(new SqlParameter("@D", MatchDate));

                    conn1.Open();
                    Matches1.ExecuteNonQuery();
                    SqlDataReader rdr1 = Matches1.ExecuteReader(CommandBehavior.CloseConnection);
                    while (rdr1.Read())
                    {
                        string HostName = rdr1.GetString(rdr1.GetOrdinal("HostClub"));
                        string GuestName = rdr1.GetString(rdr1.GetOrdinal("GuestClub"));
                        DateTime startdate = rdr1.GetDateTime(rdr1.GetOrdinal("Start_Time"));
                        DateTime enddate = rdr1.GetDateTime(rdr1.GetOrdinal("end_time"));
                        DropDownList1.Items.Add(HostName + "|" + GuestName + "|" + startdate + "|" + enddate);
                    }



                }
                conn.Close();


            }
            catch (Exception ex)
            {
                MessageBox.Show("failed");
            }

            
        }
        protected void logout_Click(object sender, EventArgs e)
        {
            Session.Remove("associationmanager");
            Response.Redirect("login.aspx");
        }
    }
}