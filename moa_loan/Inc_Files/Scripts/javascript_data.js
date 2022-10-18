<!-- 공용스크립트 시작######################################################################-->
<!-- 아이디체크 -->
function checkid(fm,fmvalue)
{
	tmp = form.userid.value ;
	if (tmp.length < 4) {
		alert("ID는 4글자 이상입니다!!") ;
		form.userid.focus() ;
		return false ;
	}
	window.open ('/db/UserIdCheck.asp?userid=' + fmvalue,'CheckID','width=300,height=200')
	return false ;
}

function topmenucheck(){
	alert("사용권한이 없습니다!!") ;
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
		alert("삭제구분을 선택해 주시기 바랍니다.") ;
		form.searcha.focus() ;
		return false ;
	}
	if ((form.searcha.value=="6")&&(form.companycode.value=="")) {
		alert("회원사를 선택해 주시기 바랍니다.") ;
		form.companycode.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.submit() ;
		return false ;
	}
//	form.submit() ;
}

function alldelok3(form)
{
	if (form.searcha.value=="") {
		alert("삭제구분을 선택해 주시기 바랍니다.") ;
		form.searcha.focus() ;
		return false ;
	}
	if ((form.searcha.value=="6")&&(form.companycode.value=="")) {
		alert("회원사를 선택해 주시기 바랍니다.") ;
		form.companycode.focus() ;
		return false ;
	}
	//var msg;
	//msg=confirm("정말 삭제하겠습니까?");
	//if(msg) {
	//	form.submit() ;
	//	return false ;
	//}
	form.submit() ;
}

function alldelok2(form)
{
	if (form.gubun.value=="") {
		alert("삭제구분을 선택해 주시기 바랍니다.") ;
		form.gubun.focus() ;
		return false ;
	}
	if (form.bcode.value=="") {
		alert("삭제 회원사를 선택해 주시기 바랍니다.") ;
		form.bcode.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.submit() ;
		return false ;
	}
//	form.submit() ;
}

function alldelok44(form)
{
	if (form.searcha.value=="") {
		alert("삭제구분을 선택해 주시기 바랍니다.") ;
		form.searcha.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
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

<!-- 숫자만 입력받기 -->
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
		alert("검색하실 단어를 입력하여 주시기바랍니다.") ;
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
		alert("검색하실 년도를 입력하여 주시기바랍니다.") ;
		kindform.searcha.focus() ;
		return false ;
	}
	if (kindform.searchb.value=="") {
		alert("검색하실 월을 입력하여 주시기바랍니다.") ;
		kindform.searchb.focus() ;
		return false ;
	}
	kindform.submit() ;
}

function kindsearchok4(kindform) {
	if (kindform.cbrandchoice.value=="0") {
		alert("파일생성하실 브랜드를 선택하여 주시기바랍니다.") ;
		kindform.cbrandchoice.focus() ;
		return false ;
	}
	if (kindform.searchc.value=="") {
		alert("파일생성하실 년월일을 입력하여 주시기바랍니다.") ;
		kindform.searchc.focus() ;
		return false ;
	}
	if (kindform.searchd.value=="") {
		alert("파일생성하실 년월일을 입력하여 주시기바랍니다.") ;
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
		alert("단가를 입력하여 주시기바랍니다.") ;
		form.imsitprice.focus() ;
		return false ;
	}
	form.saveflag.value=imsitxt;
	form.submit() ;
}

<!-- 공용스크립트 끝######################################################################-->
function smscheck() {
	if (sms.bfile1.value=="") {
		alert("엑셀파일을 선택하여 주시기바랍니다.") ;
		sms.bfile1.focus() ;
		return false ;
	}
	sms.submit() ;
}

function smscheck2() {
	if (sms1.bfile4.value=="") {
		alert("브랜드 수정 엑셀파일을 선택하여 주시기바랍니다.") ;
		sms1.bfile4.focus() ;
		return false ;
	}
	sms1.submit() ;
}

function rootedit() {
	if (form.userpwd.value=="") {
		alert("비밀번호를 입력하여 주시기바랍니다.") ;
		form.userpwd.focus() ;
		return false ;
	}
	form.submit() ;
}

