<%@ Page Trace="false" ClassName="MyPage"  Language="C#" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import namespace="System" %>
<%@ Import namespace="System.Collections.Generic" %>
<%@ Import namespace="System.Web" %>
<%@ Import namespace="System.Web.UI" %>
<%@ Import namespace="System.Web.UI.WebControls" %>
<%@ Import namespace="System.Text" %>
<%@ Import namespace="System.Collections" %>
<%@ Import namespace="System.Configuration" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Data.SqlClient" %>
<%@ Import namespace="System.Web.Security" %>
<%@ Import namespace="System.Xml" %>
<script runat="server">
        public ArrayList Locations = new ArrayList();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["zipcode"] != null)
                Locations = genprobhelper.render_usreplocation(this.Page);

            else if (Request.Params["informationtype"] != null && Request.Params["productservicetype"] == null && Request.Params["productserviceline"] == null && Request.Params["productservicename"] == null && Request.Params["location"] == null)
                genprobhelper.render_productservicetype(this.Page);

            //if they select informationtype and service type
            else if (Request.Params["informationtype"] != null && Request.Params["productservicetype"] != null && Request.Params["productserviceline"] == null && Request.Params["productservicename"] == null && Request.Params["location"] == null)
                Locations = genprobhelper.render_productservicename(this.Page);
            // genprobhelper.render_productserviceline(this.Page );

            else if (Request.Params["informationtype"] != null && Request.Params["productserviceline"] != null && Request.Params["productservicename"] == null && Request.Params["location"] == null)
                Locations = genprobhelper.render_productservicename(this.Page);

            else if (Request.Params["informationtype"] != null && (Request.Params["productservicetype"] != null || Request.Params["productserviceline"] != null) && Request.Params["productservicename"] != null && Request.Params["location"] == null)
                Locations = genprobhelper.render_locations(this.Page);
        }

    #region GenProb Required Code


	    public class genprobhelper
	    { 
	        
	    		public class location
	            {
	                private int _location_id;
	                private string _dropdownname;
	                private string _locationname;
	                private string _contactname;
	                private string _addressline1;
	                private string _addressline2;
	                private string _addressline3;
	                private string _phone1;
	                private string _phone2;
	                private string _phone3;
	                private string _fax1;
	                private string _fax2;
	                private string _email;
	                private string _website;
	                private string _locationtext;
	                private int _addr_id;
	                private string _addressoverride;
	
                public int location_id { get { return _location_id; } set { _location_id = value; } }
                public string dropdownname { get { return _dropdownname; } set { _dropdownname = value; } }
                public string locationname { get { return _locationname; } set { _locationname = value; } }
                public string contactname { get { return _contactname; } set { _contactname = value; } }
                public string addressline1 { get { return _addressline1; } set { _addressline1 = value; } }
                public string addressline2 { get { return _addressline2; } set { _addressline2 = value; } }
                public string addressline3 { get { return _addressline3; } set { _addressline3 = value; } }
                public string phone1 { get { return _phone1; } set { _phone1 = value; } }
                public string phone2 { get { return _phone2; } set { _phone2 = value; } }
                public string phone3 { get { return _phone3; } set { _phone3 = value; } }
                public string fax1 { get { return _fax1; } set { _fax1 = value; } }
                public string fax2 { get { return _fax2; } set { _fax2 = value; } }
                public string email { get { return _email; } set { _email = value; } }
                public string website { get { return _website; } set { _website = value; } }
                public string locationtext { get { return _locationtext; } set { _locationtext = value; } }
                public int addr_id { get { return _addr_id; } set { _addr_id = value; } }
                public string addressoverride { get { return _addressoverride; } set { _addressoverride = value; } }                
            }

        public static void render_productservicetype(Page thispage)
        { 
            SqlConnection sqlconn = databasehelper.GetConnection();
            SqlDataReader dr = databasehelper.staticExecuteReaderSp(sqlconn, "cu_contacts_getproductservicetype", new SqlParameter("@itype", HttpContext.Current.Request.Params["informationtype"].ToString().Trim()));

            string selectstring = "<option class=\"pstype\" value=\"0\">Select one</option>";

            while (dr.Read())
            {
                selectstring += "<option class=\"pstype\" value=\"" + dr["productservicetype"].ToString() + "\">" + dr["productservicetype"].ToString() + "</option>";
            }

           // selectstring += "</select>";
            dr.Close();
            sqlconn.Dispose();
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.Write(selectstring);
           
            //bring in the next list I need
            HttpContext.Current.Response.Write("<!--||||||||||-->");
            genprobhelper.render_productserviceline(thispage);
        }

        public static void render_productserviceline(Page thispage)
        {
            SqlConnection sqlconn = databasehelper.GetConnection();
            SqlDataReader dr = databasehelper.staticExecuteReaderSp(sqlconn, "cu_contacts_getproductserviceline2", new SqlParameter("@itype", HttpContext.Current.Request.Params["informationtype"].ToString().Trim()) );//, new SqlParameter("@stype", HttpContext.Current.Request.Params["productservicetype"].ToString().Trim()));

                
            string selectstring = "<option class=\"psline\" value=\"0\">Select one</option>";

            
            while (dr.Read())
            {
                selectstring += "<option class=\"psline\" value=\"" + dr["productserviceline"].ToString() + "\">" + dr["productserviceline"].ToString() + "</option>";
            }

            // selectstring += "</select>";
            dr.Close();
            sqlconn.Close();

            if (selectstring.Length == 93)
            {
                render_productservicename(thispage);
                return;
            }
                
                
           

              
            //also render locations early

            if (HttpContext.Current.Request.Params["informationtype"].ToString() == "locations")
            {
                HttpContext.Current.Response.Write(selectstring);
                HttpContext.Current.Response.Write("<!--||||||||||-->");
                genprobhelper.render_locations(thispage);
            }

            else
            {
                HttpContext.Current.Response.Write(selectstring);
            }
        }

        public static ArrayList render_productservicename(Page thispage)
        {
            SqlConnection sqlconn = databasehelper.GetConnection();
            
            SqlParameter[] sqlparams = new SqlParameter[3];
            int i = 0;
            
            sqlparams[i++] =  new SqlParameter("@itype", HttpContext.Current.Request.Params["informationtype"].ToString().Trim());

            if (HttpContext.Current.Request.Params["productservicetype"] != null)
                sqlparams[i++] =  new SqlParameter("@stype", HttpContext.Current.Request.Params["productservicetype"].ToString().Trim());
            
            if ( HttpContext.Current.Request.Params["productserviceline"] != null )
                sqlparams[i++] = new SqlParameter("@sline", HttpContext.Current.Request.Params["productserviceline"].ToString().Trim());

            SqlDataReader dr = databasehelper.staticExecuteReaderSp(sqlconn, "cu_contacts_getproductservicename3", sqlparams );
            //SqlDataReader dr = databasehelper.staticExecuteReaderSp(sqlconn, "cu_contacts_getproductservicename", new SqlParameter("@itype", HttpContext.Current.Request.Params["informationtype"].ToString().Trim()), new SqlParameter("@stype", HttpContext.Current.Request.Params["productservicetype"].ToString().Trim()), new SqlParameter("@sline", HttpContext.Current.Request.Params["productserviceline"].ToString().Trim()));

            string selectstring = "<option class=\"psname\" value=\"0\">Select one</option>";


            while (dr.Read())
            {
                selectstring += "<option class=\"psname\" value=\"" + dr["productservicename"].ToString() + "\">" + dr["productservicename"].ToString() + "</option>";
            }

            // selectstring += "</select>";
            dr.Close();
            sqlconn.Close();

            if (selectstring.Length == 93)
            {
               return  render_locations(thispage);
            }
            
            HttpContext.Current.Response.Write(selectstring);
            
            
            //also render locations early
            HttpContext.Current.Response.Write("<!--||||||||||-->");
            return genprobhelper.render_locations(thispage);
            
            
            //return null;
        }


        public static ArrayList render_usreplocation(Page thispage)
        {
            SqlConnection sqlconn = databasehelper.GetConnection();

            SqlParameter[] sqlparams = new SqlParameter[1];

            sqlparams[0] = new SqlParameter("@zipcode", HttpContext.Current.Request.Params["zipcode"].ToString().Trim());

            SqlDataReader dr = databasehelper.staticExecuteReaderSp(sqlconn, "cu_salesreps_getbyzipcode", sqlparams);
            // SqlDataReader dr = databasehelper.staticExecuteReaderSp(sqlconn, "cu_contacts_getlocations2", new SqlParameter("@itype", HttpContext.Current.Request.Params["informationtype"].ToString().Trim()), new SqlParameter("@stype", HttpContext.Current.Request.Params["productservicetype"].ToString().Trim()), new SqlParameter("@sline", HttpContext.Current.Request.Params["productserviceline"].ToString().Trim()), new SqlParameter("@sname", HttpContext.Current.Request.Params["productservicename"].ToString().Trim()));

            ArrayList _Locations = new ArrayList();

            while (dr.Read())
            {

                location templocation = new location();
               // templocation.location_id = Convert.ToInt32(dr["location_id"]);
              //  templocation.dropdownname = Convert.ToString(dr["dropdownname"]);
                templocation.locationname = "US Sales Rep";
                templocation.contactname = Convert.ToString(dr["contactname"]);
              //  templocation.addressline1 = Convert.ToString(dr["addressline1"]);
              //  templocation.addressline2 = Convert.ToString(dr["addressline2"]);
              //  templocation.addressline3 = Convert.ToString(dr["addressline3"]);
                templocation.phone1 = Convert.ToString(dr["phone1"]);
              //  templocation.phone2 = Convert.ToString(dr["phone2"]);
                //templocation.phone3 = Convert.ToString(dr["phone3"]);
                //templocation.fax1 = Convert.ToString(dr["fax1"]);
                //templocation.fax2 = Convert.ToString(dr["fax2"]);
                templocation.email = Convert.ToString(dr["email"]);
                //templocation.website = Convert.ToString(dr["website"]);
                //templocation.locationtext = Convert.ToString(dr["locationtext"]);
                //templocation.addr_id = Convert.ToInt32(dr["addr_id"]);

                _Locations.Add(templocation);
                //  _Locations.Add(new location() { location_id = Convert.ToInt32( dr["location_id"]),dropdownname = Convert.ToString( dr["dropdownname"]), locationname = Convert.ToString( dr["locationname"] ), contactname = Convert.ToString( dr["contactname"] ), addressline1 = Convert.ToString( dr["addressline1"] ), addressline2 = Convert.ToString( dr["addressline2"]), addressline3 = Convert.ToString( dr["addressline3"] ), phone1 = Convert.ToString( dr["phone1"] ), phone2 = Convert.ToString( dr["phone2"] ), phone3 = Convert.ToString( dr["phone3"] ), fax1 = Convert.ToString( dr["fax1"] ), fax2 = Convert.ToString( dr["fax2"] ), email = Convert.ToString( dr["email"] ), website=Convert.ToString(dr["website"]), locationtext = Convert.ToString(dr["locationtext"]), addr_id = Convert.ToInt32( dr["addr_id"] ) });
            }

            // selectstring += "</select>";
            dr.Close();
            sqlconn.Dispose();
            thispage.FindControl("panelLocation").Visible = true;

            //if (HttpContext.Current.Request.Params["informationtype"].ToString() == "locations")
            //{
                //add here
            //    ((MyPage)thispage.Page).Locations = _Locations;
           // }
            return _Locations;
        }       

        public static  ArrayList render_locations(Page thispage)
        {
            SqlConnection sqlconn = databasehelper.GetConnection();

            SqlParameter[] sqlparams = new SqlParameter[4];

            int i = 0;
            sqlparams[i++] = new SqlParameter("@itype", HttpContext.Current.Request.Params["informationtype"].ToString().Trim());

            if (HttpContext.Current.Request.Params["productservicetype"] != null)
                sqlparams[i++] = new SqlParameter("@stype", HttpContext.Current.Request.Params["productservicetype"].ToString().Trim());

            if (HttpContext.Current.Request.Params["productserviceline"] != null)
                sqlparams[i++] = new SqlParameter("@sline", HttpContext.Current.Request.Params["productserviceline"].ToString().Trim());

            if (HttpContext.Current.Request.Params["productservicename"] != null)
                sqlparams[i++] = new SqlParameter("@sname", HttpContext.Current.Request.Params["productservicename"].ToString().Trim());
            
            SqlDataReader dr = databasehelper.staticExecuteReaderSp(sqlconn, "cu_contacts_getlocations7", sqlparams);            
           // SqlDataReader dr = databasehelper.staticExecuteReaderSp(sqlconn, "cu_contacts_getlocations2", new SqlParameter("@itype", HttpContext.Current.Request.Params["informationtype"].ToString().Trim()), new SqlParameter("@stype", HttpContext.Current.Request.Params["productservicetype"].ToString().Trim()), new SqlParameter("@sline", HttpContext.Current.Request.Params["productserviceline"].ToString().Trim()), new SqlParameter("@sname", HttpContext.Current.Request.Params["productservicename"].ToString().Trim()));

            string selectstring = "<option class=\"locat\" value=\"0\">Select one</option>";
            ArrayList _Locations = new ArrayList();
            ArrayList locationsofar = new ArrayList();


            while (dr.Read())
            {
                if (locationsofar.IndexOf(dr["dropdownname"].ToString()) == -1)
                {
                    locationsofar.Add(dr["dropdownname"].ToString());

                    selectstring += "<option id=\"loc" + dr["location_id"].ToString() + "\" class=\"addr" + dr["addr_id"].ToString() + "\" value=\"" + dr["dropdownname"].ToString() + "\">" + dr["dropdownname"].ToString() + "</option>";

                    location templocation = new location();
                    templocation.location_id = Convert.ToInt32(dr["location_id"]);
                    templocation.dropdownname = Convert.ToString(dr["dropdownname"]);
                    templocation.locationname = Convert.ToString(dr["locationname"]);
                    templocation.contactname = Convert.ToString(dr["contactname"]);
                    templocation.addressline1 = Convert.ToString(dr["addressline1"]);
                    templocation.addressline2 = Convert.ToString(dr["addressline2"]);
                    templocation.addressline3 = Convert.ToString(dr["addressline3"]);
                    templocation.phone1 = Convert.ToString(dr["phone1"]);
                    templocation.phone2 = Convert.ToString(dr["phone2"]);
                    templocation.phone3 = Convert.ToString(dr["phone3"]);
                    templocation.fax1 = Convert.ToString(dr["fax1"]);
                    templocation.fax2 = Convert.ToString(dr["fax2"]);
                    templocation.email = Convert.ToString(dr["email"]);
                    templocation.website = Convert.ToString(dr["website"]);
                    templocation.locationtext = Convert.ToString(dr["locationtext"]);
                    templocation.addr_id = Convert.ToInt32(dr["addr_id"]);
                    templocation.addressoverride = Convert.ToString(dr["addressoverride"]);
                    

                    _Locations.Add(templocation);
                    //  _Locations.Add(new location() { location_id = Convert.ToInt32( dr["location_id"]),dropdownname = Convert.ToString( dr["dropdownname"]), locationname = Convert.ToString( dr["locationname"] ), contactname = Convert.ToString( dr["contactname"] ), addressline1 = Convert.ToString( dr["addressline1"] ), addressline2 = Convert.ToString( dr["addressline2"]), addressline3 = Convert.ToString( dr["addressline3"] ), phone1 = Convert.ToString( dr["phone1"] ), phone2 = Convert.ToString( dr["phone2"] ), phone3 = Convert.ToString( dr["phone3"] ), fax1 = Convert.ToString( dr["fax1"] ), fax2 = Convert.ToString( dr["fax2"] ), email = Convert.ToString( dr["email"] ), website=Convert.ToString(dr["website"]), locationtext = Convert.ToString(dr["locationtext"]), addr_id = Convert.ToInt32( dr["addr_id"] ) });
                } }

                ((MyPage)thispage.Page).Locations = _Locations;
            
                // selectstring += "</select>";
                dr.Close();
                sqlconn.Dispose();
                HttpContext.Current.Response.Write(selectstring);
                thispage.FindControl("panelLocation").Visible = true;
            
                
                return _Locations;
           
        }

        public static Hashtable GetInformationTypes()
        {

            Hashtable informationtypes = null;

            //if we have a hashtable for informationtypes stored in cache use that
            if (HttpContext.Current.Cache["informationtypes"] != null)
                informationtypes = (Hashtable)HttpContext.Current.Cache["informationtypes"];

            else
            {
                SqlConnection sqlconn = databasehelper.GetConnection();
                SqlDataReader dr = databasehelper.staticExecuteReader(sqlconn, "select * from cu_informationtypes");

                informationtypes = new Hashtable();

                while (dr.Read())
                {
                    informationtypes.Add(dr["informationtype"].ToString(), dr["dropdownname"].ToString());
                }

                dr.Close();
                sqlconn.Dispose();

                HttpContext.Current.Cache["informationtypes"] = informationtypes;
            }

            return informationtypes;
        }
    }
    
    
    

    public class databasehelper
    {

        public static void QuickSql(string query)
        {
            SqlConnection myconn = new SqlConnection(GetConnectionString());
            SqlCommand SelectCommand = new SqlCommand(query, myconn);

            myconn.Open();

            SelectCommand.ExecuteNonQuery();

            myconn.Close();

        }


        public static string GetConnectionString()
        {
            if (ConfigurationSettings.AppSettings["connString"] == null) throw new Exception("Missing [\"connString\"] appsetting ");
            return ConfigurationSettings.AppSettings["connString"];
        }

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(GetConnectionString()); //returns new connection object
        }

        #region ExecuteNonQuery

        //execute nonquery stored procedure for SQLServer (with params)
        public static void staticExecuteNonQuerySp(SqlConnection connection, string commandText, params SqlParameter[] parameters)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.StoredProcedure;

                // Append each parameter to the command
                foreach (SqlParameter parameter in parameters)
                {
                    command.Parameters.Add(parameter);
                }

                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    connection.Open();
                }

                try
                {
                    // Execute the query
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw new Exception("Problem with Execute Query: " + ex.ToString());
                }
                finally
                {
                    // If the database connection was closed before the method call, close it again
                    if (state == ConnectionState.Closed)
                    {
                        connection.Close();
                    }
                }
            }
        }

        //execute nonquery stored procedure for SQLServer (without params)
        public static void staticExecuteNonQuerySp(SqlConnection connection, string commandText)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.StoredProcedure;


                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    connection.Open();
                }

                try
                {
                    // Execute the query
                    command.ExecuteNonQuery();
                }
                finally
                {
                    // If the database connection was closed before the method call, close it again
                    if (state == ConnectionState.Closed)
                    {
                        connection.Close();
                    }
                }
            }
        }

        public static void staticExecuteNonQuery(SqlConnection connection, string commandText, params SqlParameter[] parameters)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.Text;

                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    connection.Open();
                }

                try
                {
                    // Execute the query
                    command.ExecuteNonQuery();
                }
                finally
                {
                    // If the database connection was closed before the method call, close it again
                    if (state == ConnectionState.Closed)
                    {
                        connection.Close();
                    }
                }
            }
        }



        //Execute Non-Stored Procedure Query
        public static void staticExecuteNonQuery(SqlConnection connection, string commandText)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.Text;

                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    connection.Open();
                }

                try
                {
                    // Execute the query
                    command.ExecuteNonQuery();
                }
                finally
                {
                    // If the database connection was closed before the method call, close it again
                    if (state == ConnectionState.Closed)
                    {
                        connection.Close();
                    }
                }
            }
        }

        #endregion

        #region ExecuteScalar

        //ExecuteScalar using StoredProcedures with no params (for sqlserver)
        public static object staticExecuteScalarSp(SqlConnection connection, string commandText)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.StoredProcedure;


                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    connection.Open();
                }

                try
                {
                    // Execute the query
                    return command.ExecuteScalar();
                }
                catch (Exception ex)
                {
                    throw new Exception(" Problem in staticExecuteScalarSp " + ex);
                }

                finally
                {
                    // If the database connection was closed before the method call, close it again
                    if (state == ConnectionState.Closed)
                    {
                        connection.Close();
                    }
                }
            }
        }

        public static object staticExecuteScalarSp(SqlConnection connection, string commandText, params SqlParameter[] parameters)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.StoredProcedure;

                // Append each parameter to the command
                foreach (SqlParameter parameter in parameters)
                {
                    command.Parameters.Add(parameter);
                }

                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    connection.Open();
                }

                try
                {
                    // Execute the query
                    return command.ExecuteScalar();
                }
                catch (Exception ex)
                {
                    throw new Exception("Problem with staticExecuteScalarSp" + ex.ToString());
                }
                finally
                {
                    // If the database connection was closed before the method call, close it again
                    if (state == ConnectionState.Closed)
                    {
                        connection.Close();
                    }
                }
            }
        }


        //******************************** functions that don't use stored procedures

        //ExecuteScalar using text query with no params (for sqlserver)
        public static object staticExecuteScalar(SqlConnection connection, string commandText)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.Text;


                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    connection.Open();
                }

                try
                {
                    // Execute the query
                    return command.ExecuteScalar();
                }
                finally
                {
                    // If the database connection was closed before the method call, close it again
                    if (state == ConnectionState.Closed)
                    {
                        connection.Close();
                    }
                }
            }
        }

        //Execute Scalar using text query with Params (for sqlserver)
        public static object staticExecuteScalar(SqlConnection connection, string commandText, params SqlParameter[] parameters)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.Text;

                // Append each parameter to the command
                foreach (SqlParameter parameter in parameters)
                {
                    command.Parameters.Add(parameter);
                }

                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    connection.Open();
                }

                try
                {
                    // Execute the query
                    return command.ExecuteScalar();
                }
                finally
                {
                    // If the database connection was closed before the method call, close it again
                    if (state == ConnectionState.Closed)
                    {
                        connection.Close();
                    }
                }
            }
        }



        #endregion

        #region ExecuteReader


        //Execute SQL Statement and return a DataReader
        public static SqlDataReader staticExecuteReaderSp(SqlConnection connection, string commandText)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.StoredProcedure;

                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    try
                    {
                        connection.Open();
                        return command.ExecuteReader(CommandBehavior.CloseConnection);
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("Problem with staticExecuteReaderSp " + ex.ToString());
                    }
                }
                else
                {
                    return command.ExecuteReader();
                }
            }
        }


        public static SqlDataReader staticExecuteReaderSp(SqlConnection connection, string commandText, params SqlParameter[] parameters)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.StoredProcedure;

                // Append each parameter to the command
                foreach (SqlParameter parameter in parameters)
                {
                    if (parameter != null)
                        command.Parameters.Add(parameter);
                }


                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    try
                    {
                        connection.Open();
                        return command.ExecuteReader(CommandBehavior.CloseConnection);
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("Problem Getting Reader SP (" + commandText + "): " + ex.ToString());
                    }
                }
                else
                {
                    return command.ExecuteReader();
                }
            }
        }


        //Execute SQL Statement and return a DataReader
        public static SqlDataReader staticExecuteReader(SqlConnection connection, string commandText)
        {
            ConnectionState state = connection.State;

            using (SqlCommand command = new SqlCommand())
            {
                // Initialize the command
                command.Connection = connection;
                command.CommandText = commandText;
                command.CommandType = CommandType.Text;


                command.CommandTimeout = 100;
                command.CommandTimeout = 100;

                // Open the database connection if it isn't already opened
                if (state == ConnectionState.Closed)
                {
                    try
                    {
                        connection.Open();
                        return command.ExecuteReader(CommandBehavior.CloseConnection);
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("problem excuting reader" + ex.ToString());
                    }
                }
                else
                {
                    return command.ExecuteReader();
                }
            }
        }


        #endregion



        private static void AttachParameters(SqlCommand command, SqlParameter[] commandParameters)
        {
            foreach (SqlParameter p in commandParameters)
            {
                //check for derived output value with no value assigned
                if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                {
                    p.Value = DBNull.Value;
                }

                command.Parameters.Add(p);
            }
        }

        //*********************************************************************
        //
        // This method assigns an array of values to an array of SqlParameters.
        // 
        // param name="commandParameters" array of SqlParameters to be assigned values
        // param name="parameterValues" array of objects holding the values to be assigned
        //
        //*********************************************************************

        private static void AssignParameterValues(SqlParameter[] commandParameters, object[] parameterValues)
        {
            if ((commandParameters == null) || (parameterValues == null))
            {
                //do nothing if we get no data
                return;
            }

            // we must have the same number of values as we pave parameters to put them in
            if (commandParameters.Length != parameterValues.Length)
            {
                throw new ArgumentException("Parameter count does not match Parameter Value count.");
            }

            //iterate through the SqlParameters, assigning the values from the corresponding position in the 
            //value array
            for (int i = 0, j = commandParameters.Length; i < j; i++)
            {
                commandParameters[i].Value = parameterValues[i];
            }
        }

        //*********************************************************************
        //
        // This method opens (if necessary) and assigns a connection, transaction, command type and parameters 
        // to the provided command.
        // 
        // param name="command" the SqlCommand to be prepared
        // param name="connection" a valid SqlConnection, on which to execute this command
        // param name="transaction" a valid SqlTransaction, or 'null'
        // param name="commandType" the CommandType (stored procedure, text, etc.)
        // param name="commandText" the stored procedure name or T-SQL command
        // param name="commandParameters" an array of SqlParameters to be associated with the command or 'null' if no parameters are required
        //
        //*********************************************************************

        private static void PrepareCommand(SqlCommand command, SqlConnection connection, SqlTransaction transaction, CommandType commandType, string commandText, SqlParameter[] commandParameters)
        {
            //if the provided connection is not open, we will open it
            if (connection.State != ConnectionState.Open)
            {
                connection.Open();
            }

            //associate the connection with the command
            command.Connection = connection;

            //set the command text (stored procedure name or SQL statement)
            command.CommandText = commandText;

            //if we were provided a transaction, assign it.
            if (transaction != null)
            {
                command.Transaction = transaction;
            }

            //set the command type
            command.CommandType = commandType;

            //attach the command parameters if they are provided
            if (commandParameters != null)
            {
                AttachParameters(command, commandParameters);
            }

            return;
        }

        //*********************************************************************
        //
        // Execute a SqlCommand (that returns no resultset) against the database specified in the connection string 
        // using the provided parameters.
        //
        // e.g.:  
        //  int result = ExecuteNonQuery(connString, CommandType.StoredProcedure, "PublishOrders", new SqlParameter("@prodid", 24));
        //
        // param name="connectionString" a valid connection string for a SqlConnection
        // param name="commandType" the CommandType (stored procedure, text, etc.)
        // param name="commandText" the stored procedure name or T-SQL command
        // param name="commandParameters" an array of SqlParamters used to execute the command
        // returns an int representing the number of rows affected by the command
        //
        //*********************************************************************

        public static int ExecuteNonQuery(string connectionString, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create & open a SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();

                //call the overload that takes a connection in place of the connection string
                return ExecuteNonQuery(cn, commandType, commandText, commandParameters);
            }
        }

        //*********************************************************************
        //
        // Execute a stored procedure via a SqlCommand (that returns no resultset) against the database specified in 
        // the connection string using the provided parameter values.  This method will query the database to discover the parameters for the 
        // stored procedure (the first time each stored procedure is called), and assign the values based on parameter order.
        // 
        // This method provides no access to output parameters or the stored procedure's return value parameter.
        // 
        // e.g.:  
        //  int result = ExecuteNonQuery(connString, "PublishOrders", 24, 36);
        //
        // param name="connectionString" a valid connection string for a SqlConnection
        // param name="spName" the name of the stored prcedure
        // param name="parameterValues" an array of objects to be assigned as the input values of the stored procedure
        // returns an int representing the number of rows affected by the command
        //
        //*********************************************************************

        public static int ExecuteNonQuery(string connectionString, string spName, params object[] parameterValues)
        {
            //if we receive parameter values, we need to figure out where they go
            if ((parameterValues != null) && (parameterValues.Length > 0))
            {
                //pull the parameters for this stored procedure from the parameter cache (or discover them & populate the cache)
                SqlParameter[] commandParameters = SqlHelperParameterCache.GetSpParameterSet(connectionString, spName);

                //assign the provided values to these parameters based on parameter order
                AssignParameterValues(commandParameters, parameterValues);

                //call the overload that takes an array of SqlParameters
                return ExecuteNonQuery(connectionString, CommandType.StoredProcedure, spName, commandParameters);
            }
            //otherwise we can just call the SP without params
            else
            {
                return ExecuteNonQuery(connectionString, CommandType.StoredProcedure, spName);
            }
        }

        //*********************************************************************
        //
        // Execute a SqlCommand (that returns no resultset) against the specified SqlConnection 
        // using the provided parameters.
        // 
        // e.g.:  
        //  int result = ExecuteNonQuery(conn, CommandType.StoredProcedure, "PublishOrders", new SqlParameter("@prodid", 24));
        // 
        // param name="connection" a valid SqlConnection 
        // param name="commandType" the CommandType (stored procedure, text, etc.) 
        // param name="commandText" the stored procedure name or T-SQL command 
        // param name="commandParameters" an array of SqlParamters used to execute the command 
        // returns an int representing the number of rows affected by the command
        //
        //*********************************************************************

        public static int ExecuteNonQuery(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);

            //finally, execute the command.
            int retval = cmd.ExecuteNonQuery();

            // detach the SqlParameters from the command object, so they can be used again.
            cmd.Parameters.Clear();
            return retval;
        }

        //*********************************************************************
        //
        // Execute a SqlCommand (that returns a resultset) against the database specified in the connection string 
        // using the provided parameters.
        // 
        // e.g.:  
        //  DataSet ds = ExecuteDataset(connString, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
        // 
        // param name="connectionString" a valid connection string for a SqlConnection 
        // param name="commandType" the CommandType (stored procedure, text, etc.) 
        // param name="commandText" the stored procedure name or T-SQL command 
        // param name="commandParameters" an array of SqlParamters used to execute the command 
        // returns a dataset containing the resultset generated by the command
        //
        //*********************************************************************

        public static DataSet ExecuteDataset(string connectionString, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create & open a SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();

                //call the overload that takes a connection in place of the connection string
                return ExecuteDataset(cn, commandType, commandText, commandParameters);
            }
        }

        //*********************************************************************
        //
        // Execute a stored procedure via a SqlCommand (that returns a resultset) against the database specified in 
        // the connection string using the provided parameter values.  This method will query the database to discover the parameters for the 
        // stored procedure (the first time each stored procedure is called), and assign the values based on parameter order.
        // 
        // This method provides no access to output parameters or the stored procedure's return value parameter.
        // 
        // e.g.:  
        //  DataSet ds = ExecuteDataset(connString, "GetOrders", 24, 36);
        // 
        // param name="connectionString" a valid connection string for a SqlConnection
        // param name="spName" the name of the stored procedure
        // param name="parameterValues" an array of objects to be assigned as the input values of the stored procedure
        // returns a dataset containing the resultset generated by the command
        //
        //*********************************************************************

        public static DataSet ExecuteDataset(string connectionString, string spName, params object[] parameterValues)
        {
            //if we receive parameter values, we need to figure out where they go
            if ((parameterValues != null) && (parameterValues.Length > 0))
            {
                //pull the parameters for this stored procedure from the parameter cache (or discover them & populate the cache)
                SqlParameter[] commandParameters = SqlHelperParameterCache.GetSpParameterSet(connectionString, spName);

                //assign the provided values to these parameters based on parameter order
                AssignParameterValues(commandParameters, parameterValues);

                //call the overload that takes an array of SqlParameters
                return ExecuteDataset(connectionString, CommandType.StoredProcedure, spName, commandParameters);
            }
            //otherwise we can just call the SP without params
            else
            {
                return ExecuteDataset(connectionString, CommandType.StoredProcedure, spName);
            }
        }

        //*********************************************************************
        //
        // Execute a SqlCommand (that returns a resultset) against the specified SqlConnection 
        // using the provided parameters.
        // 
        // e.g.:  
        //  DataSet ds = ExecuteDataset(conn, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
        //
        // param name="connection" a valid SqlConnection
        // param name="commandType" the CommandType (stored procedure, text, etc.)
        // param name="commandText" the stored procedure name or T-SQL command
        // param name="commandParameters" an array of SqlParamters used to execute the command
        // returns a dataset containing the resultset generated by the command
        //
        //*********************************************************************

        public static DataSet ExecuteDataset(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);

            //create the DataAdapter & DataSet
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            //fill the DataSet using default values for DataTable names, etc.
            da.Fill(ds);

            // detach the SqlParameters from the command object, so they can be used again.			
            cmd.Parameters.Clear();

            //return the dataset
            return ds;
        }

        //*********************************************************************
        //
        // Execute a SqlCommand (that returns a 1x1 resultset) against the database specified in the connection string 
        // using the provided parameters.
        // 
        // e.g.:  
        //  int orderCount = (int)ExecuteScalar(connString, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));
        // 
        // param name="connectionString" a valid connection string for a SqlConnection 
        // param name="commandType" the CommandType (stored procedure, text, etc.) 
        // param name="commandText" the stored procedure name or T-SQL command 
        // param name="commandParameters" an array of SqlParamters used to execute the command 
        // returns an object containing the value in the 1x1 resultset generated by the command
        //
        //*********************************************************************

        public static object ExecuteScalar(string connectionString, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create & open a SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();

                //call the overload that takes a connection in place of the connection string
                return ExecuteScalar(cn, commandType, commandText, commandParameters);
            }
        }

        //*********************************************************************
        //
        // Execute a stored procedure via a SqlCommand (that returns a 1x1 resultset) against the database specified in 
        // the connection string using the provided parameter values.  This method will query the database to discover the parameters for the 
        // stored procedure (the first time each stored procedure is called), and assign the values based on parameter order.
        // 
        // This method provides no access to output parameters or the stored procedure's return value parameter.
        // 
        // e.g.:  
        //  int orderCount = (int)ExecuteScalar(connString, "GetOrderCount", 24, 36);
        // 
        // param name="connectionString" a valid connection string for a SqlConnection 
        // param name="spName" the name of the stored procedure 
        // param name="parameterValues" an array of objects to be assigned as the input values of the stored procedure 
        // returns an object containing the value in the 1x1 resultset generated by the command
        //
        //*********************************************************************

        public static object ExecuteScalar(string connectionString, string spName, params object[] parameterValues)
        {
            //if we receive parameter values, we need to figure out where they go
            if ((parameterValues != null) && (parameterValues.Length > 0))
            {
                //pull the parameters for this stored procedure from the parameter cache (or discover them & populate the cache)
                SqlParameter[] commandParameters = SqlHelperParameterCache.GetSpParameterSet(connectionString, spName);

                //assign the provided values to these parameters based on parameter order
                AssignParameterValues(commandParameters, parameterValues);

                //call the overload that takes an array of SqlParameters
                return ExecuteScalar(connectionString, CommandType.StoredProcedure, spName, commandParameters);
            }
            //otherwise we can just call the SP without params
            else
            {
                return ExecuteScalar(connectionString, CommandType.StoredProcedure, spName);
            }
        }

        //*********************************************************************
        //
        // Execute a SqlCommand (that returns a 1x1 resultset) against the specified SqlConnection 
        // using the provided parameters.
        // 
        // e.g.:  
        //  int orderCount = (int)ExecuteScalar(conn, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));
        // 
        // param name="connection" a valid SqlConnection 
        // param name="commandType" the CommandType (stored procedure, text, etc.) 
        // param name="commandText" the stored procedure name or T-SQL command 
        // param name="commandParameters" an array of SqlParamters used to execute the command 
        // returns an object containing the value in the 1x1 resultset generated by the command
        //
        //*********************************************************************

        public static object ExecuteScalar(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);

            //execute the command & return the results
            object retval = cmd.ExecuteScalar();

            // detach the SqlParameters from the command object, so they can be used again.
            cmd.Parameters.Clear();
            return retval;

        }
    }

    public sealed class SqlHelperParameterCache
    {
        //*********************************************************************
        //
        // Since this class provides only static methods, make the default constructor private to prevent 
        // instances from being created with "new SqlHelperParameterCache()".
        //
        //*********************************************************************

        private SqlHelperParameterCache() { }

        private static Hashtable paramCache = Hashtable.Synchronized(new Hashtable());

        //*********************************************************************
        //
        // resolve at run time the appropriate set of SqlParameters for a stored procedure
        // 
        // param name="connectionString" a valid connection string for a SqlConnection 
        // param name="spName" the name of the stored procedure 
        // param name="includeReturnValueParameter" whether or not to include their return value parameter 
        //
        //*********************************************************************

        private static SqlParameter[] DiscoverSpParameterSet(string connectionString, string spName, bool includeReturnValueParameter)
        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(spName, cn))
            {
                cn.Open();
                cmd.CommandType = CommandType.StoredProcedure;

                SqlCommandBuilder.DeriveParameters(cmd);

                if (!includeReturnValueParameter)
                {
                    cmd.Parameters.RemoveAt(0);
                }

                SqlParameter[] discoveredParameters = new SqlParameter[cmd.Parameters.Count]; ;

                cmd.Parameters.CopyTo(discoveredParameters, 0);

                return discoveredParameters;
            }
        }

        private static SqlParameter[] CloneParameters(SqlParameter[] originalParameters)
        {
            //deep copy of cached SqlParameter array
            SqlParameter[] clonedParameters = new SqlParameter[originalParameters.Length];

            for (int i = 0, j = originalParameters.Length; i < j; i++)
            {
                clonedParameters[i] = (SqlParameter)((ICloneable)originalParameters[i]).Clone();
            }

            return clonedParameters;
        }

        //*********************************************************************
        //
        // add parameter array to the cache
        //
        // param name="connectionString" a valid connection string for a SqlConnection 
        // param name="commandText" the stored procedure name or T-SQL command 
        // param name="commandParameters" an array of SqlParamters to be cached 
        //
        //*********************************************************************

        public static void CacheParameterSet(string connectionString, string commandText, params SqlParameter[] commandParameters)
        {
            string hashKey = connectionString + ":" + commandText;

            paramCache[hashKey] = commandParameters;
        }

        //*********************************************************************
        //
        // Retrieve a parameter array from the cache
        // 
        // param name="connectionString" a valid connection string for a SqlConnection 
        // param name="commandText" the stored procedure name or T-SQL command 
        // returns an array of SqlParamters
        //
        //*********************************************************************

        public static SqlParameter[] GetCachedParameterSet(string connectionString, string commandText)
        {
            string hashKey = connectionString + ":" + commandText;

            SqlParameter[] cachedParameters = (SqlParameter[])paramCache[hashKey];

            if (cachedParameters == null)
            {
                return null;
            }
            else
            {
                return CloneParameters(cachedParameters);
            }
        }

        //*********************************************************************
        //
        // Retrieves the set of SqlParameters appropriate for the stored procedure
        // 
        // This method will query the database for this information, and then store it in a cache for future requests.
        // 
        // param name="connectionString" a valid connection string for a SqlConnection 
        // param name="spName" the name of the stored procedure 
        // returns an array of SqlParameters
        //
        //*********************************************************************

        public static SqlParameter[] GetSpParameterSet(string connectionString, string spName)
        {
            return GetSpParameterSet(connectionString, spName, false);
        }

        //*********************************************************************
        //
        // Retrieves the set of SqlParameters appropriate for the stored procedure
        // 
        // This method will query the database for this information, and then store it in a cache for future requests.
        // 
        // param name="connectionString" a valid connection string for a SqlConnection 
        // param name="spName" the name of the stored procedure 
        // param name="includeReturnValueParameter" a bool value indicating whether the return value parameter should be included in the results 
        // returns an array of SqlParameters
        //
        //*********************************************************************

        public static SqlParameter[] GetSpParameterSet(string connectionString, string spName, bool includeReturnValueParameter)
        {
            string hashKey = connectionString + ":" + spName + (includeReturnValueParameter ? ":include ReturnValue Parameter" : "");

            SqlParameter[] cachedParameters;

            cachedParameters = (SqlParameter[])paramCache[hashKey];

            if (cachedParameters == null)
            {
                cachedParameters = (SqlParameter[])(paramCache[hashKey] = DiscoverSpParameterSet(connectionString, spName, includeReturnValueParameter));
            }

            return CloneParameters(cachedParameters);
        }
    }

    #endregion
