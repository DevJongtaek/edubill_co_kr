<!-- ���뽺ũ��Ʈ ����######################################################################-->
<!-- ���̵�üũ -->
function checkid(fm,fmvalue)
{
	tmp = form.userid.value ;
	if (tmp.length < 4) {
		alert("ID�� 4���� �̻��Դϴ�!!") ;
		form.userid.focus() ;
		return false ;
	}
	window.open ('/db/UserIdCheck.asp?userid=' + fmvalue,'CheckID','width=300,height=200')
	return false ;
}

function topmenucheck(){
	alert("�������� �����ϴ�!!") ;
}






function brandcheck_ok(){
	form.btnbrand.disabled=false;
}

function brandcheck_no(){
	form.btnbrand.disabled=true;
}

function dcentercheck_ok(){
	form.btndcenter.disabled=false;
}

function dcentercheck_no(){
	form.cporg_cd.disabled=true;
}

function cporg_cd_ok(){
	form.cporg_cd.disabled=false;
	form.virtual_acnt_bank.disabled=false;
	form.vabtn.disabled=false;
}

function cporg_cd_no(){
	form.cporg_cd.disabled=true;
	form.virtual_acnt_bank.disabled=true;
	form.vabtn.disabled=true;
}

function proflag1chk(){
	if (form.proflag1.value=="1") {
		form.btnpro.disabled=true;
	} else {
		form.btnpro.disabled=false;
	}
}

function alldelok(form)
{
	if (form.searcha.value=="") {
		alert("���������� ������ �ֽñ� �ٶ��ϴ�.") ;
		form.searcha.focus() ;
		return false ;
	}
	if ((form.searcha.value=="6")&&(form.companycode.value=="")) {
		alert("ȸ���縦 ������ �ֽñ� �ٶ��ϴ�.") ;
		form.companycode.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.submit() ;
		return false ;
	}
//	form.submit() ;
}

function alldelok3(form)
{
	if (form.searcha.value=="") {
		alert("���������� ������ �ֽñ� �ٶ��ϴ�.") ;
		form.searcha.focus() ;
		return false ;
	}
	if ((form.searcha.value=="6")&&(form.companycode.value=="")) {
		alert("ȸ���縦 ������ �ֽñ� �ٶ��ϴ�.") ;
		form.companycode.focus() ;
		return false ;
	}
	//var msg;
	//msg=confirm("���� �����ϰڽ��ϱ�?");
	//if(msg) {
	//	form.submit() ;
	//	return false ;
	//}
	form.submit() ;
}

function alldelok2(form)
{
	if (form.gubun.value=="") {
		alert("���������� ������ �ֽñ� �ٶ��ϴ�.") ;
		form.gubun.focus() ;
		return false ;
	}
	if (form.bcode.value=="") {
		alert("���� ȸ���縦 ������ �ֽñ� �ٶ��ϴ�.") ;
		form.bcode.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.submit() ;
		return false ;
	}
//	form.submit() ;
}

function alldelok44(form)
{
	if (form.searcha.value=="") {
		alert("���������� ������ �ֽñ� �ٶ��ϴ�.") ;
		form.searcha.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.submit() ;
		return false ;
	}
//	form.submit() ;
}

function checkid2(fm,fmvalue)
{
	tmp = form.dcode.value ;
	window.open ('/db/UserIdCheck2.asp?userid=' + fmvalue,'CheckID','width=300,height=200')
	return false ;
}

function newwinB(){
	window.open ('/adminpage/index.asp','CheckID','scrollbars=yes,width=800,height=900');
}

<!-- ���ڸ� �Է¹ޱ� -->
function onlyNumber()
{
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}

function zeronullcheck(tvalue){
        var tzero = tvalue.value;
        if((tzero.length==0) || tvalue.value==""){
                tvalue.value = "0";
        }
}

function AutoAddr(key){
	url	= "/DB/SearchDongPost.asp?key="+key;
	window.open(url,"AutoAddr","toolbar=no,menubar=no,scrollbars=0,resizable=no,width=510,height=500");
}

function nwinopen(imsiidx,imsiflag){
	url	= "newwin.asp?idx="+imsiidx+"&flag="+imsiflag;
	window.open(url,"AutoAddr","toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=700");
}

function nwinopen2(imsival_1,imsival_2,imsival_3,imsival_4){
	url	= "newwin.asp?searcha="+imsival_1+"&searchb="+imsival_2+"&searchc="+imsival_3+"&carname="+imsival_4;
	window.open(url,"AutoAddr","toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=700");
}

function nwinopen3(imsival_1,imsival_2,imsival_3,imsival_4,imsival_5,imsival_6,imsival_7){
	url	= "newwin2.asp?pgubun="+imsival_1+"&comname2="+imsival_2+"&searcha="+imsival_3+"&searchb="+imsival_4+"&searchc="+imsival_5+"&searchd="+imsival_6+"&imsiusercode="+imsival_7;
	window.open(url,"AutoAddr","toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=700");
}

function nwinopen33(imsival_1){
	url	= "newwin2.asp?pgubun="+imsival_1+"&<%=imsilink%>";
	window.open(url,"AutoAddr","toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=700");
}

function kindsearchok(form) {
	if ((form.searcha.value!="")&&(form.searchb.value=="")) {
		alert("�˻��Ͻ� �ܾ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.searchb.focus() ;
		return false ;
	}
	form.submit() ;
}

function kindsearchok2(form) {
	form.submit() ;
}

function kindsearchok3() {
	if (kindform.searcha.value=="") {
		alert("�˻��Ͻ� �⵵�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		kindform.searcha.focus() ;
		return false ;
	}
	if (kindform.searchb.value=="") {
		alert("�˻��Ͻ� ���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		kindform.searchb.focus() ;
		return false ;
	}
	kindform.submit() ;
}

function kindsearchok4(kindform) {
	if (kindform.cbrandchoice.value=="0") {
		alert("���ϻ����Ͻ� �귣�带 �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		kindform.cbrandchoice.focus() ;
		return false ;
	}
	if (kindform.searchc.value=="") {
		alert("���ϻ����Ͻ� ������� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		kindform.searchc.focus() ;
		return false ;
	}
	if (kindform.searchd.value=="") {
		alert("���ϻ����Ͻ� ������� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		kindform.searchd.focus() ;
		return false ;
	}
	kindform.submit() ;
}

function frmzerocheck(form,url) {
	location.href = url;
}

function taxchecked(imsitxt) {
	if (form.imsitprice.value=="") {
		alert("�ܰ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.imsitprice.focus() ;
		return false ;
	}
	form.saveflag.value=imsitxt;
	form.submit() ;
}

<!-- ���뽺ũ��Ʈ ��######################################################################-->
function smscheck() {
	if (sms.bfile1.value=="") {
		alert("���������� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		sms.bfile1.focus() ;
		return false ;
	}
	sms.submit() ;
}

function smscheck2() {
	if (sms1.bfile4.value=="") {
		alert("�귣�� ���� ���������� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		sms1.bfile4.focus() ;
		return false ;
	}
	sms1.submit() ;
}

function rootedit() {
	if (form.userpwd.value=="") {
		alert("��й�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.userpwd.focus() ;
		return false ;
	}
	form.submit() ;
}

function rootedit2() {
	if (form2.userpwd.value=="") {
		alert("��й�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form2.userpwd.focus() ;
		return false ;
	}
	form2.submit() ;
}

<!-- ��ǰ���� �߰�/����/���� -->
function productwrite() {
	if (form.pcode.value=="") {
		alert("��ǰ�ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.pcode.focus() ;
		return false ;
	}
	if (form.pname.value=="") {
		alert("��ǰ���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.pname.focus() ;
		return false ;
	}
	if (form.pprice.value=="") {
		alert("��ǰ�ܰ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.pprice.focus() ;
		return false ;
	}
	if (form.qty.value=="") {
		alert("�ֹ�����������Ʈ�� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.qty.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
}

function productdel() {
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}

<!-- ȣ������ �߰�/����/���� -->
function carwrite() {
	if (form.dcarno.value=="") {
		alert("ȣ���� ���ڸ� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.dcarno.focus() ;
		return false ;
	}
	if (form.dcarno.value=="0") {
		alert("ȣ���� 0 �̻��� ���ڷ� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.dcarno.focus() ;
		return false ;
	}
	if (form.dcarname.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.dcarname.focus() ;
		return false ;
	}
	if (form.tel1.value=="") {
		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel1.focus() ;
		return false ;
	}
	if (form.tel2.value=="") {
		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel2.focus() ;
		return false ;
	}
	if (form.tel3.value=="") {
		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel3.focus() ;
		return false ;
	}
//	if (form.carno.value=="") {
//		alert("������ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.carno.focus() ;
//		return false ;
//	}
//	if (form.carkind.value=="") {
//		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.carkind.focus() ;
//		return false ;
//	}
//	if (form.caryflag.value=="") {
//		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.caryflag.focus() ;
//		return false ;
//	}
	//form.submit() ;
}

function cardel() {
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}

function check_maxLen(field, name, length){
	var str = field.value;
	if (str.length > length)
	{
		alert(name + "������ " + length + " �� ���Ϸ� �Է��ϼž� �մϴ�.");
		//field.value = "";
		field.focus();
		return false;
	}
	return true;
}



function comwrite11111(frm) {
	if (form.tcode.value=="") {
		alert("ȸ�����ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tcode.focus() ;
		return false ;
	} if (form.comname.value=="") {
		alert("ȸ������� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.comname.focus() ;
		return false ;
	} if (form.name.value=="") {
		alert("��ǥ�ڸ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.name.focus() ;
		return false ;
	} if (form.juminno1.value=="") {
		alert("�ֹ�(����)��Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.juminno1.focus() ;
		return false ;
	} if (form.juminno2.value=="") {
		alert("�ֹ�(����)��Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.juminno2.focus() ;
		return false ;
	} if (form.companynum1.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum1.focus() ;
		return false ;
	} if (form.companynum2.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum2.focus() ;
		return false ;
	} if (form.companynum3.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum3.focus() ;
		return false ;
	} if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("�����ȣ�� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_post1.focus() ;
		return false ;
	} if (form.m_addr1.value=="") {
		alert("�ּҸ� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_addr1.focus() ;
		return false ;
	} if (form.m_addr2.value=="") {
		alert("������ �ּҸ� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("���¸� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.uptae.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.upjong.focus() ;
		return false ;
	} if (form.tel1.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel1.focus() ;
		return false ;
	} if (form.tel2.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel2.focus() ;
		return false ;
	} if (form.tel3.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel3.focus() ;
		return false ;
	} if (form.userpwd.value=="") {
		alert("�α��� ��й�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.userpwd.focus() ;
		return false ;
//	} if ((form.timecheck1_1.value=="")||(form.timecheck1_2.value=="")||(form.timecheck2_1.value=="")||(form.timecheck2_2.value=="")) {
//		alert("�ֹ����� �ð��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.timecheck1_1.focus() ;
//		return false ;
	} if (form.taxtitle.value=="") {
		alert("���ݰ�꼭 �׸��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.taxtitle.focus() ;
		return false ;
	} if (form.usemoney.value=="") {
		alert("�̿�� �ݾ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.usemoney.focus() ;
		return false ;
	}
//	form.submit() ;
}

<!-- �������� �߰�/����/���� -->
function comwrite1(frm) {
	if (form.tcode.value=="") {
		alert("ȸ�����ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tcode.focus() ;
		return false ;
	} if (form.comname.value=="") {
		alert("ȸ������� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.comname.focus() ;
		return false ;
	} if (form.name.value=="") {
		alert("��ǥ�ڸ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.name.focus() ;
		return false ;
	} if (form.juminno1.value=="") {
		alert("�ֹ�(����)��Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.juminno1.focus() ;
		return false ;
	} if (form.juminno2.value=="") {
		alert("�ֹ�(����)��Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.juminno2.focus() ;
		return false ;
	} if (form.companynum1.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum1.focus() ;
		return false ;
	} if (form.companynum2.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum2.focus() ;
		return false ;
	} if (form.companynum3.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum3.focus() ;
		return false ;
	} if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("�����ȣ�� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_post1.focus() ;
		return false ;
	} if (form.m_addr1.value=="") {
		alert("�ּҸ� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_addr1.focus() ;
		return false ;
	} if (form.m_addr2.value=="") {
		alert("������ �ּҸ� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("���¸� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.uptae.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.upjong.focus() ;
		return false ;
	} if (form.tel1.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel1.focus() ;
		return false ;
	} if (form.tel2.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel2.focus() ;
		return false ;
	} if (form.tel3.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel3.focus() ;
		return false ;
	} if (form.userpwd.value=="") {
		alert("�α��� ��й�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.userpwd.focus() ;
		return false ;
//	} if ((form.timecheck1_1.value=="")||(form.timecheck1_2.value=="")||(form.timecheck2_1.value=="")||(form.timecheck2_2.value=="")) {
//		alert("�ֹ����� �ð��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.timecheck1_1.focus() ;
//		return false ;
	} if (form.taxtitle.value=="") {
		alert("���ݰ�꼭 �׸��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.taxtitle.focus() ;
		return false ;
	} if (form.usemoney.value=="") {
		alert("�̿�� �ݾ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.usemoney.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
}

function comdel1(frm) {
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?\n\n\n\n�׷��� ���� �Ͻðڽ��ϱ�?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}


function comwrite222() {
	if (form.tcode.value=="") {
		alert("����(��)�ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tcode.focus() ;
		return false ;
	}
	if (form.comname.value=="") {
		alert("����(��)���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.comname.focus() ;
		return false ;
	}
	if (form.name.value=="") {
		alert("��ǥ�ڸ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.name.focus() ;
		return false ;
	} if (form.companynum1.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum1.focus() ;
		return false ;
	} if (form.companynum2.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum2.focus() ;
		return false ;
	} if (form.companynum3.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum3.focus() ;
		return false ;
	} if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("�����ȣ�� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_post1.focus() ;
		return false ;
	} if (form.m_addr1.value=="") {
		alert("�ּҸ� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_addr1.focus() ;
		return false ;
	} if (form.m_addr2.value=="") {
		alert("������ �ּҸ� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("���¸� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.uptae.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.upjong.focus() ;
		return false ;
//	} if (form.tel1.value=="") {
//		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.tel1.focus() ;
//		return false ;
//	} if (form.tel2.value=="") {
//		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.tel2.focus() ;
//		return false ;
//	} if (form.tel3.value=="") {
//		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.tel3.focus() ;
//		return false ;
//	} if (form.fax1.value=="") {
//		alert("�ѽ���ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.fax1.focus() ;
//		return false ;
//	} if (form.fax2.value=="") {
//		alert("�ѽ���ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.fax2.focus() ;
//		return false ;
//	} if (form.fax3.value=="") {
//		alert("�ѽ���ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.fax3.focus() ;
//		return false ;
//	} if (form.hp1.value=="") {
//		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.hp1.focus() ;
//		return false ;
//	} if (form.hp2.value=="") {
//		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.hp2.focus() ;
//		return false ;
//	} if (form.hp3.value=="") {
//		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.hp3.focus() ;
//		return false ;
	} if (form.dcarno.value=="") {
		alert("ȣ���� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.dcarno.focus() ;
		return false ;
	} if (form.userpwd.value=="") {
		alert("�α��� ��й�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.userpwd.focus() ;
		return false ;
	}
	//form.submit() ;
}


<!-- �������� �߰�/����/���� -->
function comwrite2() {
	if (form.tcode.value=="") {
		alert("����(��)�ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tcode.focus() ;
		return false ;
	}
	if (form.comname.value=="") {
		alert("����(��)���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.comname.focus() ;
		return false ;
	}
	if (form.name.value=="") {
		alert("��ǥ�ڸ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.name.focus() ;
		return false ;
	} if (form.companynum1.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum1.focus() ;
		return false ;
	} if (form.companynum2.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum2.focus() ;
		return false ;
	} if (form.companynum3.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum3.focus() ;
		return false ;
	} if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("�����ȣ�� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_post1.focus() ;
		return false ;
	} if (form.m_addr1.value=="") {
		alert("�ּҸ� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_addr1.focus() ;
		return false ;
	} if (form.m_addr2.value=="") {
		alert("������ �ּҸ� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("���¸� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.uptae.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.upjong.focus() ;
		return false ;
//	} if (form.tel1.value=="") {
//		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.tel1.focus() ;
//		return false ;
//	} if (form.tel2.value=="") {
//		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.tel2.focus() ;
//		return false ;
//	} if (form.tel3.value=="") {
//		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.tel3.focus() ;
//		return false ;
//	} if (form.fax1.value=="") {
//		alert("�ѽ���ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.fax1.focus() ;
//		return false ;
//	} if (form.fax2.value=="") {
//		alert("�ѽ���ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.fax2.focus() ;
//		return false ;
//	} if (form.fax3.value=="") {
//		alert("�ѽ���ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.fax3.focus() ;
//		return false ;
//	} if (form.hp1.value=="") {
//		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.hp1.focus() ;
//		return false ;
//	} if (form.hp2.value=="") {
//		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.hp2.focus() ;
//		return false ;
//	} if (form.hp3.value=="") {
//		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.hp3.focus() ;
//		return false ;
	} if (form.dcarno.value=="") {
		alert("ȣ���� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.dcarno.focus() ;
		return false ;
//	} if (form.userpwd.value=="") {
//		alert("�α��� ��й�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.userpwd.focus() ;
//		return false ;
	}
	//form.target = "_self";
	//form.action="writeok.asp";
	form.submit() ;
	return false ;
}

function comdel2() {
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}

<!-- ü�������� �߰�/����/���� -->
function comwrite3() {
	if (form.tcode.value=="") {
		alert("ü�����ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tcode.focus() ;
		return false ;
	}
	if (form.comname.value=="") {
		alert("ü�������� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.comname.focus() ;
		return false ;
	}
	if (form.name.value=="") {
		alert("��ǥ�ڸ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.name.focus() ;
		return false ;
	} if (form.companynum1.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum1.focus() ;
		return false ;
	} if (form.companynum2.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum2.focus() ;
		return false ;
	} if (form.companynum3.value=="") {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.companynum3.focus() ;
		return false ;

	} if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("�����ȣ�� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_post1.focus() ;
		return false ;
	} if (form.m_addr1.value=="") {
		alert("�ּҸ� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_addr1.focus() ;
		return false ;
	} if (form.m_addr2.value=="") {
		alert("������ �ּҸ� �Է��Ͽ��ֽñ� �ٶ��ϴ�.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("���¸� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.uptae.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.upjong.focus() ;
		return false ;
	} if (form.tel1.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel1.focus() ;
		return false ;
	} if (form.tel2.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel2.focus() ;
		return false ;
	} if (form.tel3.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel3.focus() ;
		return false ;
	} if (form.hp1.value=="") {
		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.hp1.focus() ;
		return false ;
	} if (form.hp2.value=="") {
		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.hp2.focus() ;
		return false ;
	} if (form.hp3.value=="") {
		alert("�ڵ�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.hp3.focus() ;
		return false ;
	} if (form.dcarno.value=="") {
		alert("ȣ���� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.dcarno.focus() ;
		return false ;



	} if (form.order_weekgubun[1].checked) {
		if ((form.order_weekchoice1.checked==false)&&(form.order_weekchoice2.checked==false)&&(form.order_weekchoice3.checked==false)&&(form.order_weekchoice4.checked==false)&&(form.order_weekchoice5.checked==false)&&(form.order_weekchoice6.checked==false)&&(form.order_weekchoice7.checked==false)) {
			alert("������ �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
			return false ;
		} if ((form.order_checkStime1.value=="")||(form.order_checkStime2.value=="")) {
			alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
			form.order_checkStime1.focus() ;
			return false ;
		} if ((form.order_checkEtime1.value=="")||(form.order_checkEtime2.value=="")) {
			alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
			form.order_checkEtime1.focus() ;
			return false ;
		}
	}

	form.submit() ;
	return false ;
}

function comdel3(frm) {
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}

<!-- ��������� �߰�/����/���� -->
function uwrite() {
	if (form.username.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.username.focus() ;
		return false ;
	}
	if (form.userid.value=="") {
		alert("���̵� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.userid.focus() ;
		return false ;
	}
	if (form.userpwd.value=="") {
		alert("��й�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.userpwd.focus() ;
		return false ;
	}
	//form.submit() ;
}

<!-- ��������� �߰�/����/���� -->
function uwrite2() {
	if (form.username.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.username.focus() ;
		return false ;
	}
	if (form.userid.value=="") {
		alert("���̵� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.userid.focus() ;
		return false ;
	}
	if (form.userpwd.value=="") {
		alert("��й�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.userpwd.focus() ;
		return false ;
	} if (form.tel1.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel1.focus() ;
		return false ;
	} if (form.tel2.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel2.focus() ;
		return false ;
	} if (form.tel3.value=="") {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel3.focus() ;
		return false ;
//	} if (form.bfile1.value=="") {
//		alert("ȸ����ΰ� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
//		form.bfile1.focus() ;
//		return false ;
	} if (form.usercode.value=="") {
		alert("ȸ������� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.usercode.focus() ;
		return false ;
	}
	//form.submit() ;
}

function udel(frm) {
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}


<!-- �ֹ�Ȯ�� -->
function orderwrite() {
	if (form.rordernum.value=="") {
		alert("��޼����� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.rordernum.focus() ;
		return false ;
	}
	//frm.submit() ;
}
function orderwrite2() {
	if (form.rordernum.value=="") {
		alert("��޼����� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.rordernum.focus() ;
		return false ;
	}
	form.oogubun.value="1"
	//form.submit() ;
}
function orderwrite3() {
	if (form.rordernum.value=="") {
		alert("��޼����� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.rordernum.focus() ;
		return false ;
	}
	form.oogubun.value="2"
	//form.submit() ;
}

<!-- ��޿Ϸ� -->
function deokcheck() {
	if (form222.deflagday.value=="") {
		alert("������ڸ� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form222.deflagday.focus() ;
		return false ;
	}
	//frm.submit() ;
}


<!-- �ֹ��׽�Ʈ -->
function orderwritetest() {
	if ((form.pcode[0].value=="")&&(form.pcode[1].value=="")&&(form.pcode[2].value=="")&&(form.pcode[3].value=="")&&(form.pcode[4].value=="")&&(form.pcode[5].value=="")&&(form.pcode[6].value=="")&&(form.pcode[7].value=="")&&(form.pcode[8].value=="")&&(form.pcode[9].value=="")&&(form.pcode[10].value=="")&&(form.pcode[11].value=="")&&(form.pcode[12].value=="")&&(form.pcode[13].value=="")&&(form.pcode[14].value=="")&&(form.pcode[15].value=="")&&(form.pcode[16].value=="")&&(form.pcode[17].value=="")&&(form.pcode[18].value=="")&&(form.pcode[19].value=="")) {
		alert("��ǰ�ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.pcode[0].focus() ;
		return false ;
	}
	if ((form.ordernum[0].value=="")&&(form.ordernum[1].value=="")&&(form.ordernum[2].value=="")&&(form.ordernum[3].value=="")&&(form.ordernum[4].value=="")&&(form.ordernum[5].value=="")&&(form.ordernum[6].value=="")&&(form.ordernum[7].value=="")&&(form.ordernum[8].value=="")&&(form.ordernum[9].value=="")&&(form.ordernum[10].value=="")&&(form.ordernum[11].value=="")&&(form.ordernum[12].value=="")&&(form.ordernum[13].value=="")&&(form.ordernum[14].value=="")&&(form.ordernum[15].value=="")&&(form.ordernum[16].value=="")&&(form.ordernum[17].value=="")&&(form.ordernum[18].value=="")&&(form.ordernum[19].value=="")) {
		alert("�ֹ������� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.ordernum[0].focus() ;
		return false ;
	}
	//form.submit() ;
}

function pcodecheck(imsivar,imsivar2){
				//alert(imsivar);
				//alert(imsivar2);
	for (i=0; i<20; i++){
		if ((form.pcode[i].value != "")&&(i != imsivar2)){
			if (form.pcode[i].value == imsivar){
				alert("��ǰ�ڵ尡 �ߺ��˴ϴ�.");
				form.pcode[imsivar2].value="" ;
				form.pcode[imsivar2].focus() ;
				return false ;
			}
		}
	}
}

<!-- ������� -->
function dwrite() {
	if (form.dcode.value=="") {
		alert("�����ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.dcode.focus() ;
		return false ;
	}
	if (form.dname.value=="") {
		alert("�������� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.dname.focus() ;
		return false ;
	}
	if (form.name.value=="") {
		alert("��ǥ���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.name.focus() ;
		return false ;
	}
	if ((form.jumin1.value=="")||(form.jumin2.value=="")) {
		alert("�ֹ�(����)��Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.jumin1.focus() ;
		return false ;
	}
	if ((form.comnum1.value=="")||(form.comnum2.value=="")||(form.comnum3.value=="")) {
		alert("����ڵ�Ϲ�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.comnum1.focus() ;
		return false ;
	}
	if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("�����ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.m_post1.focus() ;
		return false ;
	}
	if (form.m_addr1.value=="") {
		alert("�ּҸ� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.m_addr1.focus() ;
		return false ;
	}
	if (form.m_addr2.value=="") {
		alert("������ �ּҸ� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("������ �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.upjong.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("���¸� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.uptae.focus() ;
		return false ;
	}
	if ((form.tel1.value=="")||(form.tel2.value=="")||(form.tel3.value=="")) {
		alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.tel1.focus() ;
		return false ;
	}
	if (form.sudang.value=="") {
		alert("���������� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.sudang.focus() ;
		return false ;
	}
}

function ddel(frm) {
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}