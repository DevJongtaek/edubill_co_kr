﻿
<html>
<head>
  
 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
   
<title>▒ 모아론 대출서비스 ▒ </title>
	<META NAME="keywords" CONTENT="모아론,모아코퍼레이션,대출,신용대출,무보증,무담보,">
	<META NAME="description" CONTENT="모아론 대출서비스 안내">
	<META NAME="robots" CONTENT="ALL">
	<META NAME="author" CONTENT="모아코퍼레이션">
	
	<META NAME="build" CONTENT="2014.5.12">
	
	<meta name='viewport' content='initial-scale=1, minimum-scale=0.3,  user-scaleable=yes' />
	<script language="javascript" src="Inc_Files/Scripts/javascript_data.js"></script>
	<script type='text/javascript' src='Inc_Files/Scripts/Common_Script.js'></script>

<!-- 스크롤 메뉴 대출 -->
<script type="text/javascript">
<!--
self.onError=null;
currentX = currentY = 0; 
whichIt = null; 
lastScrollX = 0; lastScrollY = 0;
NS = (document.layers) ? 1 : 0;
IE = (document.all) ? 1: 0;
<!-- STALKER CODE -->
function heartBeat() {
if(IE) { 
diffY = document.body.scrollTop; 
diffX = 0; 
}
if(NS) { diffY = self.pageYOffset; diffX = self.pageXOffset; }
if(diffY != lastScrollY) {
percent = .1 * (diffY - lastScrollY);
if(percent > 0) percent = Math.ceil(percent);
else percent = Math.floor(percent);
if(IE) document.all.layer1.style.pixelTop += percent;
if(NS) document.layer1.top += percent; 
lastScrollY = lastScrollY + percent;
}
if(diffX != lastScrollX) {
percent = .1 * (diffX - lastScrollX);
if(percent > 0) percent = Math.ceil(percent);
else percent = Math.floor(percent);
if(IE) document.all.layer1.style.pixelLeft += percent;
if(NS) document.layer1.top += percent;
lastScrollY = lastScrollY + percent;
} 
} 
if(NS || IE) action = window.setInterval("heartBeat()",1);

