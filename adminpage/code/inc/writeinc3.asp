<script language="JavaScript">
<!--
function imsiordercheck(){
	form.order_weekchoice1.disabled=true;
	form.order_weekchoice2.disabled=true;
	form.order_weekchoice3.disabled=true;
	form.order_weekchoice4.disabled=true;
	form.order_weekchoice5.disabled=true;
	form.order_weekchoice6.disabled=true;
	form.order_weekchoice7.disabled=true;

	form.order_checkStime1.disabled=true;
	form.order_checkStime1.style.background="#C0C0C0";
	form.order_checkStime2.disabled=true;
	form.order_checkStime2.style.background="#C0C0C0";
	form.order_checkEtime1.disabled=true;
	form.order_checkEtime1.style.background="#C0C0C0";
	form.order_checkEtime2.disabled=true;
	form.order_checkEtime2.style.background="#C0C0C0";
}

function imsiordercheck2(){
	form.order_weekchoice1.disabled=false;
	form.order_weekchoice2.disabled=false;
	form.order_weekchoice3.disabled=false;
	form.order_weekchoice4.disabled=false;
	form.order_weekchoice5.disabled=false;
	form.order_weekchoice6.disabled=false;
	form.order_weekchoice7.disabled=false;

	form.order_checkStime1.disabled=false;
	form.order_checkStime1.style.background="white";
	form.order_checkStime2.disabled=false;
	form.order_checkStime2.style.background="white";
	form.order_checkEtime1.disabled=false;
	form.order_checkEtime1.style.background="white";
	form.order_checkEtime2.disabled=false;
	form.order_checkEtime2.style.background="white";
}

function allregsave() {
	var msg;
	msg=confirm("정말 모든 체인점에 적용하시겠습니까?");
	if(msg) {
		form.action="allregsave.asp";
		form.submit() ;
		return false ;
	}
}

function partregsave() {
		if (form.bfile2.value=="") {
		alert("엑셀파일을 선택하여 주시기바랍니다.") ;
		form.bfile2.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("지정한 체인점에 적용하시겠습니까?");
	if(msg) {
		form.action="send_save3.asp";
		form.submit()
		return false ;
	}
}

function allregsave2() {
	var msg;
	msg=confirm("정말 모든 체인점에 적용하시겠습니까?");
	if(msg) {
		form.action="allregsave2.asp";
		form.submit() ;
		return false ;
	}
}
function smscheck2() {
    if(sms1.excelgubun.value == "0")
    {
        alert("수정 항목을 선택하여 주시기바랍니다.") ;
        sms1.excelgubun.focus() ;
        return false ;
    }

    else if (sms1.bfile4.value=="" ) {
        alert("수정 엑셀파일을 선택하여 주시기바랍니다.") ;
        sms1.bfile4.focus() ;
        return false ;
    }

    eGubun = sms1.excelgubun.value;

    
    if(eGubun == "Brand")
    {
        sms1.action="send_save4.asp";
        
    }else  if(eGubun == "car")
    {
        sms1.action="send_save5.asp";
      
    }
    else if(eGubun == "vitual")
    {
        //window.open ('accountup.asp','ExcellID','width=450,height=120,left=100,top=100')
        //return false ;

        sms1.action = "accountupok.asp";
    }
}

function Edown()
{
    eGubun = sms1.excelgubun.value;

    
    if(eGubun == "Brand")
    {
        self.location='excell7.asp';
    }else  if(eGubun == "car")
    {
        self.location='excell9.asp';
    }
    else if(eGubun == "vitual")
    {
        

        self.location='excell8.asp?flag=<%=flag%>&idx=<%=left(session("Ausercode"),5)%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>';
    }
}
function loc(){ 
    

    
    //alert(ss.options[i].text); 

    eGubun = sms1.excelgubun.value;
  

    sms1.Agubun.value = sms1.excelgubun.value;

    if(eGubun == "Brand")
    {
       
        //sms1.btn1.disabled=false;
        //sms1.btn2.disabled=false;
        //sms1.btn3.disabled=false;
        ////sms1.btn1.disabled=false;
       
        ////sms1.btn2.disabled=true;
        ////sms1.btn3.disabled=true;
        //document.all['btn1'].style.visibility = 'visible';
        //document.all['btn2'].style.visibility = 'hidden';
        //document.all['btn3'].style.visibility = 'hidden';

        sms1.bfile4.disabled = false;
    }
    else if(eGubun == "vitual")
    { sms1.btn1.disabled=false;
        //sms1.btn2.disabled=false;
        //sms1.btn3.disabled=false;

        ////sms1.btn1.disabled=true;
        ////sms1.btn2.disabled=false;
        ////sms1.btn3.disabled=true;
        //document.all['btn1'].style.visibility = 'hidden';
        //document.all['btn2'].style.visibility = 'visible';
        //document.all['btn3'].style.visibility = 'hidden';
        
    sms1.bfile4.disabled = false;
    }
    else if(eGubun == "car")
    {
        //sms1.btn1.disabled=false;
        //sms1.btn2.disabled=false;
        //sms1.btn3.disabled=false;
        //sms1.btn1.disabled=true;
        //sms1.btn3.disabled=false;
        //sms1.btn2.disabled=true;
        sms1.bfile4.disabled = false;
        
        //document.all['btn1'].style.visibility = 'none';
        //document.all['btn2'].style.visibility = 'hidden';
        //document.all['btn3'].style.visibility = 'visible';
    }
    else
    {
        //sms1.btn1.disabled=false;
        //sms1.btn2.disabled=false;
        //sms1.btn3.disabled=false;
        sms1.bfile4.disabled = false;
    }


   
}


//-->
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script language="JavaScript">
    function DaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                   document.getElementById("m_addr2").value = extraAddr;
                
                } else {
                    document.getElementById("m_addr2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('m_post1').value = data.zonecode.substr(0, 2);
                document.getElementById('m_post2').value = data.zonecode.substr(2, 3);
                document.getElementById("m_addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("m_addr2").focus();
            }
        }).open();
    }
