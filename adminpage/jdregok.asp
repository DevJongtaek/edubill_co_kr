<!--#include virtual="/db/db.asp" -->
<%
	checkid = request("val")
	gubun   = request("gubun")

	select case gubun
		case "1"	'ȸ������
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select isnull(count(idx),0) from tb_company where flag='1' and tcode = '"& checkid &"' "
			rs.Open sql, db, 1
			if rs(0)=0 then
				msg = checkid & " ȸ�����ڵ�� ��� ������ �ڵ��Դϴ�."
			else
				msg = checkid & " ȸ�����ڵ�� ����� �Ұ����� �ڵ��Դϴ�.\n�ٸ� ȸ�����ڵ带 ��� �ϼ���."
			end if
			rs.close
		case "2"	'������
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select isnull(count(idx),0) from tb_company where ((bidxsub = '"& left(session("Ausercode"),5) &"') or (idx = '"& left(session("Ausercode"),5) &"')) and tcode = '"& checkid &"' "
			rs.Open sql, db, 1
			if rs(0)=0 then
				msg = checkid & " �����ڵ�� ��� ������ �ڵ��Դϴ�."
			else
				msg = checkid & " �����ڵ�� ����� �Ұ����� �ڵ��Դϴ�.\n�ٸ� �����ڵ带 ��� �ϼ���."
			end if
			rs.close
		case "3"	'ü�������
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select isnull(count(idx),0) from tb_company where ((bidxsub = '"& left(session("Ausercode"),5) &"') or (idx = '"& left(session("Ausercode"),5) &"')) and tcode = '"& checkid &"' "
			rs.Open sql, db, 1
			if rs(0)=0 then
				msg = checkid & " ü�����ڵ�� ��� ������ �ڵ��Դϴ�."
			else
				msg = checkid & " ü�����ڵ�� ����� �Ұ����� �ڵ��Դϴ�.\n�ٸ� ü�����ڵ带 ��� �ϼ���."
			end if
			rs.close
		case "4"	'��ǰ���
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select count(idx) from tb_product where usercode = '"& session("Ausercode") &"' and pcode = '"& checkid &"' "
			rs.Open sql, db, 1
			if rs(0)=0 then
				msg = checkid & " ��ǰ�ڵ�� ��� ������ �ڵ��Դϴ�."
			else
				msg = checkid & " ��ǰ�ڵ�� ����� �Ұ����� �ڵ��Դϴ�.\n�ٸ� ��ǰ�ڵ带 ��� �ϼ���."
			end if
			rs.close
	end select

	response.write "<Script language=javascript>"
	response.write "	alert('" & msg & "');"
	response.write "</Script>"
%>