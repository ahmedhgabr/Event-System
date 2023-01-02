using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class WebForm7 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void clubRepRegister(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);

            String name = nameText.Text;
            String username = usernameText.Text;
            String pass = password.Text;
            String clubName = DropDownList1.SelectedValue;
            
            
            try {
                SqlCommand addRepProc = new SqlCommand("addRepresentative", conn);
                addRepProc.CommandType = CommandType.StoredProcedure;

                addRepProc.Parameters.Add(new SqlParameter("@Name", name));
                addRepProc.Parameters.Add(new SqlParameter("@ClubName", clubName));
                addRepProc.Parameters.Add(new SqlParameter("@username", username));
                addRepProc.Parameters.Add(new SqlParameter("@password", pass));

                conn.Open();
                addRepProc.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("login.aspx");
            }
            catch {
                Response.Write("username already taken");   
            }
            
        }
        protected void login_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}