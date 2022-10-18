<%
	Response.Expires = -1
	response.AddHeader "Pragma", "no-cache"
	response.AddHeader "cache-control", "no-store"
%>
<%
Dim user_agent, mobile_browser, Regex, match, mobile_agents, mobile_ua, i, size
user_agent = Request.ServerVariables("HTTP_USER_AGENT")
mobile_browser = 0
Set Regex = New RegExp
With Regex
.Pattern = "(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|pda|mobile|mini|palm)"
.IgnoreCase = True
.Global = True
End With
match = Regex.Test(user_agent)
If match Then mobile_browser = mobile_browser+1
If InStr(Request.ServerVariables("HTTP_ACCEPT"), "application/vnd.wap.xhtml+xml") Or Not IsEmpty(Request.ServerVariables("HTTP_X_PROFILE")) Or Not IsEmpty(Request.ServerVariables("HTTP_PROFILE")) Then
mobile_browser = mobile_browser+1
end If
' // Now you're going through the list of devices,
' // this is an array so as time moves on, just add
' // more that come to the marketplace into here
mobile_agents = Array("alcatel", "amoi", "android", "avantgo", "blackberry", "benq", "cell", "cricket", "docomo", "elaine", "htc", "iemobile", "iphone", "ipad", "ipaq", "ipod", "j2me", "java", "midp", "mini", "mmp", "mobi", "motorola", "nec-", "nokia", "palm", "panasonic", "philips", "phone", "sagem", "sharp", "sie-", "smartphone", "sony", "symbian", "t-mobile", "telus", "up\.browser", "up\.link", "vodafone", "wap", "webos", "wireless", "xda", "xoom", "zte")
size = Ubound(mobile_agents)
mobile_ua = LCase(Left(user_agent, 4))
' // You've previously set mobile_browser as 0,
' // now loop through the array set above and
' // if one or more is matched, add 1 to this variable
For i = 0 To size
If mobile_agents(i) = mobile_ua Then
mobile_browser = mobile_browser+1
Exit For
End If
Next
' // Check that full website has not been requested
' // (you can have a link in the page for this like:
' // View Full Site
If request.querystring("v")="full" then session("fullsite")=true
' // Check to see if the var mobile_browser is greater
' // than 0, if so it's a mobile device, act accordingly.
If mobile_browser>0 and session("fullsite")=false then
' // redirect the user to a mobile appropriate page you've written
response.redirect("mobile.asp")
End If
' END MOBILE PHONE SCRIPT
' =======================

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
    <link rel="stylesheet" href="../css/common.css" type="text/css">
    <title>에듀빌</title>
    <script type="text/javascript">
<!--
    self.onError = null;
    currentX = currentY = 0;
    whichIt = null;
    lastScrollX = 0; lastScrollY = 0;
    NS = (document.layers) ? 1 : 0;
    IE = (document.all) ? 1 : 0;
< !--STALKER CODE-- >
        function heartBeat() {
            if (IE) {
                diffY = document.body.scrollTop;
                diffX = 0;
            }
            if (NS) { diffY = self.pageYOffset; diffX = self.pageXOffset; }
            if (diffY != lastScrollY) {
                percent = .1 * (diffY - lastScrollY);
                if (percent > 0) percent = Math.ceil(percent);
                else percent = Math.floor(percent);
                if (IE) document.all.layer1.style.pixelTop += percent;
                if (NS) document.layer1.top += percent;
                lastScrollY = lastScrollY + percent;
            }
            if (diffX != lastScrollX) {
                percent = .1 * (diffX - lastScrollX);
                if (percent > 0) percent = Math.ceil(percent);
                else percent = Math.floor(percent);
                if (IE) document.all.layer1.style.pixelLeft += percent;
                if (NS) document.layer1.top += percent;
                lastScrollY = lastScrollY + percent;
            }
        }
    if (NS || IE) action = window.setInterval("heartBeat()", 1);

    function MM_preloadImages() { //v3.0
        var d = document; if (d.images) {
            if (!d.MM_p) d.MM_p = new Array();
            var i, j = d.MM_p.length, a = MM_preloadImages.arguments; for (i = 0; i < a.length; i++)
                if (a[i].indexOf("#") != 0) { d.MM_p[j] = new Image; d.MM_p[j++].src = a[i]; }
        }
    }
