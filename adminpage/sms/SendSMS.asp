<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<%
	'--------------------------------------------------------------------------------------------------------------------
	'# 자바스크립트 alert창
	'# alertFlag     1:이전페이지 이동    2:지정페이지이동    3:부모창 새로고침 후 자신창 닫기    4:부모창 새로고침만    
	'#               5:프레임 있을때 이동
	'# alertMsgFlag  y: 메세지내용 뿌림   n:메세지내용 안뿌림
	'# alertMsg	 메세지내용
	'# alertURL	 이동할 주소
	'--------------------------------------------------------------------------------------------------------------------
	searcha = request("searcha") 'oderflag
	searchb = request("searchb") 'idxsub
	searchc = request("searchc") 'bidx
	searchd = request("searchd") '검색 조건(코드, 명)
	searche = request("searche") '검색명
	searchf = request("searchf") '문자내용
	searchg = request("searchg")
	searchh = request("searchh")
	CallNumber = request("CallNumber")

	'CallNumber , 삭제 
	If CallNumber <> "" Then 
		If Len(CallNumber) > 4 Then 
			clenth = Len(CallNumber) -3
			CallNumber = Left(CallNumber, clenth)
		End  if 
	End If 
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end If
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select bidx,bname from tb_company_brand "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" order by bname asc "
	rs.Open sql, db, 1
	if not rs.eof then
		brand_array    = rs.GetRows
		brand_arraynum = ubound(brand_array,2)
	else
		brand_array    = ""
		brand_arraynum = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,comname from tb_company where flag='2' and bidxsub = "& left(session("Ausercode"),5) &" order by comname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		jisaarray = rs.GetRows
		jisaarrayint = ubound(jisaarray,2)
	else
		jisaarray = ""
		jisaarrayint = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'추가된 거래처 출력
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname, hp1 + hp2 + hp3 hp from tb_company"
	SQL = SQL & " where BIDXSUB = '"& left(session("Ausercode"),5) &"' "
	SQL = SQL & " AND flag= '3'"
	SQL = SQL & " AND tcode in ('" & CallNumber &"')"
	'response.write SQL & "<br>"
	rs.Open sql, db, 1

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname, hp1 + hp2 + hp3 hp from tb_company "
	SQL = SQL & " where BIDXSUB = '"& left(session("Ausercode"),5) &"' "
	SQL = SQL & " AND flag= '3'"
	If searcha <> "a" And  searcha <> "" Then 
		If searcha = "6" Then 
			SQL = SQL & " and 0 > (ye_money - mi_money) "
		Else 
			SQL = SQL & " and orderflag = '" & searcha & "' "     '오더플래그
		End if 
	End If 
	If searchb <> "a" And searchb <> "" Then
	    SQL = SQL & " and idxsub = '" & searchb & "'"     '지사
	End If 
	If searchc <> "a" And searchc <> "" Then      '브랜드
		SQL = SQL & " and cbrandchoice = '"& searchc &"' "
	End If 
	If searchd = "chainname" Then      '브랜드
		SQL = SQL & " and comname like '%"& searche &"%' "
	ElseIf searchd = "chaincode" Then 
		SQL = SQL & " and tcode = '"& searche &"' "
	End If 
	'response.write SQL
	rslist.Open SQL, db, 1
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>&nbsp;&nbsp;[ SMS 전송 ]</td>
	</tr>
	<tr>
		<td>
		<font color=red>&nbsp;&nbsp;① '체인점 검색'에서 문자메시지를 전송할 체인점 검색<br>
		&nbsp;&nbsp;② '검색결과'에서 '전체' 또는 '일부'를 선택한 후, [>>]로 추가(반복가능)<br>
		&nbsp;&nbsp;③ [문자보내기]로 SMS 전송(30원/건 부과)</font>
		</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="SendSMS.asp" method="POST" name="form">
	<tr>
		<td nowrap width="85" bgcolor="#F7F7FF" height="25"> &nbsp;<B>체인점 검색<BR> </td>
		<td nowrap bgcolor="#FFFFFF" height="25">
			<select name="searcha" size="1" class="box_work">
          		<option value="a" <%if searcha = "a" then%>selected<%end if%>>전체
          		<option value="y" <%if searcha = "y" then%>selected<%end if%>>주문중
				<option value="4" <%if searcha = "4" then%>selected<%end if%>>경고1(주문)
				<option value="5" <%if searcha = "5" then%>selected<%end if%>>경고2(주문)
				<option value="1" <%if searcha = "1" then%>selected<%end if%>>미수금(정지)
				<option value="2" <%if searcha = "2" then%>selected<%end if%>>폐업(정지)
				<option value="3" <%if searcha = "3" then%>selected<%end if%>>휴업(정지)
				<option value="6" <%if searcha = "6" then%>selected<%end if%>>여신초과
        	</select>
			<select name="searchb" size="1" class="box_work">
          			<option value="a" <%if searchb = "a" then%>selected<%end if%>>지사(점)전체</option>
				<%if jisaarrayint <> "" then%>
					<%for i=0 to jisaarrayint%>
		          		<option value="<%=jisaarray(0,i)%>" <%if searchb=cstr(jisaarray(0,i)) then%>selected<%end if%>><%=jisaarray(1,i)%>
					<%next%>
				<%end if%>
        	</select>
			<select name="searchc" size="1" class="box_work">
        	  		<option value="a">브랜드전체</option>
				<%if brand_arraynum<>"" then%>
					<%for i=0 to brand_arraynum%>
		        	  	<option value="<%=brand_array(0,i)%>" <%if searchc = cstr(brand_array(0,i)) then%>selected<%end if%>><%=brand_array(1,i)%></option>
					<%next%>
				<%end if%>
	        </select>
			<select name="searchd" size="1" class="box_work">
				<option value="a" <%if searchd="a" then%>selected<%end if%>>검색구분 선택
	          	<option value="chaincode" <%if searchd="chaincode" then%>selected<%end if%>>체인점코드
	          	<option value="chainname" <%if searchd="chainname" then%>selected<%end if%>>체인점명
        	</select>
			<input type="Text" name="searche" size="20" maxlength="20" class="box_work" value="<%=searche%>">
	        <input type="button" name="검 색" value="검 색 "  class="box_work" onclick="javascript:sendSMSSearch(this.form);">
	        <input type="button" name="초기화" value="초기화" class="box_work" onclick="javascript:frmzerocheck(this.form,'SendSMS.asp');">
		</td>
	</tr>
	<input name="CallNumber" type=hidden>
