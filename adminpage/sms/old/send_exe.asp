<%
if session("sessionid") = "" or isnull(session("sessionid")) = true then
	response.redirect("check.html")
end if
%>
<!-- #include file = "./DBConnect.inc"  -->
<%
strcallback = request.form("callback")
strcomment = request.form("message")
strresOrNot = request.form("resOrNot")
dtmdate = request.form("date")
dtmtime = request.form("time")
officenum = session("sessionid")

Dim strsendnum, all_count
strsendnum = request.form("receiver")
all_count = Count_receiver(strsendnum)	'' 전체 수신자 수
g_ECount = all_count
g_GCount = all_count

Dim g_TM()
ReDim g_TM(all_count)
'' ---------------------------------------------

Dim g_RecKey(), g_GroupKey()
ReDim g_RecKey(g_ECount), g_GroupKey(g_GCount)

Dim i
Dim k, v_unit, strTemp
Dim RecDB, GroupDB

g_ECount = 0
g_GCount = 0

for k = 0 to all_count-1
	v_unit = Trim(Extract_Word(strsendnum, k+1))
	strTemp = "select pk from em_addr_person where userId='"&officenum&"' and personName='"&v_unit&"'"
	Set RecDB = DBConn.Execute(strTemp)

	If Not RecDB.EOF Then
		g_RecKey(g_ECount) = Trim(RecDB("pk"))
'response.write("pk:"&g_RecKey(g_ECount) & "<br>")	'지우기.......................
		g_ECount = g_ECount + 1
		RecDB.Close
	End If
next

Dim g_GMCount
For k=0 to all_count-1
	v_unit = Trim(Extract_Word(strsendnum, k+1))
	If Left(v_unit, 3) = "[G]" Then
		v_unit = Mid (v_unit, 4)
		strTemp = "SELECT gp.pk, count(gr.personpk) cnt FROM em_addr_group gp, em_addr_group_person gr WHERE gp.userid='" &officenum& "' and gp.pk = gr.grouppk and gp.groupname ='" & v_unit & "' GROUP BY gp.pk"
		'Response.Write strTemp	'지우기.......................
		Set GroupDB = DBConn.Execute(strTemp)
	
		If Not GroupDB.EOF Then
			g_GroupKey(g_GCount) = Trim(GroupDB("pk"))
	'response.write("group key:"&g_GroupKey(g_GCount) & "<br>")	'지우기.......................
			g_GMCount = CLng(g_GMCount) + CLng(TRIM(GroupDB("cnt")))
			g_GCount = g_GCount + 1
			GroupDB.Close
		End If
	End If
next

'' 번호/email 직접 입력 추출
g_TMCount=0
For k = 0 to all_count-1
	v_unit = Trim(Extract_Word(strsendnum, k+1))
	If Is_Gadget(v_unit) Then
		g_TM(g_TMCount) = v_unit
		g_TMCount = g_TMCount + 1
	End If
next	

Dim g_TotalReceiverNum  ' 전체 수신인 수 (Group 안에 속한 사람 수 포함) 
g_TotalReceiverNum = CLng(g_TMCount) + CLng(g_ECount) + CLng(g_GMCount)


'Response.Write "g_TMCount : " & g_TMCount & "<br>"	'지우기.......................
'Response.Write "g_ECount : " & g_ECount & "<br>"
'Response.Write "g_GMCount : " & g_GMCount & "<br>"
'Response.Write "Total Receiver Num = " & g_TMCount + g_ECount + g_GMCount & "<br>"

If (g_TotalReceiverNum = 0) then
	call PrintMsg ("수신인이 한 명도 없습니다. 주소록에 있는 이름인지, 그리고 옳은 전화번호인지 확인해 주십시오.<br>전화번호를 입력하실때는 대쉬마크를 사용하세요.(예: 011-1111-1111)<br>여러명의 사용자 입력시에는 ; 기호로 구별을 합니다.")
End If


'-------------------------------------------------------------------------
' 차후에 em_tran 을 채우는 데 이용될 데이타들
'-------------------------------------------------------------------------
Dim recName(180)
Dim recMobile(180)
Dim recGroupName(180)

'-----------------------------------------------------------------------------
' Step 1. 이름 처리 
'-----------------------------------------------------------------------------

Dim MIndex
MIndex=0