//-->
    </script>
    <script language="JavaScript">
<!--
    function MM_preloadImages() { //v3.0
        var d = document; if (d.images) {
            if (!d.MM_p) d.MM_p = new Array();
            var i, j = d.MM_p.length, a = MM_preloadImages.arguments; for (i = 0; i < a.length; i++)
                if (a[i].indexOf("#") != 0) { d.MM_p[j] = new Image; d.MM_p[j++].src = a[i]; }
        }
    }

    function MM_swapImgRestore() { //v3.0
        var i, x, a = document.MM_sr; for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) x.src = x.oSrc;
    }

    function MM_findObj(n, d) { //v4.01
        var p, i, x; if (!d) d = document; if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
            d = parent.frames[n.substring(p + 1)].document; n = n.substring(0, p);
        }
        if (!(x = d[n]) && d.all) x = d.all[n]; for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
        for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
        if (!x && d.getElementById) x = d.getElementById(n); return x;
    }

    function MM_swapImage() { //v3.0
        var i, j = 0, x, a = MM_swapImage.arguments; document.MM_sr = new Array; for (i = 0; i < (a.length - 2); i += 3)
            if ((x = MM_findObj(a[i])) != null) { document.MM_sr[j++] = x; if (!x.oSrc) x.oSrc = x.src; x.src = a[i + 2]; }
    }
    function characterCheck() {
        var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\+┼<>@\#$%&\'\"\\\(\=]/gi;//정규식 구문
        var obj = document.getElementsByName("bccode")[0]
        if (RegExp.test(obj.value)) {
            alert("특수문자는 입력하실 수 없습니다.");
            obj.value = obj.value.substring(0, obj.value.length - 1);//특수문자를 지우는 구문
        }

    }

    function getCookie(name) {
        var Found = false;
        var start, end;
        var i = 0;

        while (i <= document.cookie.length) {
            start = i;
            end = start + name.length;

            if (document.cookie.substring(start, end) == name) {
                Found = true;
                break;
            }
            i++;
        }

        if (Found == true) {
            start = end + 1;
            end = document.cookie.indexOf(";", start);
            if (end < start) end = document.cookie.length;
            return document.cookie.substring(start, end);
        }
        return "";
    }

    function setUserIdFromCookie() {
        if (getCookie("user_id").length == 8) {
            form.bccode.value = getCookie("user_id");
        }
        //if (isNaN(getCookie("user_id")))
        //{
        //	form.bccode.value = getCookie("user_id");
        //}
        if (form.bccode.value.length == 8) {
            form.cbksave.checked = true;
        }
        form.bccode.focus();
        MM_preloadImages('admin/menu01_1.gif', 'admin/menu02_1.gif', 'admin/menu03_1.gif', 'admin/menu04_1.gif', 'admin/menu05_1.gif');
    }

//-->
    </script>
    <script language="JavaScript" type="text/JavaScript">
<!--
    function MM_reloadPage(init) {  //reloads the window if Nav4 resized
        if (init == true) with (navigator) {
            if ((appName == "Netscape") && (parseInt(appVersion) == 4)) {
                document.MM_pgW = innerWidth; document.MM_pgH = innerHeight; onresize = MM_reloadPage;
            }
        }
        else if (innerWidth != document.MM_pgW || innerHeight != document.MM_pgH) location.reload();
    }
    MM_reloadPage(true);

    function MM_showHideLayers() { //v6.0
        var i, p, v, obj, args = MM_showHideLayers.arguments;
        for (i = 0; i < (args.length - 2); i += 3) if ((obj = MM_findObj(args[i])) != null) {
            v = args[i + 2];
            if (obj.style) { obj = obj.style; v = (v == 'show') ? 'visible' : (v == 'hide') ? 'hidden' : v; }
            obj.visibility = v;
        }
    }
//-->
    </script>

    <script language="JavaScript">
