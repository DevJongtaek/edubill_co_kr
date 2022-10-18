<!--#include virtual="/db/db.asp"-->

<%
	pwd = replace(request("pwd"),"'","''")
	gotopage = request("gotopage")
	uid = request("uid")
	idx = request("idx")
	midx = request("midx")
	searcha = request("searcha")
	searchb = request("searchb")

	set rs = server.CreateObject("ADODB.Recordset")
	sql="select pwd from tb_ment where midx = "& midx
	rs.Open sql, db
	if not rs.eof then
		imsicount = rs(0)
	else
		imsicount = ""
	end if
	rs.close

	if imsicount <> "" then

		if imsicount = pwd then

		   	SQL = "delete tb_ment where midx = "&midx
			db.Execute SQL
			db.close
			response.redirect "content.asp?gotopage="&gotopage&"&uid="&uid&"&searcha="&searcha&"&searchb="&searchb&"&idx="&idx

		elseif imsicount <> pwd then
%>

			<script language="javascript">
				alert("비밀번호가 틀립니다.\n다시 입력하여 주시기 바랍니다.");
				window.open("/bbs/mentdel.asp?uid=<%=uid%>&gotopage=<%=gotopage%>&idx=<%=idx%>&midx=<%=midx%>&searcha=<%=searcha%>&searchb=<%=searchb%>", "_top");
			</script>

<%
		end if
	
	else

		response.redirect "content.asp?gotopage="&gotopage&"&uid="&uid&"&searcha="&searcha&"&searchb="&searchb&"&idx="&idx

	end if
%>