for i = 0 to g_ECount - 1
	sql = "select personName, phone from em_addr_person where userId='"&officenum&"' and pk='"& g_RecKey(i) &"'"
	Set rst = DBConn.Execute(sql)

	if Not rst.EOF then
		curGadget = TRIM(rst("phone"))
		if NOT (curGadget = "" OR curGadget = "--") then
			recName(MIndex) = TRIM(rst("personName"))
			recMobile(MIndex) = TRIM(rst("phone"))
			MIndex = MIndex + 1
		end if
	end if	
	rst.Close

next


'-----------------------------------------------------------------------------
' Step 2. 그룹 처리
'-----------------------------------------------------------------------------

Dim curGroupName

for i = 0 to g_GCount - 1
	sql = "SELECT gg.groupname, gp.personname, gp.phone FROM em_addr_person gp, em_addr_group_person gr, em_addr_group gg WHERE gp.userid='" &officenum& "' and gp.pk = gr.personpk and gr.grouppk ='" & g_GroupKey(i) & "' and gr.grouppk=gg.pk"
	Set rst = DBConn.Execute(sql)
	
	'Response.Write sql
	Dim curGadget, curBeeper

	Do While Not rst.EOF
		curGadget = TRIM(rst("phone"))
		if NOT (curGadget = "" OR curGadget = "--") then
			recMobile(MIndex) = curGadget
			recName(MIndex) = TRIM(rst("groupname")) & ";" & TRIM(rst("personname"))
			MIndex = MIndex + 1
		end if
		
		'recName(MIndex) = TRIM(rst("Name"))
		'recGroupName(MIndex) = TRIM(rst("GroupName"))
		'MIndex = MIndex + 1
		rst.MoveNext
	Loop
	
	rst.Close
next
		
'-----------------------------------------------------------------------------
' Step 3. 번호직접 입력 처리
'-----------------------------------------------------------------------------
For i = 0 to g_TMCount - 1
	
	recMobile(MIndex) = g_TM(i)
	recName(MIndex) = g_TM(i)
	MIndex = MIndex + 1
Next
	'Response.Write MIndex & "----<br>"


'-------------------------------------------------------------------------
' Step 4. 원문 메시지에 꼬리말 덧붙이고 메시지 쪼개기
'-------------------------------------------------------------------------

'const MaxSplitNum = 10		 ' 메시지가 이 이상 쪼개지는 것은 허용치 않는다.
const MaxMsgLen = 75       ' 메시지 한 패킷의 최고 길이 (실제로는 74 byte까지 쪼개진다.)
Dim g_splitNum                                             ' Message 가 몇 개로 쪼개졌는가?
Dim g_strSplitedMsg(10)

	if (CountByte(strcomment) <= MaxMsgLen + 1) then
		g_splitNum = 1
		g_strSplitedMsg(1) = strcomment
	Else		
		g_splitNum = MySplit(strcomment, MaxMsgLen - 5)                   ' 5 를 빼는 이유는 (1/3) 과 같은 메시지 때문 
	End If


'-----------------------------------------------------------------------------
' DB 입력 (em_tran)
'-----------------------------------------------------------------------------

if strresOrNot="soon" then
		temp_year = year(date)
		temp_month = month(date)
		temp_day = day(date)
		temp_hour = hour(time)
		temp_minute = minute(time)
		temp_second = second(time)
		If Len(temp_month) = 1 Then
			temp_month = "0"&temp_month
		End If
		If Len(temp_day) = 1 Then
			temp_day = "0"&temp_day
		End If
		If Len(temp_hour) = 1 Then
			temp_hour = "0"&temp_hour
		End If
		If Len(temp_minute) = 1 Then
			temp_minute = "0"&temp_minute
		End If
		If Len(temp_second) = 1 Then
			temp_second = "0"&temp_second
		End If
		temp_date = temp_year & temp_month & temp_day

	SendDate = temp_date & " " & temp_hour & ":" & temp_minute & ":" & temp_second
else
	SendDate = dtmdate & " " & Left(dtmtime, 2) & ":" & Right(dtmtime, 2) & ":00"
end if

