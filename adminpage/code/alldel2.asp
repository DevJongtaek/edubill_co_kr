<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	searcha1 = replace(left(now(),10),"-","")
	searcha2 = replace(left(now(),10),"-","")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,comname,tcode,datadel,datadelday "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '1' and serviceflag='2' "
	SQL = sql & " order by comname asc"
	rs.Open sql, db, 1
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 데이타삭제 ]</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>① 체인점별  삭제주기 지정 → 9085 거성푸드 / 9224 테라스 (오늘기준 1개월 이전)</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>② 오늘기준 2주일 이전삭제 → 다중 선택 후, 삭제 ( 나머지 체인본부 모두 )</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="alldelok2.asp" method="POST" name=findkindform>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> 주문데이타 삭제</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" valign=top> 
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
			<tr>
				<td colspan=2>
					<select name="searcha" size="1" class="box_work">
			          		<option value="">선택</option>
          					<option value="1">오늘기준 1주일전 이전 데이타삭제</option>
			          		<option value="2">오늘기준 2주일전 이전 데이타삭제</option>
			          		<option value="3">오늘기준 3주일전 이전 데이타삭제</option>
          					<option value="4">오늘기준 1개월전 이전 데이타삭제</option>
			          		<option value="5">오늘기준 2개월전 이전 데이타삭제</option>
			          		<option value="6" selected>체인점별 삭제주기 지정</option>
			        	</select>
				</td>
			</tr>
			<tr>
				<td width=1>
					<select name="companycode" size="30" class="box_work" multiple >
          					<!--<option value="">회원사 선택</option>-->
						<%
						i=0
						do until rs.eof
							datadel    = rs(3)
							datadelday = rs(4)
							if isnull(datadelday) then
								datadelday = ""
							end if
							if left(datadelday,10)<>left(now(),10) then
						%>
	          						<option value="<%=rs(0)%>" <%if i=0 then%>selected<%end if%>><%=rs(2)%>&nbsp;<%=rs(1)%><%if datadelday<>"" then%>&nbsp;(삭제일자:<%=left(datadelday,10)%>)<%end if%>
								<%i=1%>
							<%end if%>
						<%rs.movenext%>
						<%loop%>
						<%rs.close%>
			        	</select>
				</td>
				<td valign=top align=left>&nbsp; <input type="button" value="삭 제" class="box_work"' onclick="javascript:alldelok3(this.form);"></td>
			</tr>
		</table>		        	
		</td>
	</tr>

</form>

<%
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,comname,tcode "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '1'"
	SQL = sql & " order by comname asc"
	rs.Open sql, db, 1
%>

<form action="alldelok3.asp" method="POST" name=findkindform2>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> 상품/체인점 삭제</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="bcode" size="1" class="box_work">
          		<option value="">회원사 선택</option>
			<%do until rs.eof%>
	          		<option value="<%=rs(0)%>"><%=rs(2)%>&nbsp;<%=rs(1)%>
			<%rs.movenext%>
			<%loop%>
			<%rs.close%>
        	</select>
		<select name="gubun" size="1" class="box_work">
          		<option value="">삭제구분</option>
          		<option value="1">상품데이타
          		<option value="2">체인점데이타
        	</select>
        	<input type="button" value="삭 제" class="box_work"' onclick="javascript:alldelok2(this.form);">
		</td>
	</tr>

</form>

<script>
function alldelokCh1(form){
	if (form.dflag.value=="") {
		alert("삭제구분을 선택해 주시기 바랍니다.") ;
		form.dflag.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.submit() ;
		return false ;
	}
//	form.submit() ;
}

function alldelokCh2(form){
	if (form.dflag.value=="") {
		alert("삭제구분을 선택해 주시기 바랍니다.") ;
		form.dflag.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.submit() ;
		return false ;
	}
//	form.submit() ;
}
</script>
<form action="alldelokS.asp" method="POST" name=findkindform3>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> 세금계산서 삭제</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="dflag" size="1" class="box_work">
          		<option value="">구분</option>
          		<option value="1">최근 6개월 이전 데이터 삭제
          		<option value="2">최근 1년 이전 데이터 삭제
          		<option value="3">최근 2년 이전 데이터 삭제
        	</select>
        	<input type="button" value="삭 제" class="box_work"' onclick="javascript:alldelokCh1(this.form);">
		</td>
	</tr>

</form>

<form action="alldelokI.asp" method="POST" name=findkindform4>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> 입금내역 삭제</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="dflag" size="1" class="box_work">
          		<option value="">구분</option>
          		<option value="1">최근 6개월 이전 데이터 삭제
          		<option value="2">최근 1년 이전 데이터 삭제
          		<option value="3">최근 2년 이전 데이터 삭제
        	</select>
        	<input type="button" value="삭 제" class="box_work"' onclick="javascript:alldelokCh2(this.form);">
		</td>
	</tr>

</form>

</table>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->