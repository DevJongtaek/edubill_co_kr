<%
if session("sessionid") = "" or isnull(session("sessionid")) = true then
	response.redirect("check.html")
end if

browser = request.serverVariables("HTTP_USER_AGENT")
ie = InStr(browser, "MSIE")
if ie Then
	ver = Mid(browser, ie+5,1)
End If

if ver >= 4 then
	ie4 = 1
End If
%>

<!-- #include file = "./DBConnect.inc"  -->
<%
officenum = session("sessionid")

Function Non_To_Point(text)
	If Len(Trim(text)) = 0 Then
		Non_To_Point = "."
	Else
		Non_To_Point = Trim(text)
	End If
End Function
%>
<%
rem Multiple Select tag로부터의 QueryString을 하나씩 나누기 위해.
Function Divide_Select_Query(text, order)
	count_sect = 0
	needed_word = ""
	len_text = Len(text)

	For i=1 to len_text
		temp_char = Mid(text, i, 1)
		If temp_char = "," Then
			count_sect = count_sect + 1
			If count_sect = order Then
				Divide_Select_Query = Trim(needed_word)
				Exit For
			Else
				needed_word = ""
			End If
		ElseIf i = len_text Then
			needed_word = needed_word & temp_char
			Divide_Select_Query = Trim(needed_word)
		Else
			needed_word = needed_word & temp_char
		End If
	Next
End Function

rem Multiple Select tag로부터의 QueryString에서 Query개수를 세기 위해.
Function Count_Select_Query(text)
	count_sect = 0
	len_text = Len(text)

	For i=1 to len_text
		temp_char = Mid(text, i, 1)
		If temp_char = "," Then
			count_sect = count_sect + 1
		End If
	Next
	Count_Select_Query = count_sect + 1
End Function

If Request.QueryString("del") = "삭    제" Then
	Dim v_rec()
	Dim v_group()

	v_receivers = ""

	For h=0 to Request.QueryString("count")-1
		temp_name = "nameof"&h
		query_value = Trim(Request.QueryString(temp_name))
		If Len(query_value) > 1 Then
			v_receivers = v_receivers & ", "&query_value
		End If
	Next
	total_count = Count_Select_Query(v_receivers)
	ReDim v_rec(total_count)
	ReDim v_group(total_count)
	j = 0
	k = 0

	For h=1 to total_count
		temp_2char = Divide_Select_Query(v_receivers,h)
		rem 선택된 것이 독립된 수신자의 경우 
		If Mid(temp_2char,1,1) = "E" Then
			temp_len = Len(temp_2char)
			v_reckey = Mid(temp_2char,2,temp_len-1)
			strTemp = "select count(*) mycount from em_addr_group_person where pk ="&v_reckey
			Set CountDB = DBConn.Execute(strTemp)
			groupcount = CountDB("mycount")
'			rem 어떤 그룹에도 속하지 않을 경우 삭제한다.
'			If groupcount = 0 Then
'				strTemp = "delete em_addr_person where pk = "&v_reckey
'				DBConn.Execute(strTemp)
'			End If

			rem 어떤 그룹에 속해도 삭제한다.
			strTemp = "delete em_addr_person where pk = "&v_reckey
			DBConn.Execute(strTemp)
			strTemp = "delete em_group_person where pk = "&v_reckey
			DBConn.Execute(strTemp)

		rem 선택된 것이 그룹이름일 경우
		ElseIf Mid(temp_2char,1,1) = "G" Then
			temp_len = Len(temp_2char)
			v_groupkey = Mid(temp_2char,2,temp_len-1)

			rem 이 그룹에 속하는 수신자를 찾아내고.
			strTemp = "select pk from em_group_person where gpk = "&v_groupkey
			Set GroupsDB = DBConn.Execute(strTemp)

			rem 이 그룹을 없앤다. 
			strTemp = "delete em_group where gpk = "&v_groupkey
			DBConn.Execute(strTemp)

			rem 이 그룹과 수신자의 연결관계를 끊고.
			strTemp = "delete em_group_person where gpk = "&v_groupkey
			DBConn.Execute(strTemp)

			rem 그 각 수신자에 대해서 em_addr_person에서 해당 레코드를 지워도 되는지 검사후 삭제
			Do While Not GroupsDB.EOF
				v_reckey = GroupsDB("pk")
				strTemp = "select count(*) mycount from em_group_person where pk ="&v_reckey
				Set CountDB = DBConn.Execute(strTemp)
				groupcount = CountDB("mycount")
				strTemp = "select groupindiv from em_addr_person where pk = "&v_reckey
				Set GroupIndivDB = DBConn.Execute(strTemp)
				groupindiv = GroupIndivDB("groupindiv")

				rem 어떤 그룹에도 속하지 않을 경우 삭제한다.
				If groupcount = 1 and groupindiv = 0 Then
					strTemp = "delete em_addr_person where pk = "&v_reckey
					DBConn.Execute(strTemp)
				End If

				GroupsDB.MoveNext
			Loop
		End If
	Next