dim lop
lop=0
For i = 1 to g_splitNum
	if (g_splitNum = 1) then
		strSplitHeader = ""
	else
		strSplitHeader = "[" & i & "/" & g_splitNum & "]"
	end if
	strcomment=	strSplitHeader & g_strSplitedMsg(i)
	
	For j = 0 to MIndex - 1
	'Response.Write recMobile(j) & "<br>"
	'Response.Write recName(j) & "<br>"

		sql = "insert into em_tran(tran_id ,tran_phone, tran_callback, tran_msg, tran_date, tran_status, tran_etc1) values ('"&officenum&"' ,'"& recMobile(j) &"', '"& strcallback &"', '"& strcomment &"' , '"& SendDate &"', '1' , '"& recName(j) &"')" 
		'Response.Write sql & "<br>"
		set rs = DBConn.Execute(sql)
		
		sql1 = "select max(tran_pr) from em_tran"
		Set rs1 = DBConn.Execute(sql1)
		tran_pr=CLng(rs1(0)) - lop

		sql2 = "update em_tran set tran_etc4='" & tran_pr &"' where tran_pr='" & rs1(0) &"'"
		Set rs2 = DBConn.Execute(sql2)
		lop=lop+1
	Next
Next

%>
<%
	DBConn.close
	set DBConn=nothing
%>
<html>
<head>
<title>입력완료</title>
</head>
<body>
<center>
<table border=0 cellpadding=0 cellspacing=0 align="center"><br><br><br>
<tr>
<td align="center" bgcolor="#aa8c9b"><font face="굴림" size=2 color="#FFFFFF"><a href='./send_msg.asp'>-메시지가 성공적으로 전송되었습니다.</a></font></td>
</tr>
</table>
</center>
<%
'response.write strresOrNot & "<br>"
'response.write SendDate & "<br>"
%>
</body>
</html>

<%
'-------------------------
' SubRoutine, Function 모음
'--------------------------

'---------------------------------------------------------------------------
' Name: PrintMsg
' Purpose: Print Error or Success message and Auto-Redirect to send_msg.asp
' Argument: text  (출력할 메시지)
' Assumption: HTML 문서가 한 번도 출력된 적이 없다.
'--------------------------------------------------------------------------

Sub PrintMsg (text)

Response.Write "<html><head>" & vbCRLF
Response.Write "<SCRIPT LANGUAGE=""JavaScript"">" & vbCRLF
Response.Write "<!--" & vbCRLF
Response.Write "function Go()" & vbCRLF
Response.Write "{" & vbCRLF
Response.Write "setTimeout(""location.href = 'send_msg.asp'"",500)" & vbCRLF
Response.Write "}" & vbCRLF
Response.Write "//-->" & vbCRLF
Response.Write "</SCRIPT>" & vbCRLF
Response.Write "</head>" & vbCRLF
Response.Write "<body onLoad=""Go();"">" & vbCRLF
Response.Write "<table width=100% height=80% >"
Response.Write "<tr><td align=center>" & vbCRLF
Response.Write "<font size=2 color=blue face=""돋움"">" & vbCRLF
Response.Write text & vbCRLF
Response.Write "<br><br><input type=button value='메시지 재작성' onClick=history.back()>"
Response.Write "</font></center>" & vbCRLF
Response.Write "</td></tr></table>" & vbCRLF
Response.Write "</body></html>" & vbCRLF
Response.End

End Sub


'-------------------------------------------------------------------------
' text 가 몇바이트짜리 문자열인가를 리턴
'-------------------------------------------------------------------------
Function CountByte(text)
	Dim mycount
	Dim k
	Dim vtemp
    For k=1 to Len(text)    
        vtemp  = Mid(text, k, 1)
        If Len(Hex(Asc(vtemp))) = 2 Then
            mycount = mycount + 1
        ElseIf Len(Hex(Asc(vtemp))) = 4 Then
            mycount = mycount + 2
        End If
    Next
    CountByte = mycount
End Function

'--------------------------------------------------------------------------
' 메시지를 쪼개는 함수
' text 로 넘어온 문자열을 packetLen 만큼의 byte 수로 나누어
' g_strSplitedMsg 라는 전역변수배열 (zero-indexed)  에 넣는다.
' 
' Return : 쪼개어진 개수
'--------------------------------------------------------------------------
Function MySplit(text, ByVal packetLen)
	Dim textLen, curMsgLen, splitNum
	textLen = Len(text)
	curMsgLen = 0
	splitNum = 1

	Dim i, vtemp
	for i = 1 to textLen
			vtemp = Mid(text, i, 1)
			g_strSplitedMsg(splitNum) = g_strSplitedMsg(splitNum) & vtemp
			If Asc(vtemp) < 0 then
				curMsgLen = curMsgLen + 2
			else
				curMsgLen = curMsgLen + 1
			End If
			if (curMsgLen >= packetLen) AND (i <> textLen) then
				curMsgLen = 0
				splitNum = splitNum + 1
			end if
	Next
	MySplit = splitNum
End Function


