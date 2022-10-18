<!--#include virtual="/fileup2.asp"-->
<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	userid = replace(upload("userid"),"'","''")
	idx = upload("idx")

	set rs = server.createobject("adodb.recordset")
	sql = "select count(idx) from tb_adminuser where userid = '"& userid &"'"
	rs.open sql, db, 1
	imsicount = rs(0)
	rs.close
	if idx<>"" then
		imsicount=0
	end if

if imsicount=0 then

	searcha = upload("searcha")
	searchb = upload("searchb")
	searchc = upload("searchc")
	searchd = upload("searchd")
	searche = upload("searche")
	searchf = upload("searchf")
	searchg = upload("searchg")

	gotopage = upload("gotopage")
	dflag = upload("dflag")
	flag = upload("flag")

	username = replace(upload("username"),"'","''")
	userpwd = replace(upload("userpwd"),"'","''")
	alevel = replace(upload("alevel"),"'","''")
	if alevel="" then
		alevel = "n"
	end if
	usercode = upload("usercode")

	buse = replace(upload("buse"),"'","''")
	jik = replace(upload("jik"),"'","''")
	tel1 = replace(upload("tel1"),"'","''")
	tel2 = replace(upload("tel2"),"'","''")
	tel3 = replace(upload("tel3"),"'","''")
	hp1 = replace(upload("hp1"),"'","''")
	hp2 = replace(upload("hp2"),"'","''")
	hp3 = replace(upload("hp3"),"'","''")
	email = replace(upload("email"),"'","''")
	dcenteridx = replace(upload("dcenteridx"),"'","''")
    blevel = replace(upload("blevel"),"'","''")
      if blevel="" then
		blevel = "1"
	end if
	if dcenteridx="" then
		dcenteridx=0
	end if

	select case idx
		case ""

			SQL = "INSERT INTO tb_adminuser(usercode,flag,userid,username,userpwd,alevel,buse,jik,tel1,tel2,tel3,hp1,hp2,hp3,email,filename,sealname,mainname,wdate,wuserid,dcenteridx,blevel) VALUES "
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
			SQL = SQL & " '"& filename1 &"',"
			SQL = SQL & " '"& filename2 &"',"
			SQL = SQL & " '"& filename3 &"',"
			SQL = SQL & " '"& now() &"', "
			SQL = SQL & " '"& session("Auserid") &"',"
			SQL = SQL & "  "& dcenteridx &" ,"
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
					SQL = SQL & " dcenteridx = "& dcenteridx &" ,"
					if filename1<>"" then
						SQL = SQL & " filename = '"& filename1 &"' ,"
					end if
					if filename2<>"" then
						SQL = SQL & " sealname = '"& filename2 &"' ,"
					end if
					if filename3<>"" then
						SQL = SQL & " mainname = '"& filename3 &"' ,"
					end if
					SQL = SQL & " alevel = '"& alevel &"' ,"
					SQL = SQL & " edate = '"& now() &"', "
					SQL = SQL & " euserid = '"& session("Auserid") &"' , "
                     SQL = SQL & " blevel = '"& blevel &"' "
					SQL = SQL & " where idx = "& idx
    response.write sql
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
