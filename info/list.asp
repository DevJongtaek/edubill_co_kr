<!--#include virtual="/info/sessionend.asp"-->
<!--#include virtual = '/inc/header.asp'-->
<head>
<script language="JavaScript">
<!--
	function focus()
	{
		document.login.mid.focus();
		return 0;
	}
	function leave()
	{
		document.login.mpwd.focus();
		return 0;
	}
//-->
</script>
</head>
<body onload="return focus();">
<!--top-->
<table width="980" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left">
<!--#include virtual = '/inc/sub_top.asp'-->
    </td>
  </tr>
</table>
<!--/top-->

<!--������-->
<table width="980" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top"> 
    <td width="242">
<!--#include virtual = '/intranet/left_menu.asp'-->
    </td>
    <td><!--Ÿ��Ʋ--><table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:30">
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="300" height="40" align="left"><img src="../images/intranet/title_01.gif" width="106" height="26" /></td>
                <td align="right" valign="middle"><img src="../images/common/b_1.gif" width="10" height="9" />&nbsp;HOME&nbsp;<img src="../images/common/b_2.gif" width="3" height="10" />&nbsp;��Ʈ���&nbsp;<img src="../images/common/b_2.gif" width="3" height="10" /><span class="style1"> 
                  <strong>������
</strong></span></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="144" height="1" bgcolor="327bc7"></td>
                <td height="1" bgcolor="c7c7c7"></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <!--/Ÿ��Ʋ-->
<!--#include virtual="/db/db.asp"-->
<%
	''''''''''''''''''''''''''''''''''''''''
	'�����ں� ��ϰǼ� ����
	regnum = 100
	''''''''''''''''''''''''''''''''''''''''

	pagegubun = request("pagegubun")
	if pagegubun="" then
		pagegubun="1"
	end if
	searcha   = request("searcha")
	searchb   = request("searchb")
	searchc   = request("searchc")
	GotoPage  = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	if pagegubun="1" then
		imsititle1 = "<font color=blue size=3><B>[ ȸ������Ȳ ]</b>"
		imsititle2 = "<font color=black size=3>[ ���������Ȳ ]"
		imsititle3 = "<font color=black size=3>[ �̼��ݰ��� ]"
		imsititle4 = "<font color=black size=3>[ ������ȣ ]"
		imsititle5 = "<font color=black size=3>[ �ڷ�� ]"
	elseif pagegubun="2" then
		imsititle1 = "<font color=black size=3>[ ȸ������Ȳ ]"
		imsititle2 = "<font color=blue size=3><B>[ ���������Ȳ ]</b>"
		imsititle3 = "<font color=black size=3>[ �̼��ݰ��� ]"
		imsititle4 = "<font color=black size=3>[ ������ȣ ]"
		imsititle5 = "<font color=black size=3>[ �ڷ�� ]"
	elseif pagegubun="3" then
		imsititle1 = "<font color=black size=3>[ ȸ������Ȳ ]"
		imsititle2 = "<font color=black size=3>[ ���������Ȳ ]"
		imsititle3 = "<font color=blue size=3><B>[ �̼��ݰ��� ]</b>"
		imsititle4 = "<font color=black size=3>[ ������ȣ ]"
		imsititle5 = "<font color=black size=3>[ �ڷ�� ]"
	elseif pagegubun="4" then
		imsititle1 = "<font color=black size=3>[ ȸ������Ȳ ]"
		imsititle2 = "<font color=black size=3>[ ���������Ȳ ]"
		imsititle3 = "<font color=black size=3>[ �̼��ݰ��� ]"
		imsititle4 = "<font color=blue size=3><B>[ ������ȣ ]</b>"
		imsititle5 = "<font color=black size=3>[ �ڷ�� ]"
	elseif pagegubun="5" then
		imsititle1 = "<font color=black size=3>[ ȸ������Ȳ ]"
		imsititle2 = "<font color=black size=3>[ ���������Ȳ ]"
		imsititle3 = "<font color=black size=3>[ �̼��ݰ��� ]"
		imsititle4 = "<font color=black size=3>[ ������ȣ ]"
		imsititle5 = "<font color=blue size=3><B>[ �ڷ�� ]</b>"
	end if

	linkval1 = "pagegubun=1&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&gotopage="&gotopage
	linkval2 = "pagegubun=2&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&gotopage="&gotopage
	linkval3 = "pagegubun=3&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&gotopage="&gotopage
	linkval4 = "pagegubun=4&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&gotopage="&gotopage
	linkval5 = "pagegubun=5&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&gotopage="&gotopage&"&uid=guestbbs"
	linkval  = "pagegubun="&pagegubun&"&searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&gotopage="&gotopage

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcode,dname from tb_dealer order by dname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		dealerarry = rs.GetRows
		dealerarry_int = ubound(dealerarry,2)
	else
		dealerarry = ""
		dealerarry_int = ""
	end if
	rs.close
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" valign=top>
	<tr height="47">
		<td align=center valign=top>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center valign=top>

<table width="100%" border=0 cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center" valign=top>
	<tr height="47">
		<td>
			<a href="list.asp?pagegubun=1"><%=imsititle1%></a>
			&nbsp;
			<a href="list.asp?pagegubun=2"><%=imsititle2%></a>
			&nbsp;
			<a href="list.asp?pagegubun=3"><%=imsititle3%></a>
			&nbsp;
			<a href="list.asp?pagegubun=4"><%=imsititle4%></a>
			&nbsp;
			<a href="list.asp?pagegubun=5&uid=guestbbs"><%=imsititle5%></a>
		</td>
	</tr>
</table>

<%if pagegubun="1" then%>
	<!--#include virtual="/info/inc1.asp"-->
<%elseif pagegubun="2" then%>
	<!--#include virtual="/info/inc2.asp"-->
<%elseif pagegubun="3" then%>
	<!--#include virtual="/info/inc3.asp"-->
<%elseif pagegubun="4" then%>
	<!--#include virtual="/info/inc4.asp"-->
<%elseif pagegubun="5" then%>
	<!--#include virtual="/info/inc5.asp"-->
<%end if%>

<%if pagegubun<>"3" and pagegubun<>"4" and pagegubun<>"5" then%>
<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>����10��</font> [ "
			Else 
		%>
				<a href="list.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&pagegubun=<%=pagegubun%>">ù������</a>&nbsp;
				<a href="list.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&pagegubun=<%=pagegubun%>">���� 10��</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="list.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&pagegubun=<%=pagegubun%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If
				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>����10��</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="list.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&pagegubun=<%=pagegubun%>">���� 10��</a>
				&nbsp;<a href="list.asp?GotoPage=<%=rslist.pagecount%>&&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&pagegubun=<%=pagegubun%>">������</a>
		<% 	End If %>

		</td>
	</tr>
</table>
<%end if%>
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

</table>
<!--/������-->


<!--bottom-->

<!--/bottom-->
</body>
</html>
