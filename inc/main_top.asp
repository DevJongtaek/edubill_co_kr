 <script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function logincheck() {
	if (!isNaN(login.mid.value))
	{
		alert("�� �α����� ü���� ���翡���� �̿��� �� �ֽ��ϴ�. ü���� �ֹ� â���� �α����Ͻʽÿ�.");
		window.open ('/adminpage/index.asp','CheckID','scrollbars=yes,width=800,height='+screen.availHeight+'');
		return false;
	}
	if (login.mid.value=="") {
		alert("���̵� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		login.mid.focus() ;
		return false ;
	}if (login.mpwd.value=="") {
		alert("��й�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		login.mpwd.focus() ;
		return false ;
	}
	login.submit() ;
	return false ;
}
function characterCheck() {
            var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\+��<>@\#$%&\'\"\\\(\=]/gi;//���Խ� ����
            var obj = document.getElementsByName("mid")[0]
            if (RegExp.test(obj.value)) {
                alert("Ư�����ڴ� �Է��Ͻ� �� �����ϴ�.");
                obj.value = obj.value.substring(0, obj.value.length - 1);//Ư�����ڸ� ����� ����
            }

        }
//-->
</script>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top"> 
      
      <div class="fla1">
		  <script type="text/javascript">flashwrite("flash","../flash/main_img.swf", "980", "452", "transparent");</script>
        <div class="fla2"><div id="Layer1" style="position:absolute; z-index:1;"> 
        <table width="980" border="0" cellpadding="0" cellspacing="0">
            <tr> 
              <td align="right"><img src="../images/common/top_menu1.png" width="108" height="23" hspace="20" border="0" usemap="#Map_top_01" /></td>
            </tr>
            <map name="Map_top_01" id="Map_top_01">
              <area shape="rect" coords="7,7,48,17" href="../index.asp" />
              <area shape="rect" coords="48,7,106,18" href="../adminpage/Loan/Loan.asp">
            </map>
          </table>
        </div>  
		  <script type="text/javascript"><!--flashwrite("flash","../flash/top_menu.swf", "980", "85", "transparent");--></script>
		  
		  <img src="../img/logo[3].gif">
		  <A href="../service/service01.asp"><span style="font-size:15px;color:blue;font-weight:bold;"> ���������� ���հ��� </span></a> &nbsp;&nbsp;&nbsp;
 <A href="../intranet/intranet01.asp"><span style="font-size:15px;color:blue;font-weight:bold;"> ��Ʈ���(������) </span></a>&nbsp;&nbsp;&nbsp;
 <A href="../intranet/intranet02.asp"><span style="font-size:15px;color:blue;font-weight:bold;"> ��Ʈ���(������) </span></a>
        </div> 
      </div>
    </td>
  </tr>
</table>

