<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<%
	'--------------------------------------------------------------------------------------------------------------------
	'# 날짜관련 함수
	'# FunYMDHMS(dflag)	년월일시분초 가져오는 함수
	'#    			4:yyyy    6:yyyymm    8:yyyymmdd    10:yyyymmddhh    12:yyyymmddhhmm    14:yyyymmddhhmmss
	'# DateFormatReplace	20090605123541 -->> 2009-06-05 12:35:41
	'#    			psDate:데이타	psDateflag:날짜구분값	psDategubun:1=날짜전체 2=시간만
	'# SelectDateChoice	년월일 콤보박스
	'#    			yearDa:년도값    monthDa:월값    dayDa:일값    yvalD:년도이름    mvalD:월이름    dvalD:일이름
	'# alertURL	 이동할 주소
	'--------------------------------------------------------------------------------------------------------------------
	Function DateFormatReplace(psDate,psDateflag,psDategubun)
		if psDateflag="" then
			psDateflag = "-"
		end if
		if psDategubun="" then
			psDategubun = "1"
		end if

		if psDategubun="1" then
	        	if IsNull(psDate) OR Len(psDate)=0 then 
        	        	DateFormatReplace="" 
        		elseif Len(psDate)=6 then 
      	          		DateFormatReplace = Left(psDate,4) & psDateflag & Right(psDate,2) 
        		elseif Len(psDate)=8 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & Right(psDate,2) 
  			elseif Len(psDate)=12 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & mid(psDate,7,2) & " " & mid(psDate,9,2) & ":" & right(psDate,2) 
  			elseif Len(psDate)=14 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & mid(psDate,7,2) & " " & mid(psDate,9,2) & ":" & mid(psDate,11,2)  & ":" & mid(psDate,13,2)
			else 
	                	DateFormatReplace = psDate 
        		end if 
		else
	        	if IsNull(psDate) OR Len(psDate)=0 then 
        	        	DateFormatReplace="" 
        		elseif Len(psDate)=4 then 
                		DateFormatReplace = mid(psDate,1,2) & ":" & mid(psDate,3,2)
        		elseif Len(psDate)=6 then 
                		DateFormatReplace = mid(psDate,1,2) & ":" & mid(psDate,3,2) & ":" & mid(psDate,5,2)
			else 
	                	DateFormatReplace = psDate 
        		end if 
		end if
	End Function 
	Function regsendval(val)
		regsend1 = "0,1,A,B,C,D,2,A,B,C,D,E,F,G,H,I,J"
		regsend2 = "성공,Time Out,호처리중,음영지역,Power off,저장수초과,잘못된번호,일시정지,기타문제,착신거절,기타,형식오류,형식오류,불가단말기,호불가상태,메시지삭제,Que Full"
		regsend1array = split(regsend1,",")
		regsend2array = split(regsend2,",")
		if val<>"" then
			imsii = ""
			for k=0 to ubound(regsend1array)
				if trim(regsend1array(k))=val then
					regsendval = regsend2array(k)
					exit for
				end if
			next
		end if
	End Function 

	Function FunHPCut(Hvalnum)	'핸드폰번호0111111111->011-111-1111
		if Hvalnum<>"" and len(Hvalnum)>=10 then
			imsilenhp  = len(Hvalnum)	'전체길이
			imsilenhp1 = left(Hvalnum,3)	'통신사번호
			imsilenhp2 = mid(left(Hvalnum,(imsilenhp-4)),4)	'국번
			imsilenhp3 = right(Hvalnum,4)	'전화반호
			FunHPCut = imsilenhp1&"-"&imsilenhp2&"-"&imsilenhp3
		end if
	End Function

	Function Fundate(Hval)
		if Hval<>"" then
			DATE_MD = Right(Replace(FormatDateTime(Hval,2),"-",""),4)
			DATE_Y  = MID(Replace(FormatDateTime(Hval,2),"-",""),1,4)
			B_DATE  = DATE_Y & DATE_MD 	'월일년
			B_TIME  = left(Replace(FormatDateTime(Hval,4),":",""),6)&Right("00" & second(Hval),2)  '시분초
			IntTime = B_DATE &  B_TIME
		end if
		Fundate = IntTime
	End Function

	sub SelectDateChoice(yearDa,monthDa,dayDa,yvalD,mvalD,dvalD)
		imsiye  = mid(now(),1,4)
		imsimo  = mid(now(),6,2)
		imsida  = mid(now(),9,2)
		if yearDa<>"" then
			response.write "<select name="&yearDa&">"
					response.write "<option value=>선택"
					for i=2008 to (imsiye+1)
						imsiselected = ""
						if yvalD<>"" then
							if cstr(yvalD)=cstr(i) then
								imsiselected = "selected"
							end if
						end if
						response.write "<option value="& i &" "& imsiselected &">"&i&"년"
					next
			response.write "</select>"
		end if
		if monthDa<>"" then
			response.write "<select name="&monthDa&">"
					response.write "<option value=>선택"
					for i=1 to 12
						if i<10 then
							ii=cstr("0"&i)
						else
							ii=cstr(i)
						end if
						imsiselected = ""
						if mvalD<>"" then
							if mvalD=ii then
								imsiselected = "selected"
							end if
						end if
						response.write "<option value="& ii &" "& imsiselected &">"&ii&"월"
					next
			response.write "</select>"
		end if
		if dayDa<>"" then
			response.write "<select name="&dayDa&">"
					response.write "<option value=>전체"
					for i=1 to 31
						if i<10 then
							ii=cstr("0"&i)
						else
							ii=cstr(i)
						end if
						imsiselected = ""
						if dvalD<>"" then
							if dvalD=ii then
								imsiselected = "selected"
							end if
						end if
						response.write "<option value="&ii&" "& imsiselected &">"&ii&"일"
					next
			response.write "</select>"
		end if
	end sub
	'--------------------------------------------------------------------------------------------------------------------
	'# 자바스크립트 alert창
	'# alertFlag     1:이전페이지 이동    2:지정페이지이동    3:부모창 새로고침 후 자신창 닫기    4:부모창 새로고침만    
	'#               5:프레임 있을때 이동
	'# alertMsgFlag  y: 메세지내용 뿌림   n:메세지내용 안뿌림
	'# alertMsg	 메세지내용
	'# alertURL	 이동할 주소
	'--------------------------------------------------------------------------------------------------------------------
	SUB FunAlertMsg(alertFlag,alertMsgFlag,alertMsg,alertURL)
		response.write "<SCRIPT LANGUAGE='JavaScript'>"
			if alertMsgFlag="y" then
				response.write "alert('"& alertMsg &"');"
			end if
			if alertFlag="1" then
				response.write "history.back(-1);"
			elseif alertFlag="2" then
				response.write "location.href='"& alertURL &"';"
			elseif alertFlag="3" then
				response.write "opener.location.reload();window.close();"
			elseif alertFlag="4" then
				response.write "opener.location.reload();"
			elseif alertFlag="5" then
				response.write "window.open('"& alertURL &"', '_top');"
			end if
		response.write "</SCRIPT>"
		response.end
	End SUB
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")

	section = request("section")
	If section = "" Then 
		section = "0" 
	End If 
	if searchd="" then
		searchd = replace(left(now(),4),"-","")
	end if
	if searche="" then
		searche = replace(mid(now(),6,2),"-","")
	end If
	If searchg="전체" Then
	    searchg = ""
	End If
	if searchg="" then
		imsidate = searchd&"-"&searche
	Else
		imsidate = searchd&"-"&searche&"-"&searchg
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode from tb_company where flag='1' and idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		btcode = rs(0)
		'btcode = "9074"
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode,comname from tb_company where flag='3' and bidxsub = "& left(session("Ausercode"),5) &" order by comname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		carray = rs.GetRows
		carrayint = ubound(carray,2)
	else
		carray = ""
		carrayint = ""
	end if
	rs.close

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''	
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select ip,id,pwd,tbname,msg,dbname,cType,msg2,msg3,msg4 from tb_smsSetup "
	rslist.Open sql, db, 1
	ip = rslist(0)
	id = rslist(1)
	pwd = rslist(2)
	tbname = rslist(3)
	msg = rslist(4)
	dbname = rslist(5)
	cType = rslist(6)
	msg2 = rslist(7)
	msg3 = rslist(8)
    msg4 = rslist(9)
	rslist.close
	Set dbsms = Server.CreateObject("ADODB.Connection")
	'dbstr = "provider=sqloledb;server=61.98.130.213;database=handypay;uid=handypay;pwd=handypay;"	'db를 연다
	dbstr = "provider=sqloledb;server="&ip&";database="&dbname&";uid="&id&";pwd="&pwd&";"	'db를 연다
	dbsms.Open dbstr

	imsitable = "sc_log_" & searchd & searche	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	imsitb = "em_log_" & searchd & searche
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select isnull(count(*),0) TotCount from INFORMATION_SCHEMA.tables  where table_name = '"& imsitb &"' "
	rs.Open sql, db, 1
	imsierrcnt = rs(0)
	rs.close
	tbsql = " select * from "& imsitb &" "
	tbsql = tbsql & " where tran_etc2 = '"& btcode &"' "
	if searcha<>"" and searchb<>"" then tbsql = tbsql & " and "& searcha &" like '%"& searchb &"%' "
	if searchc<>"" then tbsql = tbsql & " and tran_etc3 = '"& searchc &"' "
	if searchf="y" then 
		tbsql = tbsql & " and tran_rslt  = '0' "
	elseif searchf="n" then 
		tbsql = tbsql & " and tran_rslt  <> '0' "
	end if
	if len(imsidate)=7 then
		tbsql = tbsql & " and substring(convert(char(10),tran_date,21),1,7) = '"& imsidate &"' "
	else
		tbsql = tbsql & " and convert(char(10),tran_date,21) = '"& imsidate &"' "
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