<!-- 
    function checkValue() {



        if (form.bccode.value == "") {
            alert("가맹점코드를 입력하여 주시기바랍니다.");
            form.bccode.focus();
            return false;
        }
        if (form.bccode.value.length < 8) {
            alert("가맹점코드는 8자리입니다");
            form.bccode.focus();
            return false;
        }
        //	if (form.pwd.value=="") {
        //		alert("비밀번호를 입력하여 주시기바랍니다.") ;
        //		form.pwd.focus() ;
        //		return false ;
        //	}
        form.submit();
        return false;
    }


//-->
    </script>

    

</head>

<body leftmargin="0" topmargin="0" onload="setUserIdFromCookie();">
    <!--<IFRAME src=http://banner.nalsee.com/nalsee/u4type.html?id=leso&bid=1 width=310 height=70 frameborder=no scrolling=no></IFRAME> -->




    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
        <tr>
            <td align="center">

                <table width="540" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
                    <tr>
                        <td align="center">

                              <br />
                              <br />
                              <br />
                            <br />
                              <br />
                              <br />
                             <br />
                              <br />
                              <br />

                            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" align="center">

                                <form action="loginok2.asp" name="form" method="post" onsubmit="return checkValue()">
                                
                                    <tr>
                                        <td align="center">

                                            <table width="540" height="350" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td valign="top" background="images/login1.jpg">

                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td height="220">&nbsp;</td>
                                                                <td style="width:20px;">&nbsp;</td>
                                                            </tr>
                                                            <tr> 
                          <td style="font-size:13px;color:red" align="right">'체인점코드' 는 숫자 8자리를 입력해 주세요.
                              <td style="width:20px;">&nbsp;</td>
                        </tr>
                                                            <tr>
                                                                <td>

                                                                    <table border="0" cellspacing="0" cellpadding="0" align="right">
                                                                        <tr>
                                                                            <td>

                                                                                <table border="0"  align="center">
                                                                                    <tr>
                                                                                        <td align="right" style="font-size:12px;">&nbsp;가맹점코드 :</td>
                                                                                        <td>
                                                                                            <input type="text" name="bccode" size="12" style="font-size:12px;" tabindex="1" maxlength="8" onkeyup="characterCheck()" onkeydown="characterCheck()"></td>
                                                                                          <td rowspan="3" width="58px" align="right" valign="middle" style="PADDING-left: 5px; WORD-BREAK: break-all;">
                                                                                            <input id="login" type="image" tabindex="3" src="/images/main/login_02.gif"width="58" height="42" border="0"></td>
                                                                                    </tr>
                                                                                
                                                                                    <tr>
                                                                                        <td align="right" style="font-size:12px;">&nbsp;비밀번호 :</td>
                                                                                        <td>
                                                                                            <input type="text" name="pwd" size="12" tabindex="2" style="font-size:12px;" maxlength="10"></td>
                                                                                    </tr>
                                                                                 
                                                                                </table>
                                                                                <table width="100%">
                                                                                   
                                                                                      <tr>
                                                                                          <td width="65px">  </td>
                                                                                        <td >
                                                                                            <input type="checkbox" name="cbksave"><font style="font-size: 12px; color: black;">가맹점코드 저장</font></input></td>
                                                                                    </tr>
                                                                                </table>

                                                                            </td>
                                                                        </tr>
                                                                    </table>


                                                                </td>
                                                                <td style="width:20px;">&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </td>
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

    <br>
    <br>

    <script>
  function onLoad(){
    var needSubmit = false;
    var queryArray = this.location.search.replace('?', '').split('&');
    for (var i = 0; i < queryArray.length; i++) {
      var query = queryArray[i];
      var p = '';
      var v = '';
      if(query.split('=').length > 0) {
        p = query.split('=')[0];
      }
      if(query.split('=').length > 1) {
        v = query.split('=')[1];
      }
      if(p == 'i' && v != '') {
        document.getElementsByName('bccode')[0].value = v;
        needSubmit = true;
      }
      if(p == 'p' && v != '') {
        document.getElementsByName('pwd')[0].value = v;
      }
      if(needSubmit) {
        characterCheck();
        document.getElementById('login').click();
      }
    }
  }
  onLoad();
    </script>
</body>
</html>
