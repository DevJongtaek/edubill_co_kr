<!--#include virtual="/adminpage/incfile/top2.asp"-->
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

	if searchg="" then
		searchg = "0"
	end if
	if searchc="" then
		searchc = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if

	if searchd="" then
		searchd = replace(left(now(),10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if

	fclass1 = Request("fclass1")
	sclass2 = Request("sclass2")
	tclass3 = Request("tclass3")
	imsifclass1 = right(Request("fclass1"),5)
	imsisclass2 = right(Request("sclass2"),5)
	imsitclass3 = right(Request("tclass3"),5)

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select vatflag "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& left(session("AAusercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsivatflag = rs(0)
	end if
	rs.close

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,usercode,comname1,comname2,orderday,ordermoney,carname,ordering,flag,wdate,rordermoney,deflagday,sendhpnum,FtpFile,order_cmt "
	SQL = sql & " from tb_order "
	SQL = sql & " where usercode = '"& session("AAusercode") &"' "
	SQL = sql & " and idx in (select idx from tb_order_product) "

	if searcha="1" then
		SQL = sql & " and flag = 'n' "
	elseif searcha="2" then
		SQL = sql & " and flag = 'y' and deflag='n' "
	elseif searcha="3" then
		SQL = sql & " and flag = 'y' and deflag='y' "
	end if

	if searchc <> "" and searchc <> "0" then
		SQL = sql & " and substring(usercode,6,5) = '"& searchc &"' "
	end if

	if searchf <> "" and searchf <> "0" then
		SQL = sql & " and substring(usercode,11,5) = '"& searchf &"' "
	end if

	if searchd <> "" then
		SQL = sql & " and orderday >= '"& searchd &"' "
	end if

	if searche <> "" then
		SQL = sql & " and orderday <= '"& searche &"' "
	end if

	if searchg<>"0" then
		SQL = sql & " and  carname = '"& searchg &"' "
	end if

	if imsifclass1<>"" then
		SQL = sql & " and  substring(usercode,1,5) = '"& imsifclass1 &"' "
	end if

	if imsisclass2<>"" then
		SQL = sql & " and  substring(usercode,6,5) = '"& imsisclass2 &"' "
	end if

	if imsitclass3<>"" then
		SQL = sql & " and  substring(usercode,11,5) = '"& imsitclass3 &"' "
	end if

	if searchh = "1" then
		SQL = sql & " and (FtpFile <> '' and FtpFile is not null)"
	elseif searchh = "2" then
		SQL = sql & " and (FtpFile = '' or FtpFile is null)"
	end if

	SQL = sql & " order by idx desc"
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("AAusercode"),5) &"' "
	SQL = sql & " order by dcarno asc"
	rs.Open sql, db, 1
	if not rs.eof then
		hcararray = rs.GetRows
		hcararrayint = ubound(hcararray,2)
	else
		hcararray = ""
		hcararrayint = ""
	end if
	rs.close

	if session("Ausergubun")="3" then	'지사로그인시만 체인점정보를 가져옴
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,comname "
		SQL = sql & " from tb_company "
		SQL = sql & " where flag = '3' "
		SQL = sql & " and bidxsub = '"& left(session("AAusercode"),5) &"' "
		SQL = sql & " and idxsub  = '"& mid(session("AAusercode"),6,5) &"' "
		SQL = sql & " order by comname asc"
		rs.Open sql, db, 1
		if not rs.eof then
			barray = rs.GetRows
			barrayint = ubound(barray,2)
		else
			barray = ""
			barrayint = ""
		end if
		rs.close
	end if
%>

<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 주문내역 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list22.asp" method="POST" name=form>
	<tr>
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>주문일자<BR> &nbsp;<B>주문정보 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="오늘" value="오늘" class="box_work"' onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);"> 예)20040928 ~ 20041004
			<BR>

			<select name="searchg" size="1" class="box_work">
				<%if hcararrayint<>"" then%>
	          			<option value="0" <%if searchg = "" then%>selected<%end if%>>호차전체</option>
					<%for i=0 to hcararrayint%>
	        	  			<option value="<%=hcararray(1,i)%>" <%if searchg=hcararray(1,i) then%>selected<%end if%>><%=hcararray(1,i)%>호차
					<%next%>
				<%else%>
	          			<option value="0" <%if searchg = "" then%>selected<%end if%>>호차등록없음</option>
				<%end if%>
        		</select>
			<select name="searcha" size="1" class="box_work">
	          			<option value="" <%if searcha="" then%>selected<%end if%>>전체</option>
        	  			<option value="1" <%if searcha="1" then%>selected<%end if%>>주문상태
        	  			<option value="2" <%if searcha="2" then%>selected<%end if%>>주문확인
        	  			<option value="3" <%if searcha="3" then%>selected<%end if%>>배달완료
        		</select>
			<select name="searchh" size="1" class="box_work">
	          			<option value="" <%if searchh="" then%>selected<%end if%>>전체
        	  			<option value="1" <%if searchh="1" then%>selected<%end if%>>음성메시지(유)
        	  			<option value="2" <%if searchh="2" then%>selected<%end if%>>음성메시지(무)
        		</select>
	        	<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="초기화" value="초기화" class="box_work"' onclick="javascript:frmzerocheck(this.form,'list.asp');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=40%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=60% align=right><font color=red>배달일자’에 ‘*’ 혹은 ‘주문확인’ 건은 수정이나 취소 못함.</font> &nbsp; (<%if imsivatflag="y" then%>부가세포함<%else%>부가세별도<%end if%>)</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=7%>코드</td>
		<td width=16%>체인점명</td>
		<td width=17%>주문일시</td>
		<td width=11%>합계금액</td>
		<td width=9%>호차</td>
		<td width=9%>기사명</td>
		<td width=13%>주문자번호</td>
		<td width=11%>배달일자</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	imsidaytime = left(rslist("idx"),4)&"/"&mid(rslist("idx"),5,2)&"/"&mid(rslist("idx"),7,2)
	imsidaytime = imsidaytime&" "&mid(rslist("idx"),9,2)&":"&mid(rslist("idx"),11,2)&":"&mid(rslist("idx"),13,2)

	imsimoney=0
	if rslist("flag")="y" then
		imsimoney=rslist("rordermoney")
	else
		imsimoney=rslist("ordermoney")
	end if
	imsidcarname = ""
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarname "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and dcarno = '"& rslist("carname") &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		imsidcarname = rs(0)
	end if
	rs.close

	imsimarkflag = ""
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select top 1 flag "
	SQL = sql & " from tb_order_product "
	SQL = sql & " where idx = '"& rslist("idx") &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		imsimarkflag = rs(0)
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = '"& right(rslist("usercode"),5) &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		imsitcode = rs(0)
	end if
	rs.close
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select fileflag,vatflag "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = '"& left(rslist("usercode"),5) &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		imsifileflag = rs(0)
		vatflag = rs(1)
	end if
	rs.close
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	imsihapmoney = 0
	imsimoney    = 0
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pprice, a.ordernum, b.gubun "
	SQL = sql & " from tb_order_product a, tb_product b "
	SQL = sql & " where a.pcodeidx = b.idx "
	SQL = sql & " and a.idx = '"& rslist("idx") &"' "
'response.write sql &"<BR>"
	rs.Open sql, db, 1
	if not rs.eof then
		do until rs.eof
			rs_price = rs(0)
			rs_pcnt  = rs(1)
			taxGubun = rs(2)
			kmoney   = CDbl(rs_price)*CDbl(rs_pcnt)	'공급가액
			if taxGubun="과세" then
				if vatflag="y" then	'포함
					imsimoney = round(rs_price*(100/110),0)
					taxmoney  = (rs_price-imsimoney) * rs_pcnt
					imsikkmoney = kmoney-taxmoney
				elseif vatflag="n" then	'별도
					taxmoney = round(kmoney*0.1,0)
					imsikkmoney = kmoney
				elseif vatflag="a" then	'비과세
					taxmoney = 0
					imsikkmoney = kmoney
				end if
			else
				imsikkmoney = kmoney
				taxmoney = 0
			end if
			imsihapmoney = imsihapmoney+imsikkmoney+taxmoney
		rs.movenext
		loop
	end if
	rs.close
	imsimoney = imsihapmoney
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


	imsiiconfile=""
	if rslist("FtpFile")="" or isnull(rslist("FtpFile"))then
	else
		imsiiconfile = rslist("FtpFile")
	end if

	imsiorder_cmt = ""
	imsiorder_cmt = rslist("order_cmt")
	'if imsiorder_cmt<>"" then
	'	imsiorder_cmt = Replace(imsiorder_cmt,chr(13),"<br>")
	'end if

%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=imsitcode%></td>
		<td align=left>&nbsp;<a href="write.asp?gotopage=<%=gotopage%>&flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&searchh=<%=searchh%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><b><%=rslist("comname2")%></a>
		<%if imsiiconfile<>"" then%><a href="/fileupdown/wav/<%=imsiiconfile%>" target=_blank><img src="/adminpage/order/icon.gif" border=0></a><%end if%><%if imsiorder_cmt<>"" then%><a href="#" onclick="window.open('/adminpage/order/order_cmt.asp?idx=<%=rslist("idx")%>' , 'blank<%=i%>','left=100, top=100, width=400, height=300, scrollbars=yes, toolbar=no');"><img src="/images/coment.gif" border=0></a><%end if%>
		</td>
		<td><%=imsidaytime%></td>
		<td align=right><%=FormatCurrency(imsimoney)%>&nbsp;</td>
		<td><%=rslist("carname")%>호차</td>
		<td><%=imsidcarname%></td>
		<td><%=rslist("sendhpnum")%></td>
		<td>
			<%if imsimarkflag="T" then%>*<%end if%>
			<%if rslist("flag")="n" then%>
			<%elseif rslist("flag")="y" then%>
				<%if rslist("deflagday")="" or isnull(rslist("deflagday")) then%>
					주문확인
				<%else%>
					<%=left(rslist("deflagday"),4)%>/<%=mid(rslist("deflagday"),5,2)%>/<%=right(rslist("deflagday"),2)%>
				<%end if%>
			<%end if%>
		</td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
%>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="list.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">첫페이지</a>&nbsp;
				<a href="list.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="list.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="list.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">다음 10개</a>
				&nbsp;<a href="list.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">마지막</a>
		<% 	End If %>

		</td>
	</tr>
</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom2.asp"-->
