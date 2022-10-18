<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<head>

</head>
<%
	
	 searchd = request("searchd")
	 searche = request("searche")

    if searchd="" then
		searchd =  replace(left(now(),10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = "  select a.orderidx,a.usercode ,b.comname, a.comname2,convert(varchar,a.createdate,120) as CreateDate,b.tcode from mobileorder as a join tb_company b on  SUBSTRING(a.usercode,1,5) = convert(varchar,b.idx) "
    
    SQL = sql & " and convert(varchar,a.createdate,112) >= '"& searchd &"' "
    SQL = sql & " and convert(varchar,a.createdate,112) <= '"& searche &"' "
    SQL = sql & " order by createdate desc "

  '  response.write sql
	rslist.Open sql, db, 1


   

   
   
%>

<script language="JavaScript">
<!--



  
    function info(frm) {
       

            form.submit();
       
    }
    

    //-->
</script>

<form method="POST" name=form>
<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 바드미어플 주문내역 ]</td>
	</tr>
	
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">



    <tr height=30 valign=bottom>
		<td width=35%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
        <td width="45%" align="right"><input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<!--<input type="button" name="오늘" value="오늘" class="box_work"' onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);">--> 
			</td>
        <td width="20%" align="center">        <input type="button" name="초기화" value="조회" class="box_work"  onclick="javascript: info(this.form);">&nbsp; <input type="button" name="EXCELL" value="EXCEL" class="box_work" onclick="    javascript: location.href = 'excellbadmi.asp?searchd=<%=searchd%>&searche=<%=searche%>';"></td>
		
	</tr>


</table>

    
</br>



                    <!--style="visibility:hidden"-->
                      
<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor="#BDCBE7" >
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=15%>코드</td>
		<td width=25%>회원사명</td>
		<td width="25%">체인점명</td>
        <td width="30%">주문일시</td>
       
	</tr>

<%
i=1

do until rslist.EOF 
   
	
	
	
%>
 
	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td><%=rslist("tcode")%></td>
		<td><%=rslist("comname")%></td>
      <td><%=rslist("comname2")%></td>
        <td><%=rslist("CreateDate")%></td>
	</tr>
  


<%
rslist.MoveNext 
i=i+1

loop
%>



</table>


				</td>
			</tr>
		</table>
            </td>
        </tr>

    </table>
    </form>

<%
  
	rslist.close
	db.close
	set rs=nothing
	set rslist=nothing
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->