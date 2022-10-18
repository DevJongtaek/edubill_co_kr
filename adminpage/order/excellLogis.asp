<% @  codepage="949" language="VBScript" %>
<%
 Session.CodePage = 949
 Response.ChaRset = "EUC-KR"
%>
<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=드림택배"&replace(left(now(),10),"-","")&".xls"
%>




<!--#include virtual="/db/db.asp"-->
<%
	gongi = request("gongi")
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	' 검색 조건 추가 
	searchi = request("searchi")
	searchj = request("searchj")
	searchk = request("searchk")
	searchl = request("searchl")

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
	
	fclass1 = Request("fclass1")
	sclass2 = Request("sclass2")
	tclass3 = Request("tclass3")
	imsifclass1 = right(Request("fclass1"),5)
	imsisclass2 = right(Request("sclass2"),5)
	imsitclass3 = right(Request("tclass3"),5)

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")

	

	SQL = "  select  name,post,addr,tel,PhoneNo,cnt,amount,etc "
	SQL  = SQL & ", case when isnull(dbo.arr_split(pname,'|',1),'') = '' then '' "
	SQL  = SQL & "else  isnull(dbo.arr_split(pname,'|',1),'') +' ('+isnull(dbo.arr_split(ordernum,'|',1),'') + ') ' end as pname1 "
SQL =  SQL & "    , case when isnull(dbo.arr_split(pname,'|',2),'') = '' then '' "
	SQL  = SQL & " else  isnull(dbo.arr_split(pname,'|',2),'') +' ('+isnull(dbo.arr_split(ordernum,'|',2),'') + ') ' end as pname2 "
SQL =  SQL & "	, case when isnull(dbo.arr_split(pname,'|',3),'') = '' then '' "
	SQL  = SQL & " else   isnull(dbo.arr_split(pname,'|',3),'') +' ('+isnull(dbo.arr_split(ordernum,'|',3),'') + ') ' end pname3 "
SQL =  SQL & "	, case when isnull(dbo.arr_split(pname,'|',4),'') = '' then '' "
SQL =  SQL & "	else isnull(dbo.arr_split(pname,'|',4),'') +' ('+isnull(dbo.arr_split(ordernum,'|',4),'') + ')' end  pname4 "
SQL =  SQL & "    from "
	SQL  = SQL & "( SELECT  b.idx,c.name,c.post,c.addr+' '+replace(addr2,'.',' ') as addr,c.tel1+'-'+c.tel2+'-'+c.tel3 as tel,c.hp1+'-'+c.hp2+'-'+c.hp3 as PhoneNo,'1' as 'cnt' "
SQL =  SQL & "   , '3500'as 'amount','선불' as 'etc', STUFF(( SELECT '|' + pname"
  SQL =  SQL & "    FROM  tb_order_product "
SQL =  SQL & "     WHERE  idx = A.idx FOR XML PATH('')),1,1,'')as pname ,"
SQL =  SQL & " 	  STUFF(( SELECT '|' + convert(varchar,rordernum)"
SQL =  SQL & "      FROM  tb_order_product "
SQL =  SQL & "     WHERE  idx = A.idx FOR XML PATH('')),1,1,'') as ordernum "
SQL =  SQL & "     FROM   tb_order_product AS A "
SQL =  SQL & "     join tb_order as b on a.idx = b.idx "
SQL =  SQL & "     join tb_company as c on c.idx = substring(b.usercode,11,5)  "
 SQL = sql & " WHERE  b.flag =  'y' and isnull(b.deflagday,'') = '' "
    SQL = sql & " and substring(b.usercode,1,5) =  '"& left(session("Ausercode"),5) &"' "
   SQL = sql &" and b.orderday >= '"& searchd &"' and b.orderday <= '"& searche &"') as a "
   SQL = sql &" group by name,post,addr,tel,PhoneNo,cnt,amount,etc,pname,ordernum"

'response.write sql
'response.end
	rslist.PageSize=10000
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if	

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

function mRegPop(){
	window.open ('mRegPop.asp','mRegPop1','toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=670,height=300,left=100,top=100');
	return false ;
}

function pop_win(){
	popWindow.style.display="none";
}
//-->
</script>


<table border="1" cellspacing="1" cellpadding="1" width="3000px" bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5% style="background-color:yellow;">수하주명</td>
        <td width=17% style="background-color:yellow;">(수)전화</td>
        <td width=11% style="background-color:yellow;">(수)핸드폰</td>
        <td width=16% style="background-color:yellow;">(수)주소1</td>
		<td width=7% style="background-color:yellow;">배송메세지</td>
		<td style="width:100%;background-color:yellow;">물품명</td>
		<td width=9% style="background-color:yellow;">택배수량</td>
		<td width=9% style="background-color:yellow;">택배운임</td>
		<td width=9% style="background-color:yellow;">선착불</td>
	
		<!--<td width=11%>품목명2</td>
		<td width=20%>품목명3</td>
		<td width=25%>품목명4</td>-->
	</tr>

