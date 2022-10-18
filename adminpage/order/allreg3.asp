<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")

	imsiuid1 = mid(session("Ausercode"),1,5)
	imsiuid2 = mid(session("Ausercode"),6,5)
	imsiuid3 = mid(session("Ausercode"),11,5)

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select max(deflagday) "
	SQL = sql & " from tb_order"
	SQL = sql & " where substring(usercode,1,5) = '"& imsiuid1 &"' "

	if imsiuid2<>"" then
		SQL = sql & " and substring(usercode,6,5) = '"& imsiuid2 &"' "
	end if

	if imsiuid3<>"" then
		SQL = sql & " and substring(usercode,11,5) = '"& imsiuid3 &"' "
	end if

'	if searchd <> "" then
'		SQL = sql & " and orderday >= '"& searchd &"' "
'	end if

'	if searche <> "" then
'		SQL = sql & " and orderday <= '"& searche &"' "
'	end if

'	if searchg<>"0" then
'		SQL = sql & " and  carname = '"& searchg &"' "
'	end if

	SQL = sql & " and flag = 'y' and deflag = 'y' "
	rs.Open sql, db, 1
	if not rs.eof then
		deflagday = rs(0)
	else
		deflagday = ""
	end if
	rs.close


if deflagday <> "" then
	'set rs = server.CreateObject("ADODB.Recordset")
	'SQL = " select idx,usercode,ordermoney "
	SQL = " select idx "
	SQL = sql & " from tb_order"
	SQL = sql & " where substring(usercode,1,5) = '"& imsiuid1 &"' "

	if imsiuid2<>"" then
		SQL = sql & " and substring(usercode,6,5) = '"& imsiuid2 &"' "
	end if

	if imsiuid3<>"" then
		SQL = sql & " and substring(usercode,11,5) = '"& imsiuid3 &"' "
	end if

	SQL = sql & " and deflagday = '"& deflagday &"' "

'	if searchd <> "" then
'		SQL = sql & " and orderday >= '"& searchd &"' "
'	end if

'	if searche <> "" then
'		SQL = sql & " and orderday <= '"& searche &"' "
'	end if

'	if searchg<>"0" then
'		SQL = sql & " and  carname = '"& searchg &"' "
'	end if

	SQL = sql & " and flag = 'y' and deflag = 'y' "
	'rs.Open sql, db, 1
	imsisql = sql

	'do until rs.eof
		SQL = "update tb_order set "
		SQL = SQL & " flag = 'y' ,"
		SQL = SQL & " deflag = 'n' ,"
		SQL = SQL & " deflagday = '' ,"
		SQL = SQL & " edate = '"& now() &"', "
		SQL = SQL & " euserid = '"& session("Auserid") &"' "
		'SQL = SQL & " where idx = '"& rs(0) &"' "
		SQL = SQL & " where idx in ("& imsisql &") "
		db.Execute SQL

	'rs.movenext
	'loop
	'rs.close

	response.redirect "list.asp?gotopage="&gotopage&"&searche="&searche&"&searchd="&searchd&"&searchg="&searchg&"&fclass1="&fclass1&"&sclass2="&sclass2&"&tclass3="&tclass3&"&searchc="&searchc&"&searchf="&searchf&"&searchh="&searchh
else
%>

	<script language="javascript">
		alert("해당 데이타가 없습니다.")
		history.go(-1);
	</script>

<%
end if
%>