</script>

<script language="JavaScript">
<!--
   
   

    
function checkval(val1,val2,val3){
	tmp = val2;
	if (tmp.length < 4) {
		alert("체인점코드는 숫자 4글자 입니다!!") ;
		return false ;
	}
	window.open ('/adminpage/jdregok2.asp?val='+val2+'&gubun='+val3,'CheckID','width=0,height=0,top=30000,left=30000')
	return false ;
}

function checkyeosin(yeosin){
	tmp = 2000000000;
	if (tmp < yeosin.value) {
		alert("여신한도는 2,000,000,000이상 지정이 불가능합니다.") ;
		yeosin.value = yeosin.value.substring(0, yeosin.value.length-1);
		yeosin.focus();
		return false ;
	}
}

function checkmisu(misu){
	tmp = 2000000000;
	if (tmp < misu.value) {
		alert("총미수금은 2,000,000,000이상 지정이 불가능합니다.") ;
		misu.value = misu.value.substring(0, misu.value.length-1);
		misu.focus();
		return false ;
	}
}

	function misu_in() 
	{
		var mimoney = form.mi_money.value;
		var inmoney = form.inmoney.value;
		if (isNaN(mimoney) == true )
		{
			alert("미수금을 정확히 입력해주세요");
			return false;
		}
		if (isNaN(inmoney) == true)
		{
			alert("입금금액을 정확히 입력해주세요");
			return false;
		}
		form.mi_money.value = mimoney - inmoney;
		return false;
	}

