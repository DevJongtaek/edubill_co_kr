<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>edubill.co.kr</title>

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

function ExcelExport(){
	
	if (selectbox.selectexcel[selectbox.selectexcel.selectedIndex].value == "product")
	{
		if (kindform.searchordertime.value == "y")
		{
			selectbox.action="excell4.asp?searcha=" + kindform.searcha.value + "&searchb=" + kindform.searchb.value + "&searchc=<%=searchc%>&gotopage=<%=gotopage%>&searchd=" + kindform.searchd.value + "&searche=" + kindform.searche.value + "&searchf=" + kindform.searchordertime.value
		}
		else
		{
			selectbox.action="excell4.asp?searcha=" + kindform.searcha.value + "&searchb=" + kindform.searchb.value + "&searchc=<%=searchc%>&gotopage=<%=gotopage%>"
		}
		
		selectbox.submit() ;
		return false ;
	}
	else if (selectbox.selectexcel[selectbox.selectexcel.selectedIndex].value == "chain")
	{
		if (kindform.searchordertime.value == "y")
		{
			selectbox.action="excell6.asp?searcha=" + kindform.searcha.value + "&searchb=" + kindform.searchb.value + "&searchc=<%=searchc%>&gotopage=<%=gotopage%>&searchd=" + kindform.searchd.value + "&searche=" + kindform.searche.value + "&searchf=" + kindform.searchordertime.value
		}
		else
		{
			selectbox.action="excell6.asp?searcha=" + kindform.searcha.value + "&searchb=" + kindform.searchb.value + "&searchc=<%=searchc%>&gotopage=<%=gotopage%>"
		}
		
		selectbox.submit() ;
		return false ;
	}
	else	
	{
		if (kindform.searchordertime.value == "y")
		{
			selectbox.action="excell5.asp?searcha=" + kindform.searcha.value + "&searchb=" + kindform.searchb.value + "&searchd=" + kindform.searchd.value + "&searche=" + kindform.searche.value + "&searchf=" + kindform.searchordertime.value
		}
		else
		{
			selectbox.action="excell5.asp?searcha=" + kindform.searcha.value + "&searchb=" + kindform.searchb.value 
		}

		selectbox.submit() ;
		return false ;
	}
	//form.action="GongiAllSave.asp"
	//form.submit() ;
//	return false ;
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

function sendSMS2() 
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
<script language="JavaScript">
<!--
<%
searchimsiday1 = replace(left(now(),10),"-","")
searchimsiday2 = replace(left(now(),10),"-","")
%>
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

<table width="800"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" align="right">

		<table  border=0 cellspacing="0" cellpadding="0">
			<tr>


				<%if session("AchoiceDcenter")<>"" then%>
	        			<td>[ Login ID : <%=session("Auserid")%>(<%=session("AchoiceDcenter")%>) ] &nbsp;&nbsp; </td>
				<%else%>
	        			<td>[ Login ID : <%=session("Auserid")%>(<%=session("Ausername")%>) ] &nbsp;&nbsp; </td>
				<%end if%>
        			<td><!--<a href="/"><img src="/images/admin/top_menu01.gif" width="57" height="17" border="0"></a>--></td>
        			<td><a href="/adminpage/logout.asp"><img src="/images/admin/top_menu02.gif" width="60" height="17" border=0></a></td>
      			</tr>
    		</table>

		</td>
	</tr>
	<tr>
		<td>

	<%if session("Ausergubun")="1" then%>

		<%if session("Auserid")="admin" then%>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr height="38">
        				<td rowspan="2"><img src="/fileupdown/logo/<%=session("Afilename")%>" width="141" height="71" border="0"></td>
        				<td width="83" ></td>
        				<td width="128"></td>
	        			<td width="126"></td>
        				<td width="125"></td>
        				<td width="126"></td>
      				</tr>
      				<tr>
        				<td height="35" colspan="5"></td>
        			</tr>
			</table>
		<%else%>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr height="38">
        				<td rowspan="2"><img src="/fileupdown/logo/<%=session("Afilename")%>" width="141" height="71" border="0"></td>
        				<td width="83" ><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/admin/m_menu01_1.gif',1)"><img src="/images/admin/m_menu01.gif" name="Image5" border="0" onMouseOver="MM_showHideLayers('Layer1','','show','Layer2','','hide','Layer3','','hide')"></a></td>
        				<td width="128"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/admin/m_menu02_1.gif',1)"><img src="/images/admin/m_menu02.gif" name="Image6" border="0" onMouseOver="MM_showHideLayers('Layer1','','hide','Layer2','','show','Layer3','','hide')"></a></td>
	      	  			<td width="126"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/admin/m_menu03_1.gif',1)"><img src="/images/admin/m_menu03.gif" name="Image7" border="0" onMouseOver="MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','show')" alt="세금계산서관리"></a></td>
        				<td width="125"></td>
        				<td width="126"></td>
      				</tr>
      				<tr>
        				<td height="35" colspan="5">
					<div id="Layer1" style="position:absolute; left:160px; top:70px; width:630px; height:22px; z-index:1; visibility: hidden;">
        	  			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
            					<tr>
              						<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
              						<td align="center" bgcolor="E9E9E9">
								<a href="/adminpage/code/list.asp?flag=1">회원사관리</a> | 
								<a href="/adminpage/code/regfile.asp">청구화일생성</a> | 
								<a href="/adminpage/SMS/NewSMS.asp">문자전송</a> | 
								<a href="/adminpage/code/updel.asp">멘트관리</a> | 
								<a href="/adminpage/code/ulist.asp">아이디관리</a> | 
								<a href="/adminpage/code/alldel2.asp">데이타삭제</a> | 
								<a href="/adminpage/code/root.asp">Root비번변경</a> |
								<a href="/adminpage/code/gongi.asp">회원사공지사항</a>
							</td>
              						<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
            					</tr>
          				</table>
        				</div>
					<div id="Layer2" style="position:absolute; left:326px; top:70px; width:430px; height:22px; z-index:2; visibility: hidden;">
					<table width="100%"  border="0" cellspacing="0" cellpadding="0">
						<tr>
      							<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
      							<td align="center" bgcolor="E9E9E9">
								<a href="/adminpage/logo/list.asp">로고관리</a> | 
								<a href="/adminpage/bbs/list.asp?uid=faq">FAQ</a> | 
								<a href="/adminpage/bbs/list.asp?uid=customer">고객의소리</a> | 
								<a href="/adminpage/bbs/list_root.asp">공지사항</a> | 
