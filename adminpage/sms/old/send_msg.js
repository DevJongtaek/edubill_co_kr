// revised 2001-06-05 PM 6:51 by LeeSangGyu
function AddChar(ch)
{
   document.frmMsg.message.focus();
   document.selection.createRange().text = ch;
}

// revised 2001-06-07 PM 7:48 by LeeSangGyu
function receiver_add()
{
	count_options = document.frmMsg.address.length;

	if (count_options == 0) 
		alert("주소록에 입력된 사람이 없습니다.\r\n"
				+"주소록을 먼저 작성해 주십시오");

	sel_count = 0;
	for (i = 0; i < count_options; i++) {
		if (document.frmMsg.address.options[i].selected == true) 
		{
			sel_count++;
			selItem = document.frmMsg.address.options[i].text;
			receiverStrLen = document.frmMsg.receiver.value.length;
			if (receiverStrLen == 0 ||
			    document.frmMsg.receiver.value.charAt(receiverStrLen-1) == ";")
				document.frmMsg.receiver.value += selItem + ";";
			else
				document.frmMsg.receiver.value += ";" + selItem + ";";			
		}
	}

	if (count_options > 0 && sel_count == 0)
		alert("오른쪽 이름/그룹란에서 적어도 하나이상\r\n"
				+ "선택하신 후 추가하셔야 합니다");	
}



function CheckLen(form)
{
	var temp;
	var mycount;
	mycount = 0;
	len = form.content.value.length;
	for(k=0;k<len;k++){
		temp = form.content.value.charAt(k);
		if (escape(temp).length > 4)
			mycount += 2;
		else
			mycount++;
	}
	form.mycount.value = mycount;
}

function edit_pass(){
	sel_count = 0;
	count = document.frmMsg.count.value;
	for(i=0;i<count;i++){
		if(document.frmMsg.address.options[i].selected == true){
			sel_count++; //선택된 option의 개수
			sel_index = i; //선택된 index번호
		}
	}
	if(sel_count > 1){
		alert('수정하시려면 하나만 선택하십시오');
		return false;
	}
	else if(sel_count == 0){
		alert('수정하시고자 하는 수신인을 선택하십시오');
		return false;
	}
	else if(sel_count == 1){
		//선택된 것이 그룹일 경우
		if(document.frmMsg.ele_count.value < sel_index+1){
			var len_str;
			var my_gpkey;
			len_str = document.frmMsg.address.options[document.frmMsg.address.selectedIndex].value.length;
			my_gpkey = document.frmMsg.address.options[document.frmMsg.address.selectedIndex].value.substring(1,len_str);
			my_url = "Edit_Group.asp?gpkey=" + my_gpkey + "&from=addr_setting&times=first";
			open(my_url, "_new",'toolbar=no,directories=no,scrollbars=1,resizable=1,status=no,menubar=0,width=350,height=420');
		}
		//선택된 것이 개인일 경우
		else{
			var len_str;
			var my_reckey;
			len_str = document.frmMsg.address.options[document.frmMsg.address.selectedIndex].value.length;
			my_reckey = document.frmMsg.address.options[document.frmMsg.address.selectedIndex].value.substring(1,len_str);
			my_url = "Edit_Element.asp?from=addr_setting&fromAddrSetting=yes&reckey=" + my_reckey;
			open(my_url,"_new",'toolbar=no,directories=no,scrollbars=1,resizable=1,status=no,menubar=0,width=420,height=440');
		}
		return false;
	}
}

function check_valid(){
	var temp;
	var mycount;
	mycount = 0;
	len = document.frMain.title.value.length;

	for(k=0;k<len;k++){
		temp = document.frMain.title.value.charAt(k);
		if(escape(temp).length > 4)
			mycount += 2;
		else
			mycount++;
	}

	if(document.frMain.receiver.value.length == 0){
		alert("받을사람을 입력하십시오");
		document.frMain.receiver.focus();
		return false;
	}
	else if(mycount > 40){
		alert('제목이 너무 깁니다. 한글 20자 이내 영문 40자 이내로 해주십시오');
		document.frMain.title.focus();
		return false;
	}
	else if(document.frMain.content.value.length == 0){
		alert("내용을 입력하십시오");
		document.frMain.content.focus();
		return false;
	}
	else if(!document.frMain.email.checked && !document.frMain.mmail.checked){
		alert("Mmail 혹은 Email 중 적어도 하나를 선택하십시오");
		document.frMain.email.focus();
		return false;
	}
	else if(document.frMain.recall1.value.length<2 ||document.frMain.recall2.value.length<2 ||document.frMain.recall3.value.length !=4){
		alert("회신번호를 입력해 주세요.");
		document.frMain.recall1.focus();
		return false;
	}

	else if(document.frMain.ResOrNot[1].checked && 
		(document.frMain.date.value.length!=8 || document.frMain.time.value.length!=4)){
		alert("예약시간이 유효하지 않습니다.");
		document.frMain.date.focus();
		return false;
	}

	else{
		document.frMain.submit();
		return false;
	}
}
function change_rec(form){
	document.frmMsg.receiver.value = form.receiver.value;
}
function clr_form(){
	document.frMain.receiver.value = "";
	document.frMain.title.value = "";
	document.frMain.content.value = "";
	document.frmMsg.receiver.value = "";
	return false;
}
