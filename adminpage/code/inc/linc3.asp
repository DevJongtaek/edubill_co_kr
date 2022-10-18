<script language=javascript>
function nextstep() {
	if(event.keyCode==13) {
		document.all.fsearchbtn.focus();
	}
}

function excell_up(){
	window.open ('misuup.asp','ExcellID','width=450,height=120,left=100,top=100')
	return false ;
}

function account_up(){
	window.open ('accountup.asp','ExcellID','width=450,height=120,left=100,top=100')
	return false ;
}

function allsaveok(){
	findkindform.action = "orderflagAllsaveok.asp?gotopage=<%=gotopage%>&flag=<%=flag%>";
	findkindform.submit();
}
</script>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=findkindform>
<input type=hidden name=flag value="<%=flag%>">

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>체인점개설일자<BR> &nbsp;<B>체인점정보 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			예)20040928 ~ 20041004
			<BR>
			<select name="searchh" size="1" class="box_work">
        	  		<option value="">브랜드전체</option>
				<%if brand_arraynum<>"" then%>
					<%for i=0 to brand_arraynum%>
		        	  		<option value="<%=brand_array(0,i)%>" <%if searchh = cstr(brand_array(0,i)) then%>selected<%end if%>><%=brand_array(1,i)%></option>
					<%next%>
				<%end if%>
	        	</select>
		<%if session("Ausergubun")<>"3" then%>
			<select name="searchc" size="1" class="box_work">
          			<option value="0" <%if searchc = "0" then%>selected<%end if%>>지사(점)전체</option>
				<%if jisaarrayint <> "" then%>
					<%for i=0 to jisaarrayint%>
		          			<option value="<%=jisaarray(0,i)%>" <%if int(searchc)=int(jisaarray(0,i)) then%>selected<%end if%>><%=jisaarray(1,i)%>
					<%next%>
				<%end if%>
        		</select>
		<%end if%>
			<select name="searchg" size="1" class="box_work">
          			<option value="0" <%if searchg = "0" then%>selected<%end if%>>호차전체</option>
				<%if hcararrayint <> "" then%>
					<%for i=0 to hcararrayint%>
		          			<option value="<%=hcararray(0,i)%>" <%if int(searchg)=int(hcararray(0,i)) then%>selected<%end if%>><%=hcararray(1,i)%>호차
					<%next%>
				<%end if%>
        		</select>

			<select name="searchi" size="1" class="box_work">
          			<option value="">전체</option>
          			<option value="1" <%if searchi = "1" then%>selected<%end if%>>정상</option>
          			<option value="2" <%if searchi = "2" then%>selected<%end if%>>경고</option>
          			<option value="3" <%if searchi = "3" then%>selected<%end if%>>정지<%If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then %>1</option><option value="4" <%if searchi = "4" then%>selected<%end if%>>정지2</option><%End if%>
        		</select>

			<select name="searcha" size="1" class="box_work">
          			<option value="">전체</option>
          			<option value="tcode" <%if searcha = "tcode" then%>selected<%end if%>>체인점코드</option>
          			<option value="comname" <%if searcha = "comname" then%>selected<%end if%>>체인점명</option>
          			<option value="name" <%if searcha = "name" then%>selected<%end if%>>대표자명</option>
    	      			<option value="tel3" <%if searcha = "tel" then%>selected<%end if%>>전화번호</option>
          			<option value="hp3" <%if searcha = "hp" then%>selected<%end if%>>핸드폰번호</option>
        		</select>
        		<input type="Text" name="searchb" size="10" maxlength="20" class="box_work" value="<%=searchb%>" onkeypress='nextstep();'>
	        	<input type="button" name="fsearchbtn" value="검 색 " class="box_work" onclick="javascript:kindsearchok(this.form);">
	        	<input type="button" name="초기화" value="초기화" class="box_work" onclick="javascript:frmzerocheck(this.form,'list.asp?flag=3');">

		</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
        
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right>
			<!--<%If cybernum="y" Then %>
			<%if session("Ausergubun")="3" then%><input type="button" name="미수UP" value="계좌수정" class="box_work"  onclick="javascript:account_up();"><%end if%>
			<%End if%>-->
			<%if imsimyflag="y" then%>
				<%if session("Ausergubun")="3" then%><%if session("Auserwrite")="y" then%><input type="button" name="미수DOWN" value="미수DOWN" class="box_work" onclick="javascript:location.href='misudown.asp?flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>';"><%end if%><%end if%>
				<%if session("Ausergubun")="3" then%><%if session("Auserwrite")="y" then%><input type="button" name="미수UP" value="미수UP" class="box_work"  onclick="javascript:excell_up();"><%end if%><%end if%>
			<%else%>
            		<%if session("Ausergubun")="3" then%><%if session("Auserwrite")="y" then%><input type="button" name="미수UP" value="미수UP" class="box_work"  onclick="javascript: excell_up();"><%end if%><%end if%>
			<%end if%>
			<%if session("Ausergubun")="3" then%><%if session("Auserwrite")="y" then%><input type="button" name="체인점등록" value="체인점등록" class="box_work"' onclick="javascript:location.href='write.asp?flag=<%=flag%>';"><%end if%><%end if%>
			<%if session("Ausergubun")="3" then%><%if session("Auserwrite")="y" then%><input type="button" name="전체수정" value="전체수정" class="box_work"' onclick="allsaveok()"><%end if%><%end if%>
			<%if rslist.recordcount>0 then%><a href="excell2.asp?flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>"><img src="/images/admin/excel.gif" border=0></a><%end if%>
            
		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=9%>체인점코드</td>
		<td width=20%>체인점명</td>

		<td width=12%>주문상태</td>
		<td width=10%>주문허용</td>

		<td width=14%>브랜드명</td>
		<td width=15%>관할지사(점)</td>
		<td width=10%>대표자</td>

		<td width=5%>공지</td>

	</tr>

<%
set rs = server.CreateObject("ADODB.Recordset")
SQL = " select myflag from tb_company where idx = "& int(left(session("Ausercode"),5)) &" "
rs.Open sql, db, 1
if not rs.eof then
	imsimyflag = rs(0)
else
	imsimyflag = ""
end if
rs.close

i=1
'j=(gotopage*10)-9
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	orderflag = rslist("orderflag")

	imsidcarno = ""
	imsicomname = ""
	imsiusername = ""

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarno"
	SQL = SQL & " from tb_car where idx = "& rslist("dcarno") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsidcarno = rs(0)
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select distinct comname from tb_company where idx = "& rslist("idxsub") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsicomname = rs(0)
	end if
	rs.close

	if rslist("cbrandchoice")<>"" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bname from tb_company_brand "
		SQL = sql & " where bidx = "& rslist("cbrandchoice") &" "
		rs.Open sql, db, 1
		if not rs.eof then
			imsibname = rs(0)
		end if
		rs.close
	else
		imsibname = ""
	end if

	orderflag_fcolor = ""

	mi_money = rslist("mi_money")
	ye_money = rslist("ye_money")
	if orderflag="4" or orderflag="5" then
		orderflag_fcolor = "<font color=blue>"
	elseif orderflag="1" or orderflag="2" or orderflag="3" Or orderflag="6" then
		orderflag_fcolor = "<font color=red>"
	elseif orderflag="y" then
		orderflag_fcolor = ""
		if imsimyflag="y" then		'주문 중 && (여신 < 미수)
			if orderflag="y" and ye_money < mi_money then
				orderflag_fcolor = "<font color=red>"
			end if
		end if
	end if

	imsich_gongi = ""
	imsich_gongi = rslist("ch_gongi")
	if imsich_gongi<>"" then
		imsich_gongi = "*&nbsp;"
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''
	If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then 
		'misugum = "미수금1"
         misugum = "주문차단"
	Else
		misugum = "미수금"
	End if 
	if orderflag="y" or orderflag="" then
		imsiorderflag = "주문중"
	elseif orderflag="1" then
		imsiorderflag = "<font color='red'>" & misugum & "(정지)"
	elseif orderflag="2" then
		imsiorderflag = "<font color='red'>폐업(정지)"
	elseif orderflag="3" then
		imsiorderflag = "<font color='red'>휴업(정비)"
	elseif orderflag="4" then
		imsiorderflag = "<font color='blue'>경고1(주문)"
	elseif orderflag="5" then
		imsiorderflag = "<font color='blue'>경고2(주문)"
	elseif orderflag="6" then
		'imsiorderflag = "<font color='red'>미수금2(정지)"
        imsiorderflag = "<font color='red'>시즈닝차단(정지)"
	end if

	order_weekchoice = rslist("order_weekchoice")
	order_weekgubun  = rslist("order_weekgubun")
	if order_weekgubun="1" then
		order_weekgubun = "매일주문"
	else
		'order_weekgubun = "요일지정주문"
		imsi_val  = ""
		if len(order_weekchoice)>0 then
			for k=1 to len(order_weekchoice)
				select case mid(order_weekchoice,k,1)
					case "2"
						imsival = "월"
					case "3"
						imsival = "화"
					case "4"
						imsival = "수"
					case "5"
						imsival = "목"
					case "6"
						imsival = "금"
					case "7"
						imsival = "토"
					case "1"
						imsival = "일"
				end select
				imsi_val = imsi_val & imsival
			next
		end if
		order_weekgubun = imsi_val
	end if

	com_notice = rslist("ch_gongi")
	if len(com_notice) > 0 then
		com_notice = "有"
	else
		com_notice = "無"
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''
%>

		<input type=hidden name="idx" value="<%=rslist("idx")%>">

		<tr height=22 bgcolor=#FFFFFF align=center align=center>
			<td><%=orderflag_fcolor%><%=j%></td>
			<td><a href="write.asp?gotopage=<%=gotopage%>&flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>"><b><%=orderflag_fcolor%><%=rslist("tcode")%></a></td>
			<td align=left>&nbsp;<%=orderflag_fcolor%><%=imsich_gongi%><%=rslist("comname")%></td>
			<td>
				<%if session("Ausergubun")="3" then%>
					<!--<select name=orderflag style="BACKGROUND-COLOR: #FFFF00;">-->
					<select name=orderflag style="BACKGROUND-COLOR: #F2F1EA;">
						<option value="y" <%if orderflag="y" then%>selected<%end if%>>주문중
						<option value="1" <%if orderflag="1" then%>selected<%end if%> style='color:red;'><%=misugum%>
						<%If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then %>
						<!--<option value="6" <%if orderflag="6" then%>selected<%end if%> style='color:red;'>미수금2-->
                            <option value="6" <%if orderflag="6" then%>selected<%end if%> style='color:red;'>시즈닝차단
						<%End if%>
						<option value="2" <%if orderflag="2" then%>selected<%end if%> style='color:red;'>폐업
						<option value="3" <%if orderflag="3" then%>selected<%end if%> style='color:red;'>휴업
						<option value="4" <%if orderflag="4" then%>selected<%end if%> style='color:blue;'>경고1
						<option value="5" <%if orderflag="5" then%>selected<%end if%> style='color:blue;'>경고2
					</select>
				<%else%>
					<%=imsiorderflag%>
				<%end if%>
			</td>
			<td><%=orderflag_fcolor%><%=order_weekgubun%></td>
			<td><%=orderflag_fcolor%><%=imsibname%></td>
			<td><%=orderflag_fcolor%><%=imsicomname%></td>
			<td><%=orderflag_fcolor%><%=rslist("name")%></td>
			<td><%=orderflag_fcolor%><%=com_notice%></td>
		</tr>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 
%>

</form>

</table>