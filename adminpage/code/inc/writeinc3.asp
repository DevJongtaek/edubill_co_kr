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
	msg=confirm("���� ��� ü������ �����Ͻðڽ��ϱ�?");
	if(msg) {
		form.action="allregsave.asp";
		form.submit() ;
		return false ;
	}
}

function partregsave() {
		if (form.bfile2.value=="") {
		alert("���������� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.bfile2.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("������ ü������ �����Ͻðڽ��ϱ�?");
	if(msg) {
		form.action="send_save3.asp";
		form.submit()
		return false ;
	}
}

function allregsave2() {
	var msg;
	msg=confirm("���� ��� ü������ �����Ͻðڽ��ϱ�?");
	if(msg) {
		form.action="allregsave2.asp";
		form.submit() ;
		return false ;
	}
}
function smscheck2() {
    if(sms1.excelgubun.value == "0")
    {
        alert("���� �׸��� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
        sms1.excelgubun.focus() ;
        return false ;
    }

    else if (sms1.bfile4.value=="" ) {
        alert("���� ���������� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
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
                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

                // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
                var addr = ''; // �ּ� ����
                var extraAddr = ''; // �����׸� ����

                //����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
                if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
                    addr = data.roadAddress;
                } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
                    addr = data.jibunAddress;
                }

                // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����׸��� �����Ѵ�.
                if(data.userSelectedType === 'R'){
                    // ���������� ���� ��� �߰��Ѵ�. (�������� ����)
                    // �������� ��� ������ ���ڰ� "��/��/��"�� ������.
                    if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // ǥ���� �����׸��� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // ���յ� �����׸��� �ش� �ʵ忡 �ִ´�.
                   document.getElementById("m_addr2").value = extraAddr;
                
                } else {
                    document.getElementById("m_addr2").value = '';
                }

                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
                document.getElementById('m_post1').value = data.zonecode.substr(0, 2);
                document.getElementById('m_post2').value = data.zonecode.substr(2, 3);
                document.getElementById("m_addr1").value = addr;
                // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
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
		alert("ü�����ڵ�� ���� 4���� �Դϴ�!!") ;
		return false ;
	}
	window.open ('/adminpage/jdregok2.asp?val='+val2+'&gubun='+val3,'CheckID','width=0,height=0,top=30000,left=30000')
	return false ;
}

function checkyeosin(yeosin){
	tmp = 2000000000;
	if (tmp < yeosin.value) {
		alert("�����ѵ��� 2,000,000,000�̻� ������ �Ұ����մϴ�.") ;
		yeosin.value = yeosin.value.substring(0, yeosin.value.length-1);
		yeosin.focus();
		return false ;
	}
}

function checkmisu(misu){
	tmp = 2000000000;
	if (tmp < misu.value) {
		alert("�ѹ̼����� 2,000,000,000�̻� ������ �Ұ����մϴ�.") ;
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
			alert("�̼����� ��Ȯ�� �Է����ּ���");
			return false;
		}
		if (isNaN(inmoney) == true)
		{
			alert("�Աݱݾ��� ��Ȯ�� �Է����ּ���");
			return false;
		}
		form.mi_money.value = mimoney - inmoney;
		return false;
	}

//ü�������� �߰�/����/���� 
function formsubmit(section) {
	if (section == "save")
	{
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
		if (form.name.value=="" || form.companynum1.value=="" || form.companynum2.value=="" || form.companynum3.value=="" || form.m_post1.value=="" || form.m_post2.value=="" || form.m_addr1.value=="" || form.m_addr2.value=="" || form.uptae.value=="" || form.upjong.value=="" || form.tel1.value=="" || form.tel2.value=="" || form.tel3.value=="" || form.hp1.value=="" || form.hp2.value=="" || form.hp3.value=="" || form.dcarno.selectedindex == 0 )
		{

			var answer = confirm('�ʼ� �Է� ������ ��� ��ϵ��� �ʾҽ��ϴ�. �̴�� ����Ͻðڽ��ϱ�?');
			if (answer)
			{
				if (form.name.value=="")
				{
					form.name.value = "ȫ�浿";
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
						form.virtual_acnt_bank.value = "����"
					}
					if (form.virtual_acnt.value == "")
					{
						form.virtual_acnt.value = "0000000000"
					}
					<%end if%>	
					}
					
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
		}
		//if (form.tel1.value=="") {
		//	alert("��ȭ��ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		//	form.tel1.focus() ;
		//	return false ;
		//} 
		
		if (form.tel2.value=="") {
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
	
		<%if fileflag="a" and fileflagchb="y" then%>
		} if (form.fileregcode.value=="") {
			alert("���ϻ����ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
			form.fileregcode.focus() ;
			return false ;
		<%end if%>
	
		<%if bonsacyberNum="y" then%>
		} if (form.virtual_acnt_bank.value=="") {
			alert("������� ������� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
			form.virtual_acnt_bank.focus() ;
			return false ;
		} if (form.virtual_acnt.value=="") {
			alert("������¹�ȣ�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
			form.virtual_acnt.focus() ;
			return false ;
		<%end if%>
		}
		<!-- 2011.01.22 �ֹ����� ������ ���� ������� ������Ʈ -->
		form.action = "writeok.asp";
		form.submit() ;
		return false ;
		} else {
		if (form.bfile2.value=="") {
		alert("���������� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.bfile2.focus() ;
		return false ;
		}
		var msg;
		msg=confirm("������ ü������ �����Ͻðڽ��ϱ�?");
		if(msg) {
			form.encoding="MULTIPART/FORM-DATA";
			form.action="send_save3.asp";
			form.submit();
			return false ;
		}
	}
}
<!-- 2011.01.22 ������ư �� ����(�� �̺�Ʈ���� ��ũ��Ʈ�� ����)-->
function comdel() {
	var msg;
	msg=confirm("���� �����ϰڽ��ϱ�?");
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
            alert('��� ���� �Ǿ����ϴ�.');
         } else {
            alert('��� ���� ����!!');
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
		<td><font color=blue size=3><B>[ ü���� ��� ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td colspan=2><B>[ �Ϲݻ��� ]</td> 
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
		<td width=20% align=right><font color=red>*</font><B>ü�����ڵ�&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="tcode" maxlength="4" size=4 OnKeypress="onlyNumber();" class="box_write" value="<%=imsitcode%>" <%if idx <> "" then%>readonly<%end if%>><%if idx="" then%><a href="#" onClick="return checkval(form,form.tcode.value,3)"><img src="/images/admin/member_01.gif" border=0></a><%end if%> * ���� 4�ڸ�</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>ü������&nbsp;</td>
		<td width=80% bgcolor=white>
			<input type="hidden" name="old_comname" maxlength="30" size=20 class="box_write" value="<%=imsicomname%>">
			<input type="text" name="comname" maxlength="30" size=20 class="box_write" value="<%=imsicomname%>">
			&nbsp;&nbsp; <B>�귣��
			<select name=cbrandchoice <%if imsibrandflag="n" then%>disabled<%end if%>>
				<option value="">���о���
				<%if imsibrandboxarry_int<>"" then%>
				<%for i=0 to imsibrandboxarry_int%>
					<option value="<%=imsibrandboxarry(0,i)%>" <%if cstr(imsibrandboxarry(0,i)) = cstr(imsicbrandchoice) then%>selected<%end if%>><%=imsibrandboxarry(1,i)%>
				<%next%>
				<%end if%>
			</select>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>��ǥ��&nbsp;</td>
		<td bgcolor=white><input type="text" name="name" maxlength="20" size=10 class="box_write" value="<%=imsiname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>����ڵ�Ϲ�ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" class="box_write" name="companynum1" maxlength="3" size=3 value="<%=imsicompanynum1%>" OnKeypress="onlyNumber();">
-
<input type="text" class="box_write" name="companynum2" maxlength="2" size=2 value="<%=imsicompanynum2%>" OnKeypress="onlyNumber();">
-
<input type="text" class="box_write" name="companynum3" maxlength="5" size=5 value="<%=imsicompanynum3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�����ȣ&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:45;" name="m_post1"  id="m_post1" maxlength=3 OnKeypress="onlyNumber();" value="<%=imsipost1%>">
			- 
			<input type="text" class="box_write" style="width:45;" name="m_post2" id="m_post2" maxlength=3 OnKeypress="onlyNumber();" value="<%=imsipost2%>"> 
			<!--<a href="#" onclick="javascript:AutoAddr();"><img src="/images/member_02.gif" hspace="5" align="absmiddle" border=0></a>-->
            <a href="#" onclick="javascript:DaumPostcode();"><img src="/images/member_02.gif" hspace="5" align="absmiddle" border=0></a>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�ּ�&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:300;" name="m_addr1" id="m_addr1" value="<%=imsiaddr%>"> 
                	<br> 
			<input type="text" class="box_write" style="width:300;" name="m_addr2" id="m_addr2" value="<%=imsiaddr2%>"> 
			������ �ּ� 
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>����&nbsp;</td>
		<td bgcolor=white><input type="text" name="uptae" maxlength="20" style="width:200;" class="box_write" value="<%=imsiuptae%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>����&nbsp;</td>
		<td bgcolor=white><input type="text" name="upjong" maxlength="20" style="width:200;" class="box_write" value="<%=imsiupjong%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>��ȭ��ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="tel1" maxlength="3" size=3 class="box_write" value="<%=imsitel1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel2" maxlength="4" size=4 class="box_write" value="<%=imsitel2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel3" maxlength="4" size=4 class="box_write" value="<%=imsitel3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ѽ���ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="fax1" maxlength="3" size=3 class="box_write" value="<%=imsifax1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax2" maxlength="4" size=4 class="box_write" value="<%=imsifax2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax3" maxlength="4" size=4 class="box_write" value="<%=imsifax3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>


	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�ڵ�����ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="hp1" maxlength="3" size=3 class="box_write" value="<%=imsihp1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="hp2" maxlength="4" size=4 class="box_write" value="<%=imsihp2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="hp3" maxlength="4" size=4 class="box_write" value="<%=imsihp3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>ȣ��&nbsp;</td>
		<td bgcolor=white>
			<select name=dcarno>
				<option value="">ȣ������
				<%do until rs.eof%>
					<option value="<%=rs(0)%>" <%if rs(0)=imsidcarno then%>selected<%end if%>><%=rs(1)%>ȣ��
				<%rs.movenext%>
				<%loop%>
				<%rs.close%>
			</select>
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��й�ȣ&nbsp;</td>
		<td bgcolor=white><input type="text" name="soundfile" class="box_write" value="<%=imsisoundfile%>" size=2 maxlength=2 OnKeypress="onlyNumber();"> (���� 2�ڸ�-'��й�ȣ'�� �Է��Ͻø�, ARS �ֹ��� '��й�ȣ' �Է� ��Ʈ�� ���ɴϴ�.)</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��������&nbsp;</td>
		<td bgcolor=white><input type="text" name="startday" maxlength="8" size=8 class="box_write" value="<%=replace(imsistartday,"/","")%>" OnKeypress="onlyNumber();"></td>
	</tr>
	<%If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then %>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ֹ�����&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="orderflag" value="y" <%if orderflag="y" or orderflag="" then%>checked<%end if%>>�ֹ���
			<%if idx<>"" then%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="�������"  style="background:lightblue;" onclick="return allregsave2();"><%end if%>
			<br>
			<input type="radio" name="orderflag" value="4" <%if orderflag="4" then%>checked<%end if%>>���1(�ֹ�)
			<input type="radio" name="orderflag" value="5" <%if orderflag="5" then%>checked<%end if%>>���2(�ֹ�)
			<!--<input type="radio" name="orderflag" value="1" <%if orderflag="1" then%>checked<%end if%>>�̼���1(����)
			<input type="radio" name="orderflag" value="6" <%if orderflag="6" then%>checked<%end if%>>�̼���2(����)-->
            <input type="radio" name="orderflag" value="1" <%if orderflag="1" then%>checked<%end if%>>�ֹ�����(����)
			<input type="radio" name="orderflag" value="6" <%if orderflag="6" then%>checked<%end if%>>���������(����)
			<input type="radio" name="orderflag" value="2" <%if orderflag="2" then%>checked<%end if%>>���(����)
			<input type="radio" name="orderflag" value="3" <%if orderflag="3" then%>checked<%end if%>>�޾�(����)

			<br>
			 <INPUT TYPE="FILE" NAME="bfile2" size="41"> 
			 <a href="#"><input type="button" value="��Ĵٿ�" onClick="self.location='excell5.asp';"></a> 
			 &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="�Ϻ�����" style="background:lightblue;" onclick="formsubmit('upload');">
		</td>
	</tr>
	<%Else %>	
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ֹ�����&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="orderflag" value="y" <%if orderflag="y" or orderflag="" then%>checked<%end if%>>�ֹ���
			<input type="radio" name="orderflag" value="4" <%if orderflag="4" then%>checked<%end if%>>���1(�ֹ�)
			<input type="radio" name="orderflag" value="5" <%if orderflag="5" then%>checked<%end if%>>���2(�ֹ�)
			<input type="radio" name="orderflag" value="1" <%if orderflag="1" then%>checked<%end if%>>�̼���(����)
			<input type="radio" name="orderflag" value="2" <%if orderflag="2" then%>checked<%end if%>>���(����)
			<input type="radio" name="orderflag" value="3" <%if orderflag="3" then%>checked<%end if%>>�޾�(����)
			<%if idx<>"" then%>&nbsp;<input type="button" value="�������"  style="background:lightblue;" onclick="return allregsave2();"><%end if%>
			<br>
			 <INPUT TYPE="FILE" NAME="bfile2" size="41" accept="application/xls"> 
			 <a href="#"><input type="button" value="��Ĵٿ�" onClick="self.location='excell5.asp';"></a> 
			 &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="�Ϻ�����" style="background:lightblue;" onclick="formsubmit('upload');">
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
		<td align=right><B>�ֹ���� ����&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="order_weekgubun" value="1" <%if imsiorder_weekgubun="1" or imsiorder_weekgubun="" then%>checked<%end if%> onclick="imsiordercheck();">�����ֹ�
			<input type="radio" name="order_weekgubun" value="2" <%if imsiorder_weekgubun="2" then%>checked<%end if%> onclick="imsiordercheck2();">���������ֹ� (������ ���ϡ��ð����� �ֹ��� ������ �� �ֽ��ϴ�.)
			<BR>
			<input type="checkbox" name="order_weekchoice2" value="2" <%if imsiorder_weekchoice2="2" then%>checked<%end if%> <%=imsidisabled%>>��
			<input type="checkbox" name="order_weekchoice3" value="3" <%if imsiorder_weekchoice3="3" then%>checked<%end if%> <%=imsidisabled%>>ȭ
			<input type="checkbox" name="order_weekchoice4" value="4" <%if imsiorder_weekchoice4="4" then%>checked<%end if%> <%=imsidisabled%>>��
			<input type="checkbox" name="order_weekchoice5" value="5" <%if imsiorder_weekchoice5="5" then%>checked<%end if%> <%=imsidisabled%>>��
			<input type="checkbox" name="order_weekchoice6" value="6" <%if imsiorder_weekchoice6="6" then%>checked<%end if%> <%=imsidisabled%>>��
			<input type="checkbox" name="order_weekchoice7" value="7" <%if imsiorder_weekchoice7="7" then%>checked<%end if%> <%=imsidisabled%>>��
			<input type="checkbox" name="order_weekchoice1" value="1" <%if imsiorder_weekchoice1="1" then%>checked<%end if%> <%=imsidisabled%>>��
			(����
			<input type="text" name="order_checkStime1" value="<%=left(imsiorder_checkStime,2)%>" size=2 maxlength=2 OnKeypress="onlyNumber();" <%=imsidisabled2%>>
			:
			<input type="text" name="order_checkStime2" value="<%=right(imsiorder_checkStime,2)%>" size=2 maxlength=2 OnKeypress="onlyNumber();" <%=imsidisabled2%>>
			~
			����
			<input type="text" name="order_checkEtime1" value="<%=left(imsiorder_checkEtime,2)%>" size=2 maxlength=2 OnKeypress="onlyNumber();" <%=imsidisabled2%>>
			:
			<input type="text" name="order_checkEtime2" value="<%=right(imsiorder_checkEtime,2)%>" size=2 maxlength=2 OnKeypress="onlyNumber();" <%=imsidisabled2%>>
			)
			<%if idx<>"" then%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="�������" style="background:lightblue;" onclick="return allregsave();"><%end if%>
		</td>
	</tr>


	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>���ϻ����ڵ�&nbsp;</td>
		<td bgcolor=white><input type="text" name="fileregcode" value="<%=imsifileregcode%>" size=20></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�������&nbsp;</td>
		<td bgcolor=white>
			�����1 : <input type="text" name="virtual_acnt_bank" value="<%=imsivirtual_acnt_bank%>" size=10>����
			&nbsp;&nbsp;
			���¹�ȣ1 : <input type="text" name="virtual_acnt" value="<%=imsivirtual_acnt%>" size=20>
            <br />
			�����2 : <input type="text" name="virtual_acnt4_bank" value="<%=imsivirtual_acnt4_bank%>" size=10>����
			&nbsp;&nbsp;
			���¹�ȣ2 : <input type="text" name="virtual_acnt4" value="<%=imsivirtual_acnt4%>" size=20>
            <br />
			�����3 : <input type="text" name="virtual_acnt5_bank" value="<%=imsivirtual_acnt5_bank%>" size=10>����
			&nbsp;&nbsp;
			���¹�ȣ3 : <input type="text" name="virtual_acnt5" value="<%=imsivirtual_acnt5%>" size=20>
            <br />
			�����4 : <input type="text" name="virtual_acnt6_bank" value="<%=imsivirtual_acnt6_bank%>" size=10>����
			&nbsp;&nbsp;
			���¹�ȣ4 : <input type="text" name="virtual_acnt6" value="<%=imsivirtual_acnt6%>" size=20>
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�̸���&nbsp;</td>
		<td bgcolor=white><input type="text" name="email" size=30 class="box_write" value="<%=imsiemail%>"></td>
	</tr>

<%if imsimyflag="y" then%>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�����ѵ�&nbsp;</td>
		<td bgcolor=white><input type="text" name="ye_money" value="<%=imsiye_money%>" size=10 maxlength=10 onchange="return checkyeosin(this);">��</td>
	</tr>
   <%if imsipremisuprint="y" then%>
    <tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�����̼���&nbsp;</td>
		<td bgcolor=white><input type="text" name="preye_money" value="<%=imsipreye_money%>" size=10 maxlength=10 onchange="return checkyeosin(this);">��</td>
	</tr>
   <%end if%>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>����̼���&nbsp;</td>
		<td bgcolor=white><input type="text" name="mi_money" value="<%=imsimi_money%>" size=10 maxlength=10 onchange="return checkmisu(this);">�� <= <input type="text" name="inmoney" size=10 maxlength=10> 
		<input type="button" value="�Ա�����" style="background:lightblue;" onclick="return misu_in();"> <font color=red>�� �ϴ� ������ �����ž� �ݿ��˴ϴ�.</font></td>
	</tr>
<%end if%>


	<tr bgcolor=#F7F7FF height=22 align=left>
		<td colspan=2><B>[ �ջ�û������ ] - <font color=red><B>�Ʒ� ������ '�Է�'�̳� '����'�� �Ͻø� �� �˴ϴ�.</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��ȭ��ȣ&nbsp;</td>
		<td bgcolor=white>
<select name=telecom>
	<option value="">����
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
		<td align=right><B>�ջ��û��&nbsp;</td>
		<td bgcolor=white><input type="text" name="hapday" maxlength="8" size=8 class="box_write" value="<%=imsihapday%>" OnKeypress="onlyNumber();"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ֹε�Ϲ�ȣ&nbsp;</td>
		<td bgcolor=white>
			<input type="text" name="jumin1" maxlength="6" size=6 class="box_write" value="<%=imsijumin1%>" OnKeypress="onlyNumber();">
			-
			<input type="text" name="jumin2" maxlength="7" size=7 class="box_write" value="<%=imsijumin2%>" OnKeypress="onlyNumber();">
			<input type="checkbox" name="jumincheck" value="y" <%if imsijumincheck="y" or imsijumincheck="" then%>checked<%end if%>>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��ȭ������&nbsp;</td>
		<td bgcolor=white><input type="text" name="telname" maxlength="20" size=15 class="box_write" value="<%=imsitelname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>����&nbsp;</td>
		<td bgcolor=white><input type="text" name="conetion" maxlength="20" size=15 class="box_write" value="<%=imsiconetion%>"></td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>���� ü���� ��������<BR><font color=red>(1000�� �̳�)&nbsp;</td>
		<td bgcolor=white>
		<table cellspacing=0 cellpadding=0 width="100%" border=0>
			<tr>
				<td width=70%><textarea name="ch_gongi" cols="80" rows="5" style="width:100%;border:1 solid #C7C7C7;back-color :black;" onkeyup='check_maxLen(form.ch_gongi, "���� ü���� ��������", 1000)'><%=imsich_gongi%></textarea></td>
				<td width=30% align=center>
					<input type="radio" name="saveflag" value="i" checked>��� &nbsp; <input type="radio" name="saveflag" value="d">����
					<BR>
					<%if imsibrandflag="y" then%>
					<select name=cbrandchoice2>
						<option value="">��ü
						<%if imsibrandboxarry_int<>"" then%>
							<%for i=0 to imsibrandboxarry_int%>
								<option value="<%=imsibrandboxarry(0,i)%>" <%if cstr(imsibrandboxarry(0,i)) = cstr(imsicbrandchoice) then%>selected<%end if%>><%=imsibrandboxarry(1,i)%>
							<%next%>
						<%end if%>
					</select>
					<%else%>
					<input type=radio name=cbrandchoice2 value="" checked>��ü
					<%end if%>
					<BR>
					<input type=button value="�������" onclick="return cgongiallsavechb()">
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
		<td><font color=blue size=3><B>[ ü���� �ϰ���� ]</td>
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
		<td width=30%><font color=red>*</font><B>�������ϼ���</td>
		<td width=70% bgcolor=white><INPUT TYPE="FILE" NAME="bfile1" size="40">
     
    
            <input type="button" value="��Ĵٿ�" onClick="self.location='excell2.asp?flag=<%=flag%>&idx=<%=left(session("Ausercode"),5)%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>';">
          
     
           
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
		<td><font color=blue size=3><B>[ ü���� �ϰ����� ]</td>
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
	<!--<option value="0">����</option>-->
	<option value="Brand">�귣��</option>
    <%If cybernum="y" Then %>
		
	<option value="vitual">�������</option>
   
			<%End if%>-->
    <option value="car">ȣ��</option>
	
</select>

		</td>
		<td width=70% bgcolor=white>
            
            <INPUT TYPE="FILE" NAME="bfile4" size="40"> 
         
              <input type="hidden" name ="Agubun" />
          
        
                
   
          <a href="#"><input type="button" value="��Ĵٿ�" name="btn1" onClick="return Edown(this);"></a> 

         
            <!--    <input type="button" name="btn2" value="���(�������)" onClick="">
         
        <input type="button" value="���(ȣ��)" name="btn3" onClick="">-->
         
        
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


