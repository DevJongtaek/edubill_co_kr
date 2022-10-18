<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	gotopage = request("gotopage")
	idx = request("idx")
	dflag = request("dflag")

	dcarno = replace(request("dcarno"),"'","''")
	dcarname = replace(request("dcarname"),"'","''")
	tel1 = replace(request("tel1"),"'","''")
	tel2 = replace(request("tel2"),"'","''")
	tel3 = replace(request("tel3"),"'","''")
	carno = replace(request("carno"),"'","''")
	carkind = replace(request("carkind"),"'","''")
	caryflag = replace(request("caryflag"),"'","''")
	dcenteridx = request("dcenteridx")
	if dcenteridx="" then dcenteridx=0
	select case idx
		case ""

			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select count(idx) "
			SQL = sql & " from tb_car "
			SQL = sql & " where usercode = '"& session("Ausercode") &"' "
			SQL = sql & " and dcarno = '"& dcarno &"' "
			rs.Open sql, db, 1
			imsicount = rs(0)
			rs.close

			if imsicount = 0 then
				SQL = "INSERT INTO tb_car(dcarno,usercode,dcarname,tel1,tel2,tel3,carno,carkind,caryflag,wdate,wuserid,dcenteridx) VALUES "
				SQL = SQL & " ('"& dcarno &"',"
				SQL = SQL & " '"& session("Ausercode") &"',"
				SQL = SQL & " '"& dcarname &"',"
				SQL = SQL & " '"& tel1 &"',"
				SQL = SQL & " '"& tel2 &"',"
				SQL = SQL & " '"& tel3 &"',"
				SQL = SQL & " '"& carno &"',"
				SQL = SQL & " '"& carkind &"',"
				SQL = SQL & " '"& caryflag &"',"
				SQL = SQL & " '"& now() &"', "
				SQL = SQL & " '"& session("Auserid") &"',"
				SQL = SQL & "  "& dcenteridx &")"
				db.Execute SQL
			else
%>
				<script language="javascript">
                    alert("호차번호가 중복됩니다.\n\n호차번호를 올바르게 입력해 주시기 바랍니다.")
                    history.back();
					//history.go(-1);
                    //window.parent.history.back();
				</script>
<%
				response.end
			end if

		case else
			select case dflag
				case ""
					SQL = "update tb_car set "
					SQL = SQL & " dcarname = '"& dcarname &"' ,"
					SQL = SQL & " tel1 = '"& tel1 &"' ,"
					SQL = SQL & " tel2 = '"& tel2 &"' ,"
					SQL = SQL & " tel3 = '"& tel3 &"' ,"
					SQL = SQL & " carno = '"& carno &"' ,"
					SQL = SQL & " carkind = '"& carkind &"' ,"
					SQL = SQL & " caryflag = '"& caryflag &"' ,"
					SQL = SQL & " edate = '"& now() &"', "
					SQL = SQL & " dcenteridx = "& dcenteridx &", "
					SQL = SQL & " euserid = '"& session("Auserid") &"' "
					SQL = SQL & " where idx = "& idx
					db.Execute SQL
				case "1"

					set rs = server.CreateObject("ADODB.Recordset")
					SQL = " select count(idx) "
					SQL = sql & " from tb_company "
					SQL = sql & " where bidxsub = '"& left(session("Ausercode"),5) &"' "
					SQL = sql & " and (flag='2' or flag='3') "
					SQL = sql & " and dcarno = "& idx &" "
					rs.Open sql, db, 1
					imsicount33 = rs(0)
					rs.close

					if imsicount33=0 then
						SQL = " delete tb_car "
						SQL = SQL & " where idx = "& idx
						db.Execute SQL
					else
%>
						<script language="javascript">
							alert("다른곳에서 호차를 사용중입니다.\n\n사용중인 호차를 바꾸신후 삭제해 주시기 바랍니다.")
							history.go(-1);
						</script>
<%
						response.end
					end if
			end select

	end select

	db.close
	set db=nothing
	response.redirect "clist.asp?gotopage="&gotopage&"&searcha="&searcha&"&searchb="&searchb
%>
