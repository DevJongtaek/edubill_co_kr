<!--#include virtual="/adminpage/incfile/mtop2.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	rowcount = 0

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sidx,sname "
	SQL = sql & " from tb_product_submenu "
	SQL = sql & " where idx = '"& left(session("AAusercode"),5) &"' order by sidx asc"
	rs.Open sql, db, 1
	if not rs.eof then
		proFlagArray = rs.GetRows
		proFlagArrayInt = ubound(proFlagArray,2)
	else
		proFlagArray    = ""
		proFlagArrayInt = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select ye_money,mi_money from tb_company where idx = "& right(session("AAusercode"),5) &" "
	rs.Open sql, db, 1
	ye_money = rs("ye_money")
	mi_money = rs("mi_money")
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag,vatflag from tb_company where idx = "& left(session("AAusercode"),5) &" "
	rs.Open sql, db, 1
	myflag = rs("myflag")
	vatflag = rs("vatflag")
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select isnull(sum(pprice*pcnt),0) from tb_product_cart where usercode = '"& session("AAusercode") &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		imsihap = rs(0)
	else
		imsihap = 0
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.*, b.pprice as cartpprice, b.pcnt, b.idx as cartidx "
	SQL = sql & " from tb_product a, tb_product_cart b"
	SQL = sql & " where a.pcode = b.pcode "
	SQL = sql & " and a.usercode = substring(b.usercode,1,5) "
	SQL = sql & " and b.usercode = '"& session("AAusercode") &"' "
	SQL = sql & " order by a.pcode asc"
	rs.Open sql, db, 1

	set rsPlus = server.CreateObject("ADODB.Recordset")
	SQL = " select a.*, c.pprice as cartpprice, b.pcnt, b.idx as cartidx "
	SQL = sql & " from tb_product a, tb_product_cart b, (select pcode, pprice from tb_product where usercode = '77275') c "
	SQL = sql & " where a.pcode = b.pcode "
	SQL = sql & " and c.pcode = a.pcode "
	SQL = sql & " and a.usercode = substring(b.usercode,1,5) "
	SQL = sql & " and b.usercode = '"& session("AAusercode") &"' "
	SQL = sql & " order by a.pcode asc"
	rsPlus.Open sql, db, 1
%>

<script language="javascript">
function radiochbsubmit() {
	form2.action="AgencyOrderFRM.asp";
	form2.submit() ;
	return false ;
}

function checkwrite() {
	var imsicnt = 0;
	var imsitcnt = 0;
	if (frm.rowcount.value <= 1)
	{
		alert("주문 상품이 없습니다. 주문 상품을 장바구니에 추가하십시오.") ;
		return false ;
	}
	if (frm.rowcount.value == 2)
	{
		imsitcnt = imsitcnt + document.all("pcnt").value;
	}
	for(var i=0; i<document.all("pcnt").length;i++) 	//체크박스 갯수
	{
		if(document.all("pcnt")[i].value == ""){
			imsicnt = 1
		}
		imsitcnt = imsitcnt + document.all("pcnt")[i].value;
	}
	if (imsicnt>0 || imsitcnt == 0) {
		alert("주문수량을 입력해 주세요.") ;
		return false ;
	}
	document.all("btnsubmit").style.display="none";
	form.submit() ;
	return false ;
}

function checksubmitEdit(form)
{
	form.proc.value = "수정";
	form.submit();
	return false;	
}

function checksubmitDel(form)
{
	form.proc.value = "삭제";
	form.submit();
	return false;	
}
</script>

<table width="310" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>
<hr>

<table width="310" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="20">
		<td>
			<%if proFlagArrayInt<>"" then%>
				<%for i=0 to proFlagArrayInt%>
					<a href="mAgencyOrderFRM.asp?popnot=1&searcha=<%=proFlagArray(1,i)%>&searchb=<%=searchb%>"><font size=2><%if proFlagArray(1,i)=searcha then%><B><%else%><font color=blue><%end if%><%=proFlagArray(1,i)%><%if proFlagArray(1,i)=searcha then%></B><%end if%></a><%if i<proFlagArrayInt then%>&nbsp;|&nbsp;<%end if%>
				<%next%>
				&nbsp;|&nbsp;<a href="mAgencyOrderFRM.asp?popnot=1&searcha=0&searchb=<%=searchb%>"><font size=2><%if searcha="0" then%><B><%else%><font color=blue><%end if%>전체보기</a>
			<%end if%>
		</td>
	</tr>
</table>

<table width="310" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">

