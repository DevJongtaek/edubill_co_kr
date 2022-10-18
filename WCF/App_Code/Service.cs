﻿using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Text;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.IO;
using System.Net;

// 참고: 여기서 클래스 이름 "Service"를 변경하는 경우 Web.config 및 연결된 .svc 파일에서 "Service"에 대한 참조도 업데이트해야 합니다.
public class Service : IService
{
    private string connectString
        = @"Data Source=220.73.136.52;Initial Catalog=edubill_co_kr;Persist Security Info=True;User ID=sa;Password=edubill@6508";
    private string connectStringTR
        = @"Data Source=220.73.136.46;Initial Catalog=TR_DB;Persist Security Info=True;User ID=tr_edubill;Password=tr@6508";

    private string connectStringKaKaotalk
         = @"Data Source=220.73.136.45;Initial Catalog=kpro_client;Persist Security Info=True;User ID=sa;Password=qsefofchasero";
    public User GetUserInformation(User value)
    {
        if (value.LEVEL == 0)
        {
            string sqlString1 = @"SELECT usercode
                            FROM tb_adminuser
                            WHERE (flag = 2) AND (userid = @userid)";
            string sqlString2 = @"SELECT comname, tcode, cporg_cd
                            FROM tb_company
                            WHERE (idx = @idx) AND (flag = 1)";
            SqlConnection cn = new SqlConnection(connectString);
            //cmd1
            SqlCommand cmd1 = new SqlCommand(sqlString1, cn);
            cmd1.Parameters.Add(new SqlParameter("@userid", value.Name));
            cn.Open();
            SqlDataReader reader1 =
                cmd1.ExecuteReader(CommandBehavior.CloseConnection | CommandBehavior.SingleRow);
            if (reader1.Read() == false)
            {
                reader1.Close();
                cn.Dispose();
                reader1.Dispose();
                cmd1.Dispose();
                return null;
            }
            value.CompanyIdx = reader1["usercode"].ToString();
            reader1.Close();
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Dispose();
            reader1.Dispose();
            cmd1.Dispose();
            //cmd2
            cn = new SqlConnection(connectString);
            SqlCommand cmd2 = new SqlCommand(sqlString2, cn);
            cmd2.Parameters.Add(new SqlParameter("@idx", value.CompanyIdx));
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Open();
            SqlDataReader reader2 =
                cmd2.ExecuteReader(CommandBehavior.CloseConnection | CommandBehavior.SingleRow);
            if (reader2.Read() == false)
            {
                reader2.Close();
                if (cn.State == ConnectionState.Open) cn.Close();
                cn.Dispose();
                reader2.Dispose();
                cmd2.Dispose();
                return null;
            }
            value.CompanyCode = reader2["tcode"].ToString();
            value.CPCode = reader2["cporg_cd"].ToString();
            value.CompanyName = reader2["comname"].ToString();
            reader2.Close();
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Dispose();
            reader2.Dispose();
            cmd2.Dispose();
        }
        else if (value.LEVEL == 1)
        {
            string sqlString1 = @"SELECT usercode
                            FROM tb_adminuser
                            WHERE (flag = 3) AND (userid = @userid)";
            string sqlString2 = @"SELECT comname, tcode, cporg_cd
                            FROM tb_company
                            WHERE (idx = @idx) AND (flag = 2)";
            SqlConnection cn = new SqlConnection(connectString);
            //cmd1
            SqlCommand cmd1 = new SqlCommand(sqlString1, cn);
            cmd1.Parameters.Add(new SqlParameter("@userid", value.Name));
            cn.Open();
            SqlDataReader reader1 =
                cmd1.ExecuteReader(CommandBehavior.CloseConnection | CommandBehavior.SingleRow);
            if (reader1.Read() == false)
            {
                reader1.Close();
                cn.Dispose();
                reader1.Dispose();
                cmd1.Dispose();
                return null;
            }
            value.CompanyIdx = reader1["usercode"].ToString().Substring(0,5);
            value.subidx = reader1["usercode"].ToString().Substring(5, 5);
            reader1.Close();
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Dispose();
            reader1.Dispose();
            cmd1.Dispose();
            //cmd2
            cn = new SqlConnection(connectString);
            SqlCommand cmd2 = new SqlCommand(sqlString2, cn);
            cmd2.Parameters.Add(new SqlParameter("@idx", value.subidx));
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Open();
            SqlDataReader reader2 =
                cmd2.ExecuteReader(CommandBehavior.CloseConnection | CommandBehavior.SingleRow);
            if (reader2.Read() == false)
            {
                reader2.Close();
                if (cn.State == ConnectionState.Open) cn.Close();
                cn.Dispose();
                reader2.Dispose();
                cmd2.Dispose();
                return null;
            }
            value.CompanyCode = reader2["tcode"].ToString();
            value.CPCode = reader2["cporg_cd"].ToString();
            value.CompanyName = reader2["comname"].ToString();
            reader2.Close();
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Dispose();
            reader2.Dispose();
            cmd2.Dispose();
        }
        else if (value.LEVEL == 2)
        {
            string sqlString1 = @"SELECT usercode
                            FROM tb_adminuser
                            WHERE (flag = 3) AND (userid = @userid)";
            string sqlString2 = @"SELECT comname, tcode, cporg_cd
                            FROM tb_company
                            WHERE (idx = @idx) AND (flag = 2)";
            SqlConnection cn = new SqlConnection(connectString);
            //cmd1
            SqlCommand cmd1 = new SqlCommand(sqlString1, cn);
            cmd1.Parameters.Add(new SqlParameter("@userid", value.Name));
            cn.Open();
            SqlDataReader reader1 =
                cmd1.ExecuteReader(CommandBehavior.CloseConnection | CommandBehavior.SingleRow);
            if (reader1.Read() == false)
            {
                reader1.Close();
                cn.Dispose();
                reader1.Dispose();
                cmd1.Dispose();
                return null;
            }
            value.CompanyIdx = reader1["usercode"].ToString().Substring(0,5);
            value.subidx = reader1["usercode"].ToString().Substring(5, 5);
            reader1.Close();
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Dispose();
            reader1.Dispose();
            cmd1.Dispose();
            //cmd2
            cn = new SqlConnection(connectString);
            SqlCommand cmd2 = new SqlCommand(sqlString2, cn);
            cmd2.Parameters.Add(new SqlParameter("@idx", value.subidx));
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Open();
            SqlDataReader reader2 =
                cmd2.ExecuteReader(CommandBehavior.CloseConnection | CommandBehavior.SingleRow);
            if (reader2.Read() == false)
            {
                reader2.Close();
                if (cn.State == ConnectionState.Open) cn.Close();
                cn.Dispose();
                reader2.Dispose();
                cmd2.Dispose();
                return null;
            }
            value.CompanyCode = reader2["tcode"].ToString();
            value.CPCode = reader2["cporg_cd"].ToString();
            value.CompanyName = reader2["comname"].ToString();
            reader2.Close();
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Dispose();
            reader2.Dispose();
            cmd2.Dispose();
        }
        return value;

    }
    public DataTable GetBonsa(Request value)
    {
        try
        {
            DataTable table = new DataTable("returnTable");

            StringBuilder sqlString = new StringBuilder();
            if (value.RequestUser.LEVEL == 0)
            {
                sqlString.AppendLine(
                    @"SELECT comname as Corp_Name
	            , name as CEO_NAME
	            , companynum1 + '-' + companynum2 + '-' + companynum3 as Corp_No
	            , post as Corp_ZIP
	            , addr as Corp_Add
	            , addr2 as Corp_Add_Detail
	            , tel1 + '-' + tel2 + '-' + tel3 as Corp_Phone
	            , fax1 + '-' + fax2 + '-' + fax3 as Corp_FAX
	            , upjong as Corp_JongMok
	            , uptae as Corp_Uptae
	            , juminno1 + '-' + juminno2 as Corp_ID
	            , 0 as Corp_Level
	            , tcode as Jisa_Code
	            , Case When Len(wdate) >=10 then Replace(Left(wdate, 10), '-', '/') else '' End as Create_Date
	            from tb_company 
	            where flag = 1 and idx = @idx");
                SqlDataAdapter adapter = new SqlDataAdapter(sqlString.ToString(), connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@idx", value.RequestUser.CompanyIdx));
                adapter.Fill(table);
                adapter.Dispose();
            }
            else
            {
                sqlString.AppendLine(
                    @"SELECT comname as Corp_Name
	            , name as CEO_NAME
	            , companynum1 + '-' + companynum2 + '-' + companynum3 as Corp_No
	            , post as Corp_ZIP
	            , addr as Corp_Add
	            , addr2 as Corp_Add_Detail
	            , tel1 + '-' + tel2 + '-' + tel3 as Corp_Phone
	            , fax1 + '-' + fax2 + '-' + fax3 as Corp_FAX
	            , upjong as Corp_JongMok
	            , uptae as Corp_Uptae
	            , juminno1 + '-' + juminno2 as Corp_ID
	            , 0 as Corp_Level
	            , tcode as Jisa_Code
	            , Case When Len(wdate) >=10 then Replace(Left(wdate, 10), '-', '/') else '' End as Create_Date
	            from tb_company 
	            where flag = 2 and idx = @idx");
                SqlDataAdapter adapter = new SqlDataAdapter(sqlString.ToString(), connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@idx", value.RequestUser.subidx));
                adapter.Fill(table);
                adapter.Dispose();
            }
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }
    public DataTable GetUsers_new(Request value)
    {
        try
        {
            DataTable table = new DataTable("returnTable");
            if (value.RequestUser.LEVEL == 0)
            {
                string sqlString =
                @"select userid as UserID , userpwd as UserPassword, username as UserName, 
                CASE WHEN len(usercode) = 5 THEN 0 WHEN len(usercode) = 10 THEN 1 ELSE 2 END as UserLevel,
                CASE WHEN len(usercode) >= 10 THEN c.tcode ELSE b.tcode END as JisaCode
                from tb_adminuser a 
                left join
                tb_company b on left(a.usercode, 5) = b.idx
                left join
                tb_company c on substring(a.usercode, 6, 5) = c.idx
                where left(usercode, 5) in (@idx)";
                SqlDataAdapter adapter = new SqlDataAdapter(sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@idx", value.RequestUser.CompanyIdx));
                adapter.Fill(table);
                adapter.Dispose();
            }
            else if (value.RequestUser.LEVEL == 1)
            {
                string sqlString =
                @"select userid as UserID , userpwd as UserPassword, username as UserName, a.dcenteridx, 
                CASE WHEN len(usercode) = 5 THEN 0 WHEN len(usercode) = 10 THEN 1 ELSE 2 END as UserLevel,
                CASE WHEN len(usercode) >= 10 THEN c.tcode ELSE b.tcode END as JisaCode
                from tb_adminuser a 
                left join
                tb_company b on left(a.usercode, 5) = b.idx
                left join
                tb_company c on substring(a.usercode, 6, 5) = c.idx
                where substring(usercode, 6,5) in (@idx) AND a.userid = @name";
                SqlDataAdapter adapter = new SqlDataAdapter(sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@idx", value.RequestUser.subidx));
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@name", value.RequestUser.Name));
                adapter.Fill(table);
                adapter.Dispose();
            }
            else if (value.RequestUser.LEVEL == 2)
            {
                string sqlString =
                @"select userid as UserID , userpwd as UserPassword, username as UserName, a.dcenteridx, 
                CASE WHEN len(usercode) = 5 THEN 0 WHEN len(usercode) = 10 THEN 1 ELSE 2 END as UserLevel,
                CASE WHEN len(usercode) >= 10 THEN c.tcode ELSE b.tcode END as JisaCode
                from tb_adminuser a 
                left join
                tb_company b on left(a.usercode, 5) = b.idx
                left join
                tb_company c on substring(a.usercode, 6, 5) = c.idx
                where substring(usercode, 6,5) in (@idx) AND a.userid = @name";
                SqlDataAdapter adapter = new SqlDataAdapter(sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@idx", value.RequestUser.subidx));
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@name", value.RequestUser.Name));
                adapter.Fill(table);
                adapter.Dispose();
            }
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }
    public DataTable GetProducts(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            DataTable table = new DataTable("returnTable");
            if(value.RequestUser.LEVEL == 2)
            {
                string sqlString =
                    @"Select a.pcode as Code, a.pname as Name
                , a.pprice as Sell_UnitPrice, a.ptitle as Size_Code, a.qty_code as Unit_Code
                , a.gubun as HasTax, a.bigo as Memo
                , a.wdate as Create_Date, fileregcode, dcenterchoice
                FROM tb_product a
                WHERE (usercode = @usercode) and (dcenterchoice = @dcenter)";
                SqlDataAdapter adapter = new SqlDataAdapter(
                    sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@usercode", value.RequestUser.CompanyIdx));
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@dcenter", value.Dcenter));
                adapter.Fill(table);
                adapter.Dispose();
            }
            else
            {
                string sqlString =
                    @"Select a.pcode as Code, a.pname as Name
                , a.pprice as Sell_UnitPrice, a.ptitle as Size_Code, a.qty_code as Unit_Code
                , a.gubun as HasTax, a.bigo as Memo
                , a.wdate as Create_Date, fileregcode, dcenterchoice
                FROM tb_product a
                WHERE (usercode = @usercode)";
                SqlDataAdapter adapter = new SqlDataAdapter(
                    sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@usercode", value.RequestUser.CompanyIdx));

                adapter.Fill(table);
                adapter.Dispose();
            }
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }
    public DataTable GetDCenterProducts(string brandCode, string dcenterCode)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString =
                @"Select a.pcode as Code, a.pname as Name
                , a.pprice as Sell_UnitPrice, a.ptitle as Size_Code, a.qty_code as Unit_Code
                , a.gubun as HasTax, a.bigo as Memo
                , a.wdate as Create_Date
                FROM tb_product a
                WHERE (usercode = @usercode) AND (dcenterchoice = @dcentercode)";
            SqlDataAdapter adapter = new SqlDataAdapter(
                sqlString, connectString);
            adapter.SelectCommand.Parameters.Add(new SqlParameter("@usercode", brandCode));
            adapter.SelectCommand.Parameters.Add(new SqlParameter("@dcentercode", dcenterCode));
            DataTable table = new DataTable("returnTable");
            adapter.Fill(table);
            adapter.Dispose();
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }
    public DataTable GetJisaInformation(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            DataTable table = new DataTable("returnTable");
            if (value.RequestUser.LEVEL == 0)
            {
                string sqlString =
                    @"SELECT tcode as Jisa_Code, comname as Corp_Name, name as CEO_NAME
                , companynum1 + '-' + companynum2 + '-' + companynum3 as Corp_No
                , post as Corp_ZIP
                , addr as Corp_Add
                , addr2 as Corp_Add_Detail
                , upjong as Corp_JongMok
                , uptae as Corp_Uptae
                , tel1 + '-' + tel2 + '-' + tel3 as Corp_Phone
                , fax1 + '-' + fax2 + '-' + fax3 as Corp_FAX
                , dcarno as Delivery_Code
                , Case When Len(wdate) >=10 then Replace(Left(wdate, 10), '-', '/') else '' End as Create_Date
                from tb_company 
                where flag = 2 and bidxsub = @bidxsub";
                SqlDataAdapter adapter = new SqlDataAdapter(
                    sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));

                adapter.Fill(table);
                adapter.Dispose();
            }
            else
            {
                string sqlString =
                @"SELECT tcode as Jisa_Code, comname as Corp_Name, name as CEO_NAME
                , companynum1 + '-' + companynum2 + '-' + companynum3 as Corp_No
                , post as Corp_ZIP
                , addr as Corp_Add
                , addr2 as Corp_Add_Detail
                , upjong as Corp_JongMok
                , uptae as Corp_Uptae
                , tel1 + '-' + tel2 + '-' + tel3 as Corp_Phone
                , fax1 + '-' + fax2 + '-' + fax3 as Corp_FAX
                , dcarno as Delivery_Code
                , Case When Len(wdate) >=10 then Replace(Left(wdate, 10), '-', '/') else '' End as Create_Date
                from tb_company 
                where flag = 2 and idx = @bidxsub";
                SqlDataAdapter adapter = new SqlDataAdapter(
                    sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));

                adapter.Fill(table);
                adapter.Dispose();
            }
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }
    public DataTable GetBrandInformation(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString =
                @"select	bidx as Code
                ,		'CLB' as Type
                ,		'' as Up_Code   
                ,		bname as Code_Name
                ,		'' as Code_Discript
                ,		'' as ICD
                ,		getDate() as IDT
                ,		'' as UCD
                ,		getDate() as UDT
                ,		0 as Code_Order   
                from tb_company_brand where idx = @bidxsub";
            SqlDataAdapter adapter = new SqlDataAdapter(
                sqlString, connectString);
            adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));
            DataTable table = new DataTable("returnTable");
            adapter.Fill(table);
            adapter.Dispose();
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }
    public DataTable GetCompanies(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            DataTable table = new DataTable("returnTable");
            if (value.RequestUser.LEVEL == 0)
            {
                string sqlString =
                    @"SELECT	a.tcode AS Code, a.comname AS Name, a.name AS CEO_Name, a.post AS Zip_Code, a.addr AS Addr, a.addr2 AS Addr_Detail, 
		                a.companynum1 + N'-' + a.companynum2 + N'-' + a.companynum3 AS ID_Code, a.uptae AS Uptae, a.upjong AS Jongmok, a.wdate AS Create_Date, 
		                a.ye_money AS Check_Limit, a.virtual_acnt AS Virtual_Check, a.virtual_acnt_bank AS Bank_Name, a.email AS Agent_Email, ISNULL(b.tcode, '') 
		                AS Jisa_Code, ISNULL(a.cbrandchoice, '') AS Type_B, c.idx AS cCode, c.usercode AS cUser_Code, c.dcarno AS cDelivery_No, 
		                c.dcarname AS cDelivery_Name, c.tel1 + N'-' + c.tel2 + N'-' + c.tel3 AS cPhone, c.carno AS cCar_No, c.carkind AS cCar_Kind, c.caryflag AS cCar_Year, 
		                c.wdate AS cCreate_Date, a.fileregcode, a.tel1 + N'-' + a.tel2 + N'-' + a.tel3 AS Agent_Phone, a.hp1 + '-' + a.hp2 + '-' + a.hp3 AS Agent_HPhone
                FROM    tb_company AS a 
                LEFT OUTER JOIN
		                (SELECT	idx, tcode, flag, fileflaglevel, bidxsub, idxsub, idxsubname, comname, name, juminno1, juminno2, post, addr, addr2, companynum1, 
				                companynum2, companynum3, uptae, upjong, tel1, tel2, tel3, fax1, fax2, fax3, hp1, hp2, hp3, homepage, email, dcarno, vatflag, taxtitle, 
				                usegubun, usemoney, startday, orderreg, soundfile, sclose, dcode, fileflag, telecom, ctel1, ctel2, ctel3, hapday, jumin1, jumin2, 
				                jumincheck, telname, conetion, wdate, wuserid, edate, euserid, orderflag, fileregcode, mregflag, brandflag, brandbox, cbrandchoice, 
				                timecheck1, timecheck2, com_notice, d_requestday, order_weekgubun, order_weekchoice, order_checkStime, order_checkEtime, 
				                maechulflag, mi_money, ye_money, myflag, myflag_select, agencycheck2, ch_gongi, serviceflag, dcenterflag, proflag1, proflag2, djflag, 
				                smsflag, chk_gongi1, chk_gongi2, miorderflag, virtual_acnt, virtual_acnt_bank, noteflag, accountflag, misuprint, datadel, datadelday, 
				                misubtn, cyberNum, cporg_cd, rec_fax, noticeflag, fileflagchb, virtual_acnt2, virtual_acnt2_bank
		                FROM          tb_company
		                WHERE      (bidxsub = @bidxsub) AND (flag = 2)) AS b ON a.idxsub = b.idx 
                LEFT OUTER JOIN
		                (SELECT     idx, usercode, dcarno, dcarname, tel1, tel2, tel3, carno, carkind, caryflag, wdate, wuserid, edate, euserid
		                FROM		tb_car) AS c ON a.dcarno = c.idx
                WHERE	(a.flag = 3) AND (a.bidxsub = @bidxsub)";
                SqlDataAdapter adapter = new SqlDataAdapter(sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));
                adapter.Fill(table);
                adapter.Dispose();
            }
            else if (value.RequestUser.LEVEL == 1)
            {
                string sqlString =
                    @"SELECT	a.bidxsub, a.idxsub, a.tcode AS Code, a.comname AS Name, a.name AS CEO_Name, a.post AS Zip_Code, a.addr AS Addr, a.addr2 AS Addr_Detail, 
		                a.companynum1 + N'-' + a.companynum2 + N'-' + a.companynum3 AS ID_Code, a.uptae AS Uptae, a.upjong AS Jongmok, a.wdate AS Create_Date, 
		                a.ye_money AS Check_Limit, a.virtual_acnt AS Virtual_Check, a.virtual_acnt_bank AS Bank_Name, a.email AS Agent_Email, ISNULL(b.tcode, '') 
		                AS Jisa_Code, ISNULL(a.cbrandchoice, '') AS Type_B, c.idx AS cCode, c.usercode AS cUser_Code, c.dcarno AS cDelivery_No, 
		                c.dcarname AS cDelivery_Name, c.tel1 + N'-' + c.tel2 + N'-' + c.tel3 AS cPhone, c.carno AS cCar_No, c.carkind AS cCar_Kind, c.caryflag AS cCar_Year, 
		                c.wdate AS cCreate_Date, a.fileregcode, a.tel1 + N'-' + a.tel2 + N'-' + a.tel3 AS Agent_Phone, a.hp1 + '-' + a.hp2 + '-' + a.hp3 AS Agent_HPhone
                FROM    tb_company AS a 
                LEFT OUTER JOIN
		                (SELECT	idx, tcode, flag, fileflaglevel, bidxsub, idxsub, idxsubname, comname, name, juminno1, juminno2, post, addr, addr2, companynum1, 
				                companynum2, companynum3, uptae, upjong, tel1, tel2, tel3, fax1, fax2, fax3, hp1, hp2, hp3, homepage, email, dcarno, vatflag, taxtitle, 
				                usegubun, usemoney, startday, orderreg, soundfile, sclose, dcode, fileflag, telecom, ctel1, ctel2, ctel3, hapday, jumin1, jumin2, 
				                jumincheck, telname, conetion, wdate, wuserid, edate, euserid, orderflag, fileregcode, mregflag, brandflag, brandbox, cbrandchoice, 
				                timecheck1, timecheck2, com_notice, d_requestday, order_weekgubun, order_weekchoice, order_checkStime, order_checkEtime, 
				                maechulflag, mi_money, ye_money, myflag, myflag_select, agencycheck2, ch_gongi, serviceflag, dcenterflag, proflag1, proflag2, djflag, 
				                smsflag, chk_gongi1, chk_gongi2, miorderflag, virtual_acnt, virtual_acnt_bank, noteflag, accountflag, misuprint, datadel, datadelday, 
				                misubtn, cyberNum, cporg_cd, rec_fax, noticeflag, fileflagchb, virtual_acnt2, virtual_acnt2_bank
		                FROM          tb_company
		                WHERE      (bidxsub = @bidxsub) AND (flag = 2)) AS b ON a.idxsub = b.idx 
                LEFT OUTER JOIN
		                (SELECT     idx, usercode, dcarno, dcarname, tel1, tel2, tel3, carno, carkind, caryflag, wdate, wuserid, edate, euserid
		                FROM		tb_car) AS c ON a.dcarno = c.idx
                WHERE	(a.flag = 3) AND (a.bidxsub = @bidxsub) AND (a.idxsub = @idxsub)";
                SqlDataAdapter adapter = new SqlDataAdapter(sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@idxsub", value.RequestUser.subidx));
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));
                adapter.Fill(table);
                adapter.Dispose();
            }
            else if (value.RequestUser.LEVEL == 2)
            {
                string sqlString =
                    @"SELECT	a.tcode AS Code, a.comname AS Name, a.name AS CEO_Name, a.post AS Zip_Code, a.addr AS Addr, a.addr2 AS Addr_Detail, 
		                a.companynum1 + N'-' + a.companynum2 + N'-' + a.companynum3 AS ID_Code, a.uptae AS Uptae, a.upjong AS Jongmok, a.wdate AS Create_Date, 
		                a.ye_money AS Check_Limit, a.virtual_acnt AS Virtual_Check, a.virtual_acnt_bank AS Bank_Name, a.email AS Agent_Email, ISNULL(b.tcode, '') 
		                AS Jisa_Code, ISNULL(a.cbrandchoice, '') AS Type_B, c.idx AS cCode, c.usercode AS cUser_Code, c.dcarno AS cDelivery_No, 
		                c.dcarname AS cDelivery_Name, c.tel1 + N'-' + c.tel2 + N'-' + c.tel3 AS cPhone, c.carno AS cCar_No, c.carkind AS cCar_Kind, c.caryflag AS cCar_Year, 
		                c.wdate AS cCreate_Date, a.fileregcode, a.tel1 + N'-' + a.tel2 + N'-' + a.tel3 AS Agent_Phone, a.hp1 + '-' + a.hp2 + '-' + a.hp3 AS Agent_HPhone
                FROM    tb_company AS a 
                LEFT OUTER JOIN
		                (SELECT	idx, tcode, flag, fileflaglevel, bidxsub, idxsub, idxsubname, comname, name, juminno1, juminno2, post, addr, addr2, companynum1, 
				                companynum2, companynum3, uptae, upjong, tel1, tel2, tel3, fax1, fax2, fax3, hp1, hp2, hp3, homepage, email, dcarno, vatflag, taxtitle, 
				                usegubun, usemoney, startday, orderreg, soundfile, sclose, dcode, fileflag, telecom, ctel1, ctel2, ctel3, hapday, jumin1, jumin2, 
				                jumincheck, telname, conetion, wdate, wuserid, edate, euserid, orderflag, fileregcode, mregflag, brandflag, brandbox, cbrandchoice, 
				                timecheck1, timecheck2, com_notice, d_requestday, order_weekgubun, order_weekchoice, order_checkStime, order_checkEtime, 
				                maechulflag, mi_money, ye_money, myflag, myflag_select, agencycheck2, ch_gongi, serviceflag, dcenterflag, proflag1, proflag2, djflag, 
				                smsflag, chk_gongi1, chk_gongi2, miorderflag, virtual_acnt, virtual_acnt_bank, noteflag, accountflag, misuprint, datadel, datadelday, 
				                misubtn, cyberNum, cporg_cd, rec_fax, noticeflag, fileflagchb, virtual_acnt2, virtual_acnt2_bank
		                FROM          tb_company
		                WHERE      (bidxsub = @bidxsub) AND (flag = 2)) AS b ON a.idxsub = b.idx 
                LEFT OUTER JOIN
		                (SELECT     idx, usercode, dcarno, dcarname, tel1, tel2, tel3, carno, carkind, caryflag, wdate, wuserid, edate, euserid
		                FROM		tb_car) AS c ON a.dcarno = c.idx
                WHERE	(a.flag = 3) AND (a.bidxsub = @bidxsub)";
                SqlDataAdapter adapter = new SqlDataAdapter(sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));
                adapter.Fill(table);
                adapter.Dispose();
            }
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }
    public DataTable GetGoobneCompanies(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            DataTable table = new DataTable("returnTable");
            if (value.RequestUser.LEVEL == 0)
            {
                string sqlString =
                    @"SELECT	a.tcode AS Code, a.comname AS Name, a.name AS CEO_Name, a.post AS Zip_Code, a.addr AS Addr, a.addr2 AS Addr_Detail, 
		                a.companynum1 + N'-' + a.companynum2 + N'-' + a.companynum3 AS ID_Code, a.uptae AS Uptae, a.upjong AS Jongmok, a.wdate AS Create_Date, 
		                a.ye_money AS Check_Limit, a.virtual_acnt AS Virtual_Check, a.virtual_acnt_bank AS Bank_Name, a.email AS Agent_Email, ISNULL(b.tcode, '') 
		                AS Jisa_Code, ISNULL(a.cbrandchoice, '') AS Type_B, c.idx AS cCode, c.usercode AS cUser_Code, c.dcarno AS cDelivery_No, 
		                c.dcarname AS cDelivery_Name, c.tel1 + N'-' + c.tel2 + N'-' + c.tel3 AS cPhone, c.carno AS cCar_No, c.carkind AS cCar_Kind, c.caryflag AS cCar_Year, 
		                c.wdate AS cCreate_Date, a.tel1 + N'-' + a.tel2 + N'-' + a.tel3 AS Agent_Phone, a.hp1 + '-' + a.hp2 + '-' + a.hp3 AS Agent_HPhone
                FROM    tb_company AS a 
                LEFT OUTER JOIN
		                (SELECT	idx, tcode, flag, fileflaglevel, bidxsub, idxsub, idxsubname, comname, name, juminno1, juminno2, post, addr, addr2, companynum1, 
				                companynum2, companynum3, uptae, upjong, tel1, tel2, tel3, fax1, fax2, fax3, hp1, hp2, hp3, homepage, email, dcarno, vatflag, taxtitle, 
				                usegubun, usemoney, startday, orderreg, soundfile, sclose, dcode, fileflag, telecom, ctel1, ctel2, ctel3, hapday, jumin1, jumin2, 
				                jumincheck, telname, conetion, wdate, wuserid, edate, euserid, orderflag, fileregcode, mregflag, brandflag, brandbox, cbrandchoice, 
				                timecheck1, timecheck2, com_notice, d_requestday, order_weekgubun, order_weekchoice, order_checkStime, order_checkEtime, 
				                maechulflag, mi_money, ye_money, myflag, myflag_select, agencycheck2, ch_gongi, serviceflag, dcenterflag, proflag1, proflag2, djflag, 
				                smsflag, chk_gongi1, chk_gongi2, miorderflag, virtual_acnt, virtual_acnt_bank, noteflag, accountflag, misuprint, datadel, datadelday, 
				                misubtn, cyberNum, cporg_cd, rec_fax, noticeflag, fileflagchb, virtual_acnt2, virtual_acnt2_bank
		                FROM          tb_company
		                WHERE      (bidxsub = @bidxsub) AND (flag = 2)) AS b ON a.idxsub = b.idx 
                LEFT OUTER JOIN
		                (SELECT     idx, usercode, dcarno, dcarname, tel1, tel2, tel3, carno, carkind, caryflag, wdate, wuserid, edate, euserid, dcenter.tcode as JisaCode
		                FROM		tb_car car 
		                left join (select tcode, choiceDcenter from tb_company where flag = 2 and bidxsub = @bidxsub) dcenter on car.dcenteridx = dcenter.choiceDcenter
		                ) AS c ON a.dcarno = c.idx
                WHERE	(a.flag = 3) AND (a.bidxsub = @bidxsub)";
                SqlDataAdapter adapter = new SqlDataAdapter(
                    sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));

                adapter.Fill(table);
                adapter.Dispose();
            }
            else if (value.RequestUser.LEVEL == 1)
            {
                string sqlString =
                   @"SELECT	a.tcode AS Code, a.comname AS Name, a.name AS CEO_Name, a.post AS Zip_Code, a.addr AS Addr, a.addr2 AS Addr_Detail, 
		                a.companynum1 + N'-' + a.companynum2 + N'-' + a.companynum3 AS ID_Code, a.uptae AS Uptae, a.upjong AS Jongmok, a.wdate AS Create_Date, 
		                a.ye_money AS Check_Limit, a.virtual_acnt AS Virtual_Check, a.virtual_acnt_bank AS Bank_Name, a.email AS Agent_Email, ISNULL(b.tcode, '') 
		                AS Jisa_Code, ISNULL(a.cbrandchoice, '') AS Type_B, c.idx AS cCode, c.usercode AS cUser_Code, c.dcarno AS cDelivery_No, 
		                c.dcarname AS cDelivery_Name, c.tel1 + N'-' + c.tel2 + N'-' + c.tel3 AS cPhone, c.carno AS cCar_No, c.carkind AS cCar_Kind, c.caryflag AS cCar_Year, 
		                c.wdate AS cCreate_Date, a.tel1 + N'-' + a.tel2 + N'-' + a.tel3 AS Agent_Phone, a.hp1 + '-' + a.hp2 + '-' + a.hp3 AS Agent_HPhone
                FROM    tb_company AS a 
                LEFT OUTER JOIN
		                (SELECT	idx, tcode, flag, fileflaglevel, bidxsub, idxsub, idxsubname, comname, name, juminno1, juminno2, post, addr, addr2, companynum1, 
				                companynum2, companynum3, uptae, upjong, tel1, tel2, tel3, fax1, fax2, fax3, hp1, hp2, hp3, homepage, email, dcarno, vatflag, taxtitle, 
				                usegubun, usemoney, startday, orderreg, soundfile, sclose, dcode, fileflag, telecom, ctel1, ctel2, ctel3, hapday, jumin1, jumin2, 
				                jumincheck, telname, conetion, wdate, wuserid, edate, euserid, orderflag, fileregcode, mregflag, brandflag, brandbox, cbrandchoice, 
				                timecheck1, timecheck2, com_notice, d_requestday, order_weekgubun, order_weekchoice, order_checkStime, order_checkEtime, 
				                maechulflag, mi_money, ye_money, myflag, myflag_select, agencycheck2, ch_gongi, serviceflag, dcenterflag, proflag1, proflag2, djflag, 
				                smsflag, chk_gongi1, chk_gongi2, miorderflag, virtual_acnt, virtual_acnt_bank, noteflag, accountflag, misuprint, datadel, datadelday, 
				                misubtn, cyberNum, cporg_cd, rec_fax, noticeflag, fileflagchb, virtual_acnt2, virtual_acnt2_bank
		                FROM          tb_company
		                WHERE      (idxsub = @bidxsub) AND (flag = 2)) AS b ON a.idxsub = b.idx 
                LEFT OUTER JOIN
		                (SELECT     idx, usercode, dcarno, dcarname, tel1, tel2, tel3, carno, carkind, caryflag, wdate, wuserid, edate, euserid, dcenter.tcode as JisaCode
		                FROM		tb_car car 
		                left join (select tcode, choiceDcenter from tb_company where flag = 2 and idxsub = @bidxsub) dcenter on car.dcenteridx = dcenter.choiceDcenter
		                ) AS c ON a.dcarno = c.idx
                WHERE	(a.flag = 3) AND (a.idxsub = @bidxsub)";
                SqlDataAdapter adapter = new SqlDataAdapter(
                    sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.subidx));

                adapter.Fill(table);
                adapter.Dispose();
            }
            else if (value.RequestUser.LEVEL == 2)
            {
                string sqlString =
                   @"SELECT	a.tcode AS Code, a.comname AS Name, a.name AS CEO_Name, a.post AS Zip_Code, a.addr AS Addr, a.addr2 AS Addr_Detail, 
		                a.companynum1 + N'-' + a.companynum2 + N'-' + a.companynum3 AS ID_Code, a.uptae AS Uptae, a.upjong AS Jongmok, a.wdate AS Create_Date, 
		                a.ye_money AS Check_Limit, a.virtual_acnt AS Virtual_Check, a.virtual_acnt_bank AS Bank_Name, a.email AS Agent_Email, ISNULL(b.tcode, '') 
		                AS Jisa_Code, ISNULL(a.cbrandchoice, '') AS Type_B, c.idx AS cCode, c.usercode AS cUser_Code, c.dcarno AS cDelivery_No, 
		                c.dcarname AS cDelivery_Name, c.tel1 + N'-' + c.tel2 + N'-' + c.tel3 AS cPhone, c.carno AS cCar_No, c.carkind AS cCar_Kind, c.caryflag AS cCar_Year, 
		                c.wdate AS cCreate_Date, a.tel1 + N'-' + a.tel2 + N'-' + a.tel3 AS Agent_Phone, a.hp1 + '-' + a.hp2 + '-' + a.hp3 AS Agent_HPhone
                FROM    tb_company AS a 
                LEFT OUTER JOIN
		                (SELECT	idx, tcode, flag, fileflaglevel, bidxsub, idxsub, idxsubname, comname, name, juminno1, juminno2, post, addr, addr2, companynum1, 
				                companynum2, companynum3, uptae, upjong, tel1, tel2, tel3, fax1, fax2, fax3, hp1, hp2, hp3, homepage, email, dcarno, vatflag, taxtitle, 
				                usegubun, usemoney, startday, orderreg, soundfile, sclose, dcode, fileflag, telecom, ctel1, ctel2, ctel3, hapday, jumin1, jumin2, 
				                jumincheck, telname, conetion, wdate, wuserid, edate, euserid, orderflag, fileregcode, mregflag, brandflag, brandbox, cbrandchoice, 
				                timecheck1, timecheck2, com_notice, d_requestday, order_weekgubun, order_weekchoice, order_checkStime, order_checkEtime, 
				                maechulflag, mi_money, ye_money, myflag, myflag_select, agencycheck2, ch_gongi, serviceflag, dcenterflag, proflag1, proflag2, djflag, 
				                smsflag, chk_gongi1, chk_gongi2, miorderflag, virtual_acnt, virtual_acnt_bank, noteflag, accountflag, misuprint, datadel, datadelday, 
				                misubtn, cyberNum, cporg_cd, rec_fax, noticeflag, fileflagchb, virtual_acnt2, virtual_acnt2_bank
		                FROM          tb_company
		                WHERE      (idxsub = @bidxsub) AND (flag = 2)) AS b ON a.idxsub = b.idx 
                LEFT OUTER JOIN
		                (SELECT     idx, usercode, dcarno, dcarname, tel1, tel2, tel3, carno, carkind, caryflag, wdate, wuserid, edate, euserid, dcenter.tcode as JisaCode
		                FROM		tb_car car 
		                left join (select tcode, choiceDcenter from tb_company where flag = 2 and idxsub = @bidxsub) dcenter on car.dcenteridx = dcenter.choiceDcenter
		                ) AS c ON a.dcarno = c.idx
                WHERE	(a.flag = 3) AND (a.idxsub = @bidxsub)";
                SqlDataAdapter adapter = new SqlDataAdapter(
                    sqlString, connectString);
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));

                adapter.Fill(table);
                adapter.Dispose();
            }
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }
    public DataTable GetVirtualAccounts(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString =
                @"SELECT a.troccorg_cd, a.cporg_cd, a.deptr_seq
                , a.tr_il as Trade_Date, a.tr_si as Trade_Time
                , a.va_no as Check_Account, a.dep_amt as Input_Amt
                , a.depbnk_nm as Input_Bank, a.cust_nm as Input_Name
                , a.chancode as Client_Code, a.channame as Client_Name
                , a.ye_money as Yeusin_Amt, a.mi_money as Misu_Amt
				FROM tb_virtual_acnt a
                join tb_company b on a.cporg_cd = b.cporg_cd
            	WHERE (b.idx = @idx) AND (tr_il >= @tr_il_Start) AND (tr_il <= @tr_il_End) AND (dep_st = '1')";
            SqlDataAdapter adapter = new SqlDataAdapter(
                sqlString, connectString);
            adapter.SelectCommand.Parameters.Add(new SqlParameter("@idx", value.RequestUser.CompanyIdx));
            adapter.SelectCommand.Parameters.Add(new SqlParameter("@tr_il_Start", value.DateStart));
            adapter.SelectCommand.Parameters.Add(new SqlParameter("@tr_il_End", value.DateEnd));
            DataTable table = new DataTable("returnTable");
            adapter.Fill(table);
            adapter.Dispose();
            return table;
        }
        catch (Exception ex)
        {
		System.IO.File.WriteAllText(String.Format("{0:yyyyMMddHHmmss}", DateTime.Now), ex.ToString());
            return null;
        }
    }
    public DataSet GetOrders(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, a.edate as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx) 
                AND (orderday >= @Order_Date_Start) 
                AND (orderday <= @Order_Date_End)
                AND flag = 'y' AND ISNULL(Rgubun,0) != 1 ";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , a.wdate
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) =@CompanyIdx) 
	                AND (orderday >= @Order_Date_Start) AND (orderday <= @Order_Date_End) AND flag = 'y' AND ISNULL(Rgubun,0) != 1) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
                ORDER BY a.pidx";
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }
    public DataSet CompanyGetOrders(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, a.edate as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in (@CompanyIdx))) 
                AND (orderday >= @Order_Date_Start) 
                AND (orderday <= @Order_Date_End)
                AND flag = 'y' AND isnull(Rgubun,0) != 1 ";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , a.wdate
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in (@CompanyIdx))) 
	                AND (orderday >= @Order_Date_Start) AND (orderday <= @Order_Date_End) AND flag = 'y' AND isnull(Rgubun,0) != 1) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
                ORDER BY a.pidx";
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }
    public DataSet GetDCenterOrders(Request value, string dCenterCode)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, a.edate as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx) 
                AND (orderday >= @Order_Date_Start) 
                AND (orderday <= @Order_Date_End)
                AND flag = 'y' AND isnull(Rgubun,0) != 1 ";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , a.wdate
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) =@CompanyIdx) 
	                AND (orderday >= @Order_Date_Start) AND (orderday <= @Order_Date_End) AND flag = 'y' AND isnull(Rgubun,0) != 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
                ORDER BY a.pidx";
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }
    public DataSet CompanyGetDCenterOrders(Request value, string dCenterCode)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, a.edate as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in (@CompanyIdx))) 
                AND (orderday >= @Order_Date_Start) 
                AND (orderday <= @Order_Date_End)
                AND flag = 'y' AND isnull(Rgubun,0) != 1 ";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , a.wdate
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in (@CompanyIdx))) 
	                AND (orderday >= @Order_Date_Start) AND (orderday <= @Order_Date_End) AND flag = 'y' AND isnull(Rgubun,0) != 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
                ORDER BY a.pidx";
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }

    public DataSet GetReturnOrders(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, a.edate as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx) 
                AND (orderday >= @Order_Date_Start) 
                AND (orderday <= @Order_Date_End)
                AND flag = 'y' AND ISNULL(Rgubun,0) = 1 ";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , a.wdate,a.Returncomment,e.bname
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) =@CompanyIdx) 
	                AND (orderday >= @Order_Date_Start) AND (orderday <= @Order_Date_End) AND flag = 'y' AND ISNULL(Rgubun,0) = 1) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
                left join tb_company_Retrurn as e on a.Returncomment = e.bidx
                ORDER BY a.pidx";
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }
    public DataSet CompanyGetReturnOrders(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, a.edate as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in (@CompanyIdx))) 
                AND (orderday >= @Order_Date_Start) 
                AND (orderday <= @Order_Date_End)
                AND flag = 'y' AND isnull(Rgubun,0) = 1 ";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , a.wdate,a.Returncomment,e.bname
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in (@CompanyIdx))) 
	                AND (orderday >= @Order_Date_Start) AND (orderday <= @Order_Date_End) AND flag = 'y' AND isnull(Rgubun,0) = 1) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
