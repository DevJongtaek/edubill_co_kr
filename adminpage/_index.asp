<%
	Response.Expires = -1
	response.AddHeader "Pragma", "no-cache"
	response.AddHeader "cache-control", "no-store"
%>
<%
	session("AAcomname") = ""
	session("AAusercode") = ""
	session("AAfilename") = ""

	session("AAcomname") = ""
	session("AAusercode") = ""
	session("AAfilename") = ""
	session("AAtel") = ""
	session("Aordertimeout")=""
	session("ymflag") = ""
	session("AAproflag") = ""
	session("AAtcode") = ""
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/css/dog.css" type="text/css">
<title>edubill.co.kr</title>
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
function characterCheck() {
            var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\+┼<>@\#$%&\'\"\\\(\=]/gi;//정규식 구문
            var obj = document.getElementsByName("bccode")[0]
            if (RegExp.test(obj.value)) {
                alert("특수문자는 입력하실 수 없습니다.");
                obj.value = obj.value.substring(0, obj.value.length - 1);//특수문자를 지우는 구문
            }

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

<script Language="JavaScript">
<!-- 
function checkValue() {



	if (form.bccode.value=="") {
		alert("가맹점코드를 입력하여 주시기바랍니다.") ;
		form.bccode.focus() ;
		return false ;
	}
	if (form.bccode.value.length<8) {
		alert("가맹점코드는 8자리입니다") ;
		form.bccode.focus() ;
		return false ;
	}
//	if (form.pwd.value=="") {
//		alert("비밀번호를 입력하여 주시기바랍니다.") ;
//		form.pwd.focus() ;
//		return false ;
//	}
	form.submit() ;
	return false ;
}

//-->
</script>

</head> 

<body leftmargin="0" topmargin="0" onLoad="form.bccode.focus(); MM_preloadImages('admin/menu01_1.gif','admin/menu02_1.gif','admin/menu03_1.gif','admin/menu04_1.gif','admin/menu05_1.gif')">

<table width="770"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>

		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			<tr height="38">
        			<td rowspan="2"><img src="/fileupdown/에듀빌.bmp" width="141" height="71" border="0"></td>
        			<td width="83" ></td>
        			<td width="128"></td>
        			<td width="126"></td>
        			<td width="125"></td>
        			<td width="126"></td>

      			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td><img src="/images/admin/top_img.gif" width="770" height="144"></td>
		<!-- 스크롤 메뉴 대출
	<td valign=bottom><div id="layer1" style="position:relative; visibility:visible; left:0px; top:0px; z-index:10; width=60px">
	<a href="#" onclick="window.open('../adminpage/loan/loan.asp','','top=100,left=100,width=650,height=800,scrollbars=yes'); return false;"><img src="../images/loan.jpg" border=0></a>
	<a href="http://www.wiseloan.co.kr/wiseloan_bin/landing_edubill.jsp" target="_blank"><img src="/images/loan_sol1.jpg" border=0></a>
	<!--<div align="center"><a href="#top" onfocus="this.blur()" title="위로">↑ top</a></div>
	</div>--></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>



<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>




<table width="100%" height=100% border="0" cellspacing="0" cellpadding="0" align="center">

<form action=loginok2.asp name=form method=post onsubmit="return checkValue()">

	<tr>
	  <td height="30" align=center>&nbsp;</td>
	  </tr>
	<tr>
		<td align=center>

		  <table width="365" height="160" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td valign="top" background="images/admin_bg.gif"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="40">&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>

<table border=0 cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td width=100></td>
		<td>

		<table border=0 cellspacing="0" cellpadding="0" align="center">
                	<tr>
                      		<td align=right><img src="images/admin_title.gif">&nbsp;</td>
                      		<td><input type=text name=bccode size=8 style=background:#f4f2e9 tabindex=1 maxlength=8 onkeyup="characterCheck()" onkeydown="characterCheck()"></td>
                      		<td rowspan=2 width=80 align=center><input type=image tabindex=3 src="images/admin_bu.gif" width="58" height="58" border=0></td>
                    	</tr>
                	<tr>
                      		<td align=right><img src="images/admin_title1.gif" >&nbsp;</td>
                      		<td><input type=text name=pwd size=8 style=background:#f4f2e9 tabindex=2 maxlength=10></td>
                    	</tr>
		</table>

		</td>
	</tr>
</table>


                  </td>
                </tr>
              </table></td>
            </tr>
          </table>
		  </td>
	</tr>

</form>

</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR><BR>

<table width="770"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="20"></td>
	</tr>
	<tr>
		<td height="1" bgcolor="E7E7E7"></td>
	</tr>
	<tr>
		<td>

		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			<tr>
              			<td width="160" align="right"><img src="/images/main/bot_logo.gif" width="129" height="42"></td>
              			<td height="55"><img src="/images/main/bot_txt.gif" width="356" height="42"></td>
              			<td align="right"><img src="/images/main/banner01.gif" width="172" height="45"></td>
            		</tr>
        	</table>

		</td>
	</tr>
</table>

</body>
</html>