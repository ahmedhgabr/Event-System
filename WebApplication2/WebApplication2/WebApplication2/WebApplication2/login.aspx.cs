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

namespace WebApplication2
{
    public partial class WebForm10 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Milestone2Entities"].ToString();

            // create new connection 
            SqlConnection conn = new SqlConnection(connStr);


            //find user 
            SqlCommand systemuser = new SqlCommand("SELECT username,Password FROM SystemUser", conn);
            systemuser.CommandType = CommandType.Text;


            conn.Open();
            systemuser.ExecuteNonQuery();
            SqlDataReader rdr = systemuser.ExecuteReader(CommandBehavior.CloseConnection);
            Boolean flag = false;
            while (rdr.Read())
            {
                if (username.Text == rdr.GetString(rdr.GetOrdinal("username")) && password.Text == rdr.GetString(rdr.GetOrdinal("Password")))
                {
                    flag = true;
                    break;
                }
            }
            conn.Close();



            if (flag)
            {
                // fan login 
                SqlCommand fan = new SqlCommand("Select count(username) as count ,National_ID FROM Fan WHERE username = @user GROUP BY National_ID ", conn);
                fan.CommandType = CommandType.Text;
                fan.Parameters.AddWithValue("@user", username.Text);
                conn.Open();
                fan.ExecuteNonQuery();
                SqlDataReader rdrfan = fan.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdrfan.Read())
                {
                    Int32 countfan = rdrfan.GetInt32(rdrfan.GetOrdinal("count"));

                    if (countfan > 0)
                    {
                        String nationalid = rdrfan.GetString(rdrfan.GetOrdinal("National_ID"));
                        Session["fan"] = nationalid;
                        Response.Redirect("fan.aspx");
                    }
                }

                conn.Close();

                //staduim manger login
                SqlCommand sm = new SqlCommand("Select count(username) as count ,username,Stadium_ID FROM StadiumManager WHERE username = @user GROUP BY username,Stadium_ID ", conn);
                sm.CommandType = CommandType.Text;
                sm.Parameters.AddWithValue("@user", username.Text);
                conn.Open();
                Int32 stadiumid = 0;
                sm.ExecuteNonQuery();
                SqlDataReader rdrsm = sm.ExecuteReader(CommandBehavior.CloseConnection);
                Boolean flagsm = false;
                while (rdrsm.Read())
                {
                    stadiumid = rdrsm.GetInt32(rdrsm.GetOrdinal("Stadium_ID"));
                    Int32 countsm = rdrsm.GetInt32(rdrsm.GetOrdinal("count"));

                    if (countsm > 0)
                    {
                        flagsm = true;
                    }
                }
                conn.Close();

                if (flagsm)
                {
                    SqlCommand stadium = new SqlCommand("SELECT Name FROM Stadium WHERE ID = @id", conn);
                    stadium.CommandType = CommandType.Text;
                    stadium.Parameters.AddWithValue("@id", stadiumid);
                    conn.Open();

                    stadium.ExecuteNonQuery();
                    SqlDataReader rdrstadium = stadium.ExecuteReader(CommandBehavior.CloseConnection);
                    while (rdrstadium.Read())
                    {
                        String stadiumname = rdrstadium.GetString(rdrstadium.GetOrdinal("Name"));
                        Session["stadiummanageruser"] = username.Text;
                        Session["stadiummanagerstadium"] = stadiumname;
                        Response.Redirect("StadiumManager.aspx");
                    }
                }
                conn.Close();


                //ClubRepresentative login
                SqlCommand cr = new SqlCommand("Select count(username) as count ,Club_ID FROM ClubRepresentative WHERE username = @user GROUP BY Club_ID ", conn);
                cr.CommandType = CommandType.Text;
                cr.Parameters.AddWithValue("@user", username.Text);
                conn.Open();
                Int32 id = 0;
                cr.ExecuteNonQuery();
                SqlDataReader rdrcr = cr.ExecuteReader(CommandBehavior.CloseConnection);
                Boolean flagcr = false;
                while (rdrcr.Read())
                {
                    id = rdrcr.GetInt32(rdrcr.GetOrdinal("Club_ID"));
                    Int32 countcr = rdrcr.GetInt32(rdrcr.GetOrdinal("count"));

                    if (countcr > 0)
                    {
                        flagcr = true;
                    }
                }
                conn.Close();
                if (flagcr)
                {
                    SqlCommand club = new SqlCommand("SELECT Name FROM Club WHERE club_ID = @id", conn);
                    club.CommandType = CommandType.Text;
                    club.Parameters.AddWithValue("@id", id);
                    conn.Open();

                    club.ExecuteNonQuery();
                    SqlDataReader rdrclub = club.ExecuteReader(CommandBehavior.CloseConnection);
                    while (rdrclub.Read())
                    {
                        String clubname = rdrclub.GetString(rdrclub.GetOrdinal("Name"));
                        Session["clubrepresentative"] = clubname;
                        Response.Redirect("clubRepresentative.aspx");
                    }
                }
                conn.Close();

                SqlCommand admin = new SqlCommand("Select count(username) as count FROM SystemAdmin WHERE username = @user", conn);
                admin.CommandType = CommandType.Text;
                admin.Parameters.AddWithValue("@user", username.Text);
                conn.Open();
                admin.ExecuteNonQuery();
                SqlDataReader rdradmin = admin.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdradmin.Read())
                {
                    Int32 countadmin = rdradmin.GetInt32(rdradmin.GetOrdinal("count"));

                    if (countadmin > 0)
                    {
                        Session["admin"] = username.Text;
                        Response.Redirect("admin.aspx");
                    }
                }

                conn.Close();

                SqlCommand asm = new SqlCommand("Select count(username) as count FROM SportsAssociationManager WHERE username = @user", conn);
                asm.CommandType = CommandType.Text;
                asm.Parameters.AddWithValue("@user", username.Text);
                conn.Open();
                asm.ExecuteNonQuery();
                SqlDataReader rdrasm = asm.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdrasm.Read())
                {
                    Int32 countasm = rdrasm.GetInt32(rdrasm.GetOrdinal("count"));

                    if (countasm > 0)
                    {
                        Session["associationmanager"] = username.Text;
                        Response.Redirect("AssociationManager.aspx");
                    }
                }

                conn.Close();
            }
            else
            {
                MessageBox.Show("Username or password is not correct");
            }
        }
    }


}