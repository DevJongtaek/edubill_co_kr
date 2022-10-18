<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	dcode = replace(request("dcode"),"'","''")
	dname = replace(request("dname"),"'","''")
	name = replace(request("name"),"'","''")
	jumin1 = replace(request("jumin1"),"'","''")
	jumin2 = replace(request("jumin2"),"'","''")
	comnum1 = replace(request("comnum1"),"'","''")
	comnum2 = replace(request("comnum2"),"'","''")
	comnum3 = replace(request("comnum3"),"'","''")
	post = request("m_post1")&"-"&request("m_post2")
	addr = replace(request("m_addr1"),"'","''")
	addr2 = replace(request("m_addr2"),"'","''")
	uptae = replace(request("uptae"),"'","''")
	upjong = replace(request("upjong"),"'","''")
	tel1 = replace(request("tel1"),"'","''")
	tel2 = replace(request("tel2"),"'","''")
	tel3 = replace(request("tel3"),"'","''")
	fax1 = replace(request("fax1"),"'","''")
	fax2 = replace(request("fax2"),"'","''")
	fax3 = replace(request("fax3"),"'","''")
	homepage = replace(request("homepage"),"'","''")
	sudang = replace(request("sudang"),"'","''")
	bank = replace(request("bank"),"'","''")
	banknum = replace(request("banknum"),"'","''")
	bankname = replace(request("bankname"),"'","''")

	gotopage = request("gotopage")
	dflag = request("dflag")
	flag = request("flag")
	idx = request("idx")

	set rs = server.createobject("adodb.recordset")
	sql = "select count(idx) from tb_dealer where dcode = '"& dcode &"'"
	rs.open sql, db, 1
	imsicount = rs(0)
	rs.close
	if idx<>"" then
		imsicount=0
	end if

if imsicount=0 then

	select case idx
		case ""

			SQL = "INSERT INTO tb_dealer(dcode,dname,name,jumin1,jumin2,comnum1,comnum2,comnum3,post,addr,addr2,uptae,upjong,tel1,tel2,tel3, "
			SQL = SQL & " fax1,fax2,fax3,homepage,sudang,bank,banknum,bankname,wdate) VALUES "
			SQL = SQL & " ('"& dcode &"',"
			SQL = SQL & " '"& dname &"',"
			SQL = SQL & " '"& name &"',"
			SQL = SQL & " '"& jumin1 &"',"
			SQL = SQL & " '"& jumin2 &"',"
			SQL = SQL & " '"& comnum1 &"',"
			SQL = SQL & " '"& comnum2 &"',"
			SQL = SQL & " '"& comnum3 &"',"
			SQL = SQL & " '"& post &"',"
			SQL = SQL & " '"& addr &"',"
			SQL = SQL & " '"& addr2 &"',"
			SQL = SQL & " '"& uptae &"',"
			SQL = SQL & " '"& upjong &"',"
			SQL = SQL & " '"& tel1 &"',"
			SQL = SQL & " '"& tel2 &"',"
			SQL = SQL & " '"& tel3 &"',"

			SQL = SQL & " '"& fax1 &"',"
			SQL = SQL & " '"& fax2 &"',"
			SQL = SQL & " '"& fax3 &"',"
			SQL = SQL & " '"& homepage &"',"
			SQL = SQL & " '"& sudang &"',"
			SQL = SQL & " '"& bank &"',"
			SQL = SQL & " '"& banknum &"',"
			SQL = SQL & " '"& bankname &"',"
			SQL = SQL & " '"& now() &"') "
			db.Execute SQL

		case else
			select case dflag
				case ""
					SQL = "update tb_dealer set "
					SQL = SQL & " name = '"& name &"' ,"
					SQL = SQL & " jumin1 = '"& jumin1 &"' ,"
					SQL = SQL & " jumin2 = '"& jumin2 &"' ,"
					SQL = SQL & " comnum1 = '"& comnum1 &"' ,"
					SQL = SQL & " comnum2 = '"& comnum2 &"' ,"
					SQL = SQL & " comnum3 = '"& comnum3 &"' ,"
					SQL = SQL & " post = '"& post &"' ,"
					SQL = SQL & " addr = '"& addr &"' ,"
					SQL = SQL & " addr2 = '"& addr2 &"' ,"
					SQL = SQL & " uptae = '"& uptae &"' ,"
					SQL = SQL & " upjong = '"& upjong &"' ,"
					SQL = SQL & " tel1 = '"& tel1 &"' ,"
					SQL = SQL & " tel2 = '"& tel2 &"' ,"
					SQL = SQL & " tel3 = '"& tel3 &"' ,"
					SQL = SQL & " fax1 = '"& fax1 &"' ,"
					SQL = SQL & " fax2 = '"& fax2 &"' ,"
					SQL = SQL & " fax3 = '"& fax3 &"' ,"
					SQL = SQL & " homepage = '"& homepage &"' ,"
					SQL = SQL & " sudang = '"& sudang &"' ,"
					SQL = SQL & " bank = '"& bank &"', "
					SQL = SQL & " banknum = '"& banknum &"' ,"
					SQL = SQL & " bankname = '"& bankname &"' "
					SQL = SQL & " where idx = "& idx
					db.Execute SQL
				case "1"
					SQL = "delete tb_dealer "
					SQL = SQL & " where idx = "& idx
					db.Execute SQL
			end select

	end select

	db.close
	set db=nothing
	response.redirect "list.asp?gotopage="&gotopage

else
%>
	<script language="javascript">
		alert("딜러코드가 중복됩니다.\n\n다른 딜러코드를 입력하여 주십시요.")
		history.go(-1);
	</script>
<%
end if
%>