</form>
</table>

<table border="1" cellspacing="0" cellpadding="1" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
<form name="formmessage" action="SendSMSok.asp" method="POST">
	<tr>
		<td nowrap width="81" bgcolor="#F7F7FF" height="25" rowspan="2"> &nbsp;<B>메시지 입력<BR> </td>
		<td nowrap bgcolor="#FFFFFF" height="25" align=right>
		<input type="Text" name="searche" size="80" maxlength="80" class="box_work" value="<%=searchf%>" onKeyup="javascript:maxLengthCheck('80', null, this, byteprint);">

		<input type="button" name="검 색" value="검 색 "  class="box_work" onclick="window.open('sms_formList.asp','','top=100,left=100,width=760,height=360'); return false;"  >
	        <input type="button" name="초기화" value="초기화" class="box_work" onclick="javascript:messageclear(this.form);">
			</td>
	</tr>
	<tr align=left>
		<td>
		<span style="color:blue">[체인점명]</span><SPAN style="WIDTH: 43em;color:red;">으로 입력하면 체인점 정보에 등록된 "체인점명"으로 자동변경</span>	    
			<input type="Text" name="byteprint" size="10" maxlength="80" class="box_work" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" readonly="true" value="0/80 Byte">	    
		</td>
	</tr>
		<input name="SendNumber" type=hidden>
	</form>
</table>

			<table border="0" cellspacing="1" cellpadding="1" width=100%>
				<form name="PrintArea">
				<tr valign="bottom" height=10>
					<td width="330"><b>[검색결과]</b><br></td>
					<td></td>
					<td width="230"><b>[전송할 체인점]</b><br></td>
				</tr>
				<tr height=20>
					<td >* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
					<td width=40 rowspan=2></td>
					<td>* 전송할 <B><span id="countArea"><%=rs.recordcount%></span></b>개의 데이타가 있습니다.<br></td>

					<td align=right><input type="button" name="문자 보내기" value="문자 보내기" class="box_work" onclick="javascript:sendSMS();"></td>
				</tr>
				<tr>

				</form>
				</tr>
				<tr>
					<td >
						<div id="tempdiv" style="overflow:auto; height:705px;overflow-y:scroll;width:100%">
							<form name="searchitems">
							<table border="0" cellspacing="1" cellpadding="1" width=100%  bgcolor=#BDCBE7 id="searchlist">
								<tr height=28 bgcolor="#F7F7FF" align="center">
									<td width=24><input type="checkbox"  name="searchChk" onclick="javascript:CheckAll('searchlist');"/></td>
									<td width=35>코드</td>
									<td width=150>체인점명</td>
									<td width=96>핸드폰번호</td>
								</tr>

								<%do until rslist.EOF %>
								<tr  bgcolor=#FFFFFF>
									<td align=center><INPUT type="checkbox" name="chk"/></td>
									<td align=center><%=rslist("tcode")%></td>
									<td><%=rslist("comname")%></td>
									<td align=center><%=rslist("hp")%></td>
								</tr>
								<% rslist.MoveNext 
								Loop %>
								</form>
							</table>
						</div>
					</td>
					<td align="center" valign="top"><input type="button" name="add" value=">>"  class="box_work" onclick="javascript:addRow('searchlist');"><br>추가<br><input type="button" name="del" value="<<"  class="box_work" onclick="javascript:deleteRow('sendlist');"><br>삭제
					</td>
					<td  valign="top" colspan=2>
					<!-- -->
						<div id="tempdiv" style="overflow:auto; height:705px; overflow-y:scroll">
						<form name="senditems">
						<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7 id="sendlist">
							<tr height=28 bgcolor=#F7F7FF align=center>
								<td width=24 align=center><input type="checkbox" name="sendChk" onclick="javascript:CheckAll('sendlist');"/></td>
								<td width=35 align=center>코드</td>
								<td width=150>체인점명</td>
								<td width=96>핸드폰번호</td>
							</tr>
							<%do until rs.EOF %>
							<tr bgcolor=#FFFFFF>
								<td align=center><INPUT type="checkbox" name="chk"/></td>
								<td align=center><%=rs("tcode")%></td>
								<td><%=rs("comname")%></td>
								<td align=center><%=rs("hp")%></td>
							</tr>
								<% rs.MoveNext 
								Loop %>
							</form>
						</table>
						</div>
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
if imsierrcnt>0 then
	rslist.close
	set rs=nothing
	set rslist=nothing
end if
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->