//체인점정보 추가/수정/삭제 
function formsubmit(section) {
	if (section == "save")
	{
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
		if (form.name.value=="" || form.companynum1.value=="" || form.companynum2.value=="" || form.companynum3.value=="" || form.m_post1.value=="" || form.m_post2.value=="" || form.m_addr1.value=="" || form.m_addr2.value=="" || form.uptae.value=="" || form.upjong.value=="" || form.tel1.value=="" || form.tel2.value=="" || form.tel3.value=="" || form.hp1.value=="" || form.hp2.value=="" || form.hp3.value=="" || form.dcarno.selectedindex == 0 )
		{

			var answer = confirm('필수 입력 사항이 모두 등록되지 않았습니다. 이대로 등록하시겠습니까?');
			if (answer)
			{
				if (form.name.value=="")
				{
					form.name.value = "홍길동";
				}
				if (form.companynum1.value=="")
				{
					form.companynum1.value = "000";
				}
				if (form.companynum2.value=="")
				{
					form.companynum2.value = "00";
				}
				if (form.companynum3.value=="")
				{
					form.companynum3.value = "00000";
				}
				if (form.m_post1.value=="")
				{
					form.m_post1.value = "000";
				}
				if (form.m_post2.value=="")
				{
					form.m_post2.value = "000";
				}
				if (form.m_addr1.value=="")
				{
					form.m_addr1.value = ".";
				}
				if (form.m_addr2.value=="")
				{
					form.m_addr2.value = ".";
				}
				if (form.uptae.value=="")
				{
					form.uptae.value = ".";
				}
				if (form.upjong.value=="")
				{
					form.upjong.value = ".";
				}
				if (form.tel1.value=="")
				{
					form.tel1.value = "000";
				}
				if (form.tel2.value=="")
				{
					form.tel2.value = "0000";
				}
				if (form.tel3.value=="")
				{
					form.tel3.value = "0000";
				}
				if (form.hp1.value=="")
				{
					form.hp1.value = "000";
				}
				if (form.hp2.value=="")
				{
					form.hp2.value = "0000";
				}
				if (form.hp3.value=="")
				{
					form.hp3.value = "0000";
				}
				if (form.dcarno.selectedIndex == 0)
				{
					form.dcarno.selectedIndex = 1;
				}	
				<%if bonsacyberNum="y" then%>
					if (form.virtual_acnt_bank.value == "")
					{
						form.virtual_acnt_bank.value = "에듀"
					}
					if (form.virtual_acnt.value == "")
					{
						form.virtual_acnt.value = "0000000000"
					}
					<%end if%>	
					}
					
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
		}
		//if (form.tel1.value=="") {
		//	alert("전화번호를 입력하여 주시기바랍니다.") ;
		//	form.tel1.focus() ;
		//	return false ;
		//} 
		
		if (form.tel2.value=="") {
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
	
		<%if fileflag="a" and fileflagchb="y" then%>
		} if (form.fileregcode.value=="") {
			alert("파일생성코드를 입력하여 주시기바랍니다.") ;
			form.fileregcode.focus() ;
			return false ;
		<%end if%>
	
		<%if bonsacyberNum="y" then%>
		} if (form.virtual_acnt_bank.value=="") {
			alert("가상계좌 은행명을 입력하여 주시기바랍니다.") ;
			form.virtual_acnt_bank.focus() ;
			return false ;
		} if (form.virtual_acnt.value=="") {
			alert("가상계좌번호를 입력하여 주시기바랍니다.") ;
			form.virtual_acnt.focus() ;
			return false ;
		<%end if%>
		}
		<!-- 2011.01.22 주문여부 엑셀로 수정 방법으로 업데이트 -->
		form.action = "writeok.asp";
		form.submit() ;
		return false ;
		} else {
		if (form.bfile2.value=="") {
		alert("엑셀파일을 선택하여 주시기바랍니다.") ;
		form.bfile2.focus() ;
		return false ;
		}
		var msg;
		msg=confirm("지정한 체인점에 적용하시겠습니까?");
		if(msg) {
			form.encoding="MULTIPART/FORM-DATA";
			form.action="send_save3.asp";
			form.submit();
			return false ;
		}
	}
}
<!-- 2011.01.22 삭제버튼 재 설정(폼 이벤트에서 스크립트로 변경)-->
function comdel() {
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.dflag.value="1"
		form.action = "writeok.asp";
		form.submit() ;
		return false ;
	}
}

function cgongiallsavechb(){
	form.action="GongiAllSave.asp"
	form.submit() ;
	return false ;
}


function FuncPutInfoForAjax(){
   var frm = document.form;
   var param = 'idx=<%=idx%>';
   param += '&ch_gongi=' + escape(frm.ch_gongi.value);
   param += '&saveflag=' + escape(frm.saveflag.value);
   param += '&cbrandchoice2=' + escape(frm.cbrandchoice2.value);
   var ReturnResponse;
   var XmlHttp = GetXMLHttpRequest();
   XmlHttp.open('POST', 'GongiAllSave.asp', true);
   XmlHttp.setRequestHeader('Accept-Language', 'ko');
   XmlHttp.setRequestHeader('Accept-Encoding', 'gzip, deflate');
   XmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded;charset=euc-kr');
   XmlHttp.setRequestHeader('Content-length', param.length);
   XmlHttp.setRequestHeader('Connection', 'close');
   XmlHttp.send(param);
   XmlHttp.onreadystatechange = function(){
      if(XmlHttp.readyState == 4 && XmlHttp.status == 200 && XmlHttp.statusText == 'OK'){
         ReturnResponse = XmlHttp.responseText;
         if(ReturnResponse == 1){
            alert('모두 적용 되었습니다.');
         } else {
            alert('모두 적용 실패!!');
		 }
      }
   }
	function formback()
	{
		window.location.href="'list.asp?flag=3&gotopage=1'";
	}
}




//-->
</script>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 체인점 등록 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td colspan=2><B>[ 일반사항 ]</td> 
	</tr>

<form name="form" method="post">
<input type=hidden name=flag value="<%=flag%>">
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type="hidden" name="searcha" value="<%=searcha%>">
<input type="hidden" name="searchb" value="<%=searchb%>">
<input type="hidden" name="searchc" value="<%=searchc%>">
<input type="hidden" name="searchd" value="<%=searchd%>">
<input type="hidden" name="searche" value="<%=searche%>">
<input type="hidden" name="searchf" value="<%=searchf%>">
<input type="hidden" name="searchg" value="<%=searchg%>">