</script><!--||||||||||--><asp:panel id="panelLocation" runat="server" visible="false">
<% foreach ( genprobhelper.location loc in Locations ) 
   { %>

           			<p id="sres<%= loc.location_id %>" class="sres <%= ( String.IsNullOrEmpty(loc.dropdownname) ) ? "" : loc.dropdownname.Split(new string[] { " - " }, StringSplitOptions.None)[0].Trim().Replace(" ","") %>" style="display:none">  
           			    <textarea style="display:none;" class="original_address"><%= ( !String.IsNullOrEmpty(loc.addressoverride)) ? loc.addressoverride : loc.addressline1 + " " + loc.addressline2 + " " + loc.addressline3 %> <%= (String.IsNullOrEmpty(loc.addressline2)) ? "" : loc.addressline2 %> <%= (String.IsNullOrEmpty(loc.addressline3)) ? "" : loc.addressline3 %></textarea>
           			    <textarea style="display:none;" class="override_address"><%= (String.IsNullOrEmpty(loc.addressline1)) ? "" : loc.addressline1 %> <%= (String.IsNullOrEmpty(loc.addressline2)) ? "" : loc.addressline2 %> <%= (String.IsNullOrEmpty(loc.addressline3)) ? "" : loc.addressline3 %></textarea>           			    
           				<span class="light small"><%= loc.locationtext %></span>
           				<br/><br/>
           				<span class="large"><strong><%= loc.locationname %></strong></span>
           				<%= (String.IsNullOrEmpty(loc.contactname)) ? "" : "<br />Contact: " + loc.contactname %>    
           			
           				<%= (String.IsNullOrEmpty(loc.addressline1)) ? "" : "<br />" + loc.addressline1 %>
           				<%= (String.IsNullOrEmpty(loc.addressline2)) ? "" : "<br />" + loc.addressline2 %>
           				<%= (String.IsNullOrEmpty(loc.addressline3)) ? "" : "<br />" + loc.addressline3 %>
       				
						<%= (String.IsNullOrEmpty(loc.phone1)) ? "" : (loc.phone1.IndexOf("Toll Free") > -1) ? "<br />" + loc.phone1 : "<br />Tel: " + loc.phone1%>
						<%= (String.IsNullOrEmpty(loc.phone2)) ? "" : (loc.phone2.IndexOf("6:00 am") > -1) ? "<br />" + loc.phone2 : "<br />Tel: " + loc.phone2%>           				<%= (String.IsNullOrEmpty(loc.phone3)) ? "" : "<br />mobile: " + loc.phone3%>
                        <%= (String.IsNullOrEmpty(loc.fax1)) ? "" : "<br />" + loc.fax1 %>
                        <%= (String.IsNullOrEmpty(loc.fax2)) ? "" : "<br />" + loc.fax2 %> 
          				
           				<%= (String.IsNullOrEmpty(loc.email)) ? "" : "<br />Email: <a href=\"mailto:" + loc.email + "\">" + loc.email + "</a>" %>
           				<%= (String.IsNullOrEmpty(loc.website)) ? "" : "<br />" + loc.website %> 
          				
           			</p>
<% } %>
</asp:panel>