left join tb_company_Retrurn as e on a.Returncomment = e.bidx
                ORDER BY a.pidx";
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }
    public DataSet GetDCenterReturnOrders(Request value, string dCenterCode)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, a.edate as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx) 
                AND (orderday >= @Order_Date_Start) 
                AND (orderday <= @Order_Date_End)
                AND flag = 'y' AND isnull(Rgubun,0) = 1 ";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , a.wdate,a.Returncomment,f.bname
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) =@CompanyIdx) 
	                AND (orderday >= @Order_Date_Start) AND (orderday <= @Order_Date_End) AND flag = 'y' AND isnull(Rgubun,0) = 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
left join tb_company_Retrurn as f on a.Returncomment = f.bidx
                ORDER BY a.pidx";
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }
    public DataSet CompanyGetDCenterReturnOrders(Request value, string dCenterCode)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, a.edate as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in (@CompanyIdx))) 
                AND (orderday >= @Order_Date_Start) 
                AND (orderday <= @Order_Date_End)
                AND flag = 'y' AND isnull(Rgubun,0) = 1 ";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , a.wdate,a.Returncomment,f.bname
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in (@CompanyIdx))) 
	                AND (orderday >= @Order_Date_Start) AND (orderday <= @Order_Date_End) AND flag = 'y' AND isnull(Rgubun,0) = 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
left join tb_company_Retrurn as f on a.Returncomment = f.bidx
                ORDER BY a.pidx";
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }

    public ServerInfomation ServerInfomation(ServerInfomation value)
    {
        if (value.ServerInfomationUser.LEVEL == 0)
        {
            OperationContext context = OperationContext.Current;
            MessageProperties messageProperties = context.IncomingMessageProperties;
            RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
            as RemoteEndpointMessageProperty;
            string ipAddress = endpointProperty.Address;

            //2013.10.17 
           // IPAddress ipAddressIn = IPAddress.Parse(ipAddress);
           // IPHostEntry Ip_Pc_Name = Dns.GetHostByAddress(ipAddressIn);
          //  string Pc_Name = Ip_Pc_Name.HostName.ToString();
         //   string Server_In_Name = 
           
            using (SqlConnection cn = new SqlConnection(connectString))
            {
                string sql = string.Empty;
                SqlParameter parmUserid = new SqlParameter("@userid", value.ServerInfomationUser.Name);
                SqlParameter parmServer_name = new SqlParameter("@server_name", ipAddress);

                //2013.10.17 오종택추가
               // SqlParameter parmPcName = new SqlParameter("@pc_name", Pc_Name);
             //   SqlParameter parmServerInName = new SqlParameter("@server_in_name,

                SqlCommand cmd;
                if (value.IsServer)
                {
                    sql = @"UPDATE 
                    SET server_name = @server_name
                    FROM tb_adminuser
                    WHERE (flag = 2) AND (userid = @userid)";
                    cmd = new SqlCommand(sql, cn);
                    cmd.Parameters.Add(parmUserid);
                    cmd.Parameters.Add(parmServer_name);
                    cn.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception)
                    {
                        value.ServerName = "";

                       
                    }
                    if (cn.State == ConnectionState.Open) cn.Close();
                }
                else
                {
                    sql = @"SELECT server_name,pc_name,server_inname
                    FROM tb_adminuser
                    WHERE (flag = 2) AND (userid = @userid)";
                    cmd = new SqlCommand(sql, cn);
                    cmd.Parameters.Add(parmUserid);
                    cn.Open();
                    SqlDataReader r = cmd.ExecuteReader(CommandBehavior.SingleResult);
                    if (r.Read())
                    {
                        value.ServerName = r[0].ToString() + "|" + r[1].ToString() + "|" + r[2].ToString();
                       
                    }
                    else
                    {

                        value.ServerName = "";
                       
                    }
                    r.Close();
                    if (cn.State == ConnectionState.Open) cn.Close();
                }
                if (cn.State == ConnectionState.Open) cn.Close();
            }
        }
        else if (value.ServerInfomationUser.LEVEL == 1)
        {
            OperationContext context = OperationContext.Current;
            MessageProperties messageProperties = context.IncomingMessageProperties;
            RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
            as RemoteEndpointMessageProperty;
            string ipAddress = endpointProperty.Address;
            using (SqlConnection cn = new SqlConnection(connectString))
            {
                string sql = string.Empty;
                SqlParameter parmUserid = new SqlParameter("@userid", value.ServerInfomationUser.Name);
                SqlParameter parmServer_name = new SqlParameter("@server_name", ipAddress);
                SqlCommand cmd;
                if (value.IsServer)
                {
                    sql = @"UPDATE 
                    SET server_name = @server_name
                    FROM tb_adminuser
                    WHERE (flag = 2) AND (userid = @userid)";
                    cmd = new SqlCommand(sql, cn);
                    cmd.Parameters.Add(parmUserid);
                    cmd.Parameters.Add(parmServer_name);
                    cn.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception)
                    {
                        value.ServerName = "";
                    }
                    if (cn.State == ConnectionState.Open) cn.Close();
                }
                else
                {
                    sql = @"SELECT server_name,pc_name,server_inname
                    FROM tb_adminuser
                    WHERE (flag = 3) AND (userid = @userid)";
                    cmd = new SqlCommand(sql, cn);
                    cmd.Parameters.Add(parmUserid);
                    cn.Open();
                    SqlDataReader r = cmd.ExecuteReader(CommandBehavior.SingleResult);
                    if (r.Read())
                       // value.ServerName = r[0].ToString();
                        value.ServerName = r[0].ToString() + "|" + r[1].ToString() + "|" + r[2].ToString();
                    else
                        value.ServerName = "";
                    r.Close();
                    if (cn.State == ConnectionState.Open) cn.Close();
                }
                if (cn.State == ConnectionState.Open) cn.Close();
            }
        }
        else if (value.ServerInfomationUser.LEVEL == 2)
        {
            OperationContext context = OperationContext.Current;
            MessageProperties messageProperties = context.IncomingMessageProperties;
            RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
            as RemoteEndpointMessageProperty;
            string ipAddress = endpointProperty.Address;
            using (SqlConnection cn = new SqlConnection(connectString))
            {
                string sql = string.Empty;
                SqlParameter parmUserid = new SqlParameter("@userid", value.ServerInfomationUser.Name);
                SqlParameter parmServer_name = new SqlParameter("@server_name", ipAddress);
                SqlCommand cmd;
                if (value.IsServer)
                {
                    sql = @"UPDATE 
                    SET server_name = @server_name
                    FROM tb_adminuser
                    WHERE (flag = 2) AND (userid = @userid)";
                    cmd = new SqlCommand(sql, cn);
                    cmd.Parameters.Add(parmUserid);
                    cmd.Parameters.Add(parmServer_name);
                    cn.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception)
                    {
                        value.ServerName = "";
                    }
                    if (cn.State == ConnectionState.Open) cn.Close();
                }
                else
                {
                    sql = @"SELECT server_name,pc_name,server_inname
                    FROM tb_adminuser
                    WHERE (flag = 3) AND (userid = @userid)";
                    cmd = new SqlCommand(sql, cn);
                    cmd.Parameters.Add(parmUserid);
                    cn.Open();
                    SqlDataReader r = cmd.ExecuteReader(CommandBehavior.SingleResult);
                    if (r.Read())
                        //value.ServerName = r[0].ToString();
                        value.ServerName = r[0].ToString() + "|" + r[1].ToString() + "|" + r[2].ToString();
                    else
                        value.ServerName = "";
                    r.Close();
                    if (cn.State == ConnectionState.Open) cn.Close();
                }
                if (cn.State == ConnectionState.Open) cn.Close();
            }
        }
        return value;
    }
    public CertInfo CertStep1(CertInfo value)
    {
        string _Comname = "";
        if(value.LEVEL == 0)
        {
                string compareString0 =
                    @"SELECT  b.idx, b.tcode, b.comname, a.userid
                    FROM    tb_adminuser AS a 
                    INNER JOIN
	                    tb_company AS b ON a.usercode = b.idx
                    WHERE   (a.flag = 2) AND (a.userid = @AdminID) 
                    AND		(b.companynum1 + b.companynum2 + b.companynum3 = @CorpNo)";
                string insertString0 =
                    @"INSERT INTO	tb_badmi_cert
                        (idx, tcode, comname, UserID, CertNo)
                    VALUES      (@idx, @tcode, @comname,@UserID,@CertNo)
                    SELECT  @@IDENTITY";
                using (SqlConnection cn = new SqlConnection(connectString))
                {
                    SqlCommand compareCmd0 = new SqlCommand(compareString0, cn);
                    compareCmd0.Parameters.Add(new SqlParameter("@AdminID", value.AdminID));
                    compareCmd0.Parameters.Add(new SqlParameter("@CorpNo", value.CorpNo));
                    SqlCommand insertCmd0 = new SqlCommand(insertString0, cn);
                    cn.Open();
                    SqlDataReader reader = compareCmd0.ExecuteReader(
                        CommandBehavior.SingleRow);
                    if (reader.Read())
                    {
                        string certNo = string.Empty;
                        Guid guid = System.Guid.NewGuid();
                        if (guid.ToString().Length > 8)
                            certNo = guid.ToString().Substring(0, 8);
                        else certNo = guid.ToString();
                        insertCmd0.Parameters.Add(new SqlParameter("@idx", (int)reader["idx"]));
                        insertCmd0.Parameters.Add(new SqlParameter("@tcode", reader["tcode"].ToString()));
                        insertCmd0.Parameters.Add(new SqlParameter("@comname", reader["comname"].ToString()));
                        insertCmd0.Parameters.Add(new SqlParameter("@UserID", reader["userid"].ToString()));
                        insertCmd0.Parameters.Add(new SqlParameter("@CertNo", certNo));
                        _Comname = reader["comname"].ToString();
                        reader.Close();
                        object oSeq = insertCmd0.ExecuteScalar();
                        if (oSeq != null)
                        {
                            value.Seq = oSeq;
                            value.CertNo = certNo;
                            value.Comname = _Comname;
                        }
                    }
                    cn.Close();
                }

//                string SEND_MSG = "바드미 관리프로그램(PC용) 인증번호 알림." +
//                                      "" + _Comname + " 인증번호는 " + value.CertNo + " 입니다." +
//                                      "해당 정보를 입력하시 후, 이용하시기 바랍니다." +
//                                      "문의 : 02-853-5111" +
//                                      "감사합니다.";

//                string kakaoinsert =
//                    @"INSERT INTO MSG_DATA (SENDER_KEY, PHONE,TMPL_CD, SEND_MSG, REQ_DATE, CUR_STATE,SMS_TYPE,ATTACHMENT_TYPE ,ATTACHMENT_NAME,ATTACHMENT_URL)
//                        VALUES('be0d331c9435c31abeecf524cde2a32bb6a9bf65','" + value.MobileNo + "','K18-0024','" + SEND_MSG + "' ,getdate(),'0' ,'N',NULL,NULL,NULL )";

//                using (SqlConnection cn = new SqlConnection(connectStringKaKaotalk))
//                {
//                    SqlCommand updateCmd = new SqlCommand(kakaoinsert, cn);
//                    //updateCmd.Parameters.Add(new SqlParameter("@UserName", value.UserName));
//                    //updateCmd.Parameters.Add(new SqlParameter("@UserLocation", value.UserLocation));
//                    //updateCmd.Parameters.Add(new SqlParameter("@Seq", value.Seq));
//                    //updateCmd.Parameters.Add(new SqlParameter("@ver", value.Ver));
//                    cn.Open();
//                    updateCmd.ExecuteNonQuery();
//                    cn.Close();
//                }
        }
        else if (value.LEVEL == 1)
        {
                string compareString1 =
                @"SELECT  b.idx, b.tcode, b.comname, a.userid
                FROM    tb_adminuser AS a 
                INNER JOIN
	            tb_company AS b ON substring(a.usercode,6,5) = b.idx
                WHERE   (a.flag = 3) AND (a.userid = @AdminID) 
                AND		(b.companynum1 + b.companynum2 + b.companynum3 = @CorpNo)";
                string insertString1 =
                @"INSERT INTO	tb_badmi_cert
                (idx, tcode, comname, UserID, CertNo)
                VALUES      (@idx, @tcode, @comname,@UserID,@CertNo)
                SELECT  @@IDENTITY";
                using (SqlConnection cn = new SqlConnection(connectString))
                {
                    SqlCommand compareCmd1 = new SqlCommand(compareString1, cn);
                    compareCmd1.Parameters.Add(new SqlParameter("@AdminID", value.AdminID));
                    compareCmd1.Parameters.Add(new SqlParameter("@CorpNo", value.CorpNo));
                    SqlCommand insertCmd1 = new SqlCommand(insertString1, cn);
                    cn.Open();
                    SqlDataReader reader = compareCmd1.ExecuteReader(
                        CommandBehavior.SingleRow);
                    if (reader.Read())
                    {
                        string certNo = string.Empty;
                        Guid guid = System.Guid.NewGuid();
                        if (guid.ToString().Length > 8)
                            certNo = guid.ToString().Substring(0, 8);
                        else certNo = guid.ToString();
                        insertCmd1.Parameters.Add(new SqlParameter("@idx", (int)reader["idx"]));
                        insertCmd1.Parameters.Add(new SqlParameter("@tcode", reader["tcode"].ToString()));
                        insertCmd1.Parameters.Add(new SqlParameter("@comname", reader["comname"].ToString()));
                        insertCmd1.Parameters.Add(new SqlParameter("@UserID", reader["userid"].ToString()));
                        insertCmd1.Parameters.Add(new SqlParameter("@CertNo", certNo));
                        reader.Close();
                        object oSeq = insertCmd1.ExecuteScalar();
                        if (oSeq != null)
                        {
                            value.Seq = oSeq;
                            value.CertNo = certNo;
                        }
                    }
                    cn.Close();
                }
        }
        else if(value.LEVEL ==2)
        {
                string compareString2 =
                    @"SELECT  b.idx, b.tcode, b.comname, a.userid, a.dcenteridx
                    FROM    tb_adminuser AS a 
                    INNER JOIN
	                    tb_company AS b ON substring(a.usercode,6,5) = b.idx
                    WHERE   (a.flag = 3) AND (a.userid = @AdminID) 
                    AND		(b.companynum1 + b.companynum2 + b.companynum3 = @CorpNo)";
                string insertString2 =
                    @"INSERT INTO	tb_badmi_cert
                        (idx, tcode, comname, UserID, CertNo)
                    VALUES      (@idx, @tcode, @comname,@UserID,@CertNo)
                    SELECT  @@IDENTITY";
                using (SqlConnection cn = new SqlConnection(connectString))
                {
                    SqlCommand compareCmd2 = new SqlCommand(compareString2, cn);
                    compareCmd2.Parameters.Add(new SqlParameter("@AdminID", value.AdminID));
                    compareCmd2.Parameters.Add(new SqlParameter("@CorpNo", value.CorpNo));
                    SqlCommand insertCmd2 = new SqlCommand(insertString2, cn);
                    cn.Open();
                    SqlDataReader reader = compareCmd2.ExecuteReader(
                        CommandBehavior.SingleRow);
                    if (reader.Read())
                    {
                        string certNo = string.Empty;
                        Guid guid = System.Guid.NewGuid();
                        if (guid.ToString().Length > 8)
                            certNo = guid.ToString().Substring(0, 8);
                        else certNo = guid.ToString();
                        insertCmd2.Parameters.Add(new SqlParameter("@idx", (int)reader["idx"]));
                        insertCmd2.Parameters.Add(new SqlParameter("@tcode", reader["tcode"].ToString()));
                        insertCmd2.Parameters.Add(new SqlParameter("@comname", reader["comname"].ToString()));
                        insertCmd2.Parameters.Add(new SqlParameter("@UserID", reader["userid"].ToString()));
                        insertCmd2.Parameters.Add(new SqlParameter("@CertNo", certNo));
                        reader.Close();
                        object oSeq = insertCmd2.ExecuteScalar();
                        if (oSeq != null)
                        {
                            value.Seq = oSeq;
                            value.CertNo = certNo;
                        }
                    }
                    cn.Close();
                }
        }
        return value;

    }
    public CertInfo CertStep2(CertInfo value)
    {
        string updateString =
            @"UPDATE	tb_badmi_cert
            SET     UserName = @UserName, UserLocation = @UserLocation, CertDate = GetDate()
            WHERE   (Seq = @Seq)
            DELETE FROM tb_badmi_cert WHERE UserName is null";
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand updateCmd = new SqlCommand(updateString, cn);
            updateCmd.Parameters.Add(new SqlParameter("@UserName", value.UserName));
            updateCmd.Parameters.Add(new SqlParameter("@UserLocation", value.UserLocation));
            updateCmd.Parameters.Add(new SqlParameter("@Seq", value.Seq));
            cn.Open();
            updateCmd.ExecuteNonQuery();
            cn.Close();
        }
        return value;
    }
    public DataTable CheckVirtualAcnt(string value)
    {
        DataTable r = new DataTable("returnTable");
        string sqlString =
             @"SELECT chancode, MAX(tr_il + tr_si) AS Expr1 FROM tb_virtual_acnt WHERE (cporg_cd = @CPCode) GROUP BY chancode";
        SqlDataAdapter adapter = new SqlDataAdapter(sqlString, connectString);
        adapter.SelectCommand.Parameters.Add(new SqlParameter("@CPCode", value));
        adapter.Fill(r);
        adapter.Dispose();
        return r;
    }
    public bool UpdateMisu(ClientMisu[] value)
    {
        int iSuccess = 0;
        bool r = true;
        if (value.Length <= 0)
        {
            return r;
        }
        FileStream stream = _GetLogFile();
        OperationContext context = OperationContext.Current;
        MessageProperties messageProperties = context.IncomingMessageProperties;
        RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
        as RemoteEndpointMessageProperty;
        _AddText(stream, string.Format("[{0}][EVENT]## Client Connected", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        _AddText(stream, string.Format("[{0}][EVENT]## Datat Receive OK !!!", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        string tcode = string.Empty;
        string company = string.Empty;
        string count = string.Empty;
        string idx = value[0].bidxsub;
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand tcodeCmd = new SqlCommand(
                @"SELECT tcode FROM tb_company WHERE idx = @idx", cn);
            tcodeCmd.Parameters.Add(new SqlParameter("@idx", idx));
            cn.Open();
            object o = tcodeCmd.ExecuteScalar();
            if (o != null) tcode = o.ToString();
            cn.Close();
        }
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand companyCmd = new SqlCommand(
                @"SELECT comname FROM tb_company WHERE idx = @idx AND tcode = @tcode", cn);
            companyCmd.Parameters.Add(new SqlParameter("@idx", idx));
            companyCmd.Parameters.Add(new SqlParameter("@tcode", tcode));
            cn.Open();
            object o = companyCmd.ExecuteScalar();
            if (o != null) company = o.ToString();
            cn.Close();
        }
        count = value.Length.ToString();
        _AddText(stream, string.Format(" - 체인본부코드 : {0}", tcode));
        _AddText(stream, string.Format(" - 체인본부 명  : {0}", company));
        _AddText(stream, string.Format(" - 데이터 건수  : {0}", count));
        _AddText(stream, "");
        try
        {
            using (SqlConnection cn = new SqlConnection(connectString))
            {
                SqlCommand updateCmd = new SqlCommand(
                    @"UPDATE    tb_company
                SET              mi_money = @mi_money, ye_money = @ye_money
                WHERE     (tcode = @tcode) AND (bidxsub = @bidxsub)", cn);
                SqlParameter paramTcode = new SqlParameter("@tcode", null);
                SqlParameter paramBidxsub = new SqlParameter("@bidxsub", null);
                SqlParameter paramMi_money = new SqlParameter("@mi_money", null);
                SqlParameter paramYe_money = new SqlParameter("@ye_money", null);
                updateCmd.Parameters.Add(paramTcode);
                updateCmd.Parameters.Add(paramBidxsub);
                updateCmd.Parameters.Add(paramMi_money);
                updateCmd.Parameters.Add(paramYe_money);
                cn.Open();
                foreach (var item in value)
                {
                    paramTcode.Value = item.tcode;
                    paramBidxsub.Value = item.bidxsub;
                    paramMi_money.Value = item.mi_money;
                    paramYe_money.Value = item.ye_money;
                    int i = 0;
                    try
                    {
                        i = updateCmd.ExecuteNonQuery();
                    }
                    catch { i = 0; }
                    iSuccess += i;
                    _AddText(stream, string.Format("[{0}][EVENT]## 미수금정보", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                    _AddText(stream, string.Format(" - 적용여부 : {0}", i > 0 ? "True" : "False"));
                    _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                    _AddText(stream, string.Format(" - 체인코드 : {0}", item.tcode));
                    _AddText(stream, string.Format(" - 여신금액 : {0}", item.ye_money.ToString("N0")));
                    _AddText(stream, string.Format(" - 미수금액 : {0}", item.mi_money.ToString("N0")));
                    _AddText(stream, "");
                }
                cn.Close();
            }
        }
        catch (Exception E)
        {
            r = false;
        }
        _AddText(stream, string.Format("[{0}][EVENT]## Connection Close", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        try
        {
            stream.Close();
            stream.Dispose();
        }
        catch { }
        return r;
    }

    public bool UpdateMisuErrString(ClientMisu[] value, out string errString)
    {
        errString = "";
        int iSuccess = 0;
        bool r = true;
        if (value.Length <= 0)
        {
            return r;
        }
        FileStream stream = _GetLogFile();
        OperationContext context = OperationContext.Current;
        MessageProperties messageProperties = context.IncomingMessageProperties;
        RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
        as RemoteEndpointMessageProperty;
        _AddText(stream, string.Format("[{0}][EVENT]## Client Connected", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        _AddText(stream, string.Format("[{0}][EVENT]## Datat Receive OK !!!", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        string tcode = string.Empty;
        string company = string.Empty;
        string count = string.Empty;
        string idx = value[0].bidxsub;
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand tcodeCmd = new SqlCommand(
                @"SELECT tcode FROM tb_company WHERE idx = @idx", cn);
            tcodeCmd.Parameters.Add(new SqlParameter("@idx", idx));
            cn.Open();
            object o = tcodeCmd.ExecuteScalar();
            if (o != null) tcode = o.ToString();
            cn.Close();
        }
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand companyCmd = new SqlCommand(
                @"SELECT comname FROM tb_company WHERE idx = @idx AND tcode = @tcode", cn);
            companyCmd.Parameters.Add(new SqlParameter("@idx", idx));
            companyCmd.Parameters.Add(new SqlParameter("@tcode", tcode));
            cn.Open();
            object o = companyCmd.ExecuteScalar();
            if (o != null) company = o.ToString();
            cn.Close();
        }
        count = value.Length.ToString();
        _AddText(stream, string.Format(" - 체인본부코드 : {0}", tcode));
        _AddText(stream, string.Format(" - 체인본부 명  : {0}", company));
        _AddText(stream, string.Format(" - 데이터 건수  : {0}", count));
        _AddText(stream, "");
        try
        {
            using (SqlConnection cn = new SqlConnection(connectString))
            {
                SqlCommand updateCmd = new SqlCommand(
                    @"UPDATE    tb_company
                SET              mi_money = @mi_money, ye_money = @ye_money
                WHERE     (tcode = @tcode) AND (bidxsub = @bidxsub)", cn);
                SqlParameter paramTcode = new SqlParameter("@tcode", null);
                SqlParameter paramBidxsub = new SqlParameter("@bidxsub", null);
                SqlParameter paramMi_money = new SqlParameter("@mi_money", null);
                SqlParameter paramYe_money = new SqlParameter("@ye_money", null);
                updateCmd.Parameters.Add(paramTcode);
                updateCmd.Parameters.Add(paramBidxsub);
                updateCmd.Parameters.Add(paramMi_money);
                updateCmd.Parameters.Add(paramYe_money);
                cn.Open();
                foreach (var item in value)
                {
                    paramTcode.Value = item.tcode;
                    paramBidxsub.Value = item.bidxsub;
                    paramMi_money.Value = item.mi_money;
                    paramYe_money.Value = item.ye_money;
                    int i = updateCmd.ExecuteNonQuery();
                    iSuccess += i;
                    _AddText(stream, string.Format("[{0}][EVENT]## 미수금정보", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                    _AddText(stream, string.Format(" - 적용여부 : {0}", i > 0 ? "True" : "False"));
                    _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                    _AddText(stream, string.Format(" - 체인코드 : {0}", item.tcode));
                    _AddText(stream, string.Format(" - 여신금액 : {0}", item.ye_money.ToString("N0")));
                    _AddText(stream, string.Format(" - 미수금액 : {0}", item.mi_money.ToString("N0")));
                    _AddText(stream, "");
                }
                cn.Close();
            }
            errString = iSuccess.ToString();
        }
        catch (Exception E)
        {
            errString = iSuccess.ToString() + "|" + E.Message;
            r = false;
        }
        _AddText(stream, string.Format("[{0}][EVENT]## Connection Close", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        try
        {
            stream.Close();
            stream.Dispose();
        }
        catch { }
        return r;
    }
    public Result UpdateAcnt(Acnt[] value)
    {
        Result r = new Result();
        r.Comment = "";
        int successcount = 0;
        int faliedcount = 0;
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand insertCmd = new SqlCommand(
                @"IF NOT EXISTS (SELECT idx FROM tb_input_acnt WHERE idx = @idx AND tcode = @tcode AND chancode = @chancode)
                BEGIN
                    INSERT INTO [edubill_co_kr].[dbo].[tb_input_acnt]
		                       ([idx]
		                       ,[tcode]
		                       ,[chancode]
		                       ,[SlipDate]
		                       ,[Collect_Method]
		                       ,[Send_Bank]
		                       ,[Input_Bank]
		                       ,[Input_Amt]
		                       ,[Misu_Amt]
		                       ,[Check_Account])
	                     VALUES
		                       (@idx
		                       ,@tcode
		                       ,@chancode
		                       ,@SlipDate
		                       ,@Collect_Method
		                       ,@Send_Bank
		                       ,@Input_Bank
		                       ,@Input_Amt
		                       ,@Misu_Amt
		                       ,@Check_Account)
                    SELECT 1
                END
                ELSE
                BEGIN
                    SELECT 0
                END", cn);
            SqlParameter prmidx = new SqlParameter("@idx", null);
            SqlParameter prmtcode = new SqlParameter("@tcode", null);
            SqlParameter prmchancode = new SqlParameter("@chancode", null);
            SqlParameter prmSlipDate = new SqlParameter("@SlipDate", null);
            SqlParameter prmCollect_Method = new SqlParameter("@Collect_Method", null);
            SqlParameter prmSend_Bank = new SqlParameter("@Send_Bank", null);
            SqlParameter prmInput_Bank = new SqlParameter("@Input_Bank", null);
            SqlParameter prmInput_Amt = new SqlParameter("@Input_Amt", null);
            SqlParameter prmMisu_Amt = new SqlParameter("@Misu_Amt", null);
            SqlParameter prmCheck_Account = new SqlParameter("@Check_Account", null);
            insertCmd.Parameters.AddRange(
                new SqlParameter[]{
                prmidx,prmtcode,prmchancode,prmSlipDate,prmCollect_Method,prmSend_Bank,
                prmInput_Bank,prmInput_Amt,prmMisu_Amt,prmCheck_Account});
            cn.Open();
            foreach (var item in value)
            {
                prmidx.Value = item.idx;
                prmtcode.Value = item.tcode;
                prmchancode.Value = item.chancode;
                prmSlipDate.Value = item.SlipDate;
                prmCollect_Method.Value = item.Collect_Method;
                prmSend_Bank.Value = item.Send_Bank;
                prmInput_Bank.Value = item.Input_Bank;
                prmInput_Amt.Value = item.Input_Amt;
                prmMisu_Amt.Value = item.Misu_Amt;
                prmCheck_Account.Value = item.Check_Account;
                try
                {
                    object o = insertCmd.ExecuteScalar();
                    if (o != null)
                    {
                        if (Convert.ToBoolean(o))
                            successcount++;
                        else
                            faliedcount++;
                    }
                }
                catch (Exception E)
                {
                    faliedcount++;
                    r.Comment += E.Message;
                }
            }
            cn.Close();
        }
        r.SuccessCount = successcount;
        r.FailedCount = faliedcount;
        return r;
    }
    public void SetServerName(ServerInfomation value)
    {

    }
    public PatchList[] GetPatchList(float value)
    {
        return new PatchList[0];
    }
    public bool Test()
    {
        bool r = true;
        try
        {
            DirectoryInfo dir = new DirectoryInfo(@"D:\Program Files\Edubill\badmi\log");
            if (dir.Exists)
            {
                OperationContext context = OperationContext.Current;
                MessageProperties messageProperties = context.IncomingMessageProperties;
                RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
                as RemoteEndpointMessageProperty;
                FileInfo[] todayFiles = dir.GetFiles(string.Format("*{0}*.log", DateTime.Now.ToString("yyyyMMdd"))).Where(c => c.Length < 4000000).ToArray();
                string fileString = string.Empty;
                if (todayFiles.Count() > 0)
                {
                    fileString = todayFiles.OrderByDescending(c => c.CreationTime).First().FullName;
                }
                else
                {
                    fileString = Path.Combine(dir.FullName, string.Format("badmi{0}.log", DateTime.Now.ToString("yyyyMMddHHmmss")));
                }
                FileStream stream;
                if (File.Exists(fileString))
                {
                    stream = File.Open(fileString, FileMode.Append);
                }
                else
                {
                    stream = File.Create(fileString);
                }
                _AddText(stream, endpointProperty.Address);
                stream.Close();
                stream.Dispose();
            }
            else
                r = false;
        }
        catch { r = false; }
        return r;
    }
    private FileStream _GetLogFile()
    {
        FileStream r = null;
        try
        {
            DirectoryInfo dir = new DirectoryInfo(@"D:\log\badmi");
            if (dir.Exists)
            {
                OperationContext context = OperationContext.Current;
                MessageProperties messageProperties = context.IncomingMessageProperties;
                RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
                as RemoteEndpointMessageProperty;
                FileInfo[] todayFiles = dir.GetFiles(string.Format("*{0}*.log", DateTime.Now.ToString("yyyyMMdd"))).Where(c => c.Length < 4000000).ToArray();
                string fileString = string.Empty;
                if (todayFiles.Count() > 0)
                {
                    fileString = todayFiles.OrderByDescending(c => c.CreationTime).First().FullName;
                }
                else
                {
                    fileString = Path.Combine(dir.FullName, string.Format("badmi{0}.log", DateTime.Now.ToString("yyyyMMddHHmmss")));
                }
                FileStream stream;
                while (true)
                {
                    if (File.Exists(fileString))
                    {
                        try
                        {
                            stream = File.Open(fileString, FileMode.Append);
                            break;
                        }
                        catch { System.Threading.Thread.Sleep(500); }
                    }
                    else
                    {
                        try
                        {
                            stream = File.Create(fileString);
                            break;
                        }
                        catch { System.Threading.Thread.Sleep(500); }
                    }
                }
                r = stream;
            }
        }
        catch { r = null; }
        return r;
    }
    private void _AddText(FileStream fs, string value)
    {
        if (fs == null) return;
        try
        {
            value = Environment.NewLine + value;
            byte[] info = new UTF8Encoding(true).GetBytes(value);
            fs.Write(info, 0, info.Length);
        }
        catch { }
    }
    public DataTable GetDCenters(Request value)
    {
        DataTable r = new DataTable("returnTable");
        SqlDataAdapter adapter = new SqlDataAdapter(
            @"SELECT bidx, bname FROM tb_company_dcenter WHERE idx = @CompanyIdx", connectString);
        adapter.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
        adapter.Fill(r);
        adapter.Dispose();
        return r;
    }
    //인증
    private bool isAllowedUser(User value)
    {
        string sqlString = @"SELECT usercode
                            FROM tb_adminuser
                            WHERE (flag = 2) AND (userid = @userid)";
        SqlConnection cn = new SqlConnection(connectString);
        SqlCommand cmd1 = new SqlCommand(sqlString, cn);
        cmd1.Parameters.Add(new SqlParameter("@userid", value.Name));
        cn.Open();
        SqlDataReader reader1 =
            cmd1.ExecuteReader(CommandBehavior.CloseConnection | CommandBehavior.SingleRow);
        if (reader1.Read() == false)
        {
            reader1.Close();
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Dispose();
            reader1.Dispose();
            cmd1.Dispose();
            return false;
        }
        else
        {
            reader1.Close();
            if (cn.State == ConnectionState.Open) cn.Close();
            cn.Dispose();
            reader1.Dispose();
            cmd1.Dispose();
            return true;
        }
    }
    public bool ETax(ETAX[] value, out string errString)
    {
        errString = "";
        int iSuccess = 0;
        bool r = true;
        if (value.Length <= 0)
        {
            return r;
        }
        FileStream stream = _GetLogFile();
        OperationContext context = OperationContext.Current;
        MessageProperties messageProperties = context.IncomingMessageProperties;
        RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
        as RemoteEndpointMessageProperty;
        _AddText(stream, string.Format("[{0}][EVENT]## Client Connected", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        _AddText(stream, string.Format("[{0}][EVENT]## Datat Receive OK !!!", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        string tcode = string.Empty;
        string company = string.Empty;
        string count = string.Empty;
        string idx = value[0].IDX;
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand tcodeCmd = new SqlCommand(
                @"SELECT tcode FROM tb_company WHERE idx = @idx", cn);
            tcodeCmd.Parameters.Add(new SqlParameter("@idx", idx));
            cn.Open();
            object o = tcodeCmd.ExecuteScalar();
            if (o != null) tcode = o.ToString();
            cn.Close();
        }
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand companyCmd = new SqlCommand(
                @"SELECT comname FROM tb_company WHERE idx = @idx AND tcode = @tcode", cn);
            companyCmd.Parameters.Add(new SqlParameter("@idx", idx));
            companyCmd.Parameters.Add(new SqlParameter("@tcode", tcode));
            cn.Open();
            object o = companyCmd.ExecuteScalar();
            if (o != null) company = o.ToString();
            cn.Close();
        }
        count = value.Length.ToString();
        _AddText(stream, string.Format(" - 체인본부코드 : {0}", tcode));
        _AddText(stream, string.Format(" - 체인본부 명  : {0}", company));
        _AddText(stream, string.Format(" - 데이터 건수  : {0}", count));
        _AddText(stream, "");
        try
        {
            using (SqlConnection cn = new SqlConnection(connectStringTR))
            {
                SqlCommand updateCmd = new SqlCommand(
                    @"--DECLARE @DATE VARCHAR(8)
            --SELECT @DATE = '20101008'
            DECLARE @DUTY_NUM VARCHAR(14)
            SELECT @DUTY_NUM = @DATE + '9' + RIGHT('00000' +	LTRIM(STR(ISNULL(MAX(RIGHT(DUTY_NUM, 5)) + 1, 1))), 5)
            FROM	[TR_DUTYMASTER]
            WHERE	LEFT(DUTY_NUM, 8) = @DATE

            INSERT INTO [TR_DUTYMASTER]
               ([CUSTOMERID], [DUTY_NUM], [DUTY_TYPE], [DUTY_GWOEN], [DUTY_HO]
	            , [DUTY_SEQ], [MCLIENTNO], [MSANGHO], [MCEONM], [MUPTEA]
	            , [MUPJONG], [MADDR], [CLIENTNO], [SANGHO], [CEONM]
	            , [UPTEA], [UPJONG], [ADDR], [WDATE], [COST]
	            , [VAT], [ETC], [HYUNGUM], [SUPYO], [EOEUM]
	            , [MISU], [RECEIPT], [TR_CRE_TIME], [TR_TRA_TIME], [TR_NTS_TIME]
	            , [MANAGER], [DEPT], [EMAIL], [TELNO1], [TELNO2]
	            , [TELNO3], [MOBIL1], [MOBIL2], [MOBIL3], [TITLE]
	            , [TAX_TYPE]
                , [MMANAGER], [MDEPT], [MEMAIL], [MTELNO1]
	            , [MTELNO2], [MTELNO3], [MMOBIL1], [MMOBIL2], [MMOBIL3]
	            , [CHGTYPE], [TRANSDATE], [TR_TEC01], [TR_TEC02], [TR_TEC03]
	            , [TR_TEC04], [TR_TEC05], [TR_RSLTSTAT], [TR_NTS_LSTSTAT])
            VALUES
               (@CUSTOMERID, @DUTY_NUM, @DUTY_TYPE, NULL, NULL
	            , NULL, @MCLIENTNO, @MSANGHO, @MCEONM, @MUPTEA
	            , @MUPJONG, @MADDR, @CLIENTNO, @SANGHO, @CEONM
	            , @UPTEA, @UPJONG, @ADDR, @WDATE, @COST
	            , @VAT, NULL, NULL, NULL, NULL
	            , NULL, @RECEIPT, NULL, NULL, NULL
	            , NULL, NULL, @EMAIL, NULL, NULL
	            , NULL, NULL, NULL, NULL, @TITLE
	            , CASE WHEN @VAT = 0 THEN '면세' ELSE '과세' END
                , NULL, NULL, NULL, NULL
	            , NULL, NULL, NULL, NULL, NULL
	            , NULL, @TRANSDATE, NULL, NULL, NULL
	            , NULL, NULL, NULL, NULL)
	        INSERT INTO [TR_DUTYDETAIL]
               ([CUSTOMERID], [DUTY_NUM], [ITMSEQ], [ITMMM], [ITMDD]
				, [ITMNM], [ITMSIZE], [ITMQTY], [ITMNET], [COST]
				, [VAT], [ETC])
             VALUES
				(@CUSTOMERID, @DUTY_NUM, 1, @ITMMM, @ITMDD
				, @ITMNM, NULL, 1, @ITMNET, @COST
				, @VAT, NULL)", cn);

                SqlParameter paramDATE = new SqlParameter("@DATE", null);
                SqlParameter paramCUSTOMERID = new SqlParameter("@CUSTOMERID", null);
                SqlParameter paramDUTY_TYPE = new SqlParameter("@DUTY_TYPE", null);
                SqlParameter paramMCLIENTNO = new SqlParameter("@MCLIENTNO", null);
                SqlParameter paramMSANGHO = new SqlParameter("@MSANGHO", null);
                SqlParameter paramMCEONM = new SqlParameter("@MCEONM", null);
                SqlParameter paramMUPTEA = new SqlParameter("@MUPTEA", null);
                SqlParameter paramMUPJONG = new SqlParameter("@MUPJONG", null);
                SqlParameter paramMADDR = new SqlParameter("@MADDR", null);
                SqlParameter paramWDATE = new SqlParameter("@WDATE", null);
                SqlParameter paramTRANSDATE = new SqlParameter("@TRANSDATE", null);
                SqlParameter paramRECEIPT = new SqlParameter("@RECEIPT", null);
                SqlParameter paramITMMM = new SqlParameter("@ITMMM", null);
                SqlParameter paramITMDD = new SqlParameter("@ITMDD", null);
                SqlParameter paramCLIENTNO = new SqlParameter("@CLIENTNO", null);
                SqlParameter paramSANGHO = new SqlParameter("@SANGHO", null);
                SqlParameter paramCEONM = new SqlParameter("@CEONM", null);
                SqlParameter paramUPTEA = new SqlParameter("@UPTEA", null);
                SqlParameter paramUPJONG = new SqlParameter("@UPJONG", null);
                SqlParameter paramADDR = new SqlParameter("@ADDR", null);
                SqlParameter paramCOST = new SqlParameter("@COST", null);
                SqlParameter paramVAT = new SqlParameter("@VAT", null);
                SqlParameter paramEMAIL = new SqlParameter("@EMAIL", null);
                SqlParameter paramITMNM = new SqlParameter("@ITMNM", null);
                SqlParameter paramITMNET = new SqlParameter("@ITMNET", null);
                SqlParameter paramTITLE = new SqlParameter("@TITLE", null);

                updateCmd.Parameters.AddRange(new SqlParameter[] {paramDATE,
                    paramCUSTOMERID,paramDUTY_TYPE,paramMCLIENTNO,paramMSANGHO,paramMCEONM,paramMUPTEA,paramMUPJONG,paramMADDR,
                    paramWDATE,paramTRANSDATE,paramRECEIPT,paramITMMM,paramITMDD,paramCLIENTNO,paramSANGHO,paramCEONM,
                    paramUPTEA,paramUPJONG,paramADDR,paramCOST,paramVAT,paramEMAIL,paramITMNM,paramITMNET,paramTITLE});

                cn.Open();
                foreach (var item in value)
                {
                    paramDATE.Value = item.DATE;
                    paramCUSTOMERID.Value = item.CUSTOMERID;
                    paramDUTY_TYPE.Value = item.DUTY_TYPE;
                    paramMCLIENTNO.Value = item.MCLIENTNO;
                    paramMSANGHO.Value = item.MSANGHO;
                    paramMCEONM.Value = item.MCEONM;
                    paramMUPTEA.Value = item.MUPTEA;
                    paramMUPJONG.Value = item.MUPJONG;
                    paramMADDR.Value = item.MADDR;
                    paramWDATE.Value = item.WDATE;
                    paramTRANSDATE.Value = item.TRANSDATE;
                    paramRECEIPT.Value = item.RECEIPT;
                    paramITMMM.Value = item.ITMMM;
                    paramITMDD.Value = item.ITMDD;
                    paramCLIENTNO.Value = item.CLIENTNO;
                    paramSANGHO.Value = item.SANGHO;
                    paramCEONM.Value = item.CEONM;
                    paramUPTEA.Value = item.UPTEA;
                    paramUPJONG.Value = item.UPJONG;
                    paramADDR.Value = item.ADDR;
                    paramCOST.Value = item.COST;
                    paramVAT.Value = item.VAT;
                    paramEMAIL.Value = item.EMAIL;
                    paramITMNM.Value = item.ITMNM;
                    paramITMNET.Value = item.ITMNET;
                    paramTITLE.Value = item.TITLE;

                    int i = updateCmd.ExecuteNonQuery();
                    iSuccess += i;
                    _AddText(stream, string.Format("[{0}][EVENT]## 전자세금계산서", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                    _AddText(stream, string.Format(" - 적용여부 : {0}", i > 0 ? "True" : "False"));
                    _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                    _AddText(stream, string.Format(" - 거래처코드 : {0}", item.CLIENTNO));
                    _AddText(stream, string.Format(" - 거래처명 : {0}", item.SANGHO));
                    _AddText(stream, string.Format(" - 단가 : {0}", item.COST));
                    _AddText(stream, string.Format(" - 세금 : {0}", item.VAT));
                    _AddText(stream, "");
                }
                cn.Close();
            }
            errString = iSuccess.ToString();
        }
        catch (Exception E)
        {
            errString = iSuccess.ToString() + "|" + E.Message;
            r = false;
        }
        _AddText(stream, string.Format("[{0}][EVENT]## Connection Close", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        try
        {
            stream.Close();
            stream.Dispose();
        }
        catch { }
        return r;
    }

    public string GoobneIP()
    {
        string goobneIP = string.Empty;
        try
        {
            using (SqlConnection cn = new SqlConnection(connectString))
            {
                SqlCommand companyCmd = new SqlCommand(
                    @"select server_name from tb_adminuser
                                          where userid = 'goobne'", cn);
                cn.Open();
                object o = companyCmd.ExecuteScalar();
                if (o != null) goobneIP = o.ToString();
                cn.Close();
            }
            return goobneIP;
        }
        catch (Exception)
        {
            return null;
        }
    }


    public DataSet GetTimeOrders(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, a.edate as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx)
				AND convert(datetime, SUBSTRING(a.idx,1,4) + '-' + SUBSTRING(a.idx,5,2) + '-' + SUBSTRING(a.idx,7,2) + ' ' + SUBSTRING(a.idx,9,2) + ':' + SUBSTRING(a.idx,11,2) + ':' + SUBSTRING(a.idx,13,2))  >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(a.idx,1,4) + '-' + SUBSTRING(a.idx,5,2) + '-' + SUBSTRING(a.idx,7,2) + ' ' + SUBSTRING(a.idx,9,2) + ':' + SUBSTRING(a.idx,11,2) + ':' + SUBSTRING(a.idx,13,2))  <= convert(datetime, @Order_Date_End)
                AND flag = 'y' 	and isnull(Rgubun,0) != 1 ";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , a.wdate
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx)
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) <= convert(datetime, @Order_Date_End)  
                    AND flag = 'y' and isnull(Rgubun,0) != 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
                ORDER BY a.pidx";
            string sqlString3 = @"SELECT  a.idx, count(*) as count
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx)
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) <= convert(datetime, @Order_Date_End)  
                    AND flag = 'y' and isnull(Rgubun,0) != 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
					group by a.idx
                ORDER BY a.idx";
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            SqlDataAdapter adapter3 = new SqlDataAdapter(
                sqlString3, connectString);
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table3 = new DataTable("Table3");
            adapter3.Fill(table3);
            adapter3.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            ds.Tables.Add(table3);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }

    public DataSet GetTimeDCenterOrders(Request value, string dCenterCode)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx) 
                AND convert(datetime, SUBSTRING(a.idx,1,4) + '-' + SUBSTRING(a.idx,5,2) + '-' + SUBSTRING(a.idx,7,2) + ' ' + SUBSTRING(a.idx,9,2) + ':' + SUBSTRING(a.idx,11,2) + ':' + SUBSTRING(a.idx,13,2)) >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(a.idx,1,4) + '-' + SUBSTRING(a.idx,5,2) + '-' + SUBSTRING(a.idx,7,2) + ' ' + SUBSTRING(a.idx,9,2) + ':' + SUBSTRING(a.idx,11,2) + ':' + SUBSTRING(a.idx,13,2)) <= convert(datetime, @Order_Date_End)
                AND flag = 'y' and isnull(Rgubun,0) != 1";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) wdate
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) =@CompanyIdx) 
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) <= convert(datetime, @Order_Date_End) 
                    AND flag = 'y' and isnull(Rgubun,0) != 1) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
                ORDER BY a.pidx";
            string sqlString3 =
                @"SELECT a.idx, count(*) as count
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) =@CompanyIdx) 
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) <= convert(datetime, @Order_Date_End) 
                    AND flag = 'y' and isnull(Rgubun,0) != 1) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
				GROUP BY a.idx
                ORDER BY a.idx";

            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            SqlDataAdapter adapter3 = new SqlDataAdapter(
            sqlString3, connectString);
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table3 = new DataTable("Table3");
            adapter3.Fill(table3);
            adapter3.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            ds.Tables.Add(table3);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }

    public DataSet CompanyGetTimeOrders(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 = string.Format(
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
	                AND convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
                AND flag = 'y' AND isnull(Rgubun,0) != 1 ", value.RequestUser.CompanyCode);
            string sqlString2 = string.Format(
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) wdate
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
   	                AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
					AND flag = 'y' AND isnull(Rgubun,0) != 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
                ORDER BY a.pidx", value.RequestUser.CompanyCode);
            string sqlString3 = string.Format(@"SELECT a.idx, count(*) as count
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
   	                AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
					AND flag = 'y' AND isnull(Rgubun,0) != 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				GROUP BY a.idx
                ORDER BY a.idx"
            , value.RequestUser.CompanyCode);
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            //adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            //adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            SqlDataAdapter adapter3 = new SqlDataAdapter(
                sqlString3, connectString);
            //adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table3 = new DataTable("Table3");
            adapter3.Fill(table3);
            adapter3.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            ds.Tables.Add(table3);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }

    public DataSet CompanyGetTimeDCenterOrders(Request value, string dCenterCode)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 = string.Format(
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
   	                AND convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
                AND flag = 'y' AND isnull(Rgubun,0) != 1 ", value.RequestUser.CompanyCode);
            string sqlString2 = string.Format(
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) wdate
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
	                AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
					AND flag = 'y' AND isnull(Rgubun,0) != 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
                ORDER BY a.pidx", value.RequestUser.CompanyCode);
            string sqlString3 = string.Format(
                @"SELECT a.idx, count(*) as count
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
	                AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
					AND flag = 'y' AND isnull(Rgubun,0) != 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
				GROUP BY a.idx
                ORDER BY a.idx", value.RequestUser.CompanyCode);
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            //adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            //adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            SqlDataAdapter adapter3 = new SqlDataAdapter(
            sqlString3, connectString);
            //adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table3 = new DataTable("Table3");
            adapter3.Fill(table3);
            adapter3.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            ds.Tables.Add(table3);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }


    public DataSet GetTimeReturnOrders(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, a.edate as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx)
				AND convert(datetime, SUBSTRING(a.idx,1,4) + '-' + SUBSTRING(a.idx,5,2) + '-' + SUBSTRING(a.idx,7,2) + ' ' + SUBSTRING(a.idx,9,2) + ':' + SUBSTRING(a.idx,11,2) + ':' + SUBSTRING(a.idx,13,2))  >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(a.idx,1,4) + '-' + SUBSTRING(a.idx,5,2) + '-' + SUBSTRING(a.idx,7,2) + ' ' + SUBSTRING(a.idx,9,2) + ':' + SUBSTRING(a.idx,11,2) + ':' + SUBSTRING(a.idx,13,2))  <= convert(datetime, @Order_Date_End)
                AND flag = 'y' 	and isnull(Rgubun,0) = 1 ";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , a.wdate,a.Returncomment,e.bname
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx)
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) <= convert(datetime, @Order_Date_End)  
                    AND flag = 'y' and isnull(Rgubun,0) = 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
left join tb_company_Retrurn as e on a.Returncomment = e.bidx
                ORDER BY a.pidx";
            string sqlString3 = @"SELECT  a.idx, count(*) as count
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx)
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) <= convert(datetime, @Order_Date_End)  
                    AND flag = 'y' and isnull(Rgubun,0) = 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
					group by a.idx
                ORDER BY a.idx";
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            SqlDataAdapter adapter3 = new SqlDataAdapter(
                sqlString3, connectString);
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table3 = new DataTable("Table3");
            adapter3.Fill(table3);
            adapter3.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            ds.Tables.Add(table3);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }

    public DataSet GetTimeDCenterReturnOrders(Request value, string dCenterCode)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 =
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) = @CompanyIdx) 
                AND convert(datetime, SUBSTRING(a.idx,1,4) + '-' + SUBSTRING(a.idx,5,2) + '-' + SUBSTRING(a.idx,7,2) + ' ' + SUBSTRING(a.idx,9,2) + ':' + SUBSTRING(a.idx,11,2) + ':' + SUBSTRING(a.idx,13,2)) >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(a.idx,1,4) + '-' + SUBSTRING(a.idx,5,2) + '-' + SUBSTRING(a.idx,7,2) + ' ' + SUBSTRING(a.idx,9,2) + ':' + SUBSTRING(a.idx,11,2) + ':' + SUBSTRING(a.idx,13,2)) <= convert(datetime, @Order_Date_End)
                AND flag = 'y' and isnull(Rgubun,0) = 1";
            string sqlString2 =
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) wdate,a.Returncomment,f.bname
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) =@CompanyIdx) 
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) <= convert(datetime, @Order_Date_End) 
                    AND flag = 'y' and isnull(Rgubun,0) = 1) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
left join tb_company_Retrurn as f on a.Returncomment = f.bidx
                ORDER BY a.pidx";
            string sqlString3 =
                @"SELECT a.idx, count(*) as count
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) =@CompanyIdx) 
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) >= convert(datetime, @Order_Date_Start)                
                AND convert(datetime, SUBSTRING(idx,1,4) + '-' + SUBSTRING(idx,5,2) + '-' + SUBSTRING(idx,7,2) + ' ' + SUBSTRING(idx,9,2) + ':' + SUBSTRING(idx,11,2) + ':' + SUBSTRING(idx,13,2)) <= convert(datetime, @Order_Date_End) 
                    AND flag = 'y' and isnull(Rgubun,0) = 1) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
				GROUP BY a.idx
                ORDER BY a.idx";

            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            SqlDataAdapter adapter3 = new SqlDataAdapter(
            sqlString3, connectString);
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table3 = new DataTable("Table3");
            adapter3.Fill(table3);
            adapter3.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            ds.Tables.Add(table3);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }

    public DataSet CompanyGetTimeReturnOrders(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 = string.Format(
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
	                AND convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
                AND flag = 'y' AND isnull(Rgubun,0) = 1 ", value.RequestUser.CompanyCode);
            string sqlString2 = string.Format(
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) wdate,a.Returncomment,e.bname
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
   	                AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
					AND flag = 'y' AND isnull(Rgubun,0) = 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
left join tb_company_Retrurn as e on a.Returncomment = e.bidx
                ORDER BY a.pidx", value.RequestUser.CompanyCode);
            string sqlString3 = string.Format(@"SELECT a.idx, count(*) as count
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
   	                AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
					AND flag = 'y' AND isnull(Rgubun,0) = 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				GROUP BY a.idx
                ORDER BY a.idx"
            , value.RequestUser.CompanyCode);
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            //adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            //adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            SqlDataAdapter adapter3 = new SqlDataAdapter(
                sqlString3, connectString);
            //adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table3 = new DataTable("Table3");
            adapter3.Fill(table3);
            adapter3.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            ds.Tables.Add(table3);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }

    public DataSet CompanyGetTimeDCenterReturnOrders(Request value, string dCenterCode)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString1 = string.Format(
                @"SELECT a.idx, a.usercode, a.comname2
                , a.orderday, a.ordermoney, a.rordermoney
                , a.carname, a.request_day, convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) as wdate
                , b.tcode as ClientCode, fileregcode,b.d_requestday
                FROM tb_order a LEFT JOIN
                (SELECT idx, tcode, fileregcode,d_requestday FROM tb_company) b on SUBSTRING(a.usercode, 11, 5) = b.idx
                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
   	                AND convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
                AND flag = 'y' AND isnull(Rgubun,0) = 1 ", value.RequestUser.CompanyCode);
            string sqlString2 = string.Format(
                @"SELECT a.pidx, a.idx, a.pcode
                , c.pc_code, d.cc_code, a.pname
                , a.pprice, a.ordernum, a.rordernum
                , convert(datetime, left(a.idx, 4) + '-' + substring(a.idx, 5, 2) + '-' + substring(a.idx, 7, 2) + ' ' + substring(a.idx, 9, 2) + ':' + substring(a.idx, 11, 2) + ':' + substring(a.idx, 13, 2)) wdate,a.Returncomment,f.bname
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
	                AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
					AND flag = 'y' AND isnull(Rgubun,0) = 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
left join tb_company_Retrurn as f on a.Returncomment = f.bidx
                ORDER BY a.pidx", value.RequestUser.CompanyCode);
            string sqlString3 = string.Format(
                @"SELECT a.idx, count(*) as count
                FROM tb_order_product AS a 
                INNER JOIN
	                (SELECT idx, SUBSTRING(usercode, 11, 5) AS cidx FROM tb_order
	                WHERE (SUBSTRING(usercode, 1, 5) in (select idx from tb_company where flag = '1' and tcode in ({0}))) 
	                AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, @Order_Date_Start) 
                    AND convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, @Order_Date_End) 
					AND flag = 'y' AND isnull(Rgubun,0) = 1 ) AS b 
	                ON a.idx = b.idx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS pc_code FROM tb_product) AS c 
	                ON c.idx = a.pcodeidx 
                LEFT OUTER JOIN
	                (SELECT idx, fileregcode AS cc_code FROM tb_company WHERE (flag = '3')) AS d 
	                ON b.cidx = d.idx
				JOIN
					(SELECT pcode FROM tb_product WHERE dcenterchoice = @DCenterCode) as e
					ON a.pcode = e.pcode
				GROUP BY a.idx
                ORDER BY a.idx", value.RequestUser.CompanyCode);
            SqlDataAdapter adapter1 = new SqlDataAdapter(
                sqlString1, connectString);
            //adapter1.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter1.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            DataTable table1 = new DataTable("Table1");
            adapter1.Fill(table1);
            adapter1.Dispose();
            SqlDataAdapter adapter2 = new SqlDataAdapter(
                sqlString2, connectString);
            //adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter2.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table2 = new DataTable("Table2");
            adapter2.Fill(table2);
            adapter2.Dispose();
            SqlDataAdapter adapter3 = new SqlDataAdapter(
            sqlString3, connectString);
            //adapter2.SelectCommand.Parameters.Add(new SqlParameter("@CompanyIdx", value.RequestUser.CompanyIdx));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_Start", value.DateStart));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@Order_Date_End", value.DateEnd));
            adapter3.SelectCommand.Parameters.Add(new SqlParameter("@DCenterCode", dCenterCode));
            DataTable table3 = new DataTable("Table3");
            adapter3.Fill(table3);
            adapter3.Dispose();
            DataSet ds = new DataSet("returnDataSet");
            ds.Tables.Add(table1);
            ds.Tables.Add(table2);
            ds.Tables.Add(table3);
            return ds;
        }
        catch (Exception E)
        {
            SerializableException sE = new SerializableException
            {
                Message = E.Message,
                Source = E.Source,
                StackTrace = E.StackTrace
                ,
                InnerExceptionName = E.InnerException == null ? "" : E.InnerException.GetType().Name,
                InnerExceptionMessage = E.InnerException == null ? "" : E.InnerException.Message
            };
            ExceptionWriter writer = new ExceptionWriter();
            writer.SendException(sE, value.RequestUser);
            return null;
        }
    }

    public DataTable GetFileCodeCompanies(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;

        try
        {
            DataTable table = new DataTable("returnTable");
            string sqlString =
                @"SELECT	a.tcode AS Code, a.comname AS Name, a.name AS CEO_Name, a.post AS Zip_Code, a.addr AS Addr, a.addr2 AS Addr_Detail, 
		                a.companynum1 + N'-' + a.companynum2 + N'-' + a.companynum3 AS ID_Code, a.uptae AS Uptae, a.upjong AS Jongmok, a.wdate AS Create_Date, 
		                a.ye_money AS Check_Limit, a.virtual_acnt AS Virtual_Check, a.virtual_acnt_bank AS Bank_Name, a.email AS Agent_Email, ISNULL(b.tcode, '') 
		                AS Jisa_Code, ISNULL(a.cbrandchoice, '') AS Type_B, c.idx AS cCode, c.usercode AS cUser_Code, c.dcarno AS cDelivery_No, 
		                c.dcarname AS cDelivery_Name, c.tel1 + N'-' + c.tel2 + N'-' + c.tel3 AS cPhone, c.carno AS cCar_No, c.carkind AS cCar_Kind, c.caryflag AS cCar_Year, 
		                c.wdate AS cCreate_Date, a.fileregcode, a.tel1 + N'-' + a.tel2 + N'-' + a.tel3 AS Agent_Phone, a.hp1 + '-' + a.hp2 + '-' + a.hp3 AS Agent_HPhone
                FROM    tb_company AS a 
                LEFT OUTER JOIN
		                (SELECT	idx, tcode, flag, fileflaglevel, bidxsub, idxsub, idxsubname, comname, name, juminno1, juminno2, post, addr, addr2, companynum1, 
				                companynum2, companynum3, uptae, upjong, tel1, tel2, tel3, fax1, fax2, fax3, hp1, hp2, hp3, homepage, email, dcarno, vatflag, taxtitle, 
				                usegubun, usemoney, startday, orderreg, soundfile, sclose, dcode, fileflag, telecom, ctel1, ctel2, ctel3, hapday, jumin1, jumin2, 
				                jumincheck, telname, conetion, wdate, wuserid, edate, euserid, orderflag, fileregcode, mregflag, brandflag, brandbox, cbrandchoice, 
				                timecheck1, timecheck2, com_notice, d_requestday, order_weekgubun, order_weekchoice, order_checkStime, order_checkEtime, 
				                maechulflag, mi_money, ye_money, myflag, myflag_select, agencycheck2, ch_gongi, serviceflag, dcenterflag, proflag1, proflag2, djflag, 
				                smsflag, chk_gongi1, chk_gongi2, miorderflag, virtual_acnt, virtual_acnt_bank, noteflag, accountflag, misuprint, datadel, datadelday, 
				                misubtn, cyberNum, cporg_cd, rec_fax, noticeflag, fileflagchb, virtual_acnt2, virtual_acnt2_bank
		                FROM          tb_company
		                WHERE      (bidxsub in (select idx from tb_company where tcode in (:Tcode))) AND (flag = 1)) AS b ON a.idxsub = b.idx 
                LEFT OUTER JOIN
		                (SELECT     idx, usercode, dcarno, dcarname, tel1, tel2, tel3, carno, carkind, caryflag, wdate, wuserid, edate, euserid
		                FROM		tb_car) AS c ON a.dcarno = c.idx
                WHERE	(a.flag = 3) AND (a.bidxsub in (select idx from tb_company where tcode in (:Tcode) AND (flag = 1)))".Replace(":Tcode", value.RequestUser.CompanyCode);
            SqlDataAdapter adapter = new SqlDataAdapter(
                sqlString, connectString);
            //adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));
            adapter.Fill(table);
            adapter.Dispose();
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }

    public DataTable GetFileCodeGoobneCompanies(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString =
                @"SELECT	a.tcode AS Code, a.comname AS Name, a.name AS CEO_Name, a.post AS Zip_Code, a.addr AS Addr, a.addr2 AS Addr_Detail, 
		                a.companynum1 + N'-' + a.companynum2 + N'-' + a.companynum3 AS ID_Code, a.uptae AS Uptae, a.upjong AS Jongmok, a.wdate AS Create_Date, 
		                a.ye_money AS Check_Limit, a.virtual_acnt AS Virtual_Check, a.virtual_acnt_bank AS Bank_Name, a.email AS Agent_Email, ISNULL(b.tcode, '') 
		                AS Jisa_Code, ISNULL(a.cbrandchoice, '') AS Type_B, c.idx AS cCode, c.usercode AS cUser_Code, c.dcarno AS cDelivery_No, 
		                c.dcarname AS cDelivery_Name, c.tel1 + N'-' + c.tel2 + N'-' + c.tel3 AS cPhone, c.carno AS cCar_No, c.carkind AS cCar_Kind, c.caryflag AS cCar_Year, 
		                c.wdate AS cCreate_Date, a.tel1 + N'-' + a.tel2 + N'-' + a.tel3 AS Agent_Phone, a.hp1 + '-' + a.hp2 + '-' + a.hp3 AS Agent_HPhone, a.fileregcode
                FROM    tb_company AS a 
                LEFT OUTER JOIN
		                (SELECT	idx, tcode, flag, fileflaglevel, bidxsub, idxsub, idxsubname, comname, name, juminno1, juminno2, post, addr, addr2, companynum1, 
				                companynum2, companynum3, uptae, upjong, tel1, tel2, tel3, fax1, fax2, fax3, hp1, hp2, hp3, homepage, email, dcarno, vatflag, taxtitle, 
				                usegubun, usemoney, startday, orderreg, soundfile, sclose, dcode, fileflag, telecom, ctel1, ctel2, ctel3, hapday, jumin1, jumin2, 
				                jumincheck, telname, conetion, wdate, wuserid, edate, euserid, orderflag, fileregcode, mregflag, brandflag, brandbox, cbrandchoice, 
				                timecheck1, timecheck2, com_notice, d_requestday, order_weekgubun, order_weekchoice, order_checkStime, order_checkEtime, 
				                maechulflag, mi_money, ye_money, myflag, myflag_select, agencycheck2, ch_gongi, serviceflag, dcenterflag, proflag1, proflag2, djflag, 
				                smsflag, chk_gongi1, chk_gongi2, miorderflag, virtual_acnt, virtual_acnt_bank, noteflag, accountflag, misuprint, datadel, datadelday, 
				                misubtn, cyberNum, cporg_cd, rec_fax, noticeflag, fileflagchb, virtual_acnt2, virtual_acnt2_bank
		                FROM          tb_company
		                WHERE      (bidxsub in (select idx from tb_company where tcode in (:Tcode))) AND (flag = 1)) AS b ON a.idxsub = b.idx 
                LEFT OUTER JOIN
		                (SELECT     idx, usercode, dcarno, dcarname, tel1, tel2, tel3, carno, carkind, caryflag, wdate, wuserid, edate, euserid, dcenter.tcode as JisaCode
		                FROM		tb_car car 
		                left join (select tcode, choiceDcenter from tb_company where flag = 2 and bidxsub in (select idx from tb_company where tcode in (:Tcode) AND (flag = 2))) dcenter on car.dcenteridx = dcenter.choiceDcenter
		                ) AS c ON a.dcarno = c.idx
                WHERE	(a.flag = 3) AND (a.bidxsub in (select idx from tb_company where tcode in (:Tcode) AND (flag = 1)))".Replace(":Tcode", value.RequestUser.CompanyCode);
            SqlDataAdapter adapter = new SqlDataAdapter(
                sqlString, connectString);
            //adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));
            DataTable table = new DataTable("returnTable");
            adapter.Fill(table);
            adapter.Dispose();
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }

    public bool UpdateMisuFileCode(ClientMisu[] value)
    {
try{
        int iSuccess = 0;
        bool r = true;
        if (value.Length <= 0)
        {
            return r;
        }
        FileStream stream = _GetLogFile();
        OperationContext context = OperationContext.Current;
        MessageProperties messageProperties = context.IncomingMessageProperties;
        RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
        as RemoteEndpointMessageProperty;
        _AddText(stream, string.Format("[{0}][EVENT]## Client Connected", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        _AddText(stream, string.Format("[{0}][EVENT]## Datat Receive OK !!!", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        string tcode = string.Empty;
        string company = string.Empty;
        string count = string.Empty;
        string idx = value[0].bidxsub;
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand tcodeCmd = new SqlCommand(
                @"SELECT tcode FROM tb_company WHERE idx = @idx", cn);
            tcodeCmd.Parameters.Add(new SqlParameter("@idx", idx));
            cn.Open();
            object o = tcodeCmd.ExecuteScalar();
            if (o != null) tcode = o.ToString();
            cn.Close();
        }
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand companyCmd = new SqlCommand(
                @"SELECT comname FROM tb_company WHERE idx = @idx AND tcode = @tcode", cn);
            companyCmd.Parameters.Add(new SqlParameter("@idx", idx));
            companyCmd.Parameters.Add(new SqlParameter("@tcode", tcode));
            cn.Open();
            object o = companyCmd.ExecuteScalar();
            if (o != null) company = o.ToString();
            cn.Close();
        }
        count = value.Length.ToString();
        _AddText(stream, string.Format(" - 체인본부코드 : {0}", tcode));
        _AddText(stream, string.Format(" - 체인본부 명  : {0}", company));
        _AddText(stream, string.Format(" - 데이터 건수  : {0}", count));
        _AddText(stream, "");
        try
        {
            using (SqlConnection cn = new SqlConnection(connectString))
            {
                SqlCommand updateCmd = new SqlCommand(
                    @"UPDATE    tb_company
                SET              mi_money = @mi_money, ye_money = @ye_money
                WHERE     (fileregcode = @tcode) AND (bidxsub = @bidxsub)", cn);
                SqlParameter paramTcode = new SqlParameter("@tcode", null);
                SqlParameter paramBidxsub = new SqlParameter("@bidxsub", null);
                SqlParameter paramMi_money = new SqlParameter("@mi_money", null);
                SqlParameter paramYe_money = new SqlParameter("@ye_money", null);
                updateCmd.Parameters.Add(paramTcode);
                updateCmd.Parameters.Add(paramBidxsub);
                updateCmd.Parameters.Add(paramMi_money);
                updateCmd.Parameters.Add(paramYe_money);
                cn.Open();
                foreach (var item in value)
                {
                    paramTcode.Value = item.tcode;
                    paramBidxsub.Value = item.bidxsub;
                    paramMi_money.Value = item.mi_money;
                    paramYe_money.Value = item.ye_money;
                    int i = updateCmd.ExecuteNonQuery();
                    iSuccess += i;
                    _AddText(stream, string.Format("[{0}][EVENT]## 미수금정보", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                    _AddText(stream, string.Format(" - 적용여부 : {0}", i > 0 ? "True" : "False"));
                    _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                    _AddText(stream, string.Format(" - 체인코드 : {0}", item.tcode));
                    _AddText(stream, string.Format(" - 여신금액 : {0}", item.ye_money.ToString("N0")));
                    _AddText(stream, string.Format(" - 미수금액 : {0}", item.mi_money.ToString("N0")));
                    _AddText(stream, "");
                }
                cn.Close();
            }
        }
        catch (Exception E)
        {
            r = false;
            _AddText(stream, string.Format("[{0}][EVENT]## Connection Close", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
            _AddText(stream, string.Format(" - Exception : {0}", E.Message));
        }
        _AddText(stream, string.Format("[{0}][EVENT]## Connection Close", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        try
        {
            stream.Close();
            stream.Dispose();
        }
        catch { }
        return r;
} catch (Exception exxx)
{
	System.IO.File.AppendAllText(@"D:\Log\Exception\Log.TXT", exxx.ToString());
	return false;
}
    }

    public DataTable GetFileCodeUsers(Request value)
    {
        try
        {
            string sqlString =
                string.Format(
                @"select userid as UserID , userpwd as UserPassword, username as UserName, 
                CASE WHEN len(usercode) = 5 THEN 0 WHEN len(usercode) = 10 THEN 1 ELSE 2 END as UserLevel,
                CASE WHEN len(usercode) >= 10 THEN c.tcode ELSE b.tcode END as JisaCode
                from tb_adminuser a 
                left join
                tb_company b on left(a.usercode, 5) = b.idx
                left join
                tb_company c on substring(a.usercode, 6, 5) = c.idx
                where left(usercode, 5) in (select idx from tb_company where tcode in ({0}) AND (flag = 1))", value.RequestUser.CompanyIdx);
            SqlDataAdapter adapter = new SqlDataAdapter(sqlString, connectString);
            //adapter.SelectCommand.Parameters.Add(new SqlParameter("@idx", value.RequestUser.CompanyIdx));
            DataTable table = new DataTable("returnTable");
            adapter.Fill(table);
            adapter.Dispose();
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }
    
    public DataTable GetFileCodeJisaInformation(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString = string.Format(
                @"SELECT tcode as Jisa_Code, comname as Corp_Name, name as CEO_NAME
                , companynum1 + '-' + companynum2 + '-' + companynum3 as Corp_No
                , post as Corp_ZIP
                , addr as Corp_Add
                , addr2 as Corp_Add_Detail
                , upjong as Corp_JongMok
                , uptae as Corp_Uptae
                , tel1 + '-' + tel2 + '-' + tel3 as Corp_Phone
                , fax1 + '-' + fax2 + '-' + fax3 as Corp_FAX
                , dcarno as Delivery_Code
                , Case When Len(wdate) >=10 then Replace(Left(wdate, 10), '-', '/') else '' End as Create_Date
                from tb_company 
                where flag = 2 and bidxsub in (select idx from tb_company where tcode in ({0}) AND (flag = 1))", value.RequestUser.CompanyCode);
            SqlDataAdapter adapter = new SqlDataAdapter(
                sqlString, connectString);
            //adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));
            DataTable table = new DataTable("returnTable");
            adapter.Fill(table);
            adapter.Dispose();
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }

    public DataTable GetFileCodeBrandInformation(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString = string.Format(
                @"select	bidx as Code
                ,		'CLB' as Type
                ,		'' as Up_Code   
                ,		bname as Code_Name
                ,		'' as Code_Discript
                ,		'' as ICD
                ,		getDate() as IDT
                ,		'' as UCD
                ,		getDate() as UDT
                ,		0 as Code_Order   
                from tb_company_brand where idx in (select idx from tb_company where tcode in ({0}) AND (flag = 1))", value.RequestUser.CompanyCode);
            SqlDataAdapter adapter = new SqlDataAdapter(
                sqlString, connectString);
            //adapter.SelectCommand.Parameters.Add(new SqlParameter("@bidxsub", value.RequestUser.CompanyIdx));
            DataTable table = new DataTable("returnTable");
            adapter.Fill(table);
            adapter.Dispose();
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }

    public DataTable GetFileCodeProducts(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString = string.Format(
                @"Select a.pcode as Code, a.pname as Name
                , a.pprice as Sell_UnitPrice, a.ptitle as Size_Code, a.qty_code as Unit_Code
                , a.gubun as HasTax, a.bigo as Memo
                , a.wdate as Create_Date, fileregcode
                FROM tb_product a
                WHERE (usercode in (select idx from tb_company where tcode in ({0}) AND (flag = 1)))", value.RequestUser.CompanyCode);
            SqlDataAdapter adapter = new SqlDataAdapter(
                sqlString, connectString);
            //adapter.SelectCommand.Parameters.Add(new SqlParameter("@usercode", value.RequestUser.CompanyIdx));
            DataTable table = new DataTable("returnTable");
            adapter.Fill(table);
            adapter.Dispose();
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }

	 public DataTable GetFileCodeVirtualAccounts(Request value)
    {
        //if (isAllowedUser(value.RequestUser) == false) return null;
        try
        {
            string sqlString = string.Format(
                @"SELECT a.troccorg_cd, a.cporg_cd, a.deptr_seq
                , a.tr_il as Trade_Date, a.tr_si as Trade_Time
                , a.va_no as Check_Account, a.dep_amt as Input_Amt
                , a.depbnk_nm as Input_Bank, a.cust_nm as Input_Name
                , c.fileregcode as Client_Code, a.channame as Client_Name
                , a.ye_money as Yeusin_Amt, a.mi_money as Misu_Amt
				FROM tb_virtual_acnt a
                join tb_company b on a.cporg_cd = b.cporg_cd
				join tb_company c on a.va_no = c.virtual_acnt
            	WHERE (b.idx in (select idx from tb_company where tcode in ({0}) AND (flag = 1))) AND (tr_il >= @tr_il_Start) AND (tr_il <= @tr_il_End) AND (dep_st = '1')", value.RequestUser.CompanyCode);
            SqlDataAdapter adapter = new SqlDataAdapter(
                sqlString, connectString);
            //adapter.SelectCommand.Parameters.Add(new SqlParameter("@idx", value.RequestUser.CompanyIdx));
            adapter.SelectCommand.Parameters.Add(new SqlParameter("@tr_il_Start", value.DateStart));
            adapter.SelectCommand.Parameters.Add(new SqlParameter("@tr_il_End", value.DateEnd));
            DataTable table = new DataTable("returnTable");
            adapter.Fill(table);
            adapter.Dispose();
            return table;
        }
        catch (Exception)
        {
            return null;
        }
    }
	public bool SendSMS(string phoneNo, string message)
    {
		bool result = true;
        string insertString =
            @"insert into em_tran (  tran_refkey  ,tran_id  ,tran_phone  ,tran_callback  ,tran_status  ,tran_date  ,tran_rsltdate  ,tran_reportdate  ,tran_rslt  ,tran_net  ,tran_msg  ,tran_etc1  ,tran_etc2  ,tran_etc3  ,tran_etc4  ,tran_type)  
	VALUES (  null  ,null  ,@RevTelNo  ,'02-853-5111'  ,'1'  ,getdate()  ,null  ,null  ,null  ,null  ,@Message  ,null  ,''  ,''   ,0   ,0 )";
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand insertCmd = new SqlCommand(insertString, cn);
            insertCmd.Parameters.Add(new SqlParameter("@RevTelNo", phoneNo));
            insertCmd.Parameters.Add(new SqlParameter("@Message", message));
            try
            {
                cn.Open();
                int value = insertCmd.ExecuteNonQuery();
                if (value < 1)
                    result = false;
                else
                    result = true;
            }
            catch (Exception)
            {
                result = false;
            }
            finally { cn.Close(); }
        }

        return result;
    }

	public bool ETaxGoobne(ETAX[] value, out string errString)
    {
        errString = "";
        int iSuccess = 0;
        bool r = true;
        if (value.Length <= 0)
        {
            return r;
        }
        FileStream stream = _GetLogFile();
        OperationContext context = OperationContext.Current;
        MessageProperties messageProperties = context.IncomingMessageProperties;
        RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
        as RemoteEndpointMessageProperty;
        _AddText(stream, string.Format("[{0}][EVENT]## Client Connected", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        _AddText(stream, string.Format("[{0}][EVENT]## Datat Receive OK !!!", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        string tcode = string.Empty;
        string company = string.Empty;
        string count = string.Empty;
        string idx = value[0].IDX;
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand tcodeCmd = new SqlCommand(
                @"SELECT tcode FROM tb_company WHERE idx = @idx", cn);
            tcodeCmd.Parameters.Add(new SqlParameter("@idx", idx));
            cn.Open();
            object o = tcodeCmd.ExecuteScalar();
            if (o != null) tcode = o.ToString();
            cn.Close();
        }
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand companyCmd = new SqlCommand(
                @"SELECT comname FROM tb_company WHERE idx = @idx AND tcode = @tcode", cn);
            companyCmd.Parameters.Add(new SqlParameter("@idx", idx));
            companyCmd.Parameters.Add(new SqlParameter("@tcode", tcode));
            cn.Open();
            object o = companyCmd.ExecuteScalar();
            if (o != null) company = o.ToString();
            cn.Close();
        }
        count = value.Length.ToString();
        _AddText(stream, string.Format(" - 체인본부코드 : {0}", tcode));
        _AddText(stream, string.Format(" - 체인본부 명  : {0}", company));
        _AddText(stream, string.Format(" - 데이터 건수  : {0}", count));
        _AddText(stream, "");
        try
        {
            using (SqlConnection cn = new SqlConnection(connectStringTR))
            {
                string sqlCommandText = string.Empty;
                
                cn.Open();
                value.OrderBy(c => c.CLIENTCODE);
                string tempClientCode = string.Empty;
                string tempDutyNum = string.Empty;
                string tempItemSEQ = "1";
                foreach (var item in value)
                {
                    SqlCommand updateCmd = new SqlCommand();
                    updateCmd.Connection = cn;

                    SqlParameter paramDATE = new SqlParameter("@DATE", null);
                    SqlParameter paramCUSTOMERID = new SqlParameter("@CUSTOMERID", null);
                    SqlParameter paramDUTY_TYPE = new SqlParameter("@DUTY_TYPE", null);
                    SqlParameter paramMCLIENTNO = new SqlParameter("@MCLIENTNO", null);
                    SqlParameter paramMSANGHO = new SqlParameter("@MSANGHO", null);
                    SqlParameter paramMCEONM = new SqlParameter("@MCEONM", null);
                    SqlParameter paramMUPTEA = new SqlParameter("@MUPTEA", null);
                    SqlParameter paramMUPJONG = new SqlParameter("@MUPJONG", null);
                    SqlParameter paramMADDR = new SqlParameter("@MADDR", null);
                    SqlParameter paramWDATE = new SqlParameter("@WDATE", null);
                    SqlParameter paramTRANSDATE = new SqlParameter("@TRANSDATE", null);
                    SqlParameter paramRECEIPT = new SqlParameter("@RECEIPT", null);
                    SqlParameter paramITMMM = new SqlParameter("@ITMMM", null);
                    SqlParameter paramITMDD = new SqlParameter("@ITMDD", null);
                    SqlParameter paramCLIENTNO = new SqlParameter("@CLIENTNO", null);
                    SqlParameter paramSANGHO = new SqlParameter("@SANGHO", null);
                    SqlParameter paramCEONM = new SqlParameter("@CEONM", null);
                    SqlParameter paramUPTEA = new SqlParameter("@UPTEA", null);
                    SqlParameter paramUPJONG = new SqlParameter("@UPJONG", null);
                    SqlParameter paramADDR = new SqlParameter("@ADDR", null);
                    SqlParameter paramCOST = new SqlParameter("@COST", null);
                    SqlParameter paramVAT = new SqlParameter("@VAT", null);
                    SqlParameter paramEMAIL = new SqlParameter("@EMAIL", null);
                    SqlParameter paramITMNM = new SqlParameter("@ITMNM", null);
                    SqlParameter paramITMNET = new SqlParameter("@ITMNET", null);
                    SqlParameter paramTITLE = new SqlParameter("@TITLE", null);
                    SqlParameter paramITMSEQ = new SqlParameter("@ITMSEQ", null);
                    SqlParameter paramDUTY_NUM = new SqlParameter("@DUTY_NUM", null);

                    if (tempClientCode == item.CLIENTCODE)
                    {
                        sqlCommandText = @"
                                INSERT INTO [TR_DUTYDETAIL]
                                   ([CUSTOMERID], [DUTY_NUM], [ITMSEQ], [ITMMM], [ITMDD]
				                    , [ITMNM], [ITMSIZE], [ITMQTY], [ITMNET], [COST]
				                    , [VAT], [ETC])
                                 VALUES
				                    (@CUSTOMERID, @DUTY_NUM, @ITMSEQ, @ITMMM, @ITMDD
				                    , @ITMNM, NULL, 1, @ITMNET, @COST
				                    , @VAT, NULL)";
                        updateCmd.Parameters.AddRange(new SqlParameter[] {
                        paramCUSTOMERID, paramDUTY_NUM, paramITMSEQ, paramITMMM, paramITMDD, paramITMNM, paramITMNET,paramCOST, paramVAT});
                    }
                    else
                    {
                        sqlCommandText = @"
                                    INSERT INTO [TR_DUTYMASTER]
                                       ([CUSTOMERID], [DUTY_NUM], [DUTY_TYPE], [DUTY_GWOEN], [DUTY_HO]
	                                    , [DUTY_SEQ], [MCLIENTNO], [MSANGHO], [MCEONM], [MUPTEA]
	                                    , [MUPJONG], [MADDR], [CLIENTNO], [SANGHO], [CEONM]
	                                    , [UPTEA], [UPJONG], [ADDR], [WDATE], [COST]
	                                    , [VAT], [ETC], [HYUNGUM], [SUPYO], [EOEUM]
	                                    , [MISU], [RECEIPT], [TR_CRE_TIME], [TR_TRA_TIME], [TR_NTS_TIME]
	                                    , [MANAGER], [DEPT], [EMAIL], [TELNO1], [TELNO2]
	                                    , [TELNO3], [MOBIL1], [MOBIL2], [MOBIL3], [TITLE]
	                                    , [TAX_TYPE]
                                        , [MMANAGER], [MDEPT], [MEMAIL], [MTELNO1]
	                                    , [MTELNO2], [MTELNO3], [MMOBIL1], [MMOBIL2], [MMOBIL3]
	                                    , [CHGTYPE], [TRANSDATE], [TR_TEC01], [TR_TEC02], [TR_TEC03]
	                                    , [TR_TEC04], [TR_TEC05], [TR_RSLTSTAT], [TR_NTS_LSTSTAT])
                                    VALUES
                                       (@CUSTOMERID, @DUTY_NUM, @DUTY_TYPE, NULL, NULL
	                                    , NULL, @MCLIENTNO, @MSANGHO, @MCEONM, @MUPTEA
	                                    , @MUPJONG, @MADDR, @CLIENTNO, @SANGHO, @CEONM
	                                    , @UPTEA, @UPJONG, @ADDR, @WDATE, @COST
	                                    , @VAT, NULL, NULL, NULL, NULL
	                                    , NULL, @RECEIPT, NULL, NULL, NULL
	                                    , NULL, NULL, @EMAIL, NULL, NULL
	                                    , NULL, NULL, NULL, NULL, @TITLE
	                                    , CASE WHEN @VAT = 0 THEN '면세' ELSE '과세' END
                                        , NULL, NULL, NULL, NULL
	                                    , NULL, NULL, NULL, NULL, NULL
	                                    , NULL, @TRANSDATE, NULL, NULL, NULL
	                                    , NULL, NULL, NULL, NULL)
	                                INSERT INTO [TR_DUTYDETAIL]
                                       ([CUSTOMERID], [DUTY_NUM], [ITMSEQ], [ITMMM], [ITMDD]
				                        , [ITMNM], [ITMSIZE], [ITMQTY], [ITMNET], [COST]
				                        , [VAT], [ETC])
                                     VALUES
				                        (@CUSTOMERID, @DUTY_NUM, @ITMSEQ, @ITMMM, @ITMDD
				                        , @ITMNM, NULL, 1, @ITMNET, @COST
				                        , @VAT, NULL)";

                        tempClientCode = item.CLIENTCODE;

                        using (SqlConnection cnduty = new SqlConnection(connectStringTR))
                        {
                            SqlCommand companyCmd = new SqlCommand(
                                @"SELECT @DATE + '9' + RIGHT('00000' +	LTRIM(STR(ISNULL(MAX(RIGHT(DUTY_NUM, 5)) + 1, 1))), 5)
                                FROM	[TR_DUTYMASTER]
                                WHERE	LEFT(DUTY_NUM, 8) = @DATE", cnduty);
                            companyCmd.Parameters.Add(new SqlParameter("@DATE", item.DATE));
                            cnduty.Open();
                            object o = companyCmd.ExecuteScalar();
                            if (o != null) tempDutyNum = o.ToString();
                            cnduty.Close();
                        }
                        updateCmd.Parameters.AddRange(new SqlParameter[] {paramDATE,
                        paramCUSTOMERID,paramDUTY_TYPE,paramMCLIENTNO,paramMSANGHO,paramMCEONM,paramMUPTEA,paramMUPJONG,paramMADDR,
                        paramWDATE,paramTRANSDATE,paramRECEIPT,paramITMMM,paramITMDD,paramCLIENTNO,paramSANGHO,paramCEONM,
                        paramUPTEA,paramUPJONG,paramADDR,paramCOST,paramVAT,paramEMAIL,paramITMNM,paramITMNET,paramTITLE,paramITMSEQ,paramDUTY_NUM});
                    }
                    updateCmd.CommandText = sqlCommandText;
                    paramDATE.Value = item.DATE;
                    paramCUSTOMERID.Value = item.CUSTOMERID;
                    paramDUTY_TYPE.Value = item.DUTY_TYPE;
                    paramMCLIENTNO.Value = item.MCLIENTNO;
                    paramMSANGHO.Value = item.MSANGHO;
                    paramMCEONM.Value = item.MCEONM;
                    paramMUPTEA.Value = item.MUPTEA;
                    paramMUPJONG.Value = item.MUPJONG;
                    paramMADDR.Value = item.MADDR;
                    paramWDATE.Value = item.WDATE;
                    paramTRANSDATE.Value = item.TRANSDATE;
                    paramRECEIPT.Value = item.RECEIPT;
                    paramITMMM.Value = item.ITMMM;
                    paramITMDD.Value = item.ITMDD;
                    paramCLIENTNO.Value = item.CLIENTNO;
                    paramSANGHO.Value = item.SANGHO;
                    paramCEONM.Value = item.CEONM;
                    paramUPTEA.Value = item.UPTEA;
                    paramUPJONG.Value = item.UPJONG;
                    paramADDR.Value = item.ADDR;
                    paramCOST.Value = item.COST;
                    paramVAT.Value = item.VAT;
                    paramEMAIL.Value = item.EMAIL;
                    paramITMNM.Value = item.ITMNM;
                    paramITMNET.Value = item.ITMNET;
                    paramTITLE.Value = item.TITLE;
                    paramDUTY_NUM.Value = tempDutyNum;
                    switch (item.ITMNM)
                    {
                        case "부자재 과세":
                            tempItemSEQ = "2";
                            break;
                        case "부자재 비과세":
                            tempItemSEQ = "3";
                            break;
                        case "치킨류 과세":
                            tempItemSEQ = "4";
                            break;
                        case "치킨류 비과세":
                            tempItemSEQ = "5";
                            break;
                        case "소모품 과세":
                            tempItemSEQ = "6";
                            break;
                        case "소모품 비과세":
                            tempItemSEQ = "7";
                            break;
                        case "식자재 과세":
                            tempItemSEQ = "8";
                            break;
                        case "식자재 비과세":
                            tempItemSEQ = "9";
                            break;
                        case "기타 과세":
                            tempItemSEQ = "10";
                            break;
                        case "기타 비과세":
                            tempItemSEQ = "11";
                            break;
                        default:
                            tempItemSEQ = "1";
                            break;
                    }
                    paramITMSEQ.Value = tempItemSEQ;

                    int i = updateCmd.ExecuteNonQuery();
                    iSuccess += i;
                    _AddText(stream, string.Format("[{0}][EVENT]## 전자세금계산서", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                    _AddText(stream, string.Format(" - 적용여부 : {0}", i > 0 ? "True" : "False"));
                    _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                    _AddText(stream, string.Format(" - 거래처코드 : {0}", item.CLIENTNO));
                    _AddText(stream, string.Format(" - 거래처명 : {0}", item.SANGHO));
                    _AddText(stream, string.Format(" - 단가 : {0}", item.COST));
                    _AddText(stream, string.Format(" - 세금 : {0}", item.VAT));
                    _AddText(stream, "");
                }
                cn.Close();
            }
            errString = iSuccess.ToString();
        }
        catch (Exception E)
        {
            errString = iSuccess.ToString() + "|" + E.Message;
            r = false;
        }
        _AddText(stream, string.Format("[{0}][EVENT]## Connection Close", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        try
        {
            stream.Close();
            stream.Dispose();
        }
        catch { }
        return r;
    }

	public bool ETaxIntegration(ETAX[] value, out string errString)
    {
        errString = "";
        int iSuccess = 0;
        bool r = true;
        if (value.Length <= 0)
        {
            return r;
        }
        FileStream stream = _GetLogFile();
        OperationContext context = OperationContext.Current;
        MessageProperties messageProperties = context.IncomingMessageProperties;
        RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
        as RemoteEndpointMessageProperty;
        _AddText(stream, string.Format("[{0}][EVENT]## Client Connected", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        _AddText(stream, string.Format("[{0}][EVENT]## Datat Receive OK !!!", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));

        int masterRowCount = 0;
        string tcode = string.Empty;
        string company = string.Empty;
        string count = string.Empty;
        string idx = value[0].IDX;
        decimal tempCOST, tempVAT;
        tempCOST = tempVAT = 0;
        string tempCUSTOMERID, tempDutyNum, tempDUTY_TYPE,
                tempMCLIENTNO, tempMSANGHO, tempMCEONM, tempMUPTEA,
                tempMUPJONG, tempMADDR, tempCLIENTNO, tempSANGHO, tempCEONM,
                tempUPTEA, tempUPJONG, tempADDR, tempWDATE,
                tempRECEIPT, tempEMAIL, tempTITLE,
                tempTRANSDATE;
        tempCUSTOMERID = tempDutyNum = tempDUTY_TYPE = tempMCLIENTNO = tempMSANGHO = tempMCEONM = tempMUPTEA =
                tempMUPJONG = tempMADDR = tempCLIENTNO = tempSANGHO = tempCEONM =
                tempUPTEA = tempUPJONG = tempADDR = tempWDATE =
                tempRECEIPT = tempEMAIL = tempTITLE =
                tempTRANSDATE = string.Empty;

        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand tcodeCmd = new SqlCommand(
                @"SELECT tcode FROM tb_company WHERE idx = @idx", cn);
            tcodeCmd.Parameters.Add(new SqlParameter("@idx", idx));
            cn.Open();
            object o = tcodeCmd.ExecuteScalar();
            if (o != null) tcode = o.ToString();
            cn.Close();
        }
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand companyCmd = new SqlCommand(
                @"SELECT comname FROM tb_company WHERE idx = @idx AND tcode = @tcode", cn);
            companyCmd.Parameters.Add(new SqlParameter("@idx", idx));
            companyCmd.Parameters.Add(new SqlParameter("@tcode", tcode));
            cn.Open();
            object o = companyCmd.ExecuteScalar();
            if (o != null) company = o.ToString();
            cn.Close();
        }
        count = value.Length.ToString();
        _AddText(stream, string.Format(" - 체인본부코드 : {0}", tcode));
        _AddText(stream, string.Format(" - 체인본부 명  : {0}", company));
        _AddText(stream, string.Format(" - 데이터 건수  : {0}", count));
        _AddText(stream, "");
        try
        {
            using (SqlConnection cn = new SqlConnection(connectStringTR))
            {
                string sqlCommandText_Master = string.Empty;
                string sqlCommandText_Detail = string.Empty;

                cn.Open();
                value.OrderBy(c => c.CLIENTCODE);
                string tempClientCode = string.Empty;
                string DutyNum = string.Empty;
                string tempItemSEQ = "1";

                SqlCommand updateCmd = new SqlCommand();
                SqlCommand masterCmd = new SqlCommand();

                updateCmd.Connection = cn;
                masterCmd.Connection = cn;

                sqlCommandText_Master = @"
                                    INSERT INTO [TR_DUTYMASTER]
                                       ([CUSTOMERID], [DUTY_NUM], [DUTY_TYPE], [DUTY_GWOEN], [DUTY_HO]
	                                    , [DUTY_SEQ], [MCLIENTNO], [MSANGHO], [MCEONM], [MUPTEA]
	                                    , [MUPJONG], [MADDR], [CLIENTNO], [SANGHO], [CEONM]
	                                    , [UPTEA], [UPJONG], [ADDR], [WDATE], [COST]
	                                    , [VAT], [ETC], [HYUNGUM], [SUPYO], [EOEUM]
	                                    , [MISU], [RECEIPT], [TR_CRE_TIME], [TR_TRA_TIME], [TR_NTS_TIME]
	                                    , [MANAGER], [DEPT], [EMAIL], [TELNO1], [TELNO2]
	                                    , [TELNO3], [MOBIL1], [MOBIL2], [MOBIL3], [TITLE]
	                                    , [TAX_TYPE]
                                        , [MMANAGER], [MDEPT], [MEMAIL], [MTELNO1]
	                                    , [MTELNO2], [MTELNO3], [MMOBIL1], [MMOBIL2], [MMOBIL3]
	                                    , [CHGTYPE], [TRANSDATE], [TR_TEC01], [TR_TEC02], [TR_TEC03]
	                                    , [TR_TEC04], [TR_TEC05], [TR_RSLTSTAT], [TR_NTS_LSTSTAT])
                                    VALUES
                                       (@CUSTOMERID, @DUTY_NUM, @DUTY_TYPE, NULL, NULL
	                                    , NULL, @MCLIENTNO, @MSANGHO, @MCEONM, @MUPTEA
	                                    , @MUPJONG, @MADDR, @CLIENTNO, @SANGHO, @CEONM
	                                    , @UPTEA, @UPJONG, @ADDR, @WDATE, @COST
	                                    , @VAT, NULL, NULL, NULL, NULL
	                                    , NULL, @RECEIPT, NULL, NULL, NULL
	                                    , NULL, NULL, @EMAIL, NULL, NULL
	                                    , NULL, NULL, NULL, NULL, @TITLE
	                                    , CASE WHEN @VAT = 0 THEN '면세' ELSE '과세' END
                                        , NULL, NULL, NULL, NULL
	                                    , NULL, NULL, NULL, NULL, NULL
	                                    , NULL, @TRANSDATE, NULL, NULL, NULL
	                                    , NULL, NULL, NULL, NULL)";

                sqlCommandText_Detail = @"
                                INSERT INTO [TR_DUTYDETAIL]
                                   ([CUSTOMERID], [DUTY_NUM], [ITMSEQ], [ITMMM], [ITMDD]
				                    , [ITMNM], [ITMSIZE], [ITMQTY], [ITMNET], [COST]
				                    , [VAT], [ETC])
                                 VALUES
				                    (@CUSTOMERID, @DUTY_NUM, @ITMSEQ, @ITMMM, @ITMDD
				                    , @ITMNM, NULL, 1, @ITMNET, @COST
				                    , @VAT, NULL)";

                masterCmd.CommandText = sqlCommandText_Master;
                updateCmd.CommandText = sqlCommandText_Detail;

                #region Parameter
                SqlParameter paramDATE = new SqlParameter("@DATE", null);
                SqlParameter paramCUSTOMERID = new SqlParameter("@CUSTOMERID", null);
                SqlParameter paramDUTY_TYPE = new SqlParameter("@DUTY_TYPE", null);
                SqlParameter paramMCLIENTNO = new SqlParameter("@MCLIENTNO", null);
                SqlParameter paramMSANGHO = new SqlParameter("@MSANGHO", null);
                SqlParameter paramMCEONM = new SqlParameter("@MCEONM", null);
                SqlParameter paramMUPTEA = new SqlParameter("@MUPTEA", null);
                SqlParameter paramMUPJONG = new SqlParameter("@MUPJONG", null);
                SqlParameter paramMADDR = new SqlParameter("@MADDR", null);
                SqlParameter paramWDATE = new SqlParameter("@WDATE", null);
                SqlParameter paramTRANSDATE = new SqlParameter("@TRANSDATE", null);
                SqlParameter paramRECEIPT = new SqlParameter("@RECEIPT", null);
                SqlParameter paramITMMM = new SqlParameter("@ITMMM", null);
                SqlParameter paramITMDD = new SqlParameter("@ITMDD", null);
                SqlParameter paramCLIENTNO = new SqlParameter("@CLIENTNO", null);
                SqlParameter paramSANGHO = new SqlParameter("@SANGHO", null);
                SqlParameter paramCEONM = new SqlParameter("@CEONM", null);
                SqlParameter paramUPTEA = new SqlParameter("@UPTEA", null);
                SqlParameter paramUPJONG = new SqlParameter("@UPJONG", null);
                SqlParameter paramADDR = new SqlParameter("@ADDR", null);
                SqlParameter paramCOST = new SqlParameter("@COST", null);
                SqlParameter paramVAT = new SqlParameter("@VAT", null);
                SqlParameter paramEMAIL = new SqlParameter("@EMAIL", null);
                SqlParameter paramITMNM = new SqlParameter("@ITMNM", null);
                SqlParameter paramITMNET = new SqlParameter("@ITMNET", null);
                SqlParameter paramTITLE = new SqlParameter("@TITLE", null);
                SqlParameter paramITMSEQ = new SqlParameter("@ITMSEQ", null);
                SqlParameter paramDUTY_NUM = new SqlParameter("@DUTY_NUM", null);

                masterCmd.Parameters.AddRange(new SqlParameter[] {
                        paramCUSTOMERID, paramDUTY_NUM, paramDUTY_TYPE, 
                        paramMCLIENTNO, paramMSANGHO, paramMCEONM, paramMUPTEA, 
                        paramMUPJONG, paramMADDR ,paramCLIENTNO, paramSANGHO, paramCEONM,
                        paramUPTEA, paramUPJONG, paramADDR, paramWDATE, paramCOST,
                        paramVAT, paramRECEIPT, paramEMAIL, paramTITLE,
                        paramTRANSDATE });

                //paramCUSTOMERID, paramDUTY_NUM, paramITMSEQ, paramITMMM, paramITMDD, paramITMNM, paramITMNET,paramCOST, paramVAT
                SqlParameter de_paramCUSTOMERID = new SqlParameter("@CUSTOMERID", null);
                SqlParameter de_paramDUTY_NUM = new SqlParameter("@DUTY_NUM", null);
                SqlParameter de_paramITMSEQ = new SqlParameter("@ITMSEQ", null);
                SqlParameter de_paramITMMM = new SqlParameter("@ITMMM", null);
                SqlParameter de_paramITMDD = new SqlParameter("@ITMDD", null);
                SqlParameter de_paramITMNM = new SqlParameter("@ITMNM", null);
                SqlParameter de_paramITMNET = new SqlParameter("@ITMNET", null);
                SqlParameter de_paramCOST = new SqlParameter("@COST", null);
                SqlParameter de_paramVAT = new SqlParameter("@VAT", null);

                updateCmd.Parameters.AddRange(new SqlParameter[] {
                        de_paramCUSTOMERID, 
                        de_paramDUTY_NUM, 
                        de_paramITMSEQ, 
                        de_paramITMMM, 
                        de_paramITMDD, 
                        de_paramITMNM, 
                        de_paramITMNET, 
                        de_paramCOST, 
                        de_paramVAT});
                #endregion

                foreach (var item in value)
                {
                    if (DutyNum.Equals("") && tempClientCode != item.CLIENTCODE)
                    {
                        using (SqlConnection cnduty = new SqlConnection(connectStringTR))
                        {
                            SqlCommand companyCmd = new SqlCommand(
                                @"SELECT @DATE + '9' + RIGHT('00000' +	LTRIM(STR(ISNULL(MAX(RIGHT(DUTY_NUM, 5)) + 1, 1))), 5)
                                    FROM	[TR_DUTYMASTER]
                                    WHERE	LEFT(DUTY_NUM, 8) = @DATE", cnduty);
                            companyCmd.Parameters.Add(new SqlParameter("@DATE", item.DATE));
                            cnduty.Open();
                            object o = companyCmd.ExecuteScalar();
                            if (o != null) DutyNum = o.ToString();
                            cnduty.Close();
                        }
                    }

                    if (tempClientCode != "" && tempClientCode != item.CLIENTCODE)
                    {
                        paramCUSTOMERID.Value = tempCUSTOMERID;
                        paramDUTY_NUM.Value = tempDutyNum;
                        paramDUTY_TYPE.Value = tempDUTY_TYPE;
                        paramMCLIENTNO.Value = tempMCLIENTNO;
                        paramMSANGHO.Value = tempMSANGHO;
                        paramMCEONM.Value = tempMCEONM;
                        paramMUPTEA.Value = tempMUPTEA;
                        paramMUPJONG.Value = tempMUPJONG;
                        paramMADDR.Value = tempMADDR;
                        paramCLIENTNO.Value = tempCLIENTNO;
                        paramSANGHO.Value = tempSANGHO;
                        paramCEONM.Value = tempCEONM;
                        paramUPTEA.Value = tempUPTEA;
                        paramUPJONG.Value = tempUPJONG;
                        paramADDR.Value = tempADDR;
                        paramWDATE.Value = tempWDATE;
                        paramCOST.Value = tempCOST;
                        paramVAT.Value = tempVAT;
                        paramRECEIPT.Value = tempRECEIPT;
                        paramEMAIL.Value = tempEMAIL;
                        paramTITLE.Value = tempTITLE;
                        paramTRANSDATE.Value = tempTRANSDATE;

                        masterRowCount = masterCmd.ExecuteNonQuery();
                        _AddText(stream, string.Format("[{0}][EVENT]## 세금계산서", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                        _AddText(stream, string.Format(" - 적용여부 : {0}", masterRowCount > 0 ? "True" : "False"));
                        _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                        _AddText(stream, string.Format(" - 거래처코드 : {0}", item.CLIENTNO));
                        _AddText(stream, string.Format(" - 거래처명 : {0}", item.SANGHO));
                        _AddText(stream, string.Format(" - 단가 : {0}", item.COST));
                        _AddText(stream, string.Format(" - 세금 : {0}", item.VAT));
                        _AddText(stream, "");

                        using (SqlConnection cnduty = new SqlConnection(connectStringTR))
                        {
                            SqlCommand companyCmd = new SqlCommand(
                                @"SELECT @DATE + '9' + RIGHT('00000' +	LTRIM(STR(ISNULL(MAX(RIGHT(DUTY_NUM, 5)) + 1, 1))), 5)
                                    FROM	[TR_DUTYMASTER]
                                    WHERE	LEFT(DUTY_NUM, 8) = @DATE", cnduty);
                            companyCmd.Parameters.Add(new SqlParameter("@DATE", item.DATE));
                            cnduty.Open();
                            object o = companyCmd.ExecuteScalar();
                            if (o != null) DutyNum = o.ToString();
                            cnduty.Close();
                        }
                        //cost, vat, Seq 초기화
                        tempCOST = 0;
                        tempVAT = 0;
                        tempItemSEQ = "1";
                    }

                    //임시 저장
                    tempCUSTOMERID = item.CUSTOMERID;
                    tempDUTY_TYPE = item.DUTY_TYPE;
                    tempMCLIENTNO = item.MCLIENTNO;
                    tempMSANGHO = item.MSANGHO;
                    tempMCEONM = item.MCEONM;
                    tempMUPTEA = item.MUPTEA;
                    tempMUPJONG = item.MUPJONG;
                    tempMADDR = item.MADDR;
                    tempCLIENTNO = item.CLIENTNO;
                    tempSANGHO = item.SANGHO;
                    tempCEONM = item.CEONM;
                    tempUPTEA = item.UPTEA;
                    tempUPJONG = item.UPJONG;
                    tempADDR = item.ADDR;
                    tempWDATE = item.WDATE;
                    tempCOST += decimal.Parse(item.COST);
                    tempVAT += decimal.Parse(item.VAT);
                    tempRECEIPT = item.RECEIPT;
                    tempEMAIL = item.EMAIL;
                    tempTITLE = item.TITLE;
                    tempTRANSDATE = item.TRANSDATE;
                    tempDutyNum = DutyNum;
                    //거래처 코드 저장
                    tempClientCode = item.CLIENTCODE;

                    de_paramCUSTOMERID.Value = item.CUSTOMERID;
                    de_paramITMMM.Value = item.ITMMM;
                    de_paramITMDD.Value = item.ITMDD;
                    de_paramDUTY_NUM.Value = DutyNum;
                    de_paramCOST.Value = item.COST;
                    de_paramVAT.Value = item.VAT;
                    de_paramITMNM.Value = item.ITMNM;
                    de_paramITMNET.Value = item.ITMNET;

                    de_paramITMSEQ.Value = paramITMSEQ.Value = tempItemSEQ;

                    tempItemSEQ = (int.Parse(tempItemSEQ) + 1).ToString();

                    int i = updateCmd.ExecuteNonQuery();

                    _AddText(stream, string.Format("[{0}][EVENT]## 세금계산서", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                    _AddText(stream, string.Format(" - 적용여부 : {0}", i > 0 ? "True" : "False"));
                    _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                    _AddText(stream, string.Format(" - 거래처코드 : {0}", item.CLIENTNO));
                    _AddText(stream, string.Format(" - 거래처명 : {0}", item.SANGHO));
                    _AddText(stream, string.Format(" - 단가 : {0}", item.COST));
                    _AddText(stream, string.Format(" - 세금 : {0}", item.VAT));
                    _AddText(stream, "");
                }
                //마지막 데이터 저장 
                paramCUSTOMERID.Value = tempCUSTOMERID;
                paramDUTY_NUM.Value = tempDutyNum;
                paramDUTY_TYPE.Value = tempDUTY_TYPE;
                paramMCLIENTNO.Value = tempMCLIENTNO;
                paramMSANGHO.Value = tempMSANGHO;
                paramMCEONM.Value = tempMCEONM;
                paramMUPTEA.Value = tempMUPTEA;
                paramMUPJONG.Value = tempMUPJONG;
                paramMADDR.Value = tempMADDR;
                paramCLIENTNO.Value = tempCLIENTNO;
                paramSANGHO.Value = tempSANGHO;
                paramCEONM.Value = tempCEONM;
                paramUPTEA.Value = tempUPTEA;
                paramUPJONG.Value = tempUPJONG;
                paramADDR.Value = tempADDR;
                paramWDATE.Value = tempWDATE;
                paramCOST.Value = tempCOST;
                paramVAT.Value = tempVAT;
                paramRECEIPT.Value = tempRECEIPT;
                paramEMAIL.Value = tempEMAIL;
                paramTITLE.Value = tempTITLE;
                paramTRANSDATE.Value = tempTRANSDATE;

                masterRowCount = masterCmd.ExecuteNonQuery();
                _AddText(stream, string.Format("[{0}][EVENT]## 세금계산서", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                _AddText(stream, string.Format(" - 적용여부 : {0}", masterRowCount > 0 ? "True" : "False"));
                _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                _AddText(stream, string.Format(" - 거래처코드 : {0}", tempCLIENTNO));
                _AddText(stream, string.Format(" - 거래처명 : {0}", tempSANGHO));
                _AddText(stream, string.Format(" - 단가 : {0}", tempCOST));
                _AddText(stream, string.Format(" - 세금 : {0}", tempVAT));
                _AddText(stream, "");
                cn.Close();
            }
            errString = iSuccess.ToString();
        }
        catch (Exception E)
        {
            errString = iSuccess.ToString() + "|" + E.Message;
            r = false;
        }
        _AddText(stream, string.Format("[{0}][EVENT]## Connection Close", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, "");
        try
        {
            stream.Close();
            stream.Dispose();
        }
        catch { }
        return r;
    }

	public ETAX[] ETaxIntegrationReturn(ETAX[] value, out string errString, bool check)
    {
        errString = "";
        int iSuccess = 0;
        List<ETAX> returnEtax = new List<ETAX>();
        if (value.Length <= 0)
        {
            return null;
        }
        FileStream stream = _GetLogFile();
        OperationContext context = OperationContext.Current;
        MessageProperties messageProperties = context.IncomingMessageProperties;
        RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name]
        as RemoteEndpointMessageProperty;
        _AddText(stream, string.Format("[{0}][EVENT]## Client Connected", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, string.Format(" - IP : {0}", endpointProperty.Address));
        _AddText(stream, "");
        _AddText(stream, string.Format("[{0}][EVENT]## Datat Receive OK !!!", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));

        int masterRowCount = 0;
        string tcode = string.Empty;
        string company = string.Empty;
        string count = string.Empty;
        string idx = value[0].IDX;
        decimal tempCOST, tempVAT;
        tempCOST = tempVAT = 0;
        string tempCUSTOMERID, tempDutyNum, tempDUTY_TYPE,
                tempMCLIENTNO, tempMSANGHO, tempMCEONM, tempMUPTEA,
                tempMUPJONG, tempMADDR, tempCLIENTNO, tempSANGHO, tempCEONM,
                tempUPTEA, tempUPJONG, tempADDR, tempWDATE,
                tempRECEIPT, tempEMAIL, tempTITLE,
                tempTRANSDATE;
        tempCUSTOMERID = tempDutyNum = tempDUTY_TYPE = tempMCLIENTNO = tempMSANGHO = tempMCEONM = tempMUPTEA =
                tempMUPJONG = tempMADDR = tempCLIENTNO = tempSANGHO = tempCEONM =
                tempUPTEA = tempUPJONG = tempADDR = tempWDATE =
                tempRECEIPT = tempEMAIL = tempTITLE =
                tempTRANSDATE = string.Empty;

        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand tcodeCmd = new SqlCommand(
                @"SELECT tcode FROM tb_company WHERE idx = @idx", cn);
            tcodeCmd.Parameters.Add(new SqlParameter("@idx", idx));
            cn.Open();
            object o = tcodeCmd.ExecuteScalar();
            if (o != null) tcode = o.ToString();
            cn.Close();
        }
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand companyCmd = new SqlCommand(
                @"SELECT comname FROM tb_company WHERE idx = @idx AND tcode = @tcode", cn);
            companyCmd.Parameters.Add(new SqlParameter("@idx", idx));
            companyCmd.Parameters.Add(new SqlParameter("@tcode", tcode));
            cn.Open();
            object o = companyCmd.ExecuteScalar();
            if (o != null) company = o.ToString();
            cn.Close();
        }
        count = value.Length.ToString();
        _AddText(stream, string.Format(" - 체인본부코드 : {0}", tcode));
        _AddText(stream, string.Format(" - 체인본부 명  : {0}", company));
        _AddText(stream, string.Format(" - 데이터 건수  : {0}", count));
        _AddText(stream, "");
        try
        {
            using (SqlConnection cn = new SqlConnection(connectStringTR))
            {
                string sqlCommandText_Master = string.Empty;
                string sqlCommandText_Detail = string.Empty;
                string sqlCommandText_MaxDuty = string.Empty;

                cn.Open();
                value.OrderBy(c => c.CLIENTCODE);
                string tempClientCode = string.Empty;
                string DutyNum = string.Empty;
                string tempItemSEQ = "1";

                SqlCommand updateCmd = new SqlCommand();
                SqlCommand masterCmd = new SqlCommand();

                updateCmd.Connection = cn;
                masterCmd.Connection = cn;

                sqlCommandText_Master = @"
                                    INSERT INTO [TR_DUTYMASTER]
                                       ([CUSTOMERID], [DUTY_NUM], [DUTY_TYPE], [DUTY_GWOEN], [DUTY_HO]
	                                    , [DUTY_SEQ], [MCLIENTNO], [MSANGHO], [MCEONM], [MUPTEA]
	                                    , [MUPJONG], [MADDR], [CLIENTNO], [SANGHO], [CEONM]
	                                    , [UPTEA], [UPJONG], [ADDR], [WDATE], [COST]
	                                    , [VAT], [ETC], [HYUNGUM], [SUPYO], [EOEUM]
	                                    , [MISU], [RECEIPT], [TR_CRE_TIME], [TR_TRA_TIME], [TR_NTS_TIME]
	                                    , [MANAGER], [DEPT], [EMAIL], [TELNO1], [TELNO2]
	                                    , [TELNO3], [MOBIL1], [MOBIL2], [MOBIL3], [TITLE]
	                                    , [TAX_TYPE]
                                        , [MMANAGER], [MDEPT], [MEMAIL], [MTELNO1]
	                                    , [MTELNO2], [MTELNO3], [MMOBIL1], [MMOBIL2], [MMOBIL3]
	                                    , [CHGTYPE], [TRANSDATE], [TR_TEC01], [TR_TEC02], [TR_TEC03]
	                                    , [TR_TEC04], [TR_TEC05], [TR_RSLTSTAT], [TR_NTS_LSTSTAT])
                                    VALUES
                                       (@CUSTOMERID, @DUTY_NUM, @DUTY_TYPE, NULL, NULL
	                                    , NULL, @MCLIENTNO, @MSANGHO, @MCEONM, @MUPTEA
	                                    , @MUPJONG, @MADDR, @CLIENTNO, @SANGHO, @CEONM
	                                    , @UPTEA, @UPJONG, @ADDR, @WDATE, @COST
	                                    , @VAT, NULL, NULL, NULL, NULL
	                                    , NULL, @RECEIPT, NULL, NULL, NULL
	                                    , NULL, NULL, @EMAIL, NULL, NULL
	                                    , NULL, NULL, NULL, NULL, @TITLE
	                                    , CASE WHEN @VAT = 0 THEN '면세' ELSE '과세' END
                                        , NULL, NULL, NULL, NULL
	                                    , NULL, NULL, NULL, NULL, NULL
	                                    , NULL, @TRANSDATE, NULL, NULL, NULL
	                                    , NULL, NULL, NULL, NULL)";

                sqlCommandText_Detail = @"
                                INSERT INTO [TR_DUTYDETAIL]
                                   ([CUSTOMERID], [DUTY_NUM], [ITMSEQ], [ITMMM], [ITMDD]
				                    , [ITMNM], [ITMSIZE], [ITMQTY], [ITMNET], [COST]
				                    , [VAT], [ETC])
                                 VALUES
				                    (@CUSTOMERID, @DUTY_NUM, @ITMSEQ, @ITMMM, @ITMDD
				                    , @ITMNM, NULL, 1, @ITMNET, @COST
				                    , @VAT, NULL)";

                sqlCommandText_MaxDuty = @"SELECT @DATE + '9' + RIGHT('00000' +	LTRIM(STR(ISNULL(MAX(RIGHT(DUTY_NUM, 5)) + 1, 1))), 5)
                                    FROM	[TR_DUTYMASTER]
                                    WHERE	LEFT(DUTY_NUM, 8) = @DATE";

                masterCmd.CommandText = (check) ? sqlCommandText_Master.Replace("[TR_DUTYMASTER]", "[CM_DUTYMASTER]") : sqlCommandText_Master;
                updateCmd.CommandText = (check) ? sqlCommandText_Detail.Replace("[TR_DUTYDETAIL]", "[CM_DUTYDETAIL]") : sqlCommandText_Detail;
                sqlCommandText_MaxDuty = (check) ? sqlCommandText_MaxDuty.Replace("[TR_DUTYMASTER]", "[CM_DUTYMASTER]") : sqlCommandText_MaxDuty;

                #region Parameter
                SqlParameter paramDATE = new SqlParameter("@DATE", null);
                SqlParameter paramCUSTOMERID = new SqlParameter("@CUSTOMERID", null);
                SqlParameter paramDUTY_TYPE = new SqlParameter("@DUTY_TYPE", null);
                SqlParameter paramMCLIENTNO = new SqlParameter("@MCLIENTNO", null);
                SqlParameter paramMSANGHO = new SqlParameter("@MSANGHO", null);
                SqlParameter paramMCEONM = new SqlParameter("@MCEONM", null);
                SqlParameter paramMUPTEA = new SqlParameter("@MUPTEA", null);
                SqlParameter paramMUPJONG = new SqlParameter("@MUPJONG", null);
                SqlParameter paramMADDR = new SqlParameter("@MADDR", null);
                SqlParameter paramWDATE = new SqlParameter("@WDATE", null);
                SqlParameter paramTRANSDATE = new SqlParameter("@TRANSDATE", null);
                SqlParameter paramRECEIPT = new SqlParameter("@RECEIPT", null);
                SqlParameter paramITMMM = new SqlParameter("@ITMMM", null);
                SqlParameter paramITMDD = new SqlParameter("@ITMDD", null);
                SqlParameter paramCLIENTNO = new SqlParameter("@CLIENTNO", null);
                SqlParameter paramSANGHO = new SqlParameter("@SANGHO", null);
                SqlParameter paramCEONM = new SqlParameter("@CEONM", null);
                SqlParameter paramUPTEA = new SqlParameter("@UPTEA", null);
                SqlParameter paramUPJONG = new SqlParameter("@UPJONG", null);
                SqlParameter paramADDR = new SqlParameter("@ADDR", null);
                SqlParameter paramCOST = new SqlParameter("@COST", null);
                SqlParameter paramVAT = new SqlParameter("@VAT", null);
                SqlParameter paramEMAIL = new SqlParameter("@EMAIL", null);
                SqlParameter paramITMNM = new SqlParameter("@ITMNM", null);
                SqlParameter paramITMNET = new SqlParameter("@ITMNET", null);
                SqlParameter paramTITLE = new SqlParameter("@TITLE", null);
                SqlParameter paramITMSEQ = new SqlParameter("@ITMSEQ", null);
                SqlParameter paramDUTY_NUM = new SqlParameter("@DUTY_NUM", null);

                masterCmd.Parameters.AddRange(new SqlParameter[] {
                        paramCUSTOMERID, paramDUTY_NUM, paramDUTY_TYPE, 
                        paramMCLIENTNO, paramMSANGHO, paramMCEONM, paramMUPTEA, 
                        paramMUPJONG, paramMADDR ,paramCLIENTNO, paramSANGHO, paramCEONM,
                        paramUPTEA, paramUPJONG, paramADDR, paramWDATE, paramCOST,
                        paramVAT, paramRECEIPT, paramEMAIL, paramTITLE,
                        paramTRANSDATE });

                //paramCUSTOMERID, paramDUTY_NUM, paramITMSEQ, paramITMMM, paramITMDD, paramITMNM, paramITMNET,paramCOST, paramVAT
                SqlParameter de_paramCUSTOMERID = new SqlParameter("@CUSTOMERID", null);
                SqlParameter de_paramDUTY_NUM = new SqlParameter("@DUTY_NUM", null);
                SqlParameter de_paramITMSEQ = new SqlParameter("@ITMSEQ", null);
                SqlParameter de_paramITMMM = new SqlParameter("@ITMMM", null);
                SqlParameter de_paramITMDD = new SqlParameter("@ITMDD", null);
                SqlParameter de_paramITMNM = new SqlParameter("@ITMNM", null);
                SqlParameter de_paramITMNET = new SqlParameter("@ITMNET", null);
                SqlParameter de_paramCOST = new SqlParameter("@COST", null);
                SqlParameter de_paramVAT = new SqlParameter("@VAT", null);

                updateCmd.Parameters.AddRange(new SqlParameter[] {
                        de_paramCUSTOMERID, 
                        de_paramDUTY_NUM, 
                        de_paramITMSEQ, 
                        de_paramITMMM, 
                        de_paramITMDD, 
                        de_paramITMNM, 
                        de_paramITMNET, 
                        de_paramCOST, 
                        de_paramVAT});
                #endregion

                foreach (var item in value)
                {
                    if (DutyNum.Equals("") && tempClientCode != item.CLIENTCODE)
                    {
                        using (SqlConnection cnduty = new SqlConnection(connectStringTR))
                        {
                            SqlCommand companyCmd = new SqlCommand();
                            companyCmd.Connection = cnduty;
                            companyCmd.CommandText = sqlCommandText_MaxDuty;
                            companyCmd.Parameters.Add(new SqlParameter("@DATE", item.DATE));
                            cnduty.Open();
                            object o = companyCmd.ExecuteScalar();
                            if (o != null) DutyNum = o.ToString();
                            cnduty.Close();
                        }
                    }

                    if (tempClientCode != "" && tempClientCode != item.CLIENTCODE)
                    {
                        paramCUSTOMERID.Value = tempCUSTOMERID;
                        paramDUTY_NUM.Value = tempDutyNum;
                        paramDUTY_TYPE.Value = tempDUTY_TYPE;
                        paramMCLIENTNO.Value = tempMCLIENTNO;
                        paramMSANGHO.Value = tempMSANGHO;
                        paramMCEONM.Value = tempMCEONM;
                        paramMUPTEA.Value = tempMUPTEA;
                        paramMUPJONG.Value = tempMUPJONG;
                        paramMADDR.Value = tempMADDR;
                        paramCLIENTNO.Value = tempCLIENTNO;
                        paramSANGHO.Value = tempSANGHO;
                        paramCEONM.Value = tempCEONM;
                        paramUPTEA.Value = tempUPTEA;
                        paramUPJONG.Value = tempUPJONG;
                        paramADDR.Value = tempADDR;
                        paramWDATE.Value = tempWDATE;
                        paramCOST.Value = tempCOST;
                        paramVAT.Value = tempVAT;
                        paramRECEIPT.Value = tempRECEIPT;
                        paramEMAIL.Value = tempEMAIL;
                        paramTITLE.Value = tempTITLE;
                        paramTRANSDATE.Value = tempTRANSDATE;

                        masterRowCount = masterCmd.ExecuteNonQuery();
                        _AddText(stream, string.Format("[{0}][EVENT]## 세금계산서", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                        _AddText(stream, string.Format(" - 적용여부 : {0}", masterRowCount > 0 ? "True" : "False"));
                        _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                        _AddText(stream, string.Format(" - 거래처코드 : {0}", item.CLIENTNO));
                        _AddText(stream, string.Format(" - 거래처명 : {0}", item.SANGHO));
                        _AddText(stream, string.Format(" - 단가 : {0}", item.COST));
                        _AddText(stream, string.Format(" - 세금 : {0}", item.VAT));
                        _AddText(stream, "");

                        using (SqlConnection cnduty = new SqlConnection(connectStringTR))
                        {
                            SqlCommand companyCmd = new SqlCommand();
                            companyCmd.Connection = cnduty;
                            companyCmd.CommandText = sqlCommandText_MaxDuty;
                            companyCmd.Parameters.Add(new SqlParameter("@DATE", item.DATE));
                            cnduty.Open();
                            object o = companyCmd.ExecuteScalar();
                            if (o != null) DutyNum = o.ToString();
                            cnduty.Close();
                        }

                        returnEtax.Add(new ETAX() { CUSTOMERID = item.CUSTOMERID, 
                            DUTY_TYPE = item.DUTY_TYPE, 
                            DUTYNUM = tempDutyNum, 
                            MCLIENTNO = item.MCLIENTNO,
                            MSANGHO = item.MSANGHO,
                            MCEONM = item.MCEONM,
                            MUPTEA = item.MUPTEA,
                            MUPJONG = item.MUPJONG,
                            MADDR = item.MADDR,
                            CLIENTNO = item.CLIENTNO,
                            SANGHO = item.SANGHO,
                            CEONM = item.CEONM,
                            UPTEA = item.UPTEA,
                            UPJONG = item.UPJONG,
                            ADDR = item.ADDR,
                            WDATE = item.WDATE,
                            COST = tempCOST.ToString(),
                            VAT = tempVAT.ToString(),
                            RECEIPT = item.RECEIPT,
                            EMAIL = item.EMAIL,
                            TITLE = item.TITLE, 
                            CLIENTCODE = item.CLIENTCODE
                            });
                        //cost, vat, Seq 초기화
                        tempCOST = 0;
                        tempVAT = 0;
                        tempItemSEQ = "1";
                    }

                    //임시 저장
                    tempCUSTOMERID = item.CUSTOMERID;
                    tempDUTY_TYPE = item.DUTY_TYPE;
                    tempMCLIENTNO = item.MCLIENTNO;
                    tempMSANGHO = item.MSANGHO;
                    tempMCEONM = item.MCEONM;
                    tempMUPTEA = item.MUPTEA;
                    tempMUPJONG = item.MUPJONG;
                    tempMADDR = item.MADDR;
                    tempCLIENTNO = item.CLIENTNO;
                    tempSANGHO = item.SANGHO;
                    tempCEONM = item.CEONM;
                    tempUPTEA = item.UPTEA;
                    tempUPJONG = item.UPJONG;
                    tempADDR = item.ADDR;
                    tempWDATE = item.WDATE;
                    tempCOST += decimal.Parse(item.COST);
                    tempVAT += decimal.Parse(item.VAT);
                    tempRECEIPT = item.RECEIPT;
                    tempEMAIL = item.EMAIL;
                    tempTITLE = item.TITLE;
                    tempTRANSDATE = item.TRANSDATE;
                    tempDutyNum = DutyNum;
                    //거래처 코드 저장
                    tempClientCode = item.CLIENTCODE;

                    de_paramCUSTOMERID.Value = item.CUSTOMERID;
                    de_paramITMMM.Value = item.ITMMM;
                    de_paramITMDD.Value = item.ITMDD;
                    de_paramDUTY_NUM.Value = DutyNum;
                    de_paramCOST.Value = item.COST;
                    de_paramVAT.Value = item.VAT;
                    de_paramITMNM.Value = item.ITMNM;
                    de_paramITMNET.Value = item.ITMNET;

                    de_paramITMSEQ.Value = paramITMSEQ.Value = tempItemSEQ;

                    tempItemSEQ = (int.Parse(tempItemSEQ) + 1).ToString();

                    int i = updateCmd.ExecuteNonQuery();

                    _AddText(stream, string.Format("[{0}][EVENT]## 세금계산서", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                    _AddText(stream, string.Format(" - 적용여부 : {0}", i > 0 ? "True" : "False"));
                    _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                    _AddText(stream, string.Format(" - 거래처코드 : {0}", item.CLIENTNO));
                    _AddText(stream, string.Format(" - 거래처명 : {0}", item.SANGHO));
                    _AddText(stream, string.Format(" - 단가 : {0}", item.COST));
                    _AddText(stream, string.Format(" - 세금 : {0}", item.VAT));
                    _AddText(stream, "");
                }
                //마지막 데이터 저장 
                paramCUSTOMERID.Value = tempCUSTOMERID;
                paramDUTY_NUM.Value = tempDutyNum;
                paramDUTY_TYPE.Value = tempDUTY_TYPE;
                paramMCLIENTNO.Value = tempMCLIENTNO;
                paramMSANGHO.Value = tempMSANGHO;
                paramMCEONM.Value = tempMCEONM;
                paramMUPTEA.Value = tempMUPTEA;
                paramMUPJONG.Value = tempMUPJONG;
                paramMADDR.Value = tempMADDR;
                paramCLIENTNO.Value = tempCLIENTNO;
                paramSANGHO.Value = tempSANGHO;
                paramCEONM.Value = tempCEONM;
                paramUPTEA.Value = tempUPTEA;
                paramUPJONG.Value = tempUPJONG;
                paramADDR.Value = tempADDR;
                paramWDATE.Value = tempWDATE;
                paramCOST.Value = tempCOST;
                paramVAT.Value = tempVAT;
                paramRECEIPT.Value = tempRECEIPT;
                paramEMAIL.Value = tempEMAIL;
                paramTITLE.Value = tempTITLE;
                paramTRANSDATE.Value = tempTRANSDATE;

                returnEtax.Add(new ETAX()
                {
                    CUSTOMERID = tempCUSTOMERID,
                    DUTY_TYPE = tempDUTY_TYPE,
                    DUTYNUM = tempDutyNum,
                    MCLIENTNO = tempMCLIENTNO,
                    MSANGHO = tempMSANGHO,
                    MCEONM = tempMCEONM,
                    MUPTEA = tempMUPTEA,
                    MUPJONG = tempMUPJONG,
                    MADDR = tempMADDR,
                    CLIENTNO = tempCLIENTNO,
                    SANGHO = tempSANGHO,
                    CEONM = tempCEONM,
                    UPTEA = tempUPTEA,
                    UPJONG = tempUPJONG,
                    ADDR = tempADDR,
                    WDATE = tempWDATE,
                    COST = tempCOST.ToString(),
                    VAT = tempVAT.ToString(),
                    RECEIPT = tempRECEIPT,
                    EMAIL = tempEMAIL,
                    TITLE = tempTITLE
                });

                masterRowCount = masterCmd.ExecuteNonQuery();
                _AddText(stream, string.Format("[{0}][EVENT]## 세금계산서", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                _AddText(stream, string.Format(" - 적용여부 : {0}", masterRowCount > 0 ? "True" : "False"));
                _AddText(stream, string.Format(" - 업체코드 : {0}", tcode));
                _AddText(stream, string.Format(" - 거래처코드 : {0}", tempCLIENTNO));
                _AddText(stream, string.Format(" - 거래처명 : {0}", tempSANGHO));
                _AddText(stream, string.Format(" - 단가 : {0}", tempCOST));
                _AddText(stream, string.Format(" - 세금 : {0}", tempVAT));
                _AddText(stream, "");
                cn.Close();
            }
            errString = iSuccess.ToString();
        }
        catch (Exception E)
        {
            errString = iSuccess.ToString() + "|" + E.Message;
            value = null;
        }
        _AddText(stream, string.Format("[{0}][EVENT]## Connection Close", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
        _AddText(stream, "");
        try
        {
            stream.Close();
            stream.Dispose();
        }
        catch { }
        return returnEtax.ToArray();
    }

    public bool ServiceFlag_new(string companyidx)
    {
        bool result = true;
        string insertString =
        @"select serviceflag from tb_company
		where idx = @companyidx";
        using (SqlConnection cn = new SqlConnection(connectString))
        {
            SqlCommand insertCmd = new SqlCommand(insertString, cn);
            insertCmd.Parameters.Add(new SqlParameter("@companyidx", companyidx));
            try
            {
                cn.Open();
                object value = insertCmd.ExecuteScalar();
                if (value != null)
                {
                    if (value.ToString() == "4")
                        result = false;
                }
                else
                    result = false;
            }
            catch (Exception)
            {
                result = false;
            }
            finally { cn.Close(); }
        }
        return result;
    }
    
}