<input type="hidden" name="old_fileregcode" value="<%=imsifileregcode%>">
<input type="hidden" name="fileflag" value="<%=fileflag%>">
<input type="hidden" name="fileflagchb2" value="<%=fileflagchb%>">

<input type="hidden" name="dflag">

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>체인점코드&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="tcode" maxlength="4" size=4 OnKeypress="onlyNumber();" class="box_write" value="<%=imsitcode%>" <%if idx <> "" then%>readonly<%end if%>><%if idx="" then%><a href="#" onClick="return checkval(form,form.tcode.value,3)"><img src="/images/admin/member_01.gif" border=0></a><%end if%> * 숫자 4자리</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>체인점명&nbsp;</td>
		<td width=80% bgcolor=white>
			<input type="hidden" name="old_comname" maxlength="30" size=20 class="box_write" value="<%=imsicomname%>">
			<input type="text" name="comname" maxlength="30" size=20 class="box_write" value="<%=imsicomname%>">
			&nbsp;&nbsp; <B>브랜드
			<select name=cbrandchoice <%if imsibrandflag="n" then%>disabled<%end if%>>
				<option value="">구분없음
				<%if imsibrandboxarry_int<>"" then%>
				<%for i=0 to imsibrandboxarry_int%>
					<option value="<%=imsibrandboxarry(0,i)%>" <%if cstr(imsibrandboxarry(0,i)) = cstr(imsicbrandchoice) then%>selected<%end if%>><%=imsibrandboxarry(1,i)%>
				<%next%>
				<%end if%>
			</select>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>대표자&nbsp;</td>
		<td bgcolor=white><input type="text" name="name" maxlength="20" size=10 class="box_write" value="<%=imsiname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>사업자등록번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" class="box_write" name="companynum1" maxlength="3" size=3 value="<%=imsicompanynum1%>" OnKeypress="onlyNumber();">
