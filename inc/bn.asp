<DIV id=STATICMENU style="position:absolute; left:expression((document.body.clientWidth-500)/2+750); 
width: 98px; height: 350px; top: 269px; left: 1006px;">
    <tr>
      <td align="left" valign="top">
      <img src="../images/common/banner.gif" border="0" usemap="#df456"></td>
    </tr>
    <tr>
        <td align="center">&nbsp;&nbsp;<a href="http://220.73.136.45:86/" target="_blank"><font size="2" family="Ghothic">���ȭ����</font> </a></td>
    </tr>
  </table>
</div>
<map name="df456" id="df456">
  <area shape="rect" coords="17,68,75,104" href="../adminpage/index.asp" target="_blank"/>
  <area shape="rect" coords="20,111,72,131" href="http://ezh.kr/edubill/" target="_blank" />
  <area shape="rect" coords="18,141,72,163" a href="/customer/customer05.asp" >
  <area shape="rect" coords="17,170,74,192" href="http://www.settlebank.co.kr" target="_blank" />
</map><script>

<!--
var stmnLEFT = (document.body.clientWidth-500)/2+750; // ��ũ�Ѹ޴��� ���� ��ġ
var stmnGAP1 = 450; // ������ ����κ��� ����
var stmnGAP2 = 100; // ��ũ�ѽ� ������ ��ܰ� �ణ ���. �ʿ������ 0���� ����
var stmnBASE = 400; // ��ũ�Ѹ޴� �ʱ� ������ġ (�ƹ����Գ� �ص� ����� ������ stmnGAP1�� �ణ ���̸� �ִ°� ���� ����)
var stmnActivateSpeed = 0.01; // �������� �����ϴ� �ӵ� (���ڰ� Ŭ���� �ʰ� �˾�����)
var stmnScrollSpeed = 10; // ��ũ�ѵǴ� �ӵ� (Ŭ���� �ʰ� ������)

var stmnTimer;

function RefreshStaticMenu() {
var stmnStartPoint, stmnEndPoint, stmnRefreshTimer;

stmnStartPoint = parseInt(STATICMENU.style.top, 10);
stmnEndPoint = document.body.scrollTop + stmnGAP2;
if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1;

stmnRefreshTimer = stmnActivateSpeed;

if ( stmnStartPoint != stmnEndPoint ) {
        stmnScrollAmount = Math.ceil( Math.abs( stmnEndPoint - stmnStartPoint ) / 15 );
        STATICMENU.style.top = parseInt(STATICMENU.style.top, 10) + ( ( stmnEndPoint<stmnStartPoint ) ? -stmnScrollAmount : 

stmnScrollAmount );
        stmnRefreshTimer = stmnScrollSpeed;
        }
        stmnTimer = setTimeout ("RefreshStaticMenu();", stmnRefreshTimer);
}

function InitializeStaticMenu() {
STATICMENU.style.left = stmnLEFT;
STATICMENU.style.top = document.body.scrollTop + stmnBASE;
RefreshStaticMenu();
}

InitializeStaticMenu();

	function focus()
	{
		document.login.mid.focus();
		return 0;
	}
	function leave()
	{
		document.login.mpwd.focus();
		return 0;
	}
	//��������
	function trim(str) {
    str = str.replace(/(^\s*)|(\s*$)/, "");
    return str;
	} 

	function sendemail()
	{
		if (trim(form.sName.value) == "")
		{
			alert("�̸��� �Է��Ͻʽÿ�");
			form.tcode.focus() ;
			return ;
		}
		if (trim(form.sPhone.value) == "")
		{
			alert("��ȭ��ȣ�� �Է��Ͻʽÿ�");
			form.sPhone.focus() ;
			return ;
		}	
		if (trim(form.email.value) == "")
		{
			alert("�̸����� �Է��Ͻʽÿ�");
			form.email.focus() ;
			return ;
		}	
		if (ID_Duplicate() == false)
		{
			form.email.focus() ;
			return ;
		}

		if (trim(form.title.value) == "")
		{
			alert("������ �Է��Ͻʽÿ�");
			form.title.focus() ;
			return 
		}
		if (trim(form.content.value) == "")
		{
			alert("������ �Է��Ͻʽÿ�");
			form.content.focus() ;
			return 
		}
		form.action = "sendmail.asp";
		form.submit();
		return false;
	}
	// �̸��� üũ �Լ�
	function ID_Duplicate()
	{
	  var email = form.email.value;
	  var emailEx1 = /^([A-Za-z0-9_]{1,15})(@{1})([A-Za-z0-9_]{1,15})(.{1})([A-Za-z0-9_]{2,10})(.{1}[A-Za-z]{2,10})?(.{1}[A-Za-z]{2,10})?$/;
	  if ( email != "" && email.search(emailEx1) == -1 ) {
		alert("�̸��� �ּҸ� ����� �Է��Ͽ� �ֽʽÿ�!!");
		form.email.focus();
		return false;
	  }
	  if (CheckEmailAddr(email) == false) return;
	  chk_no  = email.split("@");
	  chk_no2 = "@"+chk_no[1].toLowerCase()+".";
	  
	  form.action = "/note/process/id_check.php";
	  form.submit();
	}
	function CheckEmailAddr(strAddr) {
	  var arrAddr;
	  var arrMatch;
	  var strEmail;
	  if(strAddr.length == 0) return true;
	  arrAddr = strAddr.replace(/,/, ",").split(",");
	  for (var i = 0; i < arrAddr.length; i++) {
		arrMatch = arrAddr[i].match(/^([^<>]*)<([^<>]+)>$/);
		if (arrMatch == null) strEmail = arrAddr[i];
		else strEmail = arrMatch[2];
		if (strEmail != "") {
		  if (checkEmail(strEmail) == false) {
			alert(arrAddr[i] + "�� �߸��� �̸����ּ��Դϴ�.");
			return false;
		  }
		}
	  }
	  return true;
	}
	function checkEmail(strEmail) {
	  var arrMatch = strEmail.match(/^(\".*\"|[A-Za-z0-9_-]([A-Za-z0-9_-]|[\+\.])*)@(\[\d{1,3}(\.\d{1,3}){3}]|[A-Za-z0-9][A-Za-z0-9_-]*(\.[A-Za-z0-9][A-Za-z0-9_-]*)+)$/);
	  if(arrMatch == null) return false;
	  return true;
	}
//-->

</script>