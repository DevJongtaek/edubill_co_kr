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
all_count = Count_receiver(strsendnum)	'' ��ü ������ ��
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
'response.write("pk:"&g_RecKey(g_ECount) & "<br>")	'�����.......................
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
		'Response.Write strTemp	'�����.......................
		Set GroupDB = DBConn.Execute(strTemp)
	
		If Not GroupDB.EOF Then
			g_GroupKey(g_GCount) = Trim(GroupDB("pk"))
	'response.write("group key:"&g_GroupKey(g_GCount) & "<br>")	'�����.......................
			g_GMCount = CLng(g_GMCount) + CLng(TRIM(GroupDB("cnt")))
			g_GCount = g_GCount + 1
			GroupDB.Close
		End If
	End If
next

'' ��ȣ/email ���� �Է� ����
g_TMCount=0
For k = 0 to all_count-1
	v_unit = Trim(Extract_Word(strsendnum, k+1))
	If Is_Gadget(v_unit) Then
		g_TM(g_TMCount) = v_unit
		g_TMCount = g_TMCount + 1
	End If
next	

Dim g_TotalReceiverNum  ' ��ü ������ �� (Group �ȿ� ���� ��� �� ����) 
g_TotalReceiverNum = CLng(g_TMCount) + CLng(g_ECount) + CLng(g_GMCount)


'Response.Write "g_TMCount : " & g_TMCount & "<br>"	'�����.......................
'Response.Write "g_ECount : " & g_ECount & "<br>"
'Response.Write "g_GMCount : " & g_GMCount & "<br>"
'Response.Write "Total Receiver Num = " & g_TMCount + g_ECount + g_GMCount & "<br>"

If (g_TotalReceiverNum = 0) then
	call PrintMsg ("�������� �� �� �����ϴ�. �ּҷϿ� �ִ� �̸�����, �׸��� ���� ��ȭ��ȣ���� Ȯ���� �ֽʽÿ�.<br>��ȭ��ȣ�� �Է��ϽǶ��� �뽬��ũ�� ����ϼ���.(��: 011-1111-1111)<br>�������� ����� �Է½ÿ��� ; ��ȣ�� ������ �մϴ�.")
End If


'-------------------------------------------------------------------------
' ���Ŀ� em_tran �� ä��� �� �̿�� ����Ÿ��
'-------------------------------------------------------------------------
Dim recName(180)
Dim recMobile(180)
Dim recGroupName(180)

'-----------------------------------------------------------------------------
' Step 1. �̸� ó�� 
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
' Step 2. �׷� ó��
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
' Step 3. ��ȣ���� �Է� ó��
'-----------------------------------------------------------------------------
For i = 0 to g_TMCount - 1
	
	recMobile(MIndex) = g_TM(i)
	recName(MIndex) = g_TM(i)
	MIndex = MIndex + 1
Next
	'Response.Write MIndex & "----<br>"


'-------------------------------------------------------------------------
' Step 4. ���� �޽����� ������ �����̰� �޽��� �ɰ���
'-------------------------------------------------------------------------

'const MaxSplitNum = 10		 ' �޽����� �� �̻� �ɰ����� ���� ���ġ �ʴ´�.
const MaxMsgLen = 75       ' �޽��� �� ��Ŷ�� �ְ� ���� (�����δ� 74 byte���� �ɰ�����.)
Dim g_splitNum                                             ' Message �� �� ���� �ɰ����°�?
Dim g_strSplitedMsg(10)

	if (CountByte(strcomment) <= MaxMsgLen + 1) then
		g_splitNum = 1
		g_strSplitedMsg(1) = strcomment
	Else		
		g_splitNum = MySplit(strcomment, MaxMsgLen - 5)                   ' 5 �� ���� ������ (1/3) �� ���� �޽��� ���� 
	End If


'-----------------------------------------------------------------------------
' DB �Է� (em_tran)
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
<title>�Է¿Ϸ�</title>
</head>
<body>
<center>
<table border=0 cellpadding=0 cellspacing=0 align="center"><br><br><br>
<tr>
<td align="center" bgcolor="#aa8c9b"><font face="����" size=2 color="#FFFFFF"><a href='./send_msg.asp'>-�޽����� ���������� ���۵Ǿ����ϴ�.</a></font></td>
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
' SubRoutine, Function ����
'--------------------------

'---------------------------------------------------------------------------
' Name: PrintMsg
' Purpose: Print Error or Success message and Auto-Redirect to send_msg.asp
' Argument: text  (����� �޽���)
' Assumption: HTML ������ �� ���� ��µ� ���� ����.
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
Response.Write "<font size=2 color=blue face=""����"">" & vbCRLF
Response.Write text & vbCRLF
Response.Write "<br><br><input type=button value='�޽��� ���ۼ�' onClick=history.back()>"
Response.Write "</font></center>" & vbCRLF
Response.Write "</td></tr></table>" & vbCRLF
Response.Write "</body></html>" & vbCRLF
Response.End

End Sub


'-------------------------------------------------------------------------
' text �� �����Ʈ¥�� ���ڿ��ΰ��� ����
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
' �޽����� �ɰ��� �Լ�
' text �� �Ѿ�� ���ڿ��� packetLen ��ŭ�� byte ���� ������
' g_strSplitedMsg ��� ���������迭 (zero-indexed)  �� �ִ´�.
' 
' Return : �ɰ����� ����
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
' Message Key ������ �Լ�  sYYYYMMDDHHMMSSxxxx 19��  s : site �ĺ���
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
' arrNumber �� nWidth �� ���̷� �ٲ۴�. ex)  FillZero(3, 4) ->  0003
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
'' ������� �� ���
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

'' ; ���� ���е� ���� ��� parsing
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

'' text�� ��ȭ��ȣ���� �Ǻ�
Function Is_Gadget(text)
	If Mid(Trim(Extract_Word_2(text,1)),1,2)  = "01"   And Len(Trim(Extract_Word_2(text,3))) = 4 And Len(Trim(Extract_Word_2(text,2))) > 2  Then
		Is_Gadget = "true"
	ElseIf Mid(Trim(Extract_Word_2(text,1)),1,2)  = "01"   And (Len(Trim(text)) = 10 or Len(Trim(text)) = 11) Then
		Is_Gadget = "true"
	Else 
		Is_Gadget = "false"
	End If
End Function

'' ��ȭ��ȣ���� -�� ���е� �� �����ϴ� ������ ������
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

'' text�� ���ڿ����ּ����� �Ǻ�
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
' SubRoutine, Function ���� �� 
'--------------------------------------------------------------------------
%>