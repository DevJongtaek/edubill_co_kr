<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	imsititlename = "세금계산서 조회"
	stxt1 = request("stxt1")
	stxt2 = request("stxt2")
	imsiwdate = request("imsiwdate")

	if stxt2="" then
		stxt2 = "Aym"
	end if
	if stxt1="" then
		stxt1 = replace(left(now(),7),"-","")
	end if

	if stxt2="Aym" then
		imsiorderby = " order by a.tcode asc, a.hname asc"
	elseif stxt2="tcode" or stxt2="hname" then
		imsiorderby = " order by a.Aym asc, a.tcode asc"
	end if

	if stxt2 = "Aym" then
		sendSQL = " Aym = '"& stxt1 &"' "
		if imsiwdate<>"" then
			sendSQL = sendSQL & " and wdate = '"& imsiwdate &"' "
		end if
	elseif stxt2 = "tcode" then
		sendSQL = " tcode = '"& stxt1 &"' "
		if imsiwdate<>"" then
			sendSQL = sendSQL & " and wdate = '"& imsiwdate &"' "
		end if
	elseif stxt2 = "hname" then
		sendSQL = " hname like '%"& stxt1 &"%' "
		if imsiwdate<>"" then
			sendSQL = sendSQL & " and wdate = '"& imsiwdate &"' "
		end if
	end if

	'GotoPage = Request("GotoPage")
	'if GotoPage = "" then
	'	GotoPage = 1
	'end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select a.seq,a.Aym,a.hname,a.umoney,a.tcode,b.Anum,b.kmoney,b.smoney,b.hmoney from "
	SQL = sql & " (select seq,Aym,hname,umoney,tcode from tAccountM where flag='1' and "& sendSQL &" ) a "
	SQL = sql & " left outer join "
	SQL = sql & " (select tcode,sum(Anum) as Anum,sum(kmoney) as kmoney,sum(smoney) as smoney,sum(hmoney) as hmoney from tAccountM where "& sendSQL &" group by tcode) b "
	SQL = sql & " on a.tcode = b.tcode "
	SQL = sql & imsiorderby
	'rslist.PageSize=20
'response.write sql

	rslist.Open sql, db, 1

	'if not rslist.bof then
	'	rslist.AbsolutePage=int(gotopage)
	'end if
%>

<script language="JavaScript">
<!--
function taxpage(seqval)
{
	window.open ('taxpage.asp?seq='+seqval,'taxID','toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=500');
	return false ;
}

function alltaxpage()
{
	window.open ('alltaxpage.asp?stxt1=<%=stxt1%>&stxt2=<%=stxt2%>&imsiwdate=<%=imsiwdate%>','taxID','toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=700');
	return false ;
}

function checkValue() {
	if (form.stxt2.value=="") {
		alert("검색조건을 선택하여 주시기바랍니다.") ;
		form.stxt2.focus() ;
		return false ;
	}
	if (form.stxt1.value=="") {
		alert("검색어를 입력하여 주시기바랍니다.") ;
		form.stxt1.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
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

<form action="list2.asp" method="POST" name=form>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25">&nbsp;<B>정보검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
			<select name="stxt2" size="1" class="box_work">
        	  		<option value="Aym"   <%if stxt2="Aym" then%>selected<%end if%>>청구년월</option>
          			<option value="tcode" <%if stxt2="tcode" then%>selected<%end if%>>코드번호</option>
          			<option value="hname" <%if stxt2="hname" then%>selected<%end if%>>회원사명</option>
        		</select>
        		<input type="Text" name="stxt1" size="20" maxlength="20" class="box_work" value="<%=stxt1%>">
        		<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="return checkValue()">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right>
			<input type="button" name="EXCELL" value="EXCEL" class="box_work" onclick="javascript:location.href='excell.asp?stxt1=<%=stxt1%>&stxt2=<%=stxt2%>&imsiwdate=<%=imsiwdate%>';">
			<input type="button" name="일괄출력" value="일괄출력" class="box_work" onclick="javascript:alltaxpage();">
		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=6%>코드</td>
		<td width=8%>청구년월</td>
		<td width=28%>회원사명</td>
		<td width=7%>이용료</td>
		<td width=8%>체인점수</td>
		<td width=11%>공급가액</td>
		<td width=9%>세액</td>
		<td width=11%>합계금액</td>
		<td width=7%>전표출력</td>
	</tr>

<%
hap_kmoney = 0
hap_smoney = 0
hap_hmoney = 0
i=1
'j=((gotopage-1)*19)+gotopage
'do until rslist.EOF or rslist.PageSize<i
do until rslist.EOF

	Aym   = left(rslist(0),4) &"/"& right(rslist(0),2)
	wdate = mid(rslist(1),1,4) &"/"& mid(rslist(1),5,2) &"/"& mid(rslist(1),7,2) &" "& mid(rslist(1),9,2) &":"& mid(rslist(1),11,2) &":"& mid(rslist(1),13,2)

	hap_kmoney = hap_kmoney+rslist("kmoney")
	hap_smoney = hap_smoney+rslist("smoney")
	hap_hmoney = hap_hmoney+rslist("hmoney")
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td><%=rslist("tcode")%></td>
		<td><%=left(rslist("Aym"),4)%>/<%=right(rslist("Aym"),2)%></td>
		<td align=left>&nbsp;<a href="content.asp?seq=<%=rslist("seq")%>&stxt1=<%=stxt1%>&stxt2=<%=stxt2%>&imsiwdate=<%=imsiwdate%>"><B><%=rslist("hname")%></a></td>
		<td align=right><%=formatnumber(rslist("umoney"),0)%>&nbsp;</td>
		<td><%=rslist("Anum")%></td>
		<td align=right><%=formatnumber(rslist("kmoney"),0)%>&nbsp;</td>
		<td align=right><%=formatnumber(rslist("smoney"),0)%>&nbsp;</td>
		<td align=right><%=formatnumber(rslist("hmoney"),0)%>&nbsp;</td>
		<td><input type="button" name="세금" value="세금" class="box_work" onclick="javascript:taxpage('<%=rslist("seq")%>');"></td>
	</tr>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td>계</td>
		<td></td>
		<td></td>
		<td align=left></td>
		<td align=right></td>
		<td></td>
		<td align=right><%=formatnumber(hap_kmoney,0)%>&nbsp;</td>
		<td align=right><%=formatnumber(hap_smoney,0)%>&nbsp;</td>
		<td align=right><%=formatnumber(hap_hmoney,0)%>&nbsp;</td>
		<td></td>
	</tr>
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