function MM_preloadImages() { //v3.0
var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>

<script language="JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}



function itemAdd(){
	for (i=0; i < items.condition.length; i++)
	{
		if(items.condition[i].selected)
		{
			var newItem = document.createElement('OPTION');
			items.customers.add(newItem);
			newItem.innerText=items.condition[i].innerText;
			newItem.value=items.condition[i].value;
		}
	}
	return false ;
}
function addRow(tableID) 
{   	
	var checker = false;
	var table = document.getElementById(tableID); 
	var addtable = document.getElementById("sendlist");
	var rowCount = table.rows.length;
	var addrowCount = addtable.rows.length;
	var checkCount = 0;
	var errorCount = 0;
	for (j = 1; j < rowCount ; j++)
	{
		checker= false;
		var crow = table.rows[j];
		var chkbox = crow.cells[0].childNodes[0];
		if(null != chkbox && true == chkbox.checked) 
		{   
			checkCount++;
			for (a = 0; a < addrowCount; a++)
			{
				if(table.rows[j].cells[1].innerHTML == addtable.rows[a].cells[1].innerHTML)
				{
					//alert(table.rows[j].cells[2].innerHTML + "(" + table.rows[j].cells[1].innerHTML + ")는 이미 추가되었습니다");
					errorCount ++;
					checker = true;
					break;
				}
				var telNumber = table.rows[j].cells[3].innerHTML;
				if (telNumber.length < 10)
				{
					//alert(table.rows[j].cells[2].innerHTML + "(" + table.rows[j].cells[1].innerHTML + ")는 휴대폰번호를 확인하십시오");
					errorCount ++;
					checker = true;
					break;
				}
				else
				{	

					if (telNumber.substring(0,3) == "010" ||
					telNumber.substring(0,3) == "011" ||
					telNumber.substring(0,3) == "016" ||
					telNumber.substring(0,3) == "017" ||
					telNumber.substring(0,3) == "018" ||
					telNumber.substring(0,3) == "019")	{ }
					else
					{
						errorCount ++;
						checker = true;
						break;
					}
					if (telNumber.length == 10)
					{
						if (parseInt(telNumber.substring(3,7)) <= 0)
						{
							errorCount ++;
							checker = true;
							break;
						}
					}
					else if (telNumber.length == 11)
					{
						if (parseInt(telNumber.substring(3,8)) <= 0)
						{
							errorCount ++;
							checker = true;
							break;
						}
					}
				}
			}
			if (checker)
			{
				continue;
			}
			var row = addtable.insertRow(addrowCount);
			row.bgColor="#FFFFFF";
			var colCount = table.rows[j].cells.length;

			for(var i=0; i<colCount; i++) 
			{   
				var newcell = row.insertCell(i); 
				newcell.innerHTML = table.rows[j].cells[i].innerHTML;
				switch (i)
				{
					case 0:
						newcell.width=24;
						newcell.align="center";
						break;
					case 1:
						newcell.width=35;
						newcell.align="center";
						break;
					case 2:
						newcell.width=150;
						break;
					case 3:
						newcell.width=96;
						newcell.align="center";
						break;
				}
				//alert(newcell.childNodes);                
				switch(newcell.childNodes[0].type) 
				{                    
					case "text":                            
						newcell.childNodes[0].value = "";                            
						break;                    
					case "checkbox":                            
						newcell.childNodes[0].checked = false;                            
						break;                    
					case "select-one":                            
						newcell.childNodes[0].selectedIndex = 0;                            
						break;                
				}            
			}
		}	
	}
	document.getElementById("countArea").innerHTML = addtable.rows.length - 1;
	alert("선택한 거래처" + checkCount + "건 중 성공 " + (checkCount - errorCount) + "건, 실패 " + errorCount + "건");
}         
		
function deleteRow(tableID) 
{            
	try 
	{            
		var table = document.getElementById(tableID);            
		var rowCount = table.rows.length;             
		for(var i=1; i<rowCount; i++) 
		{                
			var row = table.rows[i];                
			var chkbox = row.cells[0].childNodes[0];                
			if(null != chkbox && true == chkbox.checked) 
			{                    
				if(rowCount <= 1) 
				{                        
					alert("Cannot delete all the rows.");                        
					break;                    
				}                    
			table.deleteRow(i);                    
			rowCount--;                    
			i--;                
			}             
		}
		table.rows[0].cells[0].childNodes[0].checked = false;
		document.getElementById("countArea").innerHTML = table.rows.length - 1;
	}
	catch(e) 
	{                
		alert(e);            
	}        
}

function CallNumber(tableID)
{
	try 
	{         
		var callNum = document.getElementById("CallNumber");
		var SendNum = document.getElementById("SendNumber");
		var sendNumber = "";

		var table = document.getElementById(tableID);            
		var rowCount = table.rows.length;             
		for(var i=1; i<rowCount; i++) 
		{                
			var row = table.rows[i];                
			sendNumber = sendNumber + table.rows[i].cells[1].innerHTML + "','";
		}
		callNum.value = sendNumber; 
		SendNum.value = sendNumber;
	}
	catch(e) 
	{                
		alert(e);            
	} 
}

function sendSMSSearch(form) {
	CallNumber("sendlist")
	form.submit() ;
}

function maxLengthCheck(maxSize, lineSize, obj, remainObj)
{ 
	var temp;
	var f = obj.value.length;
	var msglen = parseInt(maxSize);
	var tmpstr = "";
	var enter = 0;
	var strlen;

	if (f == 0)//남은 글자 byte 수 보여 주기
	{  
		if (remainObj != null)//null 옵션이 아닐 때 만 보여준다.
		{
			remainObj.value = (80 - msglen) + "/80 Byte";
		}  
	}
	else
	{
		for(k = 0; k < f ; k++)
		{
			temp = obj.value.charAt(k);

			if(temp =="\n")
			{
			enter++;
			}
			if(escape(temp).length > 4)
				msglen -= 2;
			else
				msglen--;
	  
			if(msglen < 0)
			{
				alert("총 영문 "+(maxSize*2)+"자 한글 "+maxSize+"자 까지 쓰실 수 있습니다.");
				obj.value = tmpstr;
				break;
			}
			else if (lineSize != null & enter > parseInt(lineSize))// lineSize 옵션이 nulldl 아닐 때만 사용
			{
				alert("라인수 "+lineSize+"라인을 넘을 수 없습니다.")
				enter = 0;
				strlen = tmpstr.length -1;
				obj.value = tmpstr.substring(0, strlen);
				break;
			}
			else
			{
				if (remainObj != null)
				{
					remainObj.value = (80 - msglen) + "/80 Byte";
				}      
				tmpstr += temp;
			}
		}  
	}
} 
function sendSMS() 
{
	var addtable = document.getElementById("sendlist");
	var addrowCount = addtable.rows.length;
	if (addrowCount <= 1)
	{
		alert("보낼 거래처를 추가하십시오");
		return;
	}

	if (formmessage.searche.value == "")
	{
		alert("메시지를 입력하십시오");
		return;
	}
	//거래처 코드 
	CallNumber("sendlist")
	formmessage.submit() ;
}

function messageclear()
{
	formmessage.searche.value = "";
	formmessage.byteprint.value = "80 Byte";
	formmessage.searche.focus();
}

function CheckAll(TableName)
{
	var table = document.getElementById(TableName); 
	var tableRow = table.rows.length;
	var row = table.rows[0]; 
	var chkbox = row.cells[0].childNodes[0];  
	for(var i=1; i<tableRow; i++) 
	{                
		if (chkbox.checked)
		{
			var chkboxitem = table.rows[i].cells[0].childNodes[0];  
			chkboxitem.checked=true;
		}	       
		else
		{
			var chkboxitem = table.rows[i].cells[0].childNodes[0];  
			chkboxitem.checked=false;
		}
	}
}

//-->
</script>
<script language="javascript" src="/adminpage/incfile/javascript_data.js"></script>
    <%
searchimsiday1 = replace(left(now(),10),"-","")
searchimsiday2 = replace(left(now(),10),"-","")
%>
<script language="JavaScript">
<!--

function serchtodaycheck(val1,val2){
    val1.value = <%=searchimsiday1%>;


}

function serchtodaychecktime(val1,val2,val11,val22){
	val1.value = <%=searchimsiday1%>;
	val11.value = "000000";
	val22.value = "235959";
}

function cyberNumchb(){
	alert("<%=session("Ausername")%>은(는) 미 신청 회원사이므로 이 서비스를 제공하지 않습니다.!!") ;
}
//-->
</script>

<style>
.hide { position:absolute; visibility:hidden; }
.show { position:absolute; visibility:visible; }
</style>

<SCRIPT LANGUAGE="JavaScript">
<!-- 
var _progressBar = new String("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■");
var _progressEnd = 15;
var _progressAt = 0;
var _progressWidth = 70;        // 그래프의 가로크기

function ProgressCreate(end) {
        _progressEnd = end;
        _progressAt = 0;

        if (document.all) {        
                progress.className = 'show';
                progress.style.left = (document.body.clientWidth/2) - (progress.offsetWidth/2);
                progress.style.top = (document.body.clientHeight/2) - (progress.offsetHeight/2);
        } else if (document.layers) {        
                document.progress.visibility = true;
                document.progress.left = (window.innerWidth/2) - 100;
                document.progress.top = (window.innerHeight/2) - 40;
        }

        ProgressUpdate();
}

function ProgressDestroy() {
        if (document.all) {        
                progress.className = 'hide';
        } else if (document.layers) {
                document.progress.visibility = false;
        }
}

function ProgressStepIt() {
        _progressAt++;
        if(_progressAt > _progressEnd) _progressAt = _progressAt % _progressEnd;
        ProgressUpdate();
}

function ProgressUpdate() {
        var n = (_progressWidth / _progressEnd) * _progressAt;
        if (document.all) {        
                var bar = dialog.bar;
        } else if (document.layers) {        
                var bar = document.layers["progress"].document.forms["dialog"].bar;
                n = n * 0.55;        
        }
        var temp = _progressBar.substring(0, n);
        bar.value = temp;
}

function Demo() {
        ProgressCreate(10);
        window.setTimeout("Click()", 100);
}

function Click() {
        if(_progressAt >= _progressEnd) {
                ProgressDestroy();
                return;
        }
        ProgressStepIt();
        window.setTimeout("Click()", 500);
}

function CallJS(jsStr) { 
  return eval(jsStr)
  }
// -->
</script>

</head>

<%

	imsiflagpopup = request("imsiflag")
	if imsiflagpopup="y" then
		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select content,flag,hflag,wsize,hsize"
		SQL = sql & " from tb_gongi "
		rslist.Open sql, db, 1
		imsicontent = rslist(0)
		imsiflag = rslist(1)
		imsihflag = rslist(2)
		imsiwsize = rslist(3)
		imsihsize = rslist(4)
		rslist.close

   
%>
		<body leftmargin="0" topmargin="0" onLoad="MM_preloadImages('admin/menu01_1.gif','admin/menu02_1.gif','admin/menu03_1.gif','admin/menu04_1.gif','admin/menu05_1.gif');">
<%
	else
%>
		<body leftmargin="0" topmargin="0" onLoad="MM_preloadImages('admin/menu01_1.gif','admin/menu02_1.gif','admin/menu03_1.gif','admin/menu04_1.gif','admin/menu05_1.gif')">
<%
	end if
%>

<table width='1000' border='0' cellspacing='0' cellpadding='0' align='center'>
            
			<tr>
               <% If session("Auserid") = "" Then %> 
                <td style='height:40px;text-align:right;'></td>
                <%else %>
				<td style='height:40px;text-align:right;'>Login ID : <%=session("Auserid")%> (<%=session("Areaname")%>&nbsp;<%=session("AName")%>)&nbsp;<a href="/moa_loan/logout.asp"><img src='/moa_loan/images/btn_logout.gif'></a></td>
                <%end if %>
			</tr>
			<tr>
				<td>
					<table width='1000' border='0' cellspacing='0' cellpadding='0' align='center'>
						<tr>
							<td style='150px;'>
                              <!-- <%if session("AuserGubunName")="관리자" then%>
                              
                                <a href='index.asp'><img src="/moa_loan/fileupdown/logo/<%=session("Afilename")%>"></a>

                                <%elseif session("AuserGubunName")="금융기관" then%>
                                 <a href='index.asp'><img src='/moa_loan/fileupdown/logo/<%=session("Afilename")%>'></a>

                                <%elseif session("AuserGubunName")="" then%>
                                 <a href='index.asp'><img src='/moa_loan/images/toplogo.gif'></a>
                               
                                <%end if %>-->

                                 <%if session("Ausergubun")="1" then%>
                              
                                <a href='list.asp'><img src="/moa_loan/fileupdown/logo/<%=session("Afilename")%>"></a>

                           

                                <%else%>
                                 <a href='list.asp'><img src='/moa_loan/images/toplogo.gif'></a>
                               
                                <%end if %>
                               
                                
							</td>
							<td style='width:6px;background:url(/moa_loan/images/tm_left.gif) no-repeat;'></td>
							<td style='width:82%;background:url(/moa_loan/images/tm_bg.gif) repeat;text-align:left;'><a href='List.asp' onMouseOut='MM_swapImgRestore();' onMouseOver="MM_swapImage('MM1','','/moa_loan/images/tm1_over.gif','1');"><img src='/moa_loan/images/tm1.gif' id='MM1'></a><a href='accounts.asp' onMouseOut='MM_swapImgRestore();' onMouseOver="MM_swapImage('MM2','','/moa_loan/images/tm2_over.gif','2');"><img src='/moa_loan/images/tm2.gif' id='MM2'></a><a href='LoginId.asp' onMouseOut='MM_swapImgRestore();' onMouseOver="MM_swapImage('MM3','','/moa_loan/images/tm3_over.gif','3');"><img src='/moa_loan/images/tm3_on.gif' id='MM3'></a></td>
							<td style='width:6px;background:url(/moa_loan/images/tm_right.gif) no-repeat;'></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<!-- 상단메뉴 끝 -->
		<!-- 콘텐츠 시작 -->
		

<SCRIPT LANGUAGE="JavaScript">
<!-- 
document.write("<span id=\"progress\" class=\"hide\">");
        document.write("<FORM name=dialog>");
        document.write("<TABLE border=0  bgcolor=\"#FFCC00\">");
        document.write("<TR><TD ALIGN=\"center\">");
        document.write("<font color=red>데이타를 가져오는 중입니다.<BR>잠시만 기다리세요.<br>");
        document.write("<input type=text name=\"bar\" size=\"" + _progressWidth/2 + "\"");
        if(document.all)         
                document.write(" bar.style=\"color:navy;\">");
        else        
                document.write(">");
        document.write("</TD></TR>");
        document.write("</TABLE>");
        document.write("</FORM>");
document.write("</span>");
ProgressDestroy();        
//  -->
</script>