-
<input type="text" class="box_write" name="companynum2" maxlength="2" size=2 value="<%=imsicompanynum2%>" OnKeypress="onlyNumber();">
-
<input type="text" class="box_write" name="companynum3" maxlength="5" size=5 value="<%=imsicompanynum3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>우편번호&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:45;" name="m_post1"  id="m_post1" maxlength=3 OnKeypress="onlyNumber();" value="<%=imsipost1%>">
			- 
			<input type="text" class="box_write" style="width:45;" name="m_post2" id="m_post2" maxlength=3 OnKeypress="onlyNumber();" value="<%=imsipost2%>"> 
			<!--<a href="#" onclick="javascript:AutoAddr();"><img src="/images/member_02.gif" hspace="5" align="absmiddle" border=0></a>-->
            <a href="#" onclick="javascript:DaumPostcode();"><img src="/images/member_02.gif" hspace="5" align="absmiddle" border=0></a>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>주소&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:300;" name="m_addr1" id="m_addr1" value="<%=imsiaddr%>"> 
                	<br> 
			<input type="text" class="box_write" style="width:300;" name="m_addr2" id="m_addr2" value="<%=imsiaddr2%>"> 
			나머지 주소 
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>업태&nbsp;</td>
		<td bgcolor=white><input type="text" name="uptae" maxlength="20" style="width:200;" class="box_write" value="<%=imsiuptae%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>업종&nbsp;</td>
		<td bgcolor=white><input type="text" name="upjong" maxlength="20" style="width:200;" class="box_write" value="<%=imsiupjong%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>전화번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="tel1" maxlength="3" size=3 class="box_write" value="<%=imsitel1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel2" maxlength="4" size=4 class="box_write" value="<%=imsitel2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel3" maxlength="4" size=4 class="box_write" value="<%=imsitel3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>팩스번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="fax1" maxlength="3" size=3 class="box_write" value="<%=imsifax1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax2" maxlength="4" size=4 class="box_write" value="<%=imsifax2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax3" maxlength="4" size=4 class="box_write" value="<%=imsifax3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>


	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>핸드폰번호&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="hp1" maxlength="3" size=3 class="box_write" value="<%=imsihp1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="hp2" maxlength="4" size=4 class="box_write" value="<%=imsihp2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="hp3" maxlength="4" size=4 class="box_write" value="<%=imsihp3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>호차&nbsp;</td>
		<td bgcolor=white>
			<select name=dcarno>
				<option value="">호차선택
				<%do until rs.eof%>
					<option value="<%=rs(0)%>" <%if rs(0)=imsidcarno then%>selected<%end if%>><%=rs(1)%>호차
				<%rs.movenext%>
				<%loop%>
				<%rs.close%>
			</select>
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>비밀번호&nbsp;</td>
		<td bgcolor=white><input type="text" name="soundfile" class="box_write" value="<%=imsisoundfile%>" size=2 maxlength=2 OnKeypress="onlyNumber();"> (숫자 2자리-'비밀번호'를 입력하시면, ARS 주문시 '비밀번호' 입력 멘트가 나옵니다.)</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>가맹일자&nbsp;</td>
		<td bgcolor=white><input type="text" name="startday" maxlength="8" size=8 class="box_write" value="<%=replace(imsistartday,"/","")%>" OnKeypress="onlyNumber();"></td>
	</tr>
	<%If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then %>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>주문여부&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="orderflag" value="y" <%if orderflag="y" or orderflag="" then%>checked<%end if%>>주문중
			<%if idx<>"" then%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="모두적용"  style="background:lightblue;" onclick="return allregsave2();"><%end if%>
			<br>
			<input type="radio" name="orderflag" value="4" <%if orderflag="4" then%>checked<%end if%>>경고1(주문)
			<input type="radio" name="orderflag" value="5" <%if orderflag="5" then%>checked<%end if%>>경고2(주문)
			<!--<input type="radio" name="orderflag" value="1" <%if orderflag="1" then%>checked<%end if%>>미수금1(정지)
			<input type="radio" name="orderflag" value="6" <%if orderflag="6" then%>checked<%end if%>>미수금2(정지)-->
            <input type="radio" name="orderflag" value="1" <%if orderflag="1" then%>checked<%end if%>>주문차단(정지)
			<input type="radio" name="orderflag" value="6" <%if orderflag="6" then%>checked<%end if%>>시즈닝차단(정지)
			<input type="radio" name="orderflag" value="2" <%if orderflag="2" then%>checked<%end if%>>폐업(정지)
			<input type="radio" name="orderflag" value="3" <%if orderflag="3" then%>checked<%end if%>>휴업(정지)

			<br>
			 <INPUT TYPE="FILE" NAME="bfile2" size="41"> 
			 <a href="#"><input type="button" value="양식다운" onClick="self.location='excell5.asp';"></a> 
			 &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="일부적용" style="background:lightblue;" onclick="formsubmit('upload');">
		</td>
	</tr>
	<%Else %>	
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>주문여부&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="orderflag" value="y" <%if orderflag="y" or orderflag="" then%>checked<%end if%>>주문중
			<input type="radio" name="orderflag" value="4" <%if orderflag="4" then%>checked<%end if%>>경고1(주문)
			<input type="radio" name="orderflag" value="5" <%if orderflag="5" then%>checked<%end if%>>경고2(주문)
			<input type="radio" name="orderflag" value="1" <%if orderflag="1" then%>checked<%end if%>>미수금(정지)
			<input type="radio" name="orderflag" value="2" <%if orderflag="2" then%>checked<%end if%>>폐업(정지)
			<input type="radio" name="orderflag" value="3" <%if orderflag="3" then%>checked<%end if%>>휴업(정지)
			<%if idx<>"" then%>&nbsp;<input type="button" value="모두적용"  style="background:lightblue;" onclick="return allregsave2();"><%end if%>
			<br>
			 <INPUT TYPE="FILE" NAME="bfile2" size="41" accept="application/xls"> 
			 <a href="#"><input type="button" value="양식다운" onClick="self.location='excell5.asp';"></a> 
			 &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="일부적용" style="background:lightblue;" onclick="formsubmit('upload');">
		</td>
	</tr>
<%
    End If 
	'imsiorder_weekgubun
	'imsiorder_weekchoice
	'imsiorder_checkStime
	'imsiorder_checkEtime

	if imsiorder_weekgubun="1" then
		imsidisabled = "disabled"
		imsidisabled2 = "disabled style=""background='#C0C0C0'"" "
	else
		imsidisabled = ""
		imsidisabled2 = ""
	end if

if imsiorder_weekchoice<>"" then
	if InStrRev(imsiorder_weekchoice,"1") > 0 then
		imsiorder_weekchoice1 = "1"
	end if
	if InStrRev(imsiorder_weekchoice,"2") > 0 then
		imsiorder_weekchoice2 = "2"
	end if
	if InStrRev(imsiorder_weekchoice,"3") > 0 then
		imsiorder_weekchoice3 = "3"
	end if
	if InStrRev(imsiorder_weekchoice,"4") > 0 then
		imsiorder_weekchoice4 = "4"
	end if
	if InStrRev(imsiorder_weekchoice,"5") > 0 then
		imsiorder_weekchoice5 = "5"
	end if
	if InStrRev(imsiorder_weekchoice,"6") > 0 then
		imsiorder_weekchoice6 = "6"
	end if
	if InStrRev(imsiorder_weekchoice,"7") > 0 then
		imsiorder_weekchoice7 = "7"
	end if
