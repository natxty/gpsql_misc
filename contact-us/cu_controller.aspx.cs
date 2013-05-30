using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;
using System.Xml;
using System.Data.SqlClient;

public partial class cu_controller: System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
    	String action;
    	    
    	if ( Request.Params["action"] == null ) {
    		Response.Write("QueryString does not exist!");
    		return;
    	} else {
    		action = Request.Params["action"];
    	}
    	
    	switch(action) {
    		case "get_informationtype":
				this.query_informationtype();
				break;
    		case "get_productservicetype":
				this.query_productservicetype();	
				break;
    		case "get_productserviceline":
    			this.query_productserviceline();
    			break;
    		case "get_productservicename":
    			this.query_productservicename();
    			break;
    		case "get_location":
    			this.query_location();
    			break;
    		case "get_contact":
    			this.query_contact();
    			break;
    		case "get_contact_id":
    			this.query_contact_id();
    			break;
    		default:
    			return;
    			break;
    	}
    	
	} 
	
	public SqlConnection sqlConnection() {
		var conn = new SqlConnection("User ID=sa;Password=d97XQ4f93z;Database=contact_us");
		return conn;
	}
	
	class MenuHelper
	{
		public String query;
		public String id;
		public SqlConnection conn;
		public Page page;
		
		public MenuHelper(String query,String id,SqlConnection conn,Page page) {
			this.query 	= query;
			this.id		= id;
			this.conn	= conn;
			this.page	= page;
		}
		
		public String selectStart() {
			return "";
			return "<select id='"+ this.id +"'>";
		}
		
		public String formatOption(SqlDataReader reader) {
			return "<option value='" + reader["id"] + "'>" + reader["name"] + "</option>";
		}
		
		public String selectEnd() {
			return "";
			return "</select>";
		}
		
		public void generateMenu(){
	    	var conn = this.conn;
			conn.Open();
			
			SqlCommand command 		= conn.CreateCommand();
			command.CommandText 	= this.query;
	 		SqlDataReader reader 	= command.ExecuteReader();
			 	
			this.page.Response.Write(this.selectStart());
	    	while (reader.Read())
			{
	 			this.page.Response.Write( this.formatOption(reader) );
			}
			this.page.Response.Write(this.selectEnd());
			
			reader.Close();
			conn.Close();		
		}
	}
	
	public void query_informationtype() {
		var query = "select * from informationtype";
		
		var menuhelper 	= new MenuHelper(query,"sel_informationtype",this.sqlConnection(),this.Page);
 		menuhelper.generateMenu();	
	}
	
	public void query_productservicetype() {
		var informationtype_id = Request.Params["informationtype_id"];
	
		var query = "EXECUTE InformationType_to_ProductServiceType_Query " + informationtype_id;
		
		var menuhelper 	= new MenuHelper(query,"sel_productservicetype",this.sqlConnection(),this.Page);
 		menuhelper.generateMenu();
	}
	
	public void query_productserviceline() {
		var informationtype_id = Request.Params["informationtype_id"];
	
		var query = "EXECUTE InformationType_to_ProductServiceLine_Query " + informationtype_id ;
		
 		var menuhelper 	= new MenuHelper(query,"sel_productserviceline",this.sqlConnection(),this.Page);
 		menuhelper.generateMenu();
	}
	
	public void query_productservicename() {
		String query;
		
		var informationtype_id = Request.Params["informationtype_id"];
		
		if ( Request.Params["productservicetype_id"] != null ) {
			// ProductServiceType to ProductServiceName
			var productservicetype_id = Request.Params["productservicetype_id"];
			query="EXECUTE InformationType_ProductServiceType_to_ProductServiceName_Query "+ informationtype_id + ',' + productservicetype_id;
		} else {
			// ProductServiceLine to ProductServiceName
			var productserviceline_id = Request.Params["productserviceline_id"];
			query="EXECUTE InformationType_ProductServiceLine_to_ProductServiceName_Query "+ informationtype_id + ',' + productserviceline_id;
		}
		
		var menuhelper 	= new MenuHelper(query,"sel_productservicename",this.sqlConnection(),this.Page);
 		menuhelper.generateMenu();
	}
			
	public void query_location() {
		String query;
		
		var informationtype_id = Request.Params["informationtype_id"];
		var productservicename_id = Request.Params["productservicename_id"];
		
		if ( Request.Params["productservicetype_id"] != null ) {
			var productservicetype_id = Request.Params["productservicetype_id"];
			query = "EXECUTE InformationType_ProductServiceType_ProductServiceName_to_Location_Query " 
				+ informationtype_id + ',' + productservicetype_id + ',' + productservicename_id ;
		} else {
			var productserviceline_id = Request.Params["productserviceline_id"];
			query = "EXECUTE InformationType_ProductServiceLine_ProductServiceName_to_Location_Query " 
				+ informationtype_id + ',' + productserviceline_id + ',' + productservicename_id ;		
		}
		
 		var menuhelper 	= new MenuHelper(query,"sel_locations",this.sqlConnection(),this.Page);
 		menuhelper.generateMenu();		
	}
	
	public void query_contact() {
		String query;
	
		var informationtype_id = Request.Params["informationtype_id"];
		var productservicename_id = Request.Params["productservicename_id"];
		var location_id = Request.Params["location_id"];	
		
		if ( Request.Params["productservicetype_id"] != null ) {
			var productservicetype_id = Request.Params["productservicetype_id"];
			query = "EXECUTE InformationType_ProductServiceType_ProductServiceName_Location_to_Contact_Query "
				 + informationtype_id + ',' + productservicetype_id + ',' + productservicename_id + ',' + location_id;
		} else {
			var productserviceline_id = Request.Params["productserviceline_id"];
			query = "EXECUTE InformationType_ProductServiceLine_ProductServiceName_Location_to_Contact_Query "
				 + informationtype_id + ',' + productserviceline_id + ',' + productservicename_id + ',' + location_id;				
		}
		
    	var conn = this.sqlConnection();
		conn.Open();
		
		SqlCommand command 		= conn.CreateCommand();
		command.CommandText 	= query;
 		SqlDataReader reader 	= command.ExecuteReader();
		 	
    	while (reader.Read())
		{
			if ( reader["label"] != "" ) {
				this.Page.Response.Write ("<span class='large'><strong>" + reader["label"] + "</strong></span><br>" );
			}
  			var contact_id = reader["id"].ToString();
			var contacthelper = new ContactHelper(contact_id,this.sqlConnection(),this.Page);
			contacthelper.info();
			this.Page.Response.Write ("<br><br>");
		}
		
		reader.Close();
		conn.Close();		
	}
	
	public void query_contact_id() {
		var contact_id = Request.Params["contact_id"];
		var contacthelper = new ContactHelper(contact_id,this.sqlConnection(),this.Page);
		contacthelper.info();			
	}
	
	class ContactHelper
	{
		public string id;
		public SqlConnection conn;
		public Page page;
		
		
		public ContactHelper(string id,SqlConnection conn,Page page) {
			this.id 	= id;
			this.conn	= conn;
			this.page	= page;
		}
		
		public void info() {
			this.getName();
			this.getAddress();
			this.getPerson();
			this.getPhone();
			this.getFax();
			this.getEmail();
			this.getWebsite();
		}
		
		public void getName() {
	    	var conn = this.conn;
			conn.Open();
			
			SqlCommand command 		= conn.CreateCommand();
			command.CommandText 	= "EXECUTE Contact_to_Facility_Query " + this.id;
	 		SqlDataReader reader 	= command.ExecuteReader();
			 	
	    	while (reader.Read())
			{
	 			this.page.Response.Write( "<span class='large'><strong>" + reader["name"] + "</strong></span><br>" );
			}
			
			reader.Close();
			conn.Close();
		}

		public void getPerson() {
	    	var conn = this.conn;
			conn.Open();
			
			SqlCommand command 		= conn.CreateCommand();
			command.CommandText 	= "EXECUTE Contact_to_Person_Query " + this.id;
	 		SqlDataReader reader 	= command.ExecuteReader();
			 	
	    	while (reader.Read())
			{
	 			this.page.Response.Write( "<b>Contact:</b> "+reader["name"] );
	 			this.page.Response.Write( "<br>" );
			}
			
			reader.Close();
			conn.Close();
		}
	
		public void getAddress() {
	    	var conn = this.conn;
			conn.Open();
			
			SqlCommand command 		= conn.CreateCommand();
			command.CommandText 	= "EXECUTE Contact_to_Address_Query " + this.id;
	 		SqlDataReader reader 	= command.ExecuteReader();
			 	
	    	while (reader.Read())
			{
	 			this.page.Response.Write( reader["address"] );
	 			this.page.Response.Write( "<br>" );
			}
			
			reader.Close();
			conn.Close();		
		}
		
		public void getPhone() {
	    	var conn = this.conn;
			conn.Open();
			
			SqlCommand command 		= conn.CreateCommand();
			command.CommandText 	= "EXECUTE Contact_to_Phone_Query " + this.id;
	 		SqlDataReader reader 	= command.ExecuteReader();
			 	
	    	while (reader.Read())
			{
	 			this.page.Response.Write( "<b>Phone:</b> "+reader["number"] );
	 			this.page.Response.Write( "<br>" );
			}
			
			reader.Close();
			conn.Close();		
		}
		
		public void getFax() {
	    	var conn = this.conn;
			conn.Open();
			
			SqlCommand command 		= conn.CreateCommand();
			command.CommandText 	= "EXECUTE Contact_to_Fax_Query " + this.id;
	 		SqlDataReader reader 	= command.ExecuteReader();
			 	
	    	while (reader.Read())
			{
	 			this.page.Response.Write( "<b>Fax:</b> "+reader["number"] );
	 			this.page.Response.Write( "<br>" );
			}
			
			reader.Close();
			conn.Close();		
		}
		
		public void getEmail() {
	    	var conn = this.conn;
			conn.Open();
			
			SqlCommand command 		= conn.CreateCommand();
			command.CommandText 	= "EXECUTE Contact_to_Email_Query " + this.id;
	 		SqlDataReader reader 	= command.ExecuteReader();
			 	
	    	while (reader.Read())
			{
	 			this.page.Response.Write( "<b>Email:</b> <a href='mailto:" + reader["email"] + "'>"+ reader["email"] +"</a>" );
	 			this.page.Response.Write( "<br>" );
			}
			
			reader.Close();
			conn.Close();		
		}
		
		public void getWebsite() {
	    	var conn = this.conn;
			conn.Open();
			
			SqlCommand command 		= conn.CreateCommand();
			command.CommandText 	= "EXECUTE Contact_to_Website_Query " + this.id;
	 		SqlDataReader reader 	= command.ExecuteReader();
			 	
	    	while (reader.Read())
			{
	 			this.page.Response.Write( "<b>Website:</b> "+reader["url"] );
	 			this.page.Response.Write( "<br>" );
			}
			
			reader.Close();
			conn.Close();		
		}
	
	}
	
	
	
}       