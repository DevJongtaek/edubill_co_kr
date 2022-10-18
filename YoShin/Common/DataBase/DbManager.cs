using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.OracleClient;			// Oracle
using System.Data.SqlClient;
using System.Data.Odbc;
using System.Xml;
using Edubill.YoShin.Common.ExceptionHandler;

namespace Edubill.YoShin.Common.DataBase
{
    public class DbManager
    {
        private string DBType_ = "";
        private string mConnectionString = "";

        public DbManager(string DBType, string connectionString)
        {
            DBType_ = DBType;
            mConnectionString = connectionString;
        }

        private IDbConnection getDbConnection()
        {
            IDbConnection oConn = null;
            switch (DBType_)
            {
                case "ORACLE":
                    oConn = new OracleConnection(mConnectionString);
                    break;
                case "MSSQL":
                    oConn = new SqlConnection(mConnectionString);
                    break;
                default:
                    oConn = new OdbcConnection(mConnectionString);
                    break;
            }

            return oConn;
        }

        private IDbDataAdapter getDataAdaptor(string sql)
        {
            IDbDataAdapter adp = null;
            IDbConnection conn = getDbConnection();
            try
            {
                conn.Open();

                switch (DBType_)
                {
                    case "ORACLE":
                        adp = new OracleDataAdapter(sql, (OracleConnection)conn);
                        break;
                    case "MSSQL":
                        adp = new SqlDataAdapter(sql, (SqlConnection)conn);
                        break;
                    default:
                        adp = new OdbcDataAdapter(sql, (OdbcConnection)conn);
                        break;
                }

                conn.Close();
                return adp;
            }
            catch (Exception E)
            {
                ExceptionHandler.ExceptionHandler.getInstance().ErrEvent(E, sql);
                return null;
            }
            finally
            {
            }
        }

        private IDbCommand getDbCommand(string sql)
        {
            IDbCommand cmd = null;
            IDbConnection conn = getDbConnection();
            try
            {
                conn.Open();

                switch (DBType_)
                {
                    case "ORACLE":
                        cmd = new OracleCommand(sql, (OracleConnection)conn);
                        break;
                    case "MSSQL":
                        cmd = new SqlCommand(sql, (SqlConnection)conn);
                        break;
                    default:
                        cmd = new OdbcCommand(sql, (OdbcConnection)conn);
                        break;
                }

                return cmd;
            }
            catch (Exception E)
            {
                ExceptionHandler.ExceptionHandler.getInstance().ErrEvent(E, sql);
                return null;
            }
            finally
            {
            }
        }

        public string DbErrorMessage
        {
            get
            {
                string strMessage = "";
                Exception e = ExceptionHandler.ExceptionHandler.getInstance().raisedException;

                if (e != null)
                    strMessage = e.Message;

                return strMessage;
            }
        }

        public bool DBExecute(string sql)
        {
            try
            {
                if (this.DBType_ == "ORACLE")
                {
                    sql = sql.Replace("[", "\"");
                    sql = sql.Replace("]", "\"");
                }

                IDbCommand cmd = getDbCommand(sql);
                cmd.ExecuteNonQuery();//실행

                cmd.Connection.Close();
                return true;
            }
            catch (Exception E)
            {
                ExceptionHandler.ExceptionHandler.getInstance().ErrEvent(E, sql);
                return false;
            }
        }

        //* ado.net *//
        public DataSet GetDataSet(string sql)
        {
            //연결
            try
            {
                if (this.DBType_ == "ORACLE")
                {
                    sql = sql.Replace("[", "\"");
                    sql = sql.Replace("]", "\"");
                }

                if (DBType_ == "ORACLE")
                    sql = sql.Replace(" = ''", " IS NULL");
                else
                    sql = sql.Replace(" IS NULL", " = ''");

                IDbDataAdapter oAdp = getDataAdaptor(sql);
                DataSet oDataSet = new DataSet();

                oAdp.Fill(oDataSet);
                return oDataSet;
            }
            catch (Exception E)
            {
                ExceptionHandler.ExceptionHandler.getInstance().ErrEvent(E, sql);
                return null;
            }
        }

        public string[,] GetRecordSet(string SQL)
        {
            try
            {
                DataSet ds;
                string[,] data = null;

                ds = GetDataSet(SQL);
                if (ds != null)
                {
                    data = new string[ds.Tables[0].Columns.Count, ds.Tables[0].Rows.Count];
                    for (int i = 0; i < data.GetLength(1); i++)
                    {
                        for (int k = 0; k < data.GetLength(0); k++)
                        {
                            if (ds.Tables[0].Rows[i].ItemArray[k] != null)
                                data[k, i] = ds.Tables[0].Rows[i].ItemArray[k].ToString();
                            else
                                data[k, i] = "";
                        }
                    }

                }

                if (data.GetLength(1) == 0) data = null;
                return data;
            }
            catch (Exception E)
            {
                ExceptionHandler.ExceptionHandler.getInstance().ErrEvent(E, SQL);
                return null;
            }
        }