<%
i=1
j=((gotopage-1)*10000)+gotopage
do until rslist.EOF or rslist.PageSize<i

	
%>
	 <tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=imsifontcolor%><%=rslist("name")%></td>
         <td><%=imsifontcolor%><%=rslist("tel")%></td>
         <td><%=imsifontcolor%><%=rslist("phoneNo")%></td>

		<td align=left><%=imsifontcolor%>&nbsp;<%=imsifontcolor%><%=rslist("addr")%></td>
		<td><%=imsifontcolor%></td>
	    <%if rslist("pname1") <> "" and rslist("pname2") <> "" and rslist("pname3") <> "" and rslist("pname4") <> ""  then%>
         <td width="600px" align=left><%=rslist("pname1")%> #<%=rslist("pname2")%> #<%=rslist("pname3")%> # <%=rslist("pname4")%> </td>
         <%elseif rslist("pname1") <> "" and rslist("pname2") <> "" and rslist("pname3") <> "" and rslist("pname4") ="" THEN %>
          <td  width="600px" align=left><%=rslist("pname1")%> #<%=rslist("pname2")%> #<%=rslist("pname3")%></td>
          <%elseif rslist("pname1") <> "" and rslist("pname2") <> "" and rslist("pname3") = "" and rslist("pname4") ="" THEN %>
          <td  width="600px"align=left><%=rslist("pname1")%> #<%=rslist("pname2")%></td>
          <%elseif rslist("pname1") <> "" and rslist("pname2") = "" and rslist("pname3") = "" and rslist("pname4") ="" THEN %>
          <td width="600px" align=left><%=rslist("pname1")%></td>
         <%end if %>
		<td><%=rslist("cnt")%></td>
		<td><%=rslist("amount")%></td>
		<td><%=rslist("etc")%></td>
        
		<!--<td align=left><%=rslist("pname1")%></td>
        <td align=left><%=rslist("pname2")%></td>
        <td align=left><%=rslist("pname3")%></td>
        <td align=left><%=rslist("pname4")%></td>-->
	</tr>
  
</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
%>

<%
	rslist.close
	Set rsoverlist=Nothing 
'response.write "overlapIdx" &overlapIdx
	db.close
	set rs=nothing
	set rslist=Nothing
	set db=nothing
%>

  </table>
<script type="text/javascript">

 cookiedata = document.cookie; 

 if ( cookiedata.indexOf("noticediv=done") < 0 ){ 
  document.all['notice'].style.display = "";
 } else {
  document.all['notice'].style.display = "none";
 }

 function noticestartTime() {
  var time = new Date();
  hours = time.getHours();
  mins = time.getMinutes();
  secs = time.getSeconds();
  closeTime = hours*3600+mins*60+secs;
  noticeTimer();
 }

 function noticeTimer() {
  var time = new Date();
  hours = time.getHours();
  mins = time.getMinutes();
  secs = time.getSeconds();
  curTime = hours*3600+mins*60+secs
  closeTime += 60;
 
  if (curTime >= closeTime) {
   document.all['notice'].style.display = "none";
  } else {
   window.setTimeout("noticeTimer()",1000);
  }
 }

 function noticesetCookie( name, value, expiredays ) { 
  var todayDate = new Date(); 
  todayDate.setDate( todayDate.getDate() + expiredays ); 
  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
 } 

 function noticecloseWin() { 
  if ( document.all.noticecheck.checked ) { 
   noticesetCookie( "noticediv", "done" , 1 ); 
  }
  
  document.all['notice'].style.display = "none";
 }
</script>

<script type="text/javascript">

 cookiedata = document.cookie; 

 if ( cookiedata.indexOf("maindiv=done") < 0 ){ 
  document.all['popup'].style.display = "";
 } else {
  document.all['popup'].style.display = "none";
 }

 function startTime() {
  var time = new Date();
  hours = time.getHours();
  mins = time.getMinutes();
  secs = time.getSeconds();
  closeTime = hours*3600+mins*60+secs;
  Timer();
 }

 function Timer() {
  var time = new Date();
  hours = time.getHours();
  mins = time.getMinutes();
  secs = time.getSeconds();
  curTime = hours*3600+mins*60+secs
  closeTime += 60;
 
  if (curTime >= closeTime) {
   document.all['popup'].style.display = "none";
  } else {
   window.setTimeout("Timer()",1000);
  }
 }

 function setCookie( name, value, expiredays ) { 
  var todayDate = new Date(); 
  todayDate.setDate( todayDate.getDate() + expiredays ); 
  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
 } 

 function closeWin() { 
  if ( document.all.popcheck.checked ) { 
   setCookie( "maindiv", "done" , 1 ); 
  }
  
  document.all['popup'].style.display = "none";
 }
</script>