'--------------------------------------------------------------------------
' Message Key 만들어내는 함수  sYYYYMMDDHHMMSSxxxx 19자  s : site 식별자
'--------------------------------------------------------------------------
Function MakeMsgKey
	Application.Lock
	MakeMsgKey = "h" & Year(Date) & FillZero(Month(Date),2) & FillZero(Day(Date),2) &_
					FillZero(Hour(Time),2) & FillZero(Minute(Time),2) & FillZero(Second(Time),2) &_
					FillZero(Application("count"), 4)
	Application("count") = (Application("count") + 1) mod 1000
	Application.UnLock
End Function


'--------------------------------------------------------------------------
' FillZero (arrNumber, nWidth)
' arrNumber 를 nWidth 의 길이로 바꾼다. ex)  FillZero(3, 4) ->  0003
'--------------------------------------------------------------------------
Function FillZero (arrNumber, nWidth)
	Dim curLen
	FillZero = arrNumber
	curLen =  Len(arrNumber)
	
	Dim i
	for i = 1 to nWidth - curLen
		FillZero = "0" & FillZero
	next
	
End Function

''-----------------------------
'' by parkboo
'' 받을사람 수 계산
''----------------------------
Function Count_receiver(pre_text)
	Dim count_sect, needed_word, text, len_text, temp_char
	
	count_sect = 0
	needed_word = ""
	text = Trim(pre_text)
	len_text = Len(text)

	For i=1 to len_text
		temp_char = Mid(text, i, 1)
		If temp_char = ";" Then
			count_sect = count_sect + 1
		End If
	Next
	If Not Mid(text,len_text,1) = ";" Then
		count_sect = count_sect + 1
	End If
	Count_receiver = count_sect
End Function

'' ; 으로 구분된 받을 사람 parsing
Function Extract_Word(pre_text, order)
	Dim count_sect, needed_word, text, len_text, temp_char, i
	
	count_sect = 0
	needed_word = ""
	text = Trim(pre_text)
	len_text = Len(text)

	For i=1 to len_text
		temp_char = Mid(text, i, 1)
		If temp_char = ";" Then
			count_sect = count_sect + 1
			If count_sect = order Then
				Extract_Word = needed_word
				Exit For
			Else
				needed_word = ""
			End If
		ElseIf i = len_text Then
			needed_word = needed_word & temp_char
			Extract_Word = needed_word
		Else
			needed_word = needed_word & temp_char
		End If
	Next
End Function

'' text가 전화번호인지 판별
Function Is_Gadget(text)
	If Mid(Trim(Extract_Word_2(text,1)),1,2)  = "01"   And Len(Trim(Extract_Word_2(text,3))) = 4 And Len(Trim(Extract_Word_2(text,2))) > 2  Then
		Is_Gadget = "true"
	ElseIf Mid(Trim(Extract_Word_2(text,1)),1,2)  = "01"   And (Len(Trim(text)) = 10 or Len(Trim(text)) = 11) Then
		Is_Gadget = "true"
	Else 
		Is_Gadget = "false"
	End If
End Function

'' 전화번호에서 -로 구분된 걸 추출하는 것으로 추측됨
Function Extract_Word_2(pre_text, order)
	Dim count_sect, needed_word, text, len_text, temp_char, i

	count_sect = 0
	needed_word = ""
	text = Trim(pre_text)
	len_text = Len(text)

	For i=1 to len_text
		temp_char = Mid(text, i, 1)
		If temp_char = "-" Then
			count_sect = count_sect + 1
			If count_sect = order Then
				Extract_Word_2 = needed_word
				Exit For
			Else
				needed_word = ""
			End If
		ElseIf i = len_text Then
			needed_word = needed_word & temp_char
			Extract_Word_2 = needed_word
		Else
			needed_word = needed_word & temp_char
		End If
	Next
End Function

'' text가 전자우편주소인지 판별
Function Is_Email(text)
	Dim char_count, count_point, is_at, k

	char_count = Len(Trim(text))
	count_point = 0
	is_at = "False"
	For k=1 to char_count
		If Mid(text, k, 1) = "@" and k>1 Then
			is_at = "True"
		End If
		If Mid(text, k, 1) = "." and k>1 Then
			count_point = count_point + 1
		End If
	Next
	If is_at="True" and count_point > 0 Then
		Is_Email = "true"
	Else
		Is_Email = "false"
	End If
End Function


'--------------------------------------------------------------------------
' SubRoutine, Function 정의 끝 
'--------------------------------------------------------------------------
%>