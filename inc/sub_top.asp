 <script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
function logincheck() {
	var imsicnt = "y" ;
	var imsiform = login.mid;
	for(var i = 0; i < imsiform.value.length; i++) {
		var chr = parseInt(imsiform.value.substr(i,1));
		if (isNaN(chr)){
			imsicnt = "n";	//안됨
		}
      	}

	if (login.mid.value=="") {
		alert("아이디를 입력하여 주시기바랍니다.") ;
		login.mid.focus() ;
		return false ;

	} if ((login.mid.value.length==8)&&(imsicnt=="y")) {
		alert("에듀빌 홈페이지에서 체인점주문을 클릭한신 후 주문하시기 바랍니다. !!!!") ;
		login.mid.focus() ;
		return false ;

	}if (login.mpwd.value=="") {
		alert("비밀번호를 입력하여 주시기바랍니다.") ;
		login.mpwd.focus() ;
		return false ;
	}
	login.submit() ;
	return false ;
}
function characterCheck() {
            var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\+┼<>@\#$%&\'\"\\\(\=]/gi;//정규식 구문
            var obj = document.getElementsByName("mid")[0]
            if (RegExp.test(obj.value)) {
                alert("특수문자는 입력하실 수 없습니다.");
                obj.value = obj.value.substring(0, obj.value.length - 1);//특수문자를 지우는 구문
            }

        }
//-->
</script>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top"> 
      
      <div class="fla3">
		  <script type="text/javascript">flashwrite("flash","/flash/sub_img.swf", "980", "359", "transparent");</script>
        <div class="fla2"><div id="Layer1" style="position:absolute; z-index:1;"> 
        <!--<table width="980" border="0" cellpadding="0" cellspacing="0">
            <tr> 
              <td align="right"><img src="../images/common/top_menu1.png" width="108" height="23" hspace="20" border="0" usemap="#Map_top_01" /></td>
            </tr>
            <map name="Map_top_01" id="Map_top_01">
              <area shape="rect" coords="7,7,48,17" href="../index.asp" />
              <area shape="rect" coords="48,7,106,18" href="#">
            </map>
          </table>-->
        </div>  
		  <script type="text/javascript">flashwrite("flash","../flash/top_menu.swf", "980", "85", "transparent");</script>
        </div> 
      </div>
    </td>
  </tr>
</table>