end if
   



%>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>주문허용 선택&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="order_weekgubun" value="1" <%if imsiorder_weekgubun="1" or imsiorder_weekgubun="" then%>checked<%end if%> onclick="imsiordercheck();">매일주문
			<input type="radio" name="order_weekgubun" value="2" <%if imsiorder_weekgubun="2" then%>checked<%end if%> onclick="imsiordercheck2();">요일지정주문 (지정한 요일·시간에만 주문을 받으실 수 있습니다.)
			<BR>
			<input type="checkbox" name="order_weekchoice2" value="2" <%if imsiorder_weekchoice2="2" then%>checked<%end if%> <%=imsidisabled%>>월
			<input type="checkbox" name="order_weekchoice3" value="3" <%if imsiorder_weekchoice3="3" then%>checked<%end if%> <%=imsidisabled%>>화
			<input type="checkbox" name="order_weekchoice4" value="4" <%if imsiorder_weekchoice4="4" then%>checked<%end if%> <%=imsidisabled%>>수
			<input type="checkbox" name="order_weekchoice5" value="5" <%if imsiorder_weekchoice5="5" then%>checked<%end if%> <%=imsidisabled%>>목
			<input type="checkbox" name="order_weekchoice6" value="6" <%if imsiorder_weekchoice6="6" then%>checked<%end if%> <%=imsidisabled%>>금
			<input type="checkbox" name="order_weekchoice7" value="7" <%if imsiorder_weekchoice7="7" then%>checked<%end if%> <%=imsidisabled%>>토
			<input type="checkbox" name="order_weekchoice1" value="1" <%if imsiorder_weekchoice1="1" then%>checked<%end if%> <%=imsidisabled%>>일
			(전일
			<input type="text" name="order_checkStime1" value="<%=left(imsiorder_checkStime,2)%>" size=2 maxlength=2 OnKeypress="onlyNumber();" <%=imsidisabled2%>>
			:
			<input type="text" name="order_checkStime2" value="<%=right(imsiorder_checkStime,2)%>" size=2 maxlength=2 OnKeypress="onlyNumber();" <%=imsidisabled2%>>
			~
			당일
			<input type="text" name="order_checkEtime1" value="<%=left(imsiorder_checkEtime,2)%>" size=2 maxlength=2 OnKeypress="onlyNumber();" <%=imsidisabled2%>>
			:
			<input type="text" name="order_checkEtime2" value="<%=right(imsiorder_checkEtime,2)%>" size=2 maxlength=2 OnKeypress="onlyNumber();" <%=imsidisabled2%>>
			)
			<%if idx<>"" then%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="모두적용" style="background:lightblue;" onclick="return allregsave();"><%end if%>
		</td>
	</tr>


	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>파일생성코드&nbsp;</td>
		<td bgcolor=white><input type="text" name="fileregcode" value="<%=imsifileregcode%>" size=20></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>가상계좌&nbsp;</td>
		<td bgcolor=white>
			은행명1 : <input type="text" name="virtual_acnt_bank" value="<%=imsivirtual_acnt_bank%>" size=10>은행
			&nbsp;&nbsp;
			계좌번호1 : <input type="text" name="virtual_acnt" value="<%=imsivirtual_acnt%>" size=20>
            <br />
			은행명2 : <input type="text" name="virtual_acnt4_bank" value="<%=imsivirtual_acnt4_bank%>" size=10>은행
			&nbsp;&nbsp;
			계좌번호2 : <input type="text" name="virtual_acnt4" value="<%=imsivirtual_acnt4%>" size=20>
            <br />
			은행명3 : <input type="text" name="virtual_acnt5_bank" value="<%=imsivirtual_acnt5_bank%>" size=10>은행
			&nbsp;&nbsp;
			계좌번호3 : <input type="text" name="virtual_acnt5" value="<%=imsivirtual_acnt5%>" size=20>
            <br />
			은행명4 : <input type="text" name="virtual_acnt6_bank" value="<%=imsivirtual_acnt6_bank%>" size=10>은행
			&nbsp;&nbsp;
			계좌번호4 : <input type="text" name="virtual_acnt6" value="<%=imsivirtual_acnt6%>" size=20>
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>이메일&nbsp;</td>
		<td bgcolor=white><input type="text" name="email" size=30 class="box_write" value="<%=imsiemail%>"></td>
	</tr>