function rootedit2() {
	if (form2.userpwd.value=="") {
		alert("비밀번호를 입력하여 주시기바랍니다.") ;
		form2.userpwd.focus() ;
		return false ;
	}
	form2.submit() ;
}

<!-- 상품정보 추가/수정/삭제 -->
function productwrite() {
	if (form.pcode.value=="") {
		alert("상품코드를 입력하여 주시기바랍니다.") ;
		form.pcode.focus() ;
		return false ;
	}
	if (form.pname.value=="") {
		alert("상품명을 입력하여 주시기바랍니다.") ;
		form.pname.focus() ;
		return false ;
	}
	if (form.pprice.value=="") {
		alert("상품단가를 입력하여 주시기바랍니다.") ;
		form.pprice.focus() ;
		return false ;
	}
	if (form.qty.value=="") {
		alert("주문수량단위멘트를 선택하여 주시기바랍니다.") ;
		form.qty.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
}

function productdel() {
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}

<!-- 호차정보 추가/수정/삭제 -->
function carwrite() {
	if (form.dcarno.value=="") {
		alert("호차를 숫자만 입력하여 주시기바랍니다.") ;
		form.dcarno.focus() ;
		return false ;
	}
	if (form.dcarno.value=="0") {
		alert("호차를 0 이상의 숫자로 입력하여 주시기바랍니다.") ;
		form.dcarno.focus() ;
		return false ;
	}
	if (form.dcarname.value=="") {
		alert("기사명을 입력하여 주시기바랍니다.") ;
		form.dcarname.focus() ;
		return false ;
	}
	if (form.tel1.value=="") {
		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
		form.tel1.focus() ;
		return false ;
	}
	if (form.tel2.value=="") {
		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
		form.tel2.focus() ;
		return false ;
	}
	if (form.tel3.value=="") {
		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
		form.tel3.focus() ;
		return false ;
	}
//	if (form.carno.value=="") {
//		alert("차량번호를 입력하여 주시기바랍니다.") ;
//		form.carno.focus() ;
//		return false ;
//	}
//	if (form.carkind.value=="") {
//		alert("차종을 입력하여 주시기바랍니다.") ;
//		form.carkind.focus() ;
//		return false ;
//	}
//	if (form.caryflag.value=="") {
//		alert("연식을 입력하여 주시기바랍니다.") ;
//		form.caryflag.focus() ;
//		return false ;
//	}
	//form.submit() ;
}

function cardel() {
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
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
		alert(name + "란에는 " + length + " 자 이하로 입력하셔야 합니다.");
		//field.value = "";
		field.focus();
		return false;
	}
	return true;
}



