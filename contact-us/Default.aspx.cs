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


public partial class genprobhelper : System.Web.UI.Page
{
    public static Hashtable GetInformationTypes()
    {

        Hashtable informationtypes = null;

        //if we have a hashtable for informationtypes stored in cache use that
        if ( HttpContext.Current.Cache["informationtypes"] != null && HttpContext.Current.Request.QueryString["clearcache"] == null)
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

/*
public Hashtable InformationTypes
{
    get
    {
        return genprobhelper.GetInformationTypes();
    }
}
*/