<%if imsimyflag="y" then%>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>여신한도&nbsp;</td>
		<td bgcolor=white><input type="text" name="ye_money" value="<%=imsiye_money%>" size=10 maxlength=10 onchange="return checkyeosin(this);">원</td>
	</tr>
   <%if imsipremisuprint="y" then%>
    <tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>직전미수금&nbsp;</td>
		<td bgcolor=white><input type="text" name="preye_money" value="<%=imsipreye_money%>" size=10 maxlength=10 onchange="return checkyeosin(this);">원</td>
	</tr>
   <%end if%>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>현재미수금&nbsp;</td>
		<td bgcolor=white><input type="text" name="mi_money" value="<%=imsimi_money%>" size=10 maxlength=10 onchange="return checkmisu(this);">원 <= <input type="text" name="inmoney" size=10 maxlength=10> 
		<input type="button" value="입금적용" style="background:lightblue;" onclick="return misu_in();"> <font color=red>※ 하단 수정을 누르셔야 반영됩니다.</font></td>
	</tr>
<%end if%>


	<tr bgcolor=#F7F7FF height=22 align=left>
		<td colspan=2><B>[ 합산청구정보 ] - <font color=red><B>아래 내용은 '입력'이나 '수정'을 하시면 안 됩니다.</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>전화번호&nbsp;</td>
		<td bgcolor=white>
<select name=telecom>
	<option value="">선택
	<option value="KT" <%if imsitelecom="KT" then%>SELECTED<%end if%>>KT
	<option value="SKT" <%if imsitelecom="SKT" then%>SELECTED<%end if%>>SKT
	<option value="LGT" <%if imsitelecom="LGT" then%>SELECTED<%end if%>>LGT
	<option value="KTF" <%if imsitelecom="KTF" then%>SELECTED<%end if%>>KTF
</select>
<input type="text" name="ctel1" maxlength="3" size=3 class="box_write" value="<%=imsictel1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="ctel2" maxlength="4" size=4 class="box_write" value="<%=imsictel2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="ctel3" maxlength="4" size=4 class="box_write" value="<%=imsictel3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>합산신청일&nbsp;</td>
		<td bgcolor=white><input type="text" name="hapday" maxlength="8" size=8 class="box_write" value="<%=imsihapday%>" OnKeypress="onlyNumber();"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>주민등록번호&nbsp;</td>
		<td bgcolor=white>
			<input type="text" name="jumin1" maxlength="6" size=6 class="box_write" value="<%=imsijumin1%>" OnKeypress="onlyNumber();">
			-
			<input type="text" name="jumin2" maxlength="7" size=7 class="box_write" value="<%=imsijumin2%>" OnKeypress="onlyNumber();">
			<input type="checkbox" name="jumincheck" value="y" <%if imsijumincheck="y" or imsijumincheck="" then%>checked<%end if%>>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>전화명의인&nbsp;</td>
		<td bgcolor=white><input type="text" name="telname" maxlength="20" size=15 class="box_write" value="<%=imsitelname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>관계&nbsp;</td>
		<td bgcolor=white><input type="text" name="conetion" maxlength="20" size=15 class="box_write" value="<%=imsiconetion%>"></td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>개별 체인점 공지사항<BR><font color=red>(1000자 이내)&nbsp;</td>
		<td bgcolor=white>
		<table cellspacing=0 cellpadding=0 width="100%" border=0>
			<tr>
				<td width=70%><textarea name="ch_gongi" cols="80" rows="5" style="width:100%;border:1 solid #C7C7C7;back-color :black;" onkeyup='check_maxLen(form.ch_gongi, "개별 체인점 공지사항", 1000)'><%=imsich_gongi%></textarea></td>
				<td width=30% align=center>
					<input type="radio" name="saveflag" value="i" checked>등록 &nbsp; <input type="radio" name="saveflag" value="d">삭제
					<BR>
					<%if imsibrandflag="y" then%>
					<select name=cbrandchoice2>
						<option value="">전체
						<%if imsibrandboxarry_int<>"" then%>
							<%for i=0 to imsibrandboxarry_int%>
								<option value="<%=imsibrandboxarry(0,i)%>" <%if cstr(imsibrandboxarry(0,i)) = cstr(imsicbrandchoice) then%>selected<%end if%>><%=imsibrandboxarry(1,i)%>
							<%next%>
						<%end if%>
					</select>
					<%else%>
					<input type=radio name=cbrandchoice2 value="" checked>전체
					<%end if%>
					<BR>
					<input type=button value="모두적용" onclick="return cgongiallsavechb()">
				</td>
			</tr>
		</table>
		</td>
	</tr>

</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>

<%if session("Ausergubun")="3" then%>
	<%if session("Auserwrite")="y" then%>
		<%if idx="" then%>
			<a href="#" ><img src="/images/admin/l_bu01.gif" border=0 onclick="formsubmit('save');"></a>
		<%else%>
			<a href="#" ><img src="/images/admin/l_bu03.gif" border=0 onclick="formsubmit('save');"></a>
			<a href="#" onclick="comdel();"><img src="/images/admin/l_bu04.gif" border=0></a>
		<%end if%>
	<%end if%>
