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
		alert("�ּҷϿ� �Էµ� ����� �����ϴ�.\r\n"
				+"�ּҷ��� ���� �ۼ��� �ֽʽÿ�");

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
		alert("������ �̸�/�׷������ ��� �ϳ��̻�\r\n"
				+ "�����Ͻ� �� �߰��ϼž� �մϴ�");	
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
			sel_count++; //���õ� option�� ����
			sel_index = i; //���õ� index��ȣ
		}
	}
	if(sel_count > 1){
		alert('�����Ͻ÷��� �ϳ��� �����Ͻʽÿ�');
		return false;
	}
	else if(sel_count == 0){
		alert('�����Ͻð��� �ϴ� �������� �����Ͻʽÿ�');
		return false;
	}
	else if(sel_count == 1){
		//���õ� ���� �׷��� ���
		if(document.frmMsg.ele_count.value < sel_index+1){
			var len_str;
			var my_gpkey;
			len_str = document.frmMsg.address.options[document.frmMsg.address.selectedIndex].value.length;
			my_gpkey = document.frmMsg.address.options[document.frmMsg.address.selectedIndex].value.substring(1,len_str);
			my_url = "Edit_Group.asp?gpkey=" + my_gpkey + "&from=addr_setting&times=first";
			open(my_url, "_new",'toolbar=no,directories=no,scrollbars=1,resizable=1,status=no,menubar=0,width=350,height=420');
		}
		//���õ� ���� ������ ���
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
		alert("��������� �Է��Ͻʽÿ�");
		document.frMain.receiver.focus();
		return false;
	}
	else if(mycount > 40){
		alert('������ �ʹ� ��ϴ�. �ѱ� 20�� �̳� ���� 40�� �̳��� ���ֽʽÿ�');
		document.frMain.title.focus();
		return false;
	}
	else if(document.frMain.content.value.length == 0){
		alert("������ �Է��Ͻʽÿ�");
		document.frMain.content.focus();
		return false;
	}
	else if(!document.frMain.email.checked && !document.frMain.mmail.checked){
		alert("Mmail Ȥ�� Email �� ��� �ϳ��� �����Ͻʽÿ�");
		document.frMain.email.focus();
		return false;
	}
	else if(document.frMain.recall1.value.length<2 ||document.frMain.recall2.value.length<2 ||document.frMain.recall3.value.length !=4){
		alert("ȸ�Ź�ȣ�� �Է��� �ּ���.");
		document.frMain.recall1.focus();
		return false;
	}

	else if(document.frMain.ResOrNot[1].checked && 
		(document.frMain.date.value.length!=8 || document.frMain.time.value.length!=4)){
		alert("����ð��� ��ȿ���� �ʽ��ϴ�.");
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