if imsierrcnt>0 then
	set rslist = server.CreateObject("ADODB.Recordset")

	sql = " select a.*, b.comname,b.tcode from ("& tbsql &") a "
	sql = sql & " left outer join "
	sql = sql & " 	(select comname,tcode as ttcode,idx from tb_company where flag='1' and tcode = '"& btcode &"') c "
	sql = sql & " on a.tran_etc2 = c.ttcode "
	sql = sql & " left outer join "
	sql = sql & " 	(select comname,tcode,bidxsub from tb_company where flag='3') b "
	sql = sql & " on c.idx = b.bidxsub and a.tran_etc3=b.tcode "
	sql = sql & " order by tran_pr asc "
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if

	tcnt = rslist.recordcount
end If

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>
<script language="JavaScript">

<!--

function onlyNumber(){
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}
function posorderwin(){
	window.open ('posDatatorder.asp','dssdsd','width=300,height=180,left=100,top=100');
	return false ;
}

function smsmsgpop(val){
	window.open ('msgpop.asp?msg='+val,'123','width=100,height=120,left=100,top=100');
	return false ;
}
function formsection(value){
	if (value=="0")
	{
		form.section.value="0";
	}
	else
	{
		form.section.value="1";
	}
	form.submit();
}

//-->
</script>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ SMS 전송내역 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="SendList.asp" method="POST" name=form>
	<input type=hidden name=section>
	<tr>
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>전송일자<BR> &nbsp;<B>전송정보 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<%call SelectDateChoice("searchd","searche","searchg",searchd,searche,searchg)%>

			<BR>

			<select name="searchc" size="1" class="box_work">
          			<option value="" <%if searchc="" then%>selected<%end if%>>체인점전체
				<%for i=0 to carrayint%>
	          			<option value="<%=carray(0,i)%>" <%if searchc=cstr(carray(0,i)) then%>selected<%end if%>><%=carray(1,i)%>
				<%next%>
        		</select>
			<!--
			<select name="searchf" size="1" class="box_work">
          			<option value="" <%if searchf="" then%>selected<%end if%>>통신사전체
          			<option value="SKT" <%if searchf="SKT" then%>selected<%end if%>>SKT
          			<option value="KTF" <%if searchf="KTF" then%>selected<%end if%>>KTF
          			<option value="LGT" <%if searchf="LGT" then%>selected<%end if%>>LGT
        		</select>
			-->
			<select name="searchf" size="1" class="box_work">
          			<option value=""  <%if searchf="" then%>selected<%end if%>>전송결과
          			<option value="y" <%if searchf="y" then%>selected<%end if%>>성공
          			<option value="n" <%if searchf="n" then%>selected<%end if%>>실패
        		</select>
			<select name="searcha" size="1" class="box_work">
	          			<option value="" <%if searcha="" then%>selected<%end if%>>검색구분 선택
	          			<option value="tran_phone" <%if searcha="tran_phone" then%>selected<%end if%>>핸드폰번호
	          			<option value="tran_etc3"  <%if searcha="tran_etc3" then%>selected<%end if%>>체인점코드
        		</select>
			<input type="Text" name="searchb" size="20" maxlength="20" class="box_work" value="<%=searchb%>">
	        	<input type="button" name="검 색" value="검 색 "  class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="초기화" value="초기화" class="box_work"' onclick="javascript:frmzerocheck(this.form,'SendList.asp');">
		</td>
	</tr>
</form>
</table>
		<!--#include virtual="adminpage/sms/SendList1.asp"-->
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