<%end if%>

			<a href="#" onclick="javascript:location.href='list.asp?flag=<%=flag%>&gotopage=<%=gotopage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchc%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>';"><img src="/images/admin/l_bu07.gif" border=0></a>

            
		</td>
	</tr>

</form>

</table>

<BR>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
<FORM NAME="sms" method="post" action="send_save2.asp" ENCTYPE="MULTIPART/FORM-DATA" onsubmit="return smscheck()">
	<tr height="47">
		<td><font color=blue size=3><B>[ 체인점 일괄등록 ]</td>
	</tr>
</table>
<%
set rs = server.CreateObject("ADODB.Recordset")
SQL = " select myflag from tb_company where idx = "& int(left(session("Ausercode"),5)) &" "
rs.Open sql, db, 1
if not rs.eof then
	imsimyflag = rs(0)
else
	imsimyflag = ""
end if
rs.close
    %>
<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
	<tr bgcolor=#F7F7FF height=22 align=center>
		<td width=30%><font color=red>*</font><B>엑셀파일선택</td>
		<td width=70% bgcolor=white><INPUT TYPE="FILE" NAME="bfile1" size="40">
     
    
            <input type="button" value="양식다운" onClick="self.location='excell2.asp?flag=<%=flag%>&idx=<%=left(session("Ausercode"),5)%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>';">
          
     
           
		</td>
	</tr>
</table>

<table align=center>
	<tr> 
		<td height=30 align=center>

<%if session("Ausergubun")="3" then%>
	<%if session("Auserwrite")="y" then%>
		<%if idx="" then%>
			<input type="image" src="/images/admin/l_bu01.gif" border=0>
		<%else%>
            <input type="image" src="/images/admin/l_bu01.gif" border=0>
			<!--<input type="image"  src="/images/admin/l_bu03.gif" border="0">-->
			<!--<a href="#" onclick="javascript:productdel(this.form);"><img src="/images/admin/l_bu04.gif" border=0></a>-->
		<%end if%>
	<%end if%>
<%end if%>
			<a href="#" onclick="javascript:history.back();"><img src="/images/admin/l_bu07.gif" border=0></a>

		</td>
	</tr>

</form>

</table>
<!--%If left(session("Ausercode"),5) = "19209" Then %-->
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
<FORM NAME="sms1" method="post"  ENCTYPE="MULTIPART/FORM-DATA" onsubmit="return smscheck2()" >
	<tr height="47">
		<td><font color=blue size=3><B>[ 체인점 일괄수정 ]</td>
	</tr>
</table>
<%
    
    set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag,cyberNum,misubtn from tb_company where idx = "& int(left(session("Ausercode"),5)) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsimyflag = rs(0)
		cyberNum = rs(1)
		misubtn  = rs(2)
	else
		imsimyflag = ""
		cyberNum = ""
		misubtn  = ""
	end if
	rs.close
    %>
<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
	<tr bgcolor=#F7F7FF height=22 align=center>
		<td width=30%>
<select name="excelgubun" onchange="return loc(this);">
	<!--<option value="0">선택</option>-->
	<option value="Brand">브랜드</option>
    <%If cybernum="y" Then %>
		
	<option value="vitual">가상계좌</option>
   
			<%End if%>-->
    <option value="car">호차</option>
	
</select>

		</td>
		<td width=70% bgcolor=white>
            
            <INPUT TYPE="FILE" NAME="bfile4" size="40"> 
         
              <input type="hidden" name ="Agubun" />
          
        
                
   
          <a href="#"><input type="button" value="양식다운" name="btn1" onClick="return Edown(this);"></a> 

         
            <!--    <input type="button" name="btn2" value="양식(가상계좌)" onClick="">
         
        <input type="button" value="양식(호차)" name="btn3" onClick="">-->
         
        
		</td>
	</tr>
</table>

<table align=center>
	<tr> 
		<td height=30 align=center>

<%if session("Ausergubun")="3" then%>
	<%if session("Auserwrite")="y" then%>
		<%if idx="" then%>
			<input type="image" src="/images/admin/l_bu01.gif" border=0>
		<%else%>
          
			<input type="image" name="up1"  src="/images/admin/l_bu03.gif" border="0">		
			
		<%end if%>
	<%end if%>
<%end if%>
			<a href="#" onclick="javascript:history.back();"><img src="/images/admin/l_bu07.gif" border=0></a>

		</td>
	</tr>

</form>
</table>
<!--%end if%-->


