<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->
<script language="JavaScript">
<!--
    function alevel_check() {
       
        if (form.alevel.checked == false) {
           // alert(form.alevel.checked);
           
            form.blevel.disabled = false;

           // alert(form.blevel.disabled);
        }

        if (form.alevel.checked == true) {
             //alert(form.alevel.checked);

             form.blevel.disabled = true;

            // alert(form.blevel.disabled);
        }
    }

    //-->
</script>
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")

	fclass1 = Request("fclass1")
	sclass2 = Request("sclass2")
	tclass3 = Request("tclass3")

	GotoPage = Request("GotoPage")
	idx = Request("idx")
	flag = Request("flag")

	if idx <> "" then
		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,usercode,username,userid,userpwd,alevel,buse,jik,tel1,tel2,tel3,hp1,hp2,hp3,email,filename,dcenteridx,sealname,mainname,blevel "
		SQL = sql & " from tb_adminuser "
		SQL = sql & " where idx = "& idx
		rslist.Open sql, db, 1

		imsiusercode = rslist(1)
		imsiusername = rslist(2)
		imsiuserid = rslist(3)
		imsiuserpwd = rslist(4)
		imsialevel = rslist(5)
		imsibuse = rslist(6)
		imsijik = rslist(7)
		imsitel1 = rslist(8)
		imsitel2 = rslist(9)
		imsitel3 = rslist(10)
		imsihp1 = rslist(11)
		imsihp2 = rslist(12)
		imsihp3 = rslist(13)
		imsiemail = rslist(14)
		imsifilename = rslist(15)
		dcenteridx = rslist(16)
		imsisealname = rslist(17)
		imsimainname = rslist(18)
        imsiblevel = rslist(19)
		rslist.close
	end if

	if session("Ausergubun")="1" then
		imsititle = "회원사명"
		imsiflagimsi = "1"
	elseif session("Ausergubun")="2" then
		imsititle = "지사(점)"
		imsiflagimsi = "2"
	elseif session("Ausergubun")="3" then
		imsititle = "체인점명"
		imsiflagimsi = "3"
	end if
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 아이디 등록 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<%if session("Ausergubun")="1" or session("Ausergubun")="2" then%>
	<form action="uwriteok2.asp" name=form method=post onsubmit="return uwrite2();"  ENCTYPE="MULTIPART/FORM-DATA">
<%else%>
	<form action="uwriteok.asp" name=form method=post onsubmit="return uwrite();">
<%end if%>

<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type="hidden" name="searcha" value="<%=searcha%>">
<input type="hidden" name="searchb" value="<%=searchb%>">
<input type="hidden" name="searchc" value="<%=searchc%>">
<input type="hidden" name="searchd" value="<%=searchd%>">
<input type="hidden" name="searche" value="<%=searche%>">
<input type="hidden" name="searchf" value="<%=searchf%>">
<input type="hidden" name="searchg" value="<%=searchg%>">

<input type="hidden" name="s_fclass1" value="<%=fclass1%>">
<input type="hidden" name="s_sclass2" value="<%=sclass2%>">
<input type="hidden" name="s_tclass3" value="<%=tclass3%>">

<input type="hidden" name="dflag">


	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>성명&nbsp;</td>
		<td bgcolor=white><input type="text" class="box_write" name="username" maxlength="20" size=20 value="<%=imsiusername%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>아이디&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="userid" maxlength="10" size=10 class="box_write" value="<%=imsiuserid%>" <%if idx <> "" then%>readonly<%end if%>>
			  <%if idx = "" then%><a href="#" onClick="return checkid(form,form.userid.value)"><img src="/images/admin/member_01.gif" border=0 hspace="5" align="absmiddle"></a><%end if%>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>비밀번호&nbsp;</td>
		<td bgcolor=white><input type="<%if session("Auserwrite")="y" then%>text<%else%>password<%end if%>" name="userpwd" maxlength="10" size=10 class="box_write" value="<%=imsiuserpwd%>"></td>
	</tr>


	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>부서/직위&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="text" name="buse" maxlength="20" size=15 class="box_write" value="<%=imsibuse%>">
