<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	userid = replace(request("userid"),"'","''")
	idx = request("idx")

	set rs = server.createobject("adodb.recordset")
	sql = "select count(idx) from tb_adminuser where userid = '"& userid &"'"
	rs.open sql, db, 1
	imsicount = rs(0)
	rs.close
	if idx<>"" then
		imsicount=0
	end if

if imsicount=0 then

	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")

	gotopage = request("gotopage")
	dflag = request("dflag")
	flag = request("flag")

	username = replace(request("username"),"'","''")
	userpwd = replace(request("userpwd"),"'","''")
	alevel = replace(request("alevel"),"'","''")
	if alevel="" then
		alevel = "n"
	end if
	usercode = request("usercode")

	buse = replace(request("buse"),"'","''")
	jik = replace(request("jik"),"'","''")
	tel1 = replace(request("tel1"),"'","''")
	tel2 = replace(request("tel2"),"'","''")
	tel3 = replace(request("tel3"),"'","''")
	hp1 = replace(request("hp1"),"'","''")
	hp2 = replace(request("hp2"),"'","''")
	hp3 = replace(request("hp3"),"'","''")
	email = replace(request("email"),"'","''")

    blevel = request("blevel")

    if blevel="" then
		blevel = ""
	end if


	select case idx
		case ""

			SQL = "INSERT INTO tb_adminuser(usercode,flag,userid,username,userpwd,alevel,buse,jik,tel1,tel2,tel3,hp1,hp2,hp3,email,wdate,wuserid,blevel) VALUES "
			SQL = SQL & " ('"& usercode &"',"
			SQL = SQL & " '"& int(session("Ausergubun")+1) &"',"
			SQL = SQL & " '"& userid &"',"
			SQL = SQL & " '"& username &"',"
			SQL = SQL & " '"& userpwd &"',"
			SQL = SQL & " '"& alevel &"',"
			SQL = SQL & " '"& buse &"',"
			SQL = SQL & " '"& jik &"',"
			SQL = SQL & " '"& tel1 &"',"
			SQL = SQL & " '"& tel2 &"',"
			SQL = SQL & " '"& tel3 &"',"
			SQL = SQL & " '"& hp1 &"',"
			SQL = SQL & " '"& hp2 &"',"
			SQL = SQL & " '"& hp3 &"',"
			SQL = SQL & " '"& email &"',"
			SQL = SQL & " '"& now() &"', "
			SQL = SQL & " '"& session("Auserid") &"',"
            SQL = SQL & " '"& blevel &"' )"
			db.Execute SQL

		case else
			select case dflag
				case ""
					SQL = "update tb_adminuser set "
					SQL = SQL & " userpwd = '"& userpwd &"' ,"
					SQL = SQL & " username = '"& username &"' ,"
					SQL = SQL & " buse = '"& buse &"' ,"
					SQL = SQL & " jik = '"& jik &"' ,"

					SQL = SQL & " tel1 = '"& tel1 &"' ,"
					SQL = SQL & " tel2 = '"& tel2 &"' ,"
					SQL = SQL & " tel3 = '"& tel3 &"' ,"
					SQL = SQL & " hp1 = '"& hp1 &"' ,"
					SQL = SQL & " hp2 = '"& hp2 &"' ,"
					SQL = SQL & " hp3 = '"& hp3 &"' ,"
					SQL = SQL & " email = '"& email &"' ,"
					SQL = SQL & " alevel = '"& alevel &"' ,"
					SQL = SQL & " edate = '"& now() &"', "
					SQL = SQL & " euserid = '"& session("Auserid") &"', "
                    SQL = SQL & " blevel = '"& blevel &"' "
					SQL = SQL & " where idx = "& idx
					db.Execute SQL
				case "1"
					SQL = "delete tb_adminuser "
					SQL = SQL & " where idx = "& idx
					db.Execute SQL
			end select

	end select

	db.close
	set db=nothing
	response.redirect "ulist.asp?flag="&flag&"&gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd&"&searche="&searche&"&searchf="&searchf&"&searchg="&searchg&"&fclass1="&s_fclass1&"&sclass2="&s_sclass2&"&tclass3="&s_tclass3 

else
%>
	<script language="javascript">
		alert("아이디가 중복됩니다.\n\n다른 아이디를 입력하여 주십시요.")
		history.go(-1);
	</script>
<%
end if
%>