<!--								<a href="/adminpage/notice/list.asp">공지사항</a> |-->
								<a href="/adminpage/bbs/list.asp?uid=news">뉴스</a> | 
								<a href="/adminpage/bbs/list.asp?uid=pds">자료실</a>| 
                                      <a href="/adminpage/bbs/badmi.asp">어플주문내역</a>
							</td>
      							<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
    						</tr>
  					</table>
					</div>
					<div id="Layer3" style="position:absolute; left:300px; top:70px; width:550px; height:22px; z-index:2; visibility: hidden;">
					<table width="100%"  border="0" cellspacing="0" cellpadding="0">
						<tr>
      							<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
      							<td align="center" bgcolor="E9E9E9">
								<a href="/adminpage/account/list.asp">세금계산서관리</a> | 
								<a href="/adminpage/account/list2.asp">세금계산서조회</a> |  
								<a href="/adminpage/code/cyberNum.asp">입금내역조회</a> |
								<a href="/adminpage/code/TcyberNum.asp">종합입금관리</a> |
                                      <a href="/adminpage/account/virtuallist.asp">가상계좌집계</a> |
                                        <a href="/adminpage/code/smslist.asp">SMS집계</a>
							</td>
      							<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
    						</tr>
  					</table>
					</div>
					</td>
        			</tr>
			</table>
		<%end if%>

	<%elseif session("Ausergubun")="4" then%>

		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			<tr height="38">
        			<td><a href="/"><img src="/images/admin/logo.gif" width="141" height="71" border="0"></a></td>
        			<td width="83" ></td>
        			<td width="128"></td>
        			<td width="126"></td>
        			<td width="125"></td>
        			<td width="126"></td>
      			</tr>
		</table>

	<%elseif session("Ausergubun")="3" and session("Auserwrite")="n" then%>

		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			<tr>
        			<td rowspan="2"><img src="/fileupdown/logo/<%=session("Afilename")%>" width="141" height="71" border="0"></td>
        			<td width="83" height="38"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/admin/menu01_1.gif',1)"><img src="/images/admin/menu01.gif" name="Image5" width="83" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','show','Laye4','','hide','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="128"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/admin/menu02_1.gif',1)"><img src="/images/admin/menu02.gif" name="Image6" width="128" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','show','Layer1','','hide','Laye4','','hide','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="126"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/admin/menu03_1.gif',1)"><img src="/images/admin/menu03.gif" name="Image7" width="126" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','hide','Laye3','','show','Laye5','','hide')"></a></td>
        			<td width="125"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/admin/menu04_1.gif',1)"><img src="/images/admin/menu04.gif" name="Image8" width="125" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','show','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="126"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/admin/menu05_1.gif',1)"><img src="/images/admin/menu05.gif" name="Image9" width="126" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','hide','Laye3','','hide','Laye5','','show')"></a></td>
      			</tr>
      			<tr>
        			<td height="35" colspan="5">

				<div id="Layer1" style="position:absolute; left:225px; top:70px; width:480px; height:22px; z-index:1; visibility: hidden;">
          			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
            				<tr>
              					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
              					<td align="center" bgcolor="E9E9E9">
							<A href="/adminpage/order/list.asp" onClick="CallJS('Demo()')">주문내역</a> | 
                                      <%if session("Usereturn")="y" then%>
                            <A href="/adminpage/order/Returnlist.asp" onClick="CallJS('Demo()')">반품내역</a> | 
                                      <%end if %>
							<A href="/adminpage/order/tlist.asp">상품별집계표</a> | 
							<A href="/adminpage/order/filemake/dlist.asp">다운로드</a>
							| <A href="/adminpage/order/rfilemake/dlist.asp">재생성</a>
							<%if session("Amiorderflag")="y" then%>| <A href="/adminpage/order/MOrderList.asp">미주문내역</a><%end if%>
							| <A href="#" onclick="javascript:newwinB();">체인점주문</a>
						</td>
              					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
            				</tr>
          			</table>
        			</div>

				<div id="Layer2" style="position:absolute; left:326px; top:70px; width:129px; height:22px; z-index:2; visibility: hidden;">
				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
					<tr>
      						<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
      						<td align="center" bgcolor="E9E9E9"><A href="/adminpage/delivery/list.asp">배달내역</td>
      						<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
    					</tr>
  				</table>
				</div>

				<div id="Laye4" style="position:absolute; left:592px; top:70px; width:155px; height:22px; z-index:4; visibility: hidden;">
            			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              				<tr>
                				<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                				<td align="center" bgcolor="E9E9E9">
							<a href="#" onclick="javascript:topmenucheck();">URL전송</a> |
							업무연락
						</td>
                				<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              				</tr>
            			</table>
          			</div>

				<%if session("AcyberNum")="y" then%>
					<div id="Laye3" style="position:absolute; left:335px; top:70px; width:410px; height:22px; z-index:3; visibility: hidden;">
            				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td align="center" bgcolor="E9E9E9">
								<!-- 2012-10-10 지사 전표출력 허용
								<A href="#" onclick="javascript:topmenucheck();">전표출력</a> | 
								<A href="#" onclick="javascript:topmenucheck();">전표출력내역</a> |  -->
								<A href="/adminpage/tax/list2.asp">전표출력</a> | 
								<A href="/adminpage/tax/list4.asp">전표출력내역</a> | 
								<A href="#" onclick="javascript:topmenucheck();">매출집계표</a> | 
								<A href="#" onclick="javascript:topmenucheck();">입금내역1</a> | 
								<A href="#" onclick="javascript:topmenucheck();">입금내역2</a>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%else%>
					<div id="Laye3" style="position:absolute; left:465px; top:70px; width:250px; height:22px; z-index:3; visibility: hidden;">
            				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td align="center" bgcolor="E9E9E9">
								<!-- 2012-10-10 지사 전표출력 허용
								<A href="#" onclick="javascript:topmenucheck();">전표출력</a> | 
								<A href="#" onclick="javascript:topmenucheck();">전표출력내역</a> |  -->
								<A href="/adminpage/tax/list2.asp">전표출력</a> | 
								<A href="/adminpage/tax/list4.asp">전표출력내역</a> | 
								<A href="#" onclick="javascript:topmenucheck();">매출집계표</a>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%end if%>

				<%if session("Ajsusu")="y" then%>
					<div id="Laye5" style="position:absolute; left:320px; top:70px; width:<%if session("Ajsusu")="y" and session("Ausergubun")="3" then%>500<%else%>420<%end if%>px; height:22px; z-index:5; visibility: hidden;">
            				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td bgcolor="E9E9E9">
								<a href="#" onclick="javascript:topmenucheck();">상품관리</a> | 
								<a href="#" onclick="javascript:topmenucheck();">호차관리</a> |
								<%if session("Ausergubun")<>"3" then%>
									<a href="/adminpage/code/list.asp?flag=2">지사(점)관리</a> | 
								<%end if%>
								<a href="#" onclick="javascript:topmenucheck();">체인점관리</a> | 
								<%if session("Ausergubun")<>"3" then%><a href="/adminpage/code/ulist.asp">아이디관리</a> | <%end if%>
								<%if session("Ausergubun")="2" then%>
									<a href="/adminpage/account/hlist.asp">거래명세서</a> |
									<a href="/adminpage/code/bonsa.asp">본사정보수정</a>
								<%elseif session("Ausergubun")="3" then%>
									<a href="/adminpage/account/hlist.asp">거래명세서</a> |
									<%if session("Ajsusu")="y" then%><a href="/adminpage/code/jisaSu.asp" onClick="CallJS('Demo()')">수수료정산내역</a> |<%end if%> 
									<a href="#" onclick="javascript:topmenucheck();">지사(점)정보수정</a>
								<%end if%>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%else%>
					<div id="Laye5" style="position:absolute; left:380px; top:70px; width:<%if session("Ajsusu")="y" and session("Ausergubun")="3" then%>500<%else%>430<%end if%>px; height:22px; z-index:5; visibility: hidden;">
            				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td bgcolor="E9E9E9">
								<a href="#" onclick="javascript:topmenucheck();">상품관리</a> | 
								<a href="#" onclick="javascript:topmenucheck();">호차관리</a> |
								<%if session("Ausergubun")<>"3" then%>
									<a href="/adminpage/code/list.asp?flag=2">지사(점)관리</a> | 
								<%end if%>
								<a href="#" onclick="javascript:topmenucheck();">체인점관리</a> | 
								<%if session("Ausergubun")<>"3" then%><a href="/adminpage/code/ulist.asp">아이디관리</a> | <%end if%>
								<%if session("Ausergubun")="2" then%>
									<a href="/adminpage/account/hlist.asp">거래명세서</a> |
									<a href="/adminpage/code/bonsa.asp">본사정보수정</a>
								<%elseif session("Ausergubun")="3" then%>
									<a href="/adminpage/account/hlist.asp">거래명세서</a> |
									<%if session("Ajsusu")="y" then%><a href="/adminpage/code/jisaSu.asp" onClick="CallJS('Demo()')">수수료정산내역</a> |<%end if%> 
									<a href="#" onclick="javascript:topmenucheck();">지사(점)정보수정</a>
								<%end if%>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%end if%>
				</td>
        		</tr>
		</table>

	<%else%>

		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			<tr>
        			<td rowspan="2"><img src="/fileupdown/logo/<%=session("Afilename")%>" width="141" height="71" border="0"></td>
        			<td width="83" height="38"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/admin/menu01_1.gif',1)"><img src="/images/admin/menu01.gif" name="Image5" width="83" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','show','Laye4','','hide','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="128"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/admin/menu02_1.gif',1)"><img src="/images/admin/menu02.gif" name="Image6" width="128" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','show','Layer1','','hide','Laye4','','hide','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="126"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/admin/menu03_1.gif',1)"><img src="/images/admin/menu03.gif" name="Image7" width="126" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','hide','Laye3','','show','Laye5','','hide')"></a></td>
        			<td width="125"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/admin/menu04_1.gif',1)"><img src="/images/admin/menu04.gif" name="Image8" width="125" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','show','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="126"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/admin/menu05_1.gif',1)"><img src="/images/admin/menu05.gif" name="Image9" width="126" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','hide','Laye3','','hide','Laye5','','show')"></a></td>
      			</tr>
      			<tr>
        			<td height="35" colspan="5">

				<div id="Layer1" style="position:absolute; left:225px; top:70px; width:480px; height:22px; z-index:1; visibility: hidden;">
          			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
            				<tr>
              					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
              					<td align="center" bgcolor="E9E9E9">
							<A href="/adminpage/order/list.asp" onClick="CallJS('Demo()')">주문내역</a> | 
                                       <%if session("Usereturn")="y" then%>
                           <A href="/adminpage/order/Returnlist.asp" onClick="CallJS('Demo()')">반품내역</a> | 
                                      <%end if %>
							<A href="/adminpage/order/tlist.asp">상품별집계표</a>
							| <A href="/adminpage/order/filemake/dlist.asp">다운로드</a>
							| <A href="/adminpage/order/rfilemake/dlist.asp">재생성</a>
							<%if session("Amiorderflag")="y" then%>| <A href="/adminpage/order/MOrderList.asp">미주문내역</a><%end if%>
							| <A href="#" onclick="javascript:newwinB();">체인점주문</a>
						</td>
              					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
            				</tr>
          			</table>
        			</div>
				<div id="Layer2" style="position:absolute; left:326px; top:70px; width:129px; height:22px; z-index:2; visibility: hidden;">
				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
					<tr>
      						<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
      						<td align="center" bgcolor="E9E9E9"><A href="/adminpage/delivery/list.asp">배달내역</td>
      						<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
    					</tr>
  				</table>
				</div>
				<div id="Laye4" style="position:absolute; left:542px; top:70px; width:225px; height:22px; z-index:4; visibility: hidden;">
            			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              				<tr>
                				<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                				<td align="center" bgcolor="E9E9E9">
							<a href="/adminpage/sms/write.asp">URL전송</a> | 
							<%if session("Ausergubun")="2" then%>
								<%'if session("Asmsflag")="y" then%>
									<a href="/adminpage/sms/SendList.asp">SMS전송내역</a> | 
								<%'else%>
									<!--<a href="#" onclick="cyberNumchb()"> |  SMS전송내역</a>-->
								<%'end if%>
								<%If session("SMS")="y" then%>
									<a href="/adminpage/sms/SendSMS.asp">SMS전송</a>
								<%else%>	
									 SMS전송
								<%End If %>
							<%End If %>
						</td>
                				<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              				</tr>
            			</table>
          			</div>
				<%if session("AcyberNum")="y" then%>
					<div id="Laye3" style="position:absolute; left:335px; top:70px; width:450px; height:22px; z-index:3; visibility: hidden;">
        	    			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td align="center" bgcolor="E9E9E9">
								<A href="/adminpage/tax/list2.asp">전표출력</a> | 
								<A href="/adminpage/tax/list4.asp">전표출력내역</a> | 
								<A href="/adminpage/tax/list3.asp">매출집계표</a> | 
								<A href="http://www.settlebank.co.kr/" target=_blank>입금내역1</a> | 
								<A href="/adminpage/tax/cyberNum.asp">입금내역2</a> |
								<A href="/adminpage/order/filemake/depositlist.asp">입금다운로드</a>
							</td>
        	        				<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%else%>
					<div id="Laye3" style="position:absolute; left:465px; top:70px; width:250px; height:22px; z-index:3; visibility: hidden;">
            				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td align="center" bgcolor="E9E9E9">
								<A href="/adminpage/tax/list2.asp">전표출력</a> | 
								<A href="/adminpage/tax/list4.asp">전표출력내역</a> | 
								<A href="/adminpage/tax/list3.asp">매출집계표</a>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%end if%>

				<%if session("Ajsusu")="y" then%>
					<div id="Laye5" style="position:absolute; left:<%if session("Ausergubun")="3" then%>290<%else%><%if session("Ausergubun")="2" then%>190<%else%>249<%end if%><%end if%>px; top:70px; width:<%if session("Ausergubun")<>"3" then%><%if session("Ausergubun")="2" then%>600<%else%>450<%end if%><%else%>500<%end if%>px; height:22px; z-index:5; visibility: hidden;">
        	    			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td bgcolor="E9E9E9">
								<a href="/adminpage/code/plist.asp">상품관리</a> | 
								<a href="/adminpage/code/clist.asp">호차관리</a> |
								<%if session("Ausergubun")<>"3" then%>
									<a href="/adminpage/code/list.asp?flag=2">지사(점)관리</a> | 
								<%end if%>
								<a href="/adminpage/code/list.asp?flag=3">체인점관리</a> | 
								<%if session("Ausergubun")<>"3" then%><a href="/adminpage/code/ulist.asp">아이디관리</a> | <%end if%>
								<%if session("Ausergubun")="2" then%><a href="/adminpage/code/alldel.asp">데이타삭제</a> | <%end if%>
								<%if session("Ausergubun")="2" then%>
									<a href="/adminpage/account/hlist.asp">거래명세서</a> |
									<a href="/adminpage/code/bonsa.asp">본사정보수정</a>
								<%elseif session("Ausergubun")="3" then%>
									<a href="/adminpage/account/hlist.asp">거래명세서</a> |
									<%if session("Ajsusu")="y" then%><a href="/adminpage/code/jisaSu.asp" onClick="CallJS('Demo()')">수수료정산내역</a> |<%end if%> 
									<a href="/adminpage/code/jisa.asp">지사(점)정보수정</a>
								<%end if%>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
	          			</div>
				<%else%>
					<div id="Laye5" style="position:absolute; left:<%if session("Ausergubun")="3" then%>380<%else%><%if session("Ausergubun")="2" then%>190<%else%>249<%end if%><%end if%>px; top:70px; width:<%if session("Ausergubun")<>"3" then%><%if session("Ausergubun")="2" then%>600<%else%>450<%end if%><%else%>420<%end if%>px; height:22px; z-index:5; visibility: hidden;">
        	    			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td bgcolor="E9E9E9">
								<a href="/adminpage/code/plist.asp">상품관리</a> | 
								<a href="/adminpage/code/clist.asp">호차관리</a> |
								<%if session("Ausergubun")<>"3" then%>
									<a href="/adminpage/code/list.asp?flag=2">지사(점)관리</a> | 
								<%end if%>
								<a href="/adminpage/code/list.asp?flag=3">체인점관리</a> | 
								<%if session("Ausergubun")<>"3" then%><a href="/adminpage/code/ulist.asp">아이디관리</a> | <%end if%>
								<%if session("Ausergubun")="2" then%><a href="/adminpage/code/alldel.asp">데이타삭제</a> | <%end if%>
								<%if session("Ausergubun")="2" then%>
									<a href="/adminpage/account/hlist.asp">거래명세서</a> |
									<a href="/adminpage/code/bonsa.asp">본사정보수정</a>
								<%elseif session("Ausergubun")="3" then%>
									<a href="/adminpage/account/hlist.asp">거래명세서</a> |
									<%if session("Ajsusu")="y" then%><a href="/adminpage/code/jisaSu.asp" onClick="CallJS('Demo()')">수수료정산내역</a> |<%end if%> 
									<a href="/adminpage/code/jisa.asp">지사(점)정보수정</a>
								<%end if%>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
	          			</div>
				<%end if%>

				</td>
        		</tr>
		</table>

	<%end if%>

		</td>
	</tr>
	<tr>
		<td><img src="/images/admin/top_img.gif" width="800" height="144"></td>
	<!-- 스크롤 메뉴 대출
	<% If session("Auserid") <> "huwloan" Then%>  <td valign=bottom><div id="layer1" style="position:relative; visibility:visible; left:0px; top:0px; z-index:10; width=60px">
	<a href="#" onclick="window.open('../loan/loan.asp','','top=100,left=100,width=650,height=800,scrollbars=yes'); return false;"><img src="../images/loan.jpg" border=0></a>
	<a href="http://www.wiseloan.co.kr/wiseloan_bin/landing_edubill.jsp" target="_blank"><img src="/images/loan_sol1.jpg" border=0></a>
	<!--<div align="center"><a href="#top" onfocus="this.blur()" title="위로">↑ top</a></div>
	</div>--></td>
	<% End If %>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

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