        public string GetRecordSetXML(string SQL)
        {
            StringBuilder sbData = new StringBuilder();
            try
            {
                if (this.DBType_ == "ORACLE")
                {
                    SQL = SQL.Replace("[", "\"");
                    SQL = SQL.Replace("]", "\"");
                }

                DataSet ds;

                SQL += " FOR XML AUTO ";
                ds = GetDataSet(SQL);
                if (ds != null)
                {
                    foreach (DataRow oRow in ds.Tables[0].Rows)
                    {
                        sbData.Append(oRow.ItemArray[0]);
                    }
                }

                return sbData.ToString();
            }
            catch (Exception E)
            {
                ExceptionHandler.ExceptionHandler.getInstance().ErrEvent(E, SQL);
                return "";
            }
            finally
            {
                sbData = null;
            }
        }

        public XmlDocument GetRecordSetDoc(string SQL)
        {
            try
            {
                if (this.DBType_ == "ORACLE")
                {
                    SQL = SQL.Replace("[", "\"");
                    SQL = SQL.Replace("]", "\"");
                }

                XmlDocument oDoc = new XmlDocument();
                string strXml = GetRecordSetXML(SQL);

                oDoc.LoadXml("<SQL>" + strXml + "</SQL>");
                return oDoc;
            }
            catch (Exception E)
            {
                ExceptionHandler.ExceptionHandler.getInstance().ErrEvent(E, SQL);
                return null;
            }
        }

        public XmlDocument GetRecordSetDocSimple(string SQL, string elementName)
        {
            try
            {
                if (this.DBType_ == "ORACLE")
                {
                    SQL = SQL.Replace("[", "\"");
                    SQL = SQL.Replace("]", "\"");
                }

                XmlDocument oDoc = new XmlDocument();
                string strXml = GetRecordSetXMLSimple(SQL, elementName);

                if (strXml.Length == 0)
                    return null;
                else
                {
                    oDoc.LoadXml("<SQL>" + strXml + "</SQL>");
                    return oDoc;
                }
            }
            catch (Exception E)
            {
                ExceptionHandler.ExceptionHandler.getInstance().ErrEvent(E, SQL);
                return null;
            }
        }

        public string GetRecordSetXMLSimple(string SQL, string elementName)
        {
            StringBuilder sbData = new StringBuilder();
            string colval = "";
            try
            {
                if (this.DBType_ == "ORACLE")
                {
                    SQL = SQL.Replace("[", "\"");
                    SQL = SQL.Replace("]", "\"");
                }

                DataSet ds;

                ds = GetDataSet(SQL);

                if (ds != null)
                {
                    foreach (DataRow oRow in ds.Tables[0].Rows)
                    {
                        sbData.Append("<" + elementName + " ");
                        for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
                        {
                            if (oRow.ItemArray[i] == null)
                                colval = "";
                            else
                                colval = oRow.ItemArray[i].ToString();

                            sbData.Append(ds.Tables[0].Columns[i].Caption);
                            sbData.Append("='" + colval + "' ");
                        }
                        sbData.Append("/>");
                    }
                }

                return sbData.ToString();
            }
            catch (Exception E)
            {
                ExceptionHandler.ExceptionHandler.getInstance().ErrEvent(E, SQL);
                return "";
            }
            finally
            {
                sbData = null;
            }
        }


        public bool IsExistDBValue(string TableName, string FieldName, string FieldValue, bool isNumField)
        {
            string[] FieldNames, FieldValues;
            string sql = "";
            try
            {

                FieldNames = FieldName.Split(',');
                FieldValues = FieldValue.Split(',');

                sql = "";
                sql += "\r\n SELECT " + FieldName;
                sql += "\r\n FROM " + TableName;
                sql += "\r\n WHERE ";
                for (int i = 0; i < FieldNames.GetLength(0); i++)
                {
                    if (isNumField) { sql += "\r\n " + FieldNames[i] + "=" + FieldValues[i] + " "; }
                    else { sql += "\r\n " + FieldNames[i] + "='" + FieldValues[i] + "' "; }

                    if (i != FieldNames.GetLength(0) - 1) sql += " AND ";
                }
                string[,] rs = GetRecordSet(sql);
                if (rs == null)
                    return false;
                else
                    return true;
            }
            catch (Exception E)
            {
                ExceptionHandler.ExceptionHandler.getInstance().ErrEvent(E, sql);
                return false;
            }
        }

        public string GetDataDB2Xml(string sql, string elementName)
        {
            StringBuilder sbData = new StringBuilder();
            string colval = "";

            if (this.DBType_ == "ORACLE")
            {
                sql = sql.Replace("[", "\"");
                sql = sql.Replace("]", "\"");
            }

            DataSet ds;

            ds = GetDataSet(sql);

            if (ds != null)
            {
                foreach (DataRow oRow in ds.Tables[0].Rows)
                {
                    sbData.Append("<" + elementName + " ");
                    for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
                    {
                        if (oRow.ItemArray[i] == null)
                            colval = "";
                        else
                            colval = oRow.ItemArray[i].ToString();

                        sbData.Append(ds.Tables[0].Columns[i].Caption);
                        sbData.Append("='" + colval + "' ");
                    }
                    sbData.Append("/>");
                }
            }

            return sbData.ToString();
        }
    }
}
