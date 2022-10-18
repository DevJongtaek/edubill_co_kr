<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=3.0, minimum-scale=1.0, user-scalable=1, target-densitydpi=medium-dpi" />
<link rel="stylesheet" href="/css/dog.css" type="text/css">
<title>edubill.co.kr</title>
<!-- 스크롤 메뉴 대출 -->
<script type="text/javascript">
<!--
history.navigationMode= 'compatible';
window.history.forward(0);

document.onkeydown = function (e) {
	key = (e) ? e.keyCode : event.keyCode;

	if (key == 8 || key == 116) 
	{
		if (event.srcElement.type != "text" && event.srcElement.type != "textarea") 
		{
			if (e) 
			{ //표준 
				e.preventDefault();
			}
			else 
			{ //익스용
				event.keyCode = 0;
				event.returnValue = false;
			}
		}
	}
}
//뒤로 가기 버튼 시 데이터 손실 방지용
function noBack() { window.history.forward() }
noBack();
window.onload = noBack;
window.onpageshow = function (evt) { if (evt.persisted) noBack() }
window.onunload = function () { void (0) }


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
	val2.value = <%=searchimsiday2%>;
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

<body leftmargin="0" topmargin="0" onLoad="MM_preloadImages('admin/menu01_1.gif','admin/menu02_1.gif','admin/menu03_1.gif','admin/menu04_1.gif','admin/menu05_1.gif')">

<!--#include virtual="/db/db.asp"-->
<%
	'if session("Ausergubun")>1 then
		set rs22 = server.CreateObject("ADODB.Recordset")
		SQL = " select cyberNum,ipConFlag from tb_company where idx = "& left(session("AAusercode"),5)
		rs22.Open sql, db, 1
		if not rs22.eof then
			cyberNum  = rs22(0)
			ipConFlag = rs22(1)
		else
			cyberNum  = ""
			ipConFlag = ""
		end if
		rs22.close
	'end if
%>

<table width="310"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" align="right">

		<table  border=0 cellspacing="0" cellpadding="0" width="310">
			<tr>
        			<td>[ Login ID : <%=session("AAuserid")%>(<%=session("AAcomname")%>) ] &nbsp;&nbsp; </td>
				</tr>
				<tr>
        			<td align=right><a href="/adminpage/logout2.asp"><img src="/images/admin/top_menu02.gif" width="60" height="17" border=0></a></td>
      			</tr>
			<tr>

                  <% If  left(session("AAusercode"),5) = "19209"  Then %>
                <td colspan=3 align=right>주문문의 : 1661-9481</td>
                <%else %>
              	<td colspan=3 align=right>주문문의 : <%=session("AAtel")%></td>
                <%end if%>


        		
      			</tr>
    		</table>

		</td>
	</tr>
	<tr>
		<td> 
		<table width="310"  border=0 cellspacing="0" cellpadding="0">
			<tr height="34">
        		<td width=67><img src="/fileupdown/logo/<%=session("AAfilename")%>" width="89" height="45" border="0"></td>
				<td align=right><% If  left(session("AAusercode"),5) = "19209" or left(session("AAusercode"),5) = "96338" Then %>
						<a href="http://goobne.shop/"><font color=red size=3><b>[전단지 주문]</b></a></font>
					<% End If %></td>				
			</tr>
			<tr>
        		<td valign=bottom align=right colspan="2">
					<!--<div id="notice" style="position:absolute; left:150px; top:18px; z-index:0; width:480;height:80;background-color:white; overflow:auto"><iframe src="/adminpage/weather2.asp" width=475 height=77 frameborder=0 marginwidth=0 marginheight=0></iframe></div>-->
					<a href="/adminpage/mobile/list.asp" onClick="CallJS('Demo()')"><font color=blue><B>[ 주문내역 ]</a>
					<%if session("ymflag") = "" then%>
						<%if session("Aordertimeout") = "" then%>
							<%if session("AAproflag")="1" then%>
								<a href="/adminpage/mobile/index4.asp"><font color=blue><B>[ 주문하기 ]</a>
							<%else%>
								<a href="/adminpage/mobile/mAgencyOrderFRM.asp?popnot=1"><font color=blue><B>[ 주문하기 ]</a>
							<%end if%>
						<%end if%>
					<%end if%>
					<a href="/adminpage/mobile/pwd.asp"><font color=blue><B>[ 비밀번호/가상계좌 ]</a>
					<%'if cyberNum="y" then%>
						<%if ipConFlag="1" then%>
							<A href="/adminpage/mobile/cyberNum2.asp"><font color=blue><B>[입금내역조회]</a>
						<%elseif ipConFlag="2" then%>
							<A href="/adminpage/mobile/cyberNum.asp"><font color=blue><B>[입금내역조회]</a>
                     <%elseif ipConFlag="3" then%>
							<A href="/adminpage/mobile/cyberNum3.asp"><font color=blue><B>[입금내역조회]</a>
					
						<%end if%>
					<%'else%>
						<!--<A href="#" onclick="cyberNumchb()"><font color=blue><B>[ 가상계좌입금내역 ]</a>-->
					<%'end if%>
				</td>
      			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td></td>
		<!-- 스크롤 메뉴 대출 
	<td valign=bottom><div id="layer1" style="position:relative; visibility:visible; left:0px; top:0px; z-index:10; width=60px">
	<a href="#" onclick="window.open('../adminpage/loan/loan.asp','','top=100,left=100,width=650,height=800,scrollbars=yes'); return false;"><img src="../images/loan.jpg" border=0></a>
	<a href="http://www.wiseloan.co.kr/wiseloan_bin/landing_edubill.jsp" target="_blank"><img src="/images/loan_sol1.jpg" border=0></a>
	<!--<div align="center"><a href="#top" onfocus="this.blur()" title="위로">↑ top</a></div>
	</div>--></td>
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