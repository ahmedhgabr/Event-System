using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using static System.Net.Mime.MediaTypeNames;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;


namespace WebApplication2
{
    public partial class WebForm3 : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Session["admin"] as string))
            {
                Response.Redirect("login.aspx");
            }
            
        }


        

        protected void addClub(object sender, EventArgs e)
        {
            
             string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);

            //int id = Int16.Parse(username.Text);
            String clubName = clubNameText.Text;
            String location = locationText.Text;
            
            SqlCommand addClubProc = new SqlCommand("addClub", conn);
            addClubProc.CommandType = CommandType.StoredProcedure;
            
            if (clubName == "") {
                MessageBox.Show("clubName can not be empty");
            }
            else if(location == "")
            {
                MessageBox.Show("location can not be empty");
            }
            else
            {
                try
                {
                    addClubProc.Parameters.Add(new SqlParameter("@club", clubName));
                    addClubProc.Parameters.Add(new SqlParameter("@clublocation", location));
                    
                    conn.Open();
                    addClubProc.ExecuteNonQuery();
                    DropDownList1.DataBind();
                    conn.Close();

                }
                catch (Exception ex) {
                    MessageBox.Show("Club name already taken");  
                }
                
            }
            

        }

        protected void deleteClub(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);
            //String clubName = clubNameText.Text;
            String clubName = DropDownList1.SelectedValue;
            try
            {
                SqlCommand deleteClubbProc = new SqlCommand("deleteClub", conn);
                deleteClubbProc.CommandType = CommandType.StoredProcedure;
                deleteClubbProc.Parameters.Add(new SqlParameter("@club", clubName));
                
                conn.Open();
                deleteClubbProc.ExecuteNonQuery();
                DropDownList1.DataBind();
                conn.Close();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Club already has matches with tickets");
            }
            

        }

        protected void addStadium(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);


            String stadiumName = stadiumNameText.Text;
            String stadiumLocation = stadiumLocationText.Text;
            String stadiumCapacity = stadiumCapacityText.Text;

                if (stadiumName == "")
                {
                    MessageBox.Show("stadiumName can not be empty");
                }
                else if (stadiumLocation == "")
                {
                    MessageBox.Show("stadiumLocation can not be empty");
                }
                else if (stadiumCapacity == "") {
                    MessageBox.Show("stadiumCapacity can not be empty");
                }
                else
                {
                    try {
                        SqlCommand addStadiumProc = new SqlCommand("addStadium", conn);
                        addStadiumProc.CommandType = CommandType.StoredProcedure;

                        addStadiumProc.Parameters.Add(new SqlParameter("@stadium", stadiumName));
                        addStadiumProc.Parameters.Add(new SqlParameter("@location", stadiumLocation));
                        addStadiumProc.Parameters.Add(new SqlParameter("@capacity", stadiumCapacity));

                        conn.Open();
                        addStadiumProc.ExecuteNonQuery();
                        DropDownList2.DataBind();
                        conn.Close();

                    }
                    catch(Exception ex) {
                        MessageBox.Show("Stadium name already taken");
                    }

                }
            

        }

        protected void deleteStadium(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);


            String stadiumName = DropDownList2.SelectedValue;

            try
            {
                SqlCommand deleteStadiumProc = new SqlCommand("deleteStadium", conn);
                deleteStadiumProc.CommandType = CommandType.StoredProcedure;

                deleteStadiumProc.Parameters.Add(new SqlParameter("@stadium", stadiumName));

                conn.Open();
                deleteStadiumProc.ExecuteNonQuery();
                DropDownList2.DataBind();
                conn.Close();

            }
            catch (Exception ex)
            {
                MessageBox.Show("there are already matches on that stadium");
            }

        }

        protected void blockFan(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);


            String fan_Nid = DropDownList3.SelectedValue;


            try
            {
                SqlCommand blockFanProc = new SqlCommand("blockFan", conn);
                blockFanProc.CommandType = CommandType.StoredProcedure;

                blockFanProc.Parameters.Add(new SqlParameter("@NationalID", fan_Nid));

                conn.Open();
                blockFanProc.ExecuteNonQuery();
                DropDownList3.DataBind();
                conn.Close();

            }
            catch (Exception ex)
            {
                MessageBox.Show("failed");
            }





        }

        protected void logout_Click(object sender, EventArgs e)
        {
            Session.Remove("admin");
            Response.Redirect("login.aspx");
        }
    }
}