End If
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html">
<title>Emma 주소록</title>
</head>
<script language="javascript">
function add_group(){
	window.open("group.asp", "_blank",'scrollbars,resizable=1,width=400,height=420');
	return false;
}
function add_element(){
	window.open("addusr.asp", "_blank",'scrollbars,resizable=1,width=400,height=450');
	return false;
}

function on_search(){
	if(document.forms[0].keyword.value.length == 0){
		alert('검색어를 입력하십시오');
		return false;
	}
	if(document.forms[0].standard.value == "dummy"){
		alert('항목을 선택해 주십시오.');
		return false;
	}
}

function click_grp(grp) {
	nameDiv = "idDiv"+grp;
	img_name = document.all("folder"+grp).name;
	disp = document.all(nameDiv).style.display;
	if (disp == "none") {
		new_disp = "";
		new_img = "./img/folder_open.gif";
	}
	else {
		new_disp = "none";
		new_img = "./img/folder_close.gif";
	}
	
	document.all(nameDiv).style.display = new_disp;
	document.all(img_name).src = new_img;
}

function edit_element(ele) {
	window.open("modifyusr.asp?pk="+ele, "_blank", 'toolbar=no,directories=no,scrollbars=1,resizable=1,status=no,menubar=0,width=400,height=450');
}

function del_group(key) {
	quest = confirm("정말 삭제하시겠습니까?");
	if(quest != "0"){
		window.open("delgroup.asp?gpk="+key, "_blank", 'toolbar=no,directories=no,scrollbars=1,resizable=1,status=no,menubar=0,width=1,height=1');
		return true;
	}
	else
		return false;
}

function del_ele(key) {
	quest = confirm("정말 삭제하시겠습니까?");
	if(quest != "0"){
		window.open("delusr.asp?pk="+key, "_blank", 'toolbar=no,directories=no,scrollbars=1,resizable=1,status=no,menubar=0,width=1,height=1');
		return true;
	}
	else
		return false;
}

function mypopup() {
	ie = document.all;
	ns = document.layers;
	if (ie) {
		disp = divSearch.style.display;
		if (disp == "")
			divSearch.style.display = "none";
		else
			divSearch.style.display = "";
	}
	if (ns) {
		disp = document.layers["divSearch"].visibility;
		if (disp == "show") 
			document.layers["divSearch"].visibility = "hide";
		else
			document.layers["divSearch"].visibility = "show";
	}
}
</script>
<link rel="stylesheet" href="../hanool.css" type="text/css">
<style type="text/css">
<!--
.menu {
	color: #555555;
}
.topmenu {
	color: #000000;
}
a { text-decoration: none }
a:hover { color:red }
-->
</style>

<body bgcolor="#FFFFFF" topmargin="0" marginheight="0" leftmargin="0" marginwidth="0">
<!-- 메뉴바 -->
<CENTER><br><br>
<P><font face="굴림" size="4"><B>E M M A</B></font></p>
<P>
<A HREF="./send_msg.asp"><font face="굴림" size="2">메시지보내기</font></A><B>|</B>
<A HREF="./SentMailbox.asp"><font face="굴림" size="2">보낸메시지함</font></A><B>|</B>
<A HREF="./ReservMailbox.asp"><font face="굴림" size="2">예약메시지함</font></A><B>|</B>
<A HREF="./addrlist.asp"><font face="굴림" size="2">주소록</font></A><B>|</B>
<A HREF="./logout.asp"><font face="굴림" size="2">로그아웃</font></A>
</P>
</CENTER>

