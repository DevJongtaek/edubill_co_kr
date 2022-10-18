<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	imsititlename = "가상계좌정산"
	stxt1 = request("stxt1")
	'stxt2 = request("stxt2")
	imsiwdate = request("imsiwdate")

	'if stxt2="" then
'		stxt2 = "Aym"
	'end if
	if stxt1="" then
		stxt1 = replace(left(now(),7),"-","")
	end if

   ' if
	

	'GotoPage = Request("GotoPage")
	'if GotoPage = "" then
	'	GotoPage = 1
	'end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select max(a.tr_il) as tr_il,  a.cporg_cd, max(a.cnt) as cnt,max(b.comname)  as comname from "

SQL = sql & "(select count(cporg_cd) as cnt, cporg_cd,max(substring(tr_il,1,4)+'/'+substring(tr_il,5,2)) as tr_il from tb_virtual_acnt where dep_st ='1' and substring(tr_il,1,6)='"& stxt1 &"' group by cporg_cd  )  as a "
SQL = sql & "join (select  cporg_cd, comname from tb_company where flag='1' and cporg_cd != '') as b on a.cporg_cd = b.cporg_cd "
SQL = sql & "group by  a.cporg_cd,,b.comname order by b.comname "
   
	'rslist.PageSize=20
'response.write sql

	rslist.Open sql, db, 1

	'if not rslist.bof then
	'	rslist.AbsolutePage=int(gotopage)
	'end if
%>

<script language="JavaScript">
<!--
    //function taxpage(seqval) {
    //    window.open('taxpage.asp?seq=' + seqval, 'taxID', 'toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=500');
    //    return false;
    //}

    //function alltaxpage() {
    //    window.open('alltaxpage.asp?stxt1=<%=stxt1%>&stxt2=<%=stxt2%>&imsiwdate=<%=imsiwdate%>', 'taxID', 'toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=700');
    //    return false;
    //}

    function checkValue() {
        //if (form.stxt2.value == "") {
        //    alert("검색조건을 선택하여 주시기바랍니다.");
        //    form.stxt2.focus();
        //    return false;
        //}
        if (form.stxt1.value == "") {
            alert("검색어를 입력하여 주시기바랍니다.");
            form.stxt1.focus();
            return false;
        }
        form.submit();
        return false;
    }
    //-->
</script>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td> &nbsp; <font color=blue size=3><B>[ <%=imsititlename%> ]</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>


<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="virtuallist.asp" method="POST" name=form>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25">&nbsp;<B>정보검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
			<!--<select name="stxt2" size="1" class="box_work">
        	  		<option value="Aym"   <%if stxt2="Aym" then%>selected<%end if%>>청구년월</option>
          			<option value="tcode" <%if stxt2="tcode" then%>selected<%end if%>>코드번호</option>
          			<option value="hname" <%if stxt2="hname" then%>selected<%end if%>>회원사명</option>
        		</select>-->
            청구년월
        		<input type="Text" name="stxt1" size="20" maxlength="20" class="box_work" value="<%=stxt1%>">
        		<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="return checkValue()">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=60%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=40% align=right>
		&nbsp;<input type="button" name="EXCELL" value="EXCEL" class="box_work" onclick="javascript: location.href = 'excellvirtual.asp?stxt1=<%=stxt1%>';">&nbsp;
		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		
		<td width=8%>입금년월</td>
        <td width=17%>기관코드</td>
		<td width=21%>체인본부</td>
		<!--<td width=7%>이용료</td>-->
		<td width=8%>건수</td>
		<td width=37%>비고</td>
		<!--<td width=9%>세액</td>
		<td width=10%>합계금액</td>-->
		<!--<td width=4%>입금</td>-->
		<!--<td width=7%>전표출력</td>-->
	</tr>

<%
hap_kmoney = 0
hap_smoney = 0
hap_hmoney = 0
i=1
'j=((gotopage-1)*19)+gotopage
'do until rslist.EOF or rslist.PageSize<i
do until rslist.EOF

	'Aym   = left(rslist(0),4) &"/"& right(rslist(0),2)
	'wdate = mid(rslist(1),1,4) &"/"& mid(rslist(1),5,2) &"/"& mid(rslist(1),7,2) &" "& mid(rslist(1),9,2) &":"& mid(rslist(1),11,2) &":"& mid(rslist(1),13,2)

	'if rslist("accountflag")="y" then
	'	hap_kmoney = hap_kmoney+rslist("kmoney")
	'	hap_smoney = hap_smoney+rslist("smoney")
	'	hap_hmoney = hap_hmoney+rslist("hmoney")
	'else
'		hap_kmoney = hap_kmoney+rslist("kmoney")
'		hap_smoney = hap_smoney+0
'		hap_hmoney = hap_hmoney+rslist("kmoney")
'	end if

'	if rslist("jtcode")="" or isnull(rslist("jtcode")) then
'		bgcolor="#FFFFFF"
'	else
'		bgcolor="#FBCECE"
'	end if
    wdate = rslist("tr_il")
	cporg_cd = rslist("cporg_cd")
	comname = rslist("comname")
    cnt = rslist("cnt")
   ' if jtcode<>"" then
	'	comcode = jtcode
	'	comname = bname &"<font color=red>(" & jisaname & ")"
	'else
	'	comcode = tcode
	'	comname = bname
	'end if
	'idate = rslist("idate")
	'if idate<>"" then
	'	idate = "<font color=red>V"
	'else
	'	idate = ""
	'end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td><%=wdate%></td>
		<td><%=cporg_cd%></td>
		<td align=left>&nbsp;<%=comname%></td>
		<td align=right><%=formatnumber(rslist("cnt"),0)%>&nbsp;</td>
		<td></td>
	</tr>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 

%>


</table>


				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<!--
<table border="0" cellspacing="0" cellpadding="0" width=800>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="list2.asp?GotoPage=1&stxt1=<%=stxt1%>&stxt2=<%=stxt2%>&imsiwdate=<%=imsiwdate%>">첫페이지</a>&nbsp;
				<a href="list2.asp?GotoPage=<%=blockPage-10%>&stxt1=<%=stxt1%>&stxt2=<%=stxt2%>&imsiwdate=<%=imsiwdate%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="list2.asp?GotoPage=<%=blockPage%>&stxt1=<%=stxt1%>&stxt2=<%=stxt2%>&imsiwdate=<%=imsiwdate%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="list2.asp?GotoPage=<%=blockPage%>&stxt1=<%=stxt1%>&stxt2=<%=stxt2%>&imsiwdate=<%=imsiwdate%>">다음 10개</a>
				&nbsp;<a href="list2.asp?GotoPage=<%=rslist.pagecount%>&stxt1=<%=stxt1%>&stxt2=<%=stxt2%>&imsiwdate=<%=imsiwdate%>">마지막</a>
		<% 	End If %>

		</td>
	</tr>
</table>
-->

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->