/
<input type="text" name="jik" maxlength="20" size=15 class="box_write" value="<%=imsijik%>">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>전화번호&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="text" name="tel1" maxlength="3" size=3 class="box_write" value="<%=imsitel1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel2" maxlength="4" size=4 class="box_write" value="<%=imsitel2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel3" maxlength="4" size=4 class="box_write" value="<%=imsitel3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>핸드폰&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="text" name="hp1" maxlength="3" size=3 class="box_write" value="<%=imsihp1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="hp2" maxlength="4" size=4 class="box_write" value="<%=imsihp2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="hp3" maxlength="4" size=4 class="box_write" value="<%=imsihp3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><B>이메일&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="text" name="email" maxlength="50" size=40 class="box_write" value="<%=imsiemail%>">
		</td>
	</tr>

<%if session("Ausergubun")="1" then%>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>회원사 로고&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="file" name="bfile1" style="width:70%;" class="box_write"> <%if imsifilename<>"" then%><a href="http://220.73.136.50:8080/fileupdown/logo/<%=imsifilename%>" target=_blank><img src="/fileupdown/<%=imsifilename%>" width=22 height=22 border=0></a><%end if%>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>회원사 도장&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="file" name="bfile2" style="width:70%;" class="box_write"> <%if imsisealname<>"" then%><a href="http://220.73.136.50:8080/fileupdown/logo/<%=imsisealname%>" target=_blank><img src="/fileupdown/<%=imsisealname%>" width=22 height=22 border=0></a><%end if%>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>주문어플 메인이미지&nbsp;</td>
		<td width=80% bgcolor=white>
<input type="file" name="bfile3" style="width:70%;" class="box_write"> <%if imsimainname<>"" then%><a href="http://220.73.136.50:8080/fileupdown/app/<%=imsimainname%>" target=_blank><img src="/fileupdown/<%=imsimainname%>" width=22 height=22 border=0></a><%end if%>
		</td>
	</tr>

<%end if%>



	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>등록/수정권한&nbsp;</td>
		<td bgcolor=white>
			<%if session("Ausergubun")="1" then%>
				<input type="hidden" name="alevel" value="y">YES
			<%elseif session("Ausergubun")="3" then%>
				<input type="hidden" name="alevel" value="n">NO
			<%else%>
				<input type="checkbox" name="alevel" value="y" <%if imsialevel="y" then%>checked<%end if%> onchange="alevel_check()"  >YES
			<%end if%>
            </br>
           <select name="blevel" <%if imsialevel="y"  then%>disabled<%end if%>>
				<option value="1" <%if imsiblevel="1" then%>selected<%end if%>>모든권한 없음
				<option value="2" <%if imsiblevel="2" then%>selected<%end if%>>주문확인 및 거래명세서만            
              
			</select>
		 
	</tr>

<%if session("Ausergubun")<>"3" then%>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B><%=imsititle%>&nbsp;</td>
		<td bgcolor=white>

		<%
		if idx <> "" then
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select comname "
			SQL = sql & " from tb_company "

			if session("Ausergubun")="1" then
				SQL = sql & " where flag = '1' "
				SQL = sql & " and idx = "& imsiusercode &" "
			elseif session("Ausergubun")="2" then
				SQL = sql & " where flag = '2' "
				SQL = sql & " and idx = "& right(imsiusercode,5) &" "
			elseif session("Ausergubun")="3" then
				SQL = sql & " where flag = '3' "
				SQL = sql & " and idx = "& right(imsiusercode,5) &" "
			end if

			rs.Open sql, db, 1
			response.write rs(0)
			response.write "<input type=hidden name=usercode value=1>"
			rs.close

			if session("Ausergubun")="2" then
				set rs2 = server.CreateObject("ADODB.Recordset")
				SQL = " select b.bidx,b.bname from tb_company a, tb_company_dcenter b where a.idx = b.idx and a.idx = "& int(session("Ausercode")) &" and a.dcenterflag='y' "
				SQL = sql & " order by b.bname asc"
				rs2.Open sql, db, 1
		%>
				<%if not rs2.eof then%>
					&nbsp; 물류센터
					<select name=dcenteridx>
						<option value="0">선택
						<%do until rs2.eof%>
							<option value="<%=rs2(0)%>" <%if rs2(0)=dcenteridx then%>selected<%end if%>><%=rs2(1)%>
						<%rs2.movenext%>
						<%loop%>
						<%rs2.close%>
					</select>
				<%end if%>
		<%
			end if
		%>
		<%else%>
			<%
			if session("Ausergubun")="1" then	'슈퍼유저->본사
				'set rs = server.CreateObject("ADODB.Recordset")
				'SQL = " select * "
				'SQL = sql & " from tb_company "
				'SQL = sql & " where flag = '1' "
				'SQL = sql & " order by comname asc"
				'rs.Open sql, db, 1

				set rs = server.CreateObject("ADODB.Recordset")
				SQL = " select * "
				SQL = sql & " from tb_company"
				SQL = sql & " where flag='1' "
				SQL = sql & " and idx not in (select substring(usercode,1,5) from tb_adminuser where flag='2') "
				SQL = sql & " order by comname asc"
				rs.Open sql, db, 1
			%>
				<select name=usercode>
					<%do until rs.eof%>
						<option value="<%=rs("idx")%>" <%if int(imsiusercode)=rs("idx") then%>selected<%end if%>><%=rs("comname")%>
					<%rs.movenext%>
					<%loop%>
					<%rs.close%>
				</select>
			<%
			elseif session("Ausergubun")="2" then	'본사->지사
				set rs = server.CreateObject("ADODB.Recordset")
				SQL = " select * "
				SQL = sql & " from tb_company "
				SQL = sql & " where flag = '2' "
				SQL = sql & " and bidxsub = "& int(session("Ausercode")) &" "
				SQL = sql & " order by comname asc"
				rs.Open sql, db, 1

				set rs2 = server.CreateObject("ADODB.Recordset")
				SQL = " select b.bidx,b.bname from tb_company a, tb_company_dcenter b where a.idx = b.idx and a.idx = "& int(session("Ausercode")) &" and a.dcenterflag='y' "
				SQL = sql & " order by b.bname asc"
				rs2.Open sql, db, 1
			%>
				<select name=usercode>
					<%do until rs.eof%>
						<%imsinum = rs("bidxsub")&rs("idx")%>
						<option value="<%=rs("bidxsub")%><%=rs("idx")%>" <%if int(imsiusercode)=int(imsinum) then%>selected<%end if%>><%=rs("comname")%>
					<%rs.movenext%>
					<%loop%>
					<%rs.close%>
				</select>
				<%if not rs2.eof then%>
					&nbsp; 물류센터
					<select name=dcenteridx>
						<%do until rs2.eof%>
							<option value="<%=rs2(0)%>" <%if rs2(0)=dcenteridx then%>selected<%end if%>><%=rs2(1)%>
						<%rs2.movenext%>
						<%loop%>
						<%rs2.close%>
					</select>
				<%end if%>

			<%
			elseif session("Ausergubun")="3" then	'지사->체인점

				set rs = server.CreateObject("ADODB.Recordset")
				SQL = " select * "
				SQL = sql & " from tb_company "
				SQL = sql & " where flag = '3' "
				SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
				SQL = sql & " and idxsub = "& int(mid(session("Ausercode"),6,5)) &" "
				SQL = sql & " order by comname asc"
				rs.Open sql, db, 1
			%>
				<select name=usercode>
					<%do until rs.eof%>
						<%imsinum = rs("bidxsub")&rs("idxsub")&rs("idx")%>
						<option value="<%=rs("bidxsub")%><%=rs("idxsub")%><%=rs("idx")%>" <%if int(imsiusercode)=int(imsinum) then%>selected<%end if%>><%=rs("comname")%>
					<%rs.movenext%>
					<%loop%>
					<%rs.close%>
				</select>
			<%end if%>
		<%end if%>

		</td>
	</tr>
<%end if%>

</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>

	<%if session("Auserwrite")="y" then%>
		<%if idx="" then%>
			<input type="image" src="/images/admin/l_bu01.gif" border=0>
		<%else%>
			<input type="image" src="/images/admin/l_bu03.gif" border=0>
			<a href="#" onclick="javascript:udel(this.form);"><img src="/images/admin/l_bu04.gif" border=0></a>
		<%end if%>
	<%end if%>
			<a href="#" onclick="javascript:history.back();"><img src="/images/admin/l_bu07.gif" border=0></a>
		</td>
	</tr>

</form>

</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR><BR>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->