<form name=form2 method=post>
<input type=hidden name=searcha value="<%=searcha%>">

	<tr height="27">
		<td width=50%><font size=2><B>[ 장바구니 보기 ]</td>
		<td width=50% align=right>
		<%if myflag="y" then%>
		⊙ 현재여신 : <%=formatnumber((ye_money-mi_money)-imsihap,0)%> 원
			<!--정렬순서 : 
			<input type=radio name="searchb" value="pcode" onclick="radiochbsubmit()" <%if searchb="pcode" or searchb="" then%>checked<%end if%>>상품코드
			<input type=radio name="searchb" value="pname" onclick="radiochbsubmit()" <%if searchb="pname" then%>checked<%end if%>>상품명
			<input type=radio name="searchb" value="sname" onclick="radiochbsubmit()" <%if searchb="sname" then%>checked<%end if%>>서브메뉴
			<input type=button value="장바구니보기"  onclick="javascript:location.href='AgencyOrderCartFRM.asp?btnsee=y';">-->
		<%end if%>
		</td>
	</tr>
</form>
</table>

<table cellspacing=0 cellpadding=0 width="310" border=0>
	<%If left(session("AAusercode"),5) = "19209" Then %>
	<tr>
		<td align="left"><b>[지엔푸드]</b></td>
	</tr>
	<%End If %>
    <%If left(session("AAusercode"),5) = "96338" Then %>
	<tr>
		<td align="left"><b>[94번가]</b></td>
	</tr>
	<%End If %>
	<tr>
		<td align=center>

		<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width=10%><B>코드</td>
				<td width=20%><B>상품명</td>
				<!-- <td width=20%><B>규격</td> -->
				<td width=10%><B>단가</td>
				<td width=10%><B>수량</td>
				<td width=15%><B>공급가</td>
				<td width=10%><B>세액</td>
				<td width=8%><B>구분</td>
			</tr>

			<%
			i=1
			tothap = 0
			kmoneyHap = 0
			tmoneyHap = 0
			do until rs.eof
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				taxGubun = rs("gubun")			'과세/비과세 / vatflag
				kmoney   = rs("cartpprice")*rs("pcnt")	'공급가액
				if taxGubun="과세" then
					if vatflag="y" then	'포함
						imsimoney = round(rs("cartpprice")*(100/110),0)
						taxmoney  = (rs("cartpprice")-imsimoney)*rs("pcnt")
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
				if taxmoney="" then taxmoney=0
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				kmoneyHap = kmoneyHap + imsikkmoney
				tmoneyHap = tmoneyHap + taxmoney
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				tothap = tothap + (rs("cartpprice")*rs("pcnt"))

				if i=1 then
					pcode = rs("pcode")
					ordernum = rs("pcnt")
				else
					pcode = pcode &","& rs("pcode")
					ordernum = ordernum &","& rs("pcnt")
				end if
			%>

				<form action="mAgencyOrderCartDel.asp" name=form<%=i%> method=post>
				<input type=hidden name=idx value="<%=rs("cartidx")%>">

				<tr height=25 bgcolor=white align=center>
					<td><%=rs("pcode")%></td>
					<td align=left>&nbsp;<B><%=rs("pname")%></td>
					<!-- <td align=left>&nbsp;<%=rs("ptitle")%></td> -->
					<td align=right><%=formatnumber(rs("cartpprice"),0)%>&nbsp;</td>
					<td><input type=text name=pcnt size=4 value="<%=rs("pcnt")%>" style="ime-mode:disabled;" OnKeypress="onlyNumber();" maxlength=4>						<!-- <br><input type=submit value="수정" name=btnname>
					<br><input type=submit value="삭제" name=btnname> --></td>
					<td align=right><%=formatnumber(imsikkmoney,0)%>&nbsp;</td>
					<td align=right><%=formatnumber(taxmoney,0)%>&nbsp;</td>
					<td>
						<input type=submit value="수정" name=btnname>
						<!-- <table border=0  cellspacing="1" cellpadding="0">
						<tr>
							<td><input type=image src="../images/mobile/save.gif" onclick="checksubmitEdit(this.form);" alt="수정"></td>
						</tr>
						<tr>
						</tr>
							<td height=1></td>
						<tr>
							<td><input type=image src="../images/mobile/cancel.gif" onclick="checksubmitDel(this.form);" alt="삭제"></td>
						</tr>
						</table>
					</td> -->
				</tr>

				</form>

			<%
			rs.movenext
			i=i+1
			loop
			rs.close
			rowcount = i
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			totHap = kmoneyHap + tmoneyHap
			if vatflag="y" then
				rs_vatflag = "VAT포함"
			elseif vatflag="n" then
				rs_vatflag = "VAT별도"
			else
				rs_vatflag = "비과세"
			end if
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			%>

				<tr height=25 bgcolor=#FEF7F1 align=center>
					<td colspan=4 align=right><B>합 계<!--(<%=rs_vatflag%>)-->&nbsp;</td>
					<td colspan=2 align=right><B><%=formatnumber(tothap,0)%>&nbsp;</td>
					<td></td>
				</tr>
		</table>