<center>
<br>
<table border=0 cellspacing=0>
<tr>
	<td align=center>
		<font size="2" face="돋움" color=#555555><a href="#" class="menu" onClick="add_group(); return false;">그룹만들기</a> /</font>
		<font size="2" face="돋움" color=#555555><a href="#" class="menu" onClick="add_element(); return false;">개인추가</a> /</font>
		<font size="2" face="돋움" color=#555555><a href="addrlist.asp" class="menu">그룹으로 보기</a> /</font>
		<font size="2" face="돋움" color=#555555><a href="addrlist.asp?standard=unsorted" class="menu">입력순으로 보기</a> /</font>
		<font size="2" face="돋움" color=#555555><a href="addrlist.asp?standard=sorted" class="menu">이름순으로 보기</a>
	<% IF ie4 Then %>
		/</font>
		<font size="2" face="돋움" color=#555555><a href="#" class="menu" onClick="mypopup(); return false;">검색</a></font>
	<% End If %>
	</td>
</tr>
<tr>
	<td>
		<hr size=1>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="1" width="400" align=center>
			<tr bgcolor="#8694F2">
				<td colspan=2 width=160 height=20 align="center" bgcolor="#aa8c9b"><font face="돋움" size="2" color="white">이름</font></td>
				<td width=140 bgcolor="#aa8c9b" align="center"><font face="돋움" size="2" color="white">이동전화번호</font></td>
				<td width=50 bgcolor="#aa8c9b" align="center"><font face="돋움" size="2" color="white">수정</font></td>
				<td width=50 bgcolor="#aa8c9b" align="center"><font face="돋움" size="2" color="white">삭제</font></td>
			</tr>
<%
v_count = 0
v_ele_count = 0

'''''''''''''''''''''''''''''''''''''''''
'' 검색을 하지 않는 경우
'''''''''''''''''''''''''''''''''''''''''
ecount = 0

If Request.QueryString("standard") = "" Then
	''**************************************************************************************************

	sqlcount = "select count(*) from em_addr_group where userId = '"&officenum&"'"
	set gCount = DBConn.Execute(sqlcount)
	maxGroups = gCount(0)

	ReDim GroupKey(maxGroups)
	ReDim GroupName(maxGroups)