function comwrite11111(frm) {
	if (form.tcode.value=="") {
		alert("회원사코드를 입력하여 주시기바랍니다.") ;
		form.tcode.focus() ;
		return false ;
	} if (form.comname.value=="") {
		alert("회원사명을 입력하여 주시기바랍니다.") ;
		form.comname.focus() ;
		return false ;
	} if (form.name.value=="") {
		alert("대표자명을 입력하여 주시기바랍니다.") ;
		form.name.focus() ;
		return false ;
	} if (form.juminno1.value=="") {
		alert("주민(법인)등록번호를 입력하여 주시기바랍니다.") ;
		form.juminno1.focus() ;
		return false ;
	} if (form.juminno2.value=="") {
		alert("주민(법인)등록번호를 입력하여 주시기바랍니다.") ;
		form.juminno2.focus() ;
		return false ;
	} if (form.companynum1.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum1.focus() ;
		return false ;
	} if (form.companynum2.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum2.focus() ;
		return false ;
	} if (form.companynum3.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum3.focus() ;
		return false ;
	} if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("우편번호를 입력하여주시기 바랍니다.") ;
		form.m_post1.focus() ;
		return false ;
	} if (form.m_addr1.value=="") {
		alert("주소를 입력하여주시기 바랍니다.") ;
		form.m_addr1.focus() ;
		return false ;
	} if (form.m_addr2.value=="") {
		alert("나마지 주소를 입력하여주시기 바랍니다.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("업태를 입력하여 주시기바랍니다.") ;
		form.uptae.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("업종을 입력하여 주시기바랍니다.") ;
		form.upjong.focus() ;
		return false ;
	} if (form.tel1.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel1.focus() ;
		return false ;
	} if (form.tel2.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel2.focus() ;
		return false ;
	} if (form.tel3.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel3.focus() ;
		return false ;
	} if (form.userpwd.value=="") {
		alert("로그인 비밀번호를 입력하여 주시기바랍니다.") ;
		form.userpwd.focus() ;
		return false ;
//	} if ((form.timecheck1_1.value=="")||(form.timecheck1_2.value=="")||(form.timecheck2_1.value=="")||(form.timecheck2_2.value=="")) {
//		alert("주문차단 시간을 입력하여 주시기바랍니다.") ;
//		form.timecheck1_1.focus() ;
//		return false ;
	} if (form.taxtitle.value=="") {
		alert("세금계산서 항목을 입력하여 주시기바랍니다.") ;
		form.taxtitle.focus() ;
		return false ;
	} if (form.usemoney.value=="") {
		alert("이용료 금액을 입력하여 주시기바랍니다.") ;
		form.usemoney.focus() ;
		return false ;
	}
//	form.submit() ;
}

