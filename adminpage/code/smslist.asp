<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	
	 searchd = request("searchd")
	 'searche = request("searche")

    if searchd="" then
		searchd =  replace(left(now(),8),"-","")
	end if

	'if searche="" then
	'	searche = replace(left(now(),10),"-","")
	'end if

	set rslist = server.CreateObject("ADODB.Recordset")

    imsitb = "em_log_" & searchd


	 sql = " select a.tran_etc2 as tcode,max(b.comname) as comname,max(c.cnt) as Order1,max(isnull(d.cnt,0)) as Order2 from "& imsitb &" as a " 

sql = sql & " join tb_company b on a.tran_etc2 = b.tcode and b.flag = '1' "

sql = sql & " left join (select count(*) as cnt,tran_etc2 from "& imsitb &" where (tran_msg like '%에서%완료%'or tran_msg like '%에서%취소%' or tran_msg like '%에서%입금액%') group by tran_etc2) c on a.tran_etc2 = c.tran_etc2 "
sql = sql & " left join (select count(*) as cnt,tran_etc2 from "& imsitb &" where (tran_msg not like '%에서%완료%'and tran_msg not like '%에서%취소%' and tran_msg not like '%에서%입금액%') group by tran_etc2) d on a.tran_etc2 = d.tran_etc2"
sql = sql & " where len(a.tran_etc2) =4 group by a.tran_etc2"


	rslist.Open sql, db, 1

	'tcnt = rslist.recordcount

  '  response.write sql
'	rslist.Open sql, db, 1


   

   
   
%>

<script language="JavaScript">
<!--
  
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
		<td><font color=blue size=3><B>[ SMS 집계 ]</td>
	</tr>
	
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">



    <tr height=30 valign=bottom>
		<td width=35%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다. </td>
        <td width="45%" align="right">년월 : <input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			&nbsp;
			<!--<input type="button" name="오늘" value="오늘" class="box_work"' onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);">--> 
			</td>
        <td width="20%" align="center">        <input type="button" name="초기화" value="조회" class="box_work"  onclick="javascript: info(this.form);">&nbsp; <input type="button" name="EXCELL" value="EXCEL" class="box_work" onclick="    javascript: location.href = 'excellsmsList.asp?searchd=<%=searchd%>';"></td>
		
	</tr>


</table>

    
</br>



                    <!--style="visibility:hidden"-->
                      
<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor="#BDCBE7" >
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=15%>코드</td>
		<td width=40%>회원사명</td>
		<td width="20%">주문</td>
        <td width="20%">수동</td>
       
	</tr>

<%
i=1

do until rslist.EOF 
   
	
	
	
%>
 
	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td><%=rslist("tcode")%></td>
		<td><%=rslist("comname")%></td>
      <td><%=rslist("Order1")%></td>
        <td><%=rslist("Order2")%></td>
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