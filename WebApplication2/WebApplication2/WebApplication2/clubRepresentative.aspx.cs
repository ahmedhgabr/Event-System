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

namespace WebApplication2
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Session["clubrepresentative"] as string))
            {
                Response.Redirect("login.aspx");
            }
        }

        protected void ClubInfoClick(object sender, EventArgs e)
        {
            GridView12.Visible = true;
        }
        protected void MatchesClick(object sender, EventArgs e)
        {
            GridView2.Visible = true;

        }

        protected void StadiumsClick(object sender, EventArgs e)
        {
            if(Date.Text == "")
            {
                MessageBox.Show("Date Can't be empty");
            }
            GridView3.Visible = true;
        }
        protected void SendRequest(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand Addrequest = new SqlCommand("addHostRequest", conn);

            Addrequest.CommandType = CommandType.StoredProcedure;


            
            if (MatchDate.Text == "")
            {
                MessageBox.Show("Date of Match can not be empty");
            }
            else
            {
                try
                {

                    DateTime DateofMatch = Convert.ToDateTime(MatchDate.Text);
                    String StadName = DropDownList1.SelectedValue;
                    String ClubName = Convert.ToString(Session["clubrepresentative"]);

                    Addrequest.Parameters.Add(new SqlParameter("@ClubName", ClubName));
                    Addrequest.Parameters.Add(new SqlParameter("@StadiumName", StadName));
                    Addrequest.Parameters.Add(new SqlParameter("@StartTime", DateofMatch));

                    conn.Open();
                    Addrequest.ExecuteNonQuery();
                    Response.Write(StadName);
                    DropDownList1.DataBind();
                    conn.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("failed");
                }

            }


        }
        protected void logout_Click(object sender, EventArgs e)
        {
            Session.Remove("clubrepresentative");
            Response.Redirect("login.aspx");
        }

    }
}