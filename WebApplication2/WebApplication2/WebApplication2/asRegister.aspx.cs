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
    public partial class WebForm4 : System.Web.UI.Page
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


            SqlCommand addAssociationProc = new SqlCommand("addAssociationManager", conn);
            addAssociationProc.CommandType = CommandType.StoredProcedure;

            addAssociationProc.Parameters.Add(new SqlParameter("@AssociationManager", name));
            addAssociationProc.Parameters.Add(new SqlParameter("@username", username));
            addAssociationProc.Parameters.Add(new SqlParameter("@password", pass));

            try
            {
                conn.Open();
                addAssociationProc.ExecuteNonQuery();
                conn.Close();
                Response.Redirect("login.aspx");
            }catch(Exception ex) { 
                 Response.Write("username is already taken");    
            }
            



        }
        protected void login_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}