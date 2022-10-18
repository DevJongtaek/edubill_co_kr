<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<head>
    <style type="text/css">
        .auto-style1 {
            width: 30%;
        }
    </style>

</head>
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	'주문 시간
	searchi = request("searchi")
	searchj = request("searchj")

  


	if searchg="" then
		searchg = "0"
	end if
	if searchc="" then
		searchc = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if

	if searchd="" then
		searchd = replace(left(now()-1,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end If

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end If
	
	 
	
	
   
	

   
	

	
		
	



    


	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from NewSMS "

  
   
 
	

	

	rslist.Open sql, db, 1


    
    if not rslist.eof then
		hcararray = rslist.GetRows
		hcararrayint = ubound(hcararray,2)
	else
		hcararray = ""
		hcararrayint = ""
	end if


	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
      
	end if

   
   
%>

<script language="JavaScript">
<!--

    

    function excell_up(){
        window.open ('smsup.asp','ExcellID','width=450,height=120,left=100,top=100')
        return false ;
    }
    function comdel1(frm) {
        var msg;
        msg = confirm("정말 삭제하겠습니까?");
        if (msg) {
          
            form.submit();
            return false;
        }
    }
    function frmchk(frm) {
        var msg;
     
        alert("전송할 번호가 없습니다.");
    }
    function alldelokCh3(url) {

        var msg;
        msg = confirm("정말 삭제하겠습니까?");
        if (msg) {
            location.href = url;
            //return false;
        }
        //	form.submit() ;
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
		<td><font color=blue size=3><B>[ 문자전송 ]</td>
	</tr>
	
</table>
<form action="NewSMSOK.asp" method="POST" name=form>
<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">



    <tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		
	</tr>


</table>

    </form>
</br>

<table cellspacing=2 cellpadding=0 width="100%" border=0 bgcolor=#BDCBE7>
	<tr bgcolor=#F7F7FF height=22 align=center>
		<td class="auto-style1"><font color=red>*</font><B>엑셀파일선택</td>
       
		<td width=70% bgcolor=white>
            
            <input type="button" value="양식" onClick="self.location = 'excell2.asp';">
        <input type="button" name="초기화" value="초기화" class="box_work"  onclick="javascript: comdel1();">
            <input type="button" name="엑셀UP" value="엑셀UP" class="box_work"  onclick="javascript: excell_up();">
         
          
            <%if hcararrayint = "" then%>
           <input type="button" name="문자전송" value="문자전송" class="box_work"  onclick="javascript: frmchk();">
            <%else %>
 <input type="button" name="문자전송" value="문자전송" class="box_work"  onclick="javascript: bwinopenXY('Msms.asp?sms=<%=rslist.recordcount%>&tcode=<%if hcararrayint<>"" then%>	<%for i=0 to hcararrayint%> <%=hcararray(0,i)%>, <%next%><%end if%>', 'domain', 500, 400)">
            <%end if %>
           
		</td>
	</tr>
    
</table>
                    </br>

                    <!--style="visibility:hidden"-->
                       <form action="NewSMSdelok.asp" method="POST" name=frm2>
<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor="#BDCBE7" >
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=88%>핸드폰번호</td>
		<td width="7%">삭제</td>
	</tr>

<%
i=1

do until rslist.EOF 
   
	
	
	
%>
 
	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td><%=rslist("MobileNo")%></td>
       <td>
           <input type="button" value="삭 제" class="box_work"' onclick="javascript:alldelokCh3('NewSMSdelok.asp?idx=<%=rslist(1)%>');">

       </td>
	</tr>
  


<%
rslist.MoveNext 
i=i+1

loop
%>



</table>
</form>


				</td>
			</tr>
		</table>


<%
  
	rslist.close
	db.close
	set rs=nothing
	set rslist=nothing
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->