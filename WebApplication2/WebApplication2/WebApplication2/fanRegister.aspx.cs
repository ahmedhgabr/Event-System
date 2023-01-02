using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void fanRegister(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();
           
            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);

            //int id = Int16.Parse(username.Text);
            String name = nameText.Text;
            String username = usernameText.Text;
            String pass = password.Text;
            String nationalid= nationalText.Text;
            String address = addressText.Text;
            String phoneNumber = phoneNumberText.Text;
            String birtdate = birtdateText.Text;
            

            SqlCommand addFanProc = new SqlCommand("addFan", conn);
            addFanProc.CommandType = CommandType.StoredProcedure;

            addFanProc.Parameters.Add(new SqlParameter("@Name", name));
            addFanProc.Parameters.Add(new SqlParameter("@Username", username));
            addFanProc.Parameters.Add(new SqlParameter("@password", pass));
            addFanProc.Parameters.Add(new SqlParameter("@NationalID", nationalid));
            addFanProc.Parameters.Add(new SqlParameter("@Address", address));
            addFanProc.Parameters.Add(new SqlParameter("@Phone", phoneNumber));
            addFanProc.Parameters.Add(new SqlParameter("@BirthDate", birtdate));
            
            try {
                conn.Open();
                addFanProc.ExecuteNonQuery();
                conn.Close();

               // Session["n_id"] = nationalid;
                Response.Redirect("login.aspx");

            }catch(Exception ex) {
                Response.Write("username already taken or you already have an account");  
            }
            


        }
        protected void login_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}