<!-- #include file = "./DBConnect.inc"  -->
<%
officenum = session("sessionid")

if Request("page")="" then
	curpage=1
else
	curpage=cint(Request("page"))
end if

if Request("startpage")="" then
	startpage=1
else
	startpage=cint(Request("startpage"))
end if

ipp=10
ten=5

yea=YEAR(NOW)
mon=MONTH(NOW)
pre_yea=yea-1
pre_mon=mon-1
if pre_mon < 10 then
	pre_mon= "0" & pre_mon
end if
if mon < 10 then
	mon= "0" & mon
end if

cur_log=yea & mon
if mon = "01" then
	prev_log=pre_yea & pre_mon
else
	prev_log=yea & pre_mon
end if

Response.Write DateAdd("d",-1,day(NOW)) & "<br>" '이건 그 전의 날짜
Response.Write DateAdd("m",-1,MONTH(NOW)) & "<br>" '이건 그 전의 달
Response.Write DateAdd("y",-1,Now()) & "<br>" '그 뒤의 날입니다..

sql = "if not exists (select * from dbo.sysobjects where id = object_id(N'[yoohw].[em_log_" & cur_log & "]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) CREATE TABLE em_log_" & cur_log & " (tran_pr int NOT NULL identity(1,1),	tran_refkey varchar(20) default NULL,	tran_id varchar(20) default NULL, tran_phone varchar(15) NOT NULL default '', tran_callback varchar(15) default NULL, tran_status char(1) default NULL, tran_date datetime NOT NULL default '0000-00-00 00:00:00', tran_rstdate datetime default NULL, tran_reportdate datetime default NULL, tran_rslt char(1) default NULL, tran_msg varchar(255) default NULL, tran_etc1 varchar(64) default NULL, tran_etc2 varchar(16) default NULL, tran_etc3 varchar(16) default NULL, tran_etc4 int default NULL, tran_type int NOT NULL default '0', PRIMARY KEY (tran_pr))"
set rs = DBConn.Execute(sql)

Set DbRec=Server.CreateObject("ADODB.Recordset")
DbRec.CursorType=1
DbRec.Open "SELECT tran_date, tran_msg, tran_etc1, tran_etc4 FROM em_log_" & cur_log & " WHERE tran_id = '" & officenum & "' AND tran_pr=tran_etc4 AND tran_date <= getdate() AND ( tran_etc3 IS NULL or SUBSTRING(tran_etc3,3,1) <> 'D') order by tran_etc4 ASC", DBConn

if DbRec.BOF or DbRec.EOF then
%>
없다%%
<%else%>
있다..
<%end if%>
<%=yea%><br>
<%=pre_yea%><br>
<%=mon%><br>
<%=pre_mon%><br>