'' 그룹수 계산
'' 배열에 그룹 내용 입력
	sql = "select PK, groupName from em_addr_group where userId = '"&officenum&"'"
	Set GroupDB = DBConn.Execute(sql)
	
	For i = 0 to maxGroups-1
		GroupKey(i) = Trim(GroupDB("pk"))
		GroupName(i) =Trim(GroupDB("groupName"))
		GroupDB.MoveNext
		If (GroupDB.EOF) Then
			Exit For
		End If
	Next

	For i = 0 To maxGroups-1
		temp_name = "nameof"&v_count
		ecount = ecount + 1
		v_bgcolor="white"
	
		strTemp = "select count(*) from em_addr_group_person gr, em_addr_person rp where rp.PK=gr.personPK and gr.groupPK="&GroupKey(i)
		set sel = DBConn.Execute(strTemp)
		sqlcount = sel(0)
	%>
			<tr>
				<td width=20 height=20><a href="JavaScript:;" 
		<% if ie4 then%>
				onClick="click_grp(<%=GroupKey(i)%>); return false;"
		<% end if %> ><img name="folder<%=GroupKey(i)%>" src="./img/folder_close.gif" border=0></a></td>
				<td width="140" valign="center" ><font face="돋움" size="2" color="#aa8c9b">&nbsp;&nbsp;<%=GroupName(i)%> (<%=sqlcount%>명)</font></td>
				<td width="140" valign="center" ><font face="돋움" size="2" color="#aa8c9b"></font></td>
				<td width="50" valign="center"><a href="#" onClick="window.open('modifygroup.asp?gpk=<%=GroupKey(i)%>', '_blank','toolbar=no,directories=no,scrollbars=1,resizable=1,status=no,menubar=0,width=400,height=450'); return false;"><img src="./img/edit2.gif" border=0 width=16 height=16 alt="수정"></a></td>
				<td width="50" valign="center"><a href="#" onClick="del_group(<%=GroupKey(i)%>); return false;" color="blue"><img src="./img/delete2.gif" border=0 width=18 height=16 alt="삭제"></a></td>
			</tr>
			<tr>
				<td colspan=5>
			<% if ie4 then %>	
					<div id="idDiv<%=GroupKey(i)%>" style="display:none">
			<% End If %>
					<table border=0 cellspacing=0 cellpadding=0 bgcolor="#FFFFFF" >
	<%
	'''' 그룹을 클릭한 경우 처리
	
	strTemp = "select * from em_addr_group_person gr, em_addr_person rp where rp.pk=gr.personPK and gr.groupPK="&GroupKey(i)
	'Set RecDB = DBConn.Execute(strTemp)
	'strTemp = "select count(*) mycount  from em_addr_person where officenum = '"&officenum&"'"
	'Set CountDB = DBConn.Execute(strTemp)
	'temp_count = CountDB("mycount")
	'strTemp = "select * from em_addr_person where userId = '"&officenum&"' order by name Asc"
	Set ReceiverDB = DBConn.Execute(strTemp)

	img = "./img/linem.gif"
		For j = 0 to sqlcount-1
			If j = sqlcount-1 Then
				img = "./img/linee.gif"
			End If
	%>
					<tr>
						<td width="20" height="20" align="center" valign="center"><font size="2" face="돋움"><img src="<%=img%>" align="top" width=20 height=20 border=0></font></td>
						<td width="140" valign="center"><font size="2" color="black" face="돋움">&nbsp;<%=ReceiverDB("personName")%></font></td>
						<td width="140" valign="center"><font size="2" face="돋움">&nbsp;<%=Non_To_Point(ReceiverDB("phone"))%></font></td>
						<td width="50" valign="center"><font size="2" face="돋움"><a href="#" onClick="edit_element(<%=ReceiverDB("pk")%>); return false;"><img src="./img/edit2.gif" border=0 width=16 height=16 alt="수정"></a></font></td>
						<td width="50" valign="center"><font size="2" face="돋움"><a href="#" onClick="del_ele(<%=ReceiverDB("pk")%>); return false;"><img src="./img/delete2.gif" border=0 width=18 height=16 alt="삭제"></a></font></td>
					</tr>
	<%
		ReceiverDB.MoveNext
		ecount = ecount + 1
		Next
		
	'If lflag <> "" Then
	%>
					</table>
			<% if ie4 then %>
					</div>
			<% end if %>
				</td>
			</tr>
	<%
	Next
'' 그룹 처리 끝

'' 그룹에 속하지 않은 사람만 출력
	sql = "select * from em_addr_person where userId = '"&officenum&"' and PK not in (select a.personPK from em_addr_group_person a, em_addr_person b where b.userId = '"&officenum&"' and a.personPK = b.PK)"

	set receiverdb = DBConn.execute(sql)
	while NOT receiverdb.EOF
	%>
			<tr bgcolor="#FFFFFF">
				<td width="20" height=20 align="center" valign="center"><font size="2" face="돋움"><img src="./img/people.gif" align="top" width=13 height=13 border=0></font></td>
				<td width="140" valign="center"><font size="2" face="돋움" color="black">&nbsp;<%=ReceiverDB("personName")%></font></td>
				<td width="140" valign="center"><font size="2" face="돋움">&nbsp;<%=Non_To_Point(ReceiverDB("phone"))%></font></td>
				<td width="50" valign="center"><font size="2" face="돋움"><a href="#" onClick="edit_element(<%=ReceiverDB("pk")%>); return false;"><img src="./img/edit2.gif" border=0 width=16 height=16 alt="수정"></a></font></td>
				<td width="50" valign="center"><font size="2" face="돋움"><a href="#" onClick="del_ele(<%=ReceiverDB("pk")%>); return false;"><img src="./img/delete2.gif" border=0 width=18 height=16 alt="삭제"></a></font></td>
			</tr>
	<%
		receiverdb.MoveNext
		ecount = ecount + 1
	Wend


''************************************************************************************************
Else
'''''''''''''''''''''''''''''''''''''''''
'' 검색을 하는 경우
'''''''''''''''''''''''''''''''''''''''''
v_count = 0
v_ele_count = 0

strTemp = "select count(*) mycount  from em_addr_person where userId = '"&officenum&"'"
Set CountDB = DBConn.Execute(strTemp)
temp_count = CountDB("mycount")

	If Request.QueryString("standard") = "name" Then
		strTemp = "select * from em_addr_person where userId = '"&officenum&"' and personName like '%"&Trim(Request.QueryString("keyword"))&"%' order by personName Asc"
	ElseIf Request.QueryString("standard") = "phone" Then
		strTemp = "select * from em_addr_person where userId = '"&officenum&"' and phone like '%"&Trim(Request.QueryString("keyword"))&"%' order by personName Asc"
	'ElseIf Request.QueryString("standard") = "email" Then
	'	strTemp = "select * from em_addr_person where userId = '"&officenum&"' and Email like '%"&Trim(Request.QueryString("keyword"))&"%' order by personName Asc"
	'ElseIf Request.QueryString("standard") = "sorted" Then
	'	strTemp = "select * from em_addr_person where userId = '"&officenum&"' order by personName Asc"
	'Else
	'	strTemp = "select * from em_addr_person where userId = '"&officenum&"' order by PK Asc" 'standard="unsorted" 의 경우
	End If

Set ReceiverDB = DBConn.Execute(strTemp)

'' 검색된 내용이 없다면
	If ReceiverDB.EOF Then
	%>
			<tr>
				<td colspan=5 bgcolor="white" align=center><font size="2" face="돋움">등록된 사람이 없습니다.</font></td>
			</tr>
	<%
	End If

	Do While Not ReceiverDB.EOF
		temp_name = "nameof"&v_count
		If v_count Mod 2 = 0 Then
			v_bgcolor = "#97D6FF"
		Else
			v_bgcolor = "#7BB5FB"
		End If
		v_bgcolor="#FFFFFF"
	%>
			<tr>
				<td valign=center width=20><img src="./img/people.gif"></td>
				<td bgcolor="<%=v_bgcolor%>" width=140 height=20><font face="돋움" size="2">&nbsp;<!--<a href="detail_element.asp?pk=<%=Trim(ReceiverDB("pk"))%>">--><%=Trim(ReceiverDB("personName"))%></font></td>
				<td width=140 bgcolor="<%=v_bgcolor%>"><font face="돋움" size="2"><%=Non_To_Point(ReceiverDB("phone"))%></font></td>
				<td width=50 bgcolor="<%=v_bgcolor%>" valign=center><font size="2" face="돋움"><a href="#" onClick="edit_element(<%=ReceiverDB("pk")%>); return false;"><img src="./img/edit2.gif" border=0 width=16 height=16 alt="수정"></a></font></td>
				<td width=50 bgcolor="<%=v_bgcolor%>" valign=center><font size="2" face="돋움"><a href="#" onClick="del_ele(<%=ReceiverDB("pk")%>); return false;"><img src="./img/delete2.gif" border=0 width=18 height=16 alt="삭제"></a></font></td>
			</tr>
	<%
		ReceiverDB.MoveNext
		v_count = v_count + 1
		v_ele_count = v_ele_count + 1
	Loop

'' *****************************************************************************
End If

response.write "<input type=hidden name=count value="&v_count&">"
response.write "<input type=hidden name=ele_count value="&v_ele_count&">"

DBConn.Close
set DBConn = nothing
%>
		</table>
	</td>
</tr>
</table>

<br>

<% IF ie4 Then %>
<div id="divSearch" style="left:150; top:125; width:370; visibility:hide; display:none">
<table border=0 cellpadding=1 cellspacing=1>   
<tr>
	<td>
		<table border=0 cellpadding=1 cellspacing=0>
			<tr bgcolor="#aa8c9b">
				<td align=center height=20 width=350><font size="2" face="돋움"><b>검색</b></font></td>
				<td width=20 align=right><a href="#" onClick="mypopup(); return false;"><img src="./img/x.gif" border=0 alt="닫기"></a></td>
			</tr>
			<tr bgcolor=#FFFFFF>
				<td colspan=2>
					<table border="0" width="370">
					    <tr>
						<form action="addrlist.asp" method="get" name="thisform">
							<td width="370" align=center><font face="돋움" size="2">항목
								<select name="standard" size="1">
								<option value="dummy">항목선택
								<option value="dummy">----------
								<option value="name">이름</option>
								<option value="pphone">이동전화번호</option>
								</select></font>
								<font face="돋움" size="3"><input type="text" name="keyword" size="10" value="검색어" onMouseOver="document.thisform.keyword.select(); document.thisform.keyword.focus();"> &nbsp;<input type="submit" name="search" value=" 검 색 " onClick="return on_search();"></font></td>
						</form>
						</tr>
					</table>
					<center><font size=2 face="돋움">* 이동전화번호 검색시 '-' 를 넣으십시오.</font></center>
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>
</div> 
<% End If %>
</center>
</body>
</html>