</td>
</tr>
<%If left(session("AAusercode"),5) = "19209" Then %>
<!--<tr>
<td align="left">
<br>
<b>[플러스원]</b>
<br>
계육 가공 및 배송비
</td>
</tr>-->
<!--<tr>
<td>
	<table cellspacing=0 cellpadding=0 width="100%" border=0>
	<tr>
		<td align=center>

		<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width=9%><B>코드</td>
				<td width=22%><B>상품명</td>
			
				<td width=8%><B>단가</td>
				<td width=8%><B>수량</td>
				<td width=11%><B>공급가</td>
				<td width=9%><B>세액</td>
				
			</tr>

			<%
			i=1
			tothap = 0
			kmoneyHap = 0
			tmoneyHap = 0
			do until rsPlus.eof
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				taxGubun = "과세"			'과세/비과세 / vatflag
				kmoney   = rsPlus("cartpprice")*rsPlus("pcnt")	'공급가액
				vatflag="y"
				if taxGubun="과세" then
					if vatflag="y" then	'포함
						imsimoney = round(rsPlus("cartpprice")*(100/110),0)
						taxmoney  = (rsPlus("cartpprice")-imsimoney)*rsPlus("pcnt")
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
				if taxmoney="" then taxmoney=0
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				kmoneyHap = kmoneyHap + imsikkmoney
				tmoneyHap = tmoneyHap + taxmoney
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				tothap = tothap + (rsPlus("cartpprice")*rsPlus("pcnt"))
			%>

				<form action="mAgencyOrderCartDel.asp" name=form<%=i%> method=post>
				<input type=hidden name=idx value="<%=rsPlus("cartidx")%>">

				<tr height=25 bgcolor=white align=center>
					<td><%=rsPlus("pcode")%></td>
					<td align=left>&nbsp;<B><%=rsPlus("pname")%></td>
					
					<td align=right><%=formatnumber(rsPlus("cartpprice"),0)%>&nbsp;</td>
					<td><%=rsPlus("pcnt")%>&nbsp;</td>
					<td align=right><%=formatnumber(imsikkmoney,0)%>&nbsp;</td>
					<td align=right><%=formatnumber(taxmoney,0)%>&nbsp;</td>
					 <td>
						<input type=submit value="수정" name=btnname>
						<input type=submit value="삭제" name=btnname> 
					</td>
				</tr>

				</form>

			<%
			rsPlus.movenext
			i=i+1
			loop
			rsPlus.close
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			totHap = kmoneyHap + tmoneyHap
			if vatflag="y" then
				rs_vatflag = "VAT포함"
			elseif vatflag="n" then
				rs_vatflag = "VAT별도"
			else
				rs_vatflag = "비과세"
			end if
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			%>

				<tr height=25 bgcolor=#FEF7F1 align=center>
					<td colspan=4 align=right><B>합 계(<%=rs_vatflag%>)&nbsp;</td>
					<td colspan=2 align=right><B><%=formatnumber(tothap,0)%>&nbsp;</td>
				</tr>
		</table>

		</td>
		</table>

		</td>
	</tr>-->
	<%End If %>
</table>


<BR>

<table align=center>

<form action="orderok3.asp" name=frm method=post onsubmit="return checkwrite();">
<input type=hidden name="pcode" value="<%=pcode%>">
<input type=hidden name="ordernum" value="<%=ordernum%>">
<input type=hidden name="rowcount" value="<%=rowcount%>">
	<tr> 
		<td height=30 align=center>
			<input type="image" name="btnsubmit" src="../images/mobile/cartok.gif" border=0>
			<a href="mAgencyOrderCartDel.asp"><img src="../images/mobile/cartdel.gif" border=0></a>
			<a href="mAgencyOrderFRM.asp?popnot=1&searcha=<%=searcha%>&searchb=<%=searchb%>"><img src="/images/admin/l_bu07.gif" border=0></a>
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

<!--#include virtual="/adminpage/incfile/mbottom2.asp"-->