<!-- 본사정보 추가/수정/삭제 -->
function comwrite1(frm) {
	if (form.tcode.value=="") {
		alert("회원사코드를 입력하여 주시기바랍니다.") ;
		form.tcode.focus() ;
		return false ;
	} if (form.comname.value=="") {
		alert("회원사명을 입력하여 주시기바랍니다.") ;
		form.comname.focus() ;
		return false ;
	} if (form.name.value=="") {
		alert("대표자명을 입력하여 주시기바랍니다.") ;
		form.name.focus() ;
		return false ;
	} if (form.juminno1.value=="") {
		alert("주민(법인)등록번호를 입력하여 주시기바랍니다.") ;
		form.juminno1.focus() ;
		return false ;
	} if (form.juminno2.value=="") {
		alert("주민(법인)등록번호를 입력하여 주시기바랍니다.") ;
		form.juminno2.focus() ;
		return false ;
	} if (form.companynum1.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum1.focus() ;
		return false ;
	} if (form.companynum2.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum2.focus() ;
		return false ;
	} if (form.companynum3.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum3.focus() ;
		return false ;
	} if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("우편번호를 입력하여주시기 바랍니다.") ;
		form.m_post1.focus() ;
		return false ;
	} if (form.m_addr1.value=="") {
		alert("주소를 입력하여주시기 바랍니다.") ;
		form.m_addr1.focus() ;
		return false ;
	} if (form.m_addr2.value=="") {
		alert("나마지 주소를 입력하여주시기 바랍니다.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("업태를 입력하여 주시기바랍니다.") ;
		form.uptae.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("업종을 입력하여 주시기바랍니다.") ;
		form.upjong.focus() ;
		return false ;
	} if (form.tel1.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel1.focus() ;
		return false ;
	} if (form.tel2.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel2.focus() ;
		return false ;
	} if (form.tel3.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel3.focus() ;
		return false ;
	} if (form.userpwd.value=="") {
		alert("로그인 비밀번호를 입력하여 주시기바랍니다.") ;
		form.userpwd.focus() ;
		return false ;
//	} if ((form.timecheck1_1.value=="")||(form.timecheck1_2.value=="")||(form.timecheck2_1.value=="")||(form.timecheck2_2.value=="")) {
//		alert("주문차단 시간을 입력하여 주시기바랍니다.") ;
//		form.timecheck1_1.focus() ;
//		return false ;
	} if (form.taxtitle.value=="") {
		alert("세금계산서 항목을 입력하여 주시기바랍니다.") ;
		form.taxtitle.focus() ;
		return false ;
	} if (form.usemoney.value=="") {
		alert("이용료 금액을 입력하여 주시기바랍니다.") ;
		form.usemoney.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
}

function comdel1(frm) {
	var msg;
	msg=confirm("정말 삭제하겠습니까?\n\n\n\n그래도 삭제 하시겠습니까?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}


function comwrite222() {
	if (form.tcode.value=="") {
		alert("지사(점)코드를 입력하여 주시기바랍니다.") ;
		form.tcode.focus() ;
		return false ;
	}
	if (form.comname.value=="") {
		alert("지사(점)명을 입력하여 주시기바랍니다.") ;
		form.comname.focus() ;
		return false ;
	}
	if (form.name.value=="") {
		alert("대표자명을 입력하여 주시기바랍니다.") ;
		form.name.focus() ;
		return false ;
	} if (form.companynum1.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum1.focus() ;
		return false ;
	} if (form.companynum2.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum2.focus() ;
		return false ;
	} if (form.companynum3.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum3.focus() ;
		return false ;
	} if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("우편번호를 입력하여주시기 바랍니다.") ;
		form.m_post1.focus() ;
		return false ;
	} if (form.m_addr1.value=="") {
		alert("주소를 입력하여주시기 바랍니다.") ;
		form.m_addr1.focus() ;
		return false ;
	} if (form.m_addr2.value=="") {
		alert("나마지 주소를 입력하여주시기 바랍니다.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("업태를 입력하여 주시기바랍니다.") ;
		form.uptae.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("업종을 입력하여 주시기바랍니다.") ;
		form.upjong.focus() ;
		return false ;
//	} if (form.tel1.value=="") {
//		alert("전화번호를 입력하여 주시기바랍니다.") ;
//		form.tel1.focus() ;
//		return false ;
//	} if (form.tel2.value=="") {
//		alert("전화번호를 입력하여 주시기바랍니다.") ;
//		form.tel2.focus() ;
//		return false ;
//	} if (form.tel3.value=="") {
//		alert("전화번호를 입력하여 주시기바랍니다.") ;
//		form.tel3.focus() ;
//		return false ;
//	} if (form.fax1.value=="") {
//		alert("팩스번호를 입력하여 주시기바랍니다.") ;
//		form.fax1.focus() ;
//		return false ;
//	} if (form.fax2.value=="") {
//		alert("팩스번호를 입력하여 주시기바랍니다.") ;
//		form.fax2.focus() ;
//		return false ;
//	} if (form.fax3.value=="") {
//		alert("팩스번호를 입력하여 주시기바랍니다.") ;
//		form.fax3.focus() ;
//		return false ;
//	} if (form.hp1.value=="") {
//		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
//		form.hp1.focus() ;
//		return false ;
//	} if (form.hp2.value=="") {
//		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
//		form.hp2.focus() ;
//		return false ;
//	} if (form.hp3.value=="") {
//		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
//		form.hp3.focus() ;
//		return false ;
	} if (form.dcarno.value=="") {
		alert("호차를 선택하여 주시기바랍니다.") ;
		form.dcarno.focus() ;
		return false ;
	} if (form.userpwd.value=="") {
		alert("로그인 비밀번호를 입력하여 주시기바랍니다.") ;
		form.userpwd.focus() ;
		return false ;
	}
	//form.submit() ;
}


<!-- 지사정보 추가/수정/삭제 -->
function comwrite2() {
	if (form.tcode.value=="") {
		alert("지사(점)코드를 입력하여 주시기바랍니다.") ;
		form.tcode.focus() ;
		return false ;
	}
	if (form.comname.value=="") {
		alert("지사(점)명을 입력하여 주시기바랍니다.") ;
		form.comname.focus() ;
		return false ;
	}
	if (form.name.value=="") {
		alert("대표자명을 입력하여 주시기바랍니다.") ;
		form.name.focus() ;
		return false ;
	} if (form.companynum1.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum1.focus() ;
		return false ;
	} if (form.companynum2.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum2.focus() ;
		return false ;
	} if (form.companynum3.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum3.focus() ;
		return false ;
	} if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("우편번호를 입력하여주시기 바랍니다.") ;
		form.m_post1.focus() ;
		return false ;
	} if (form.m_addr1.value=="") {
		alert("주소를 입력하여주시기 바랍니다.") ;
		form.m_addr1.focus() ;
		return false ;
	} if (form.m_addr2.value=="") {
		alert("나마지 주소를 입력하여주시기 바랍니다.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("업태를 입력하여 주시기바랍니다.") ;
		form.uptae.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("업종을 입력하여 주시기바랍니다.") ;
		form.upjong.focus() ;
		return false ;
//	} if (form.tel1.value=="") {
//		alert("전화번호를 입력하여 주시기바랍니다.") ;
//		form.tel1.focus() ;
//		return false ;
//	} if (form.tel2.value=="") {
//		alert("전화번호를 입력하여 주시기바랍니다.") ;
//		form.tel2.focus() ;
//		return false ;
//	} if (form.tel3.value=="") {
//		alert("전화번호를 입력하여 주시기바랍니다.") ;
//		form.tel3.focus() ;
//		return false ;
//	} if (form.fax1.value=="") {
//		alert("팩스번호를 입력하여 주시기바랍니다.") ;
//		form.fax1.focus() ;
//		return false ;
//	} if (form.fax2.value=="") {
//		alert("팩스번호를 입력하여 주시기바랍니다.") ;
//		form.fax2.focus() ;
//		return false ;
//	} if (form.fax3.value=="") {
//		alert("팩스번호를 입력하여 주시기바랍니다.") ;
//		form.fax3.focus() ;
//		return false ;
//	} if (form.hp1.value=="") {
//		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
//		form.hp1.focus() ;
//		return false ;
//	} if (form.hp2.value=="") {
//		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
//		form.hp2.focus() ;
//		return false ;
//	} if (form.hp3.value=="") {
//		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
//		form.hp3.focus() ;
//		return false ;
	} if (form.dcarno.value=="") {
		alert("호차를 선택하여 주시기바랍니다.") ;
		form.dcarno.focus() ;
		return false ;
//	} if (form.userpwd.value=="") {
//		alert("로그인 비밀번호를 입력하여 주시기바랍니다.") ;
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
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}

<!-- 체인점정보 추가/수정/삭제 -->
function comwrite3() {
	if (form.tcode.value=="") {
		alert("체인점코드를 입력하여 주시기바랍니다.") ;
		form.tcode.focus() ;
		return false ;
	}
	if (form.comname.value=="") {
		alert("체인점명을 입력하여 주시기바랍니다.") ;
		form.comname.focus() ;
		return false ;
	}
	if (form.name.value=="") {
		alert("대표자명을 입력하여 주시기바랍니다.") ;
		form.name.focus() ;
		return false ;
	} if (form.companynum1.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum1.focus() ;
		return false ;
	} if (form.companynum2.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum2.focus() ;
		return false ;
	} if (form.companynum3.value=="") {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.companynum3.focus() ;
		return false ;

	} if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("우편번호를 입력하여주시기 바랍니다.") ;
		form.m_post1.focus() ;
		return false ;
	} if (form.m_addr1.value=="") {
		alert("주소를 입력하여주시기 바랍니다.") ;
		form.m_addr1.focus() ;
		return false ;
	} if (form.m_addr2.value=="") {
		alert("나마지 주소를 입력하여주시기 바랍니다.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("업태를 입력하여 주시기바랍니다.") ;
		form.uptae.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("업종을 입력하여 주시기바랍니다.") ;
		form.upjong.focus() ;
		return false ;
	} if (form.tel1.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel1.focus() ;
		return false ;
	} if (form.tel2.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel2.focus() ;
		return false ;
	} if (form.tel3.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel3.focus() ;
		return false ;
	} if (form.hp1.value=="") {
		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
		form.hp1.focus() ;
		return false ;
	} if (form.hp2.value=="") {
		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
		form.hp2.focus() ;
		return false ;
	} if (form.hp3.value=="") {
		alert("핸드폰번호를 입력하여 주시기바랍니다.") ;
		form.hp3.focus() ;
		return false ;
	} if (form.dcarno.value=="") {
		alert("호차를 선택하여 주시기바랍니다.") ;
		form.dcarno.focus() ;
		return false ;



	} if (form.order_weekgubun[1].checked) {
		if ((form.order_weekchoice1.checked==false)&&(form.order_weekchoice2.checked==false)&&(form.order_weekchoice3.checked==false)&&(form.order_weekchoice4.checked==false)&&(form.order_weekchoice5.checked==false)&&(form.order_weekchoice6.checked==false)&&(form.order_weekchoice7.checked==false)) {
			alert("요일을 선택하여 주시기바랍니다.") ;
			return false ;
		} if ((form.order_checkStime1.value=="")||(form.order_checkStime2.value=="")) {
			alert("전일을 입력하여 주시기바랍니다.") ;
			form.order_checkStime1.focus() ;
			return false ;
		} if ((form.order_checkEtime1.value=="")||(form.order_checkEtime2.value=="")) {
			alert("당일을 입력하여 주시기바랍니다.") ;
			form.order_checkEtime1.focus() ;
			return false ;
		}
	}

	form.submit() ;
	return false ;
}

function comdel3(frm) {
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}

<!-- 사용자정보 추가/수정/삭제 -->
function uwrite() {
	if (form.username.value=="") {
		alert("성명을 입력하여 주시기바랍니다.") ;
		form.username.focus() ;
		return false ;
	}
	if (form.userid.value=="") {
		alert("아이디를 입력하여 주시기바랍니다.") ;
		form.userid.focus() ;
		return false ;
	}
	if (form.userpwd.value=="") {
		alert("비밀번호를 입력하여 주시기바랍니다.") ;
		form.userpwd.focus() ;
		return false ;
	}
	//form.submit() ;
}

<!-- 사용자정보 추가/수정/삭제 -->
function uwrite2() {
	if (form.username.value=="") {
		alert("성명을 입력하여 주시기바랍니다.") ;
		form.username.focus() ;
		return false ;
	}
	if (form.userid.value=="") {
		alert("아이디를 입력하여 주시기바랍니다.") ;
		form.userid.focus() ;
		return false ;
	}
	if (form.userpwd.value=="") {
		alert("비밀번호를 입력하여 주시기바랍니다.") ;
		form.userpwd.focus() ;
		return false ;
	} if (form.tel1.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel1.focus() ;
		return false ;
	} if (form.tel2.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel2.focus() ;
		return false ;
	} if (form.tel3.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel3.focus() ;
		return false ;
//	} if (form.bfile1.value=="") {
//		alert("회원사로고를 선택하여 주시기바랍니다.") ;
//		form.bfile1.focus() ;
//		return false ;
	} if (form.usercode.value=="") {
		alert("회원사명을 선택하여 주시기바랍니다.") ;
		form.usercode.focus() ;
		return false ;
	}
	//form.submit() ;
}

function udel(frm) {
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}


<!-- 주문확인 -->
function orderwrite() {
	if (form.rordernum.value=="") {
		alert("배달수량을 입력하여 주시기바랍니다.") ;
		form.rordernum.focus() ;
		return false ;
	}
	//frm.submit() ;
}
function orderwrite2() {
	if (form.rordernum.value=="") {
		alert("배달수량을 입력하여 주시기바랍니다.") ;
		form.rordernum.focus() ;
		return false ;
	}
	form.oogubun.value="1"
	//form.submit() ;
}
function orderwrite3() {
	if (form.rordernum.value=="") {
		alert("배달수량을 입력하여 주시기바랍니다.") ;
		form.rordernum.focus() ;
		return false ;
	}
	form.oogubun.value="2"
	//form.submit() ;
}

<!-- 배달완료 -->
function deokcheck() {
	if (form222.deflagday.value=="") {
		alert("배달일자를 입력하여 주시기바랍니다.") ;
		form222.deflagday.focus() ;
		return false ;
	}
	//frm.submit() ;
}


<!-- 주문테스트 -->
function orderwritetest() {
	if ((form.pcode[0].value=="")&&(form.pcode[1].value=="")&&(form.pcode[2].value=="")&&(form.pcode[3].value=="")&&(form.pcode[4].value=="")&&(form.pcode[5].value=="")&&(form.pcode[6].value=="")&&(form.pcode[7].value=="")&&(form.pcode[8].value=="")&&(form.pcode[9].value=="")&&(form.pcode[10].value=="")&&(form.pcode[11].value=="")&&(form.pcode[12].value=="")&&(form.pcode[13].value=="")&&(form.pcode[14].value=="")&&(form.pcode[15].value=="")&&(form.pcode[16].value=="")&&(form.pcode[17].value=="")&&(form.pcode[18].value=="")&&(form.pcode[19].value=="")) {
		alert("상품코드를 입력하여 주시기바랍니다.") ;
		form.pcode[0].focus() ;
		return false ;
	}
	if ((form.ordernum[0].value=="")&&(form.ordernum[1].value=="")&&(form.ordernum[2].value=="")&&(form.ordernum[3].value=="")&&(form.ordernum[4].value=="")&&(form.ordernum[5].value=="")&&(form.ordernum[6].value=="")&&(form.ordernum[7].value=="")&&(form.ordernum[8].value=="")&&(form.ordernum[9].value=="")&&(form.ordernum[10].value=="")&&(form.ordernum[11].value=="")&&(form.ordernum[12].value=="")&&(form.ordernum[13].value=="")&&(form.ordernum[14].value=="")&&(form.ordernum[15].value=="")&&(form.ordernum[16].value=="")&&(form.ordernum[17].value=="")&&(form.ordernum[18].value=="")&&(form.ordernum[19].value=="")) {
		alert("주문수량을 입력하여 주시기바랍니다.") ;
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
				alert("상품코드가 중복됩니다.");
				form.pcode[imsivar2].value="" ;
				form.pcode[imsivar2].focus() ;
				return false ;
			}
		}
	}
}

<!-- 딜러등록 -->
function dwrite() {
	if (form.dcode.value=="") {
		alert("딜러코드를 입력하여 주시기바랍니다.") ;
		form.dcode.focus() ;
		return false ;
	}
	if (form.dname.value=="") {
		alert("딜러명을 입력하여 주시기바랍니다.") ;
		form.dname.focus() ;
		return false ;
	}
	if (form.name.value=="") {
		alert("대표자을 입력하여 주시기바랍니다.") ;
		form.name.focus() ;
		return false ;
	}
	if ((form.jumin1.value=="")||(form.jumin2.value=="")) {
		alert("주민(법인)등록번호를 입력하여 주시기바랍니다.") ;
		form.jumin1.focus() ;
		return false ;
	}
	if ((form.comnum1.value=="")||(form.comnum2.value=="")||(form.comnum3.value=="")) {
		alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		form.comnum1.focus() ;
		return false ;
	}
	if ((form.m_post1.value=="")||(form.m_post2.value=="")) {
		alert("우편번호를 입력하여 주시기바랍니다.") ;
		form.m_post1.focus() ;
		return false ;
	}
	if (form.m_addr1.value=="") {
		alert("주소를 입력하여 주시기바랍니다.") ;
		form.m_addr1.focus() ;
		return false ;
	}
	if (form.m_addr2.value=="") {
		alert("나머지 주소를 입력하여 주시기바랍니다.") ;
		form.m_addr2.focus() ;
		return false ;
	}
	if (form.upjong.value=="") {
		alert("업종을 입력하여 주시기바랍니다.") ;
		form.upjong.focus() ;
		return false ;
	}
	if (form.uptae.value=="") {
		alert("업태를 입력하여 주시기바랍니다.") ;
		form.uptae.focus() ;
		return false ;
	}
	if ((form.tel1.value=="")||(form.tel2.value=="")||(form.tel3.value=="")) {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		form.tel1.focus() ;
		return false ;
	}
	if (form.sudang.value=="") {
		alert("영업수당을 입력하여 주시기바랍니다.") ;
		form.sudang.focus() ;
		return false ;
	}
}

function ddel(frm) {
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}