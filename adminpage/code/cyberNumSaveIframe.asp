<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SUB fReload(fsmval)	'���������ӿ��� �θ�â ���ε�
			response.write "<SCRIPT LANGUAGE=JavaScript>"
			response.write "	alert('"& fsmval &"');parent.location.reload();"
			response.write "</SCRIPT>"
			response.end
	End SUB
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	searchd = trim(request("searchd"))
	searche = trim(request("searche"))
	idx     = trim(request("fidx"))		'�Ա����̺�Ű��
	tcode   = trim(request("ftcode"))	'ȸ�����ڵ�
	dep_amt = trim(request("dep_amt"))	'�Աݾ�
	tr_il   = trim(request("tr_il"))	'�Ա�����
	comflag = trim(request("comflag"))	'����/���� ����
	comidx  = trim(request("comidx"))	'����/���� ����Ű��
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if idx<>"" then
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		arr_idx     = split(idx,",")
		arr_tcode   = split(tcode,",")
		arr_dep_amt = split(dep_amt,",")
		arr_tr_il   = split(tr_il,",")
		arr_comflag = split(comflag,",")
		arr_comidx  = split(comidx,",")
		arr_idx_int = ubound(arr_idx)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		upCnt    = 0
		for i=0 to arr_idx_int
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			r_idx     = trim(arr_idx(i))
			r_tcode   = trim(arr_tcode(i))
			r_dep_amt = trim(arr_dep_amt(i))
			r_tr_il   = trim(arr_tr_il(i))
			r_comflag = trim(arr_comflag(i))
			r_comidx  = trim(arr_comidx(i))
			if r_tr_il="" or isnull(r_tr_il) then r_tr_il=0
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			if r_comflag="2" then	'�����ϰ�� �����ڵ�� �����ڵ� ������
				set rs = server.CreateObject("ADODB.Recordset")
				SQL = " select b.tcode, a.tcode as jtcode "
				SQL = sql & " from "
				SQL = sql & " 	(select bidxsub,tcode from tb_company where idx = "& r_comidx &" and flag='2') a "
				SQL = sql & " left outer join "
				SQL = sql & " 	(select idx,tcode from tb_company where flag = '1') b "
				SQL = sql & " on a.bidxsub = b.idx "
				rs.Open sql, db, 1
				r_tcode  = rs(0)
				r_jtcode = rs(1)
				rs.close
			else
				r_jtcode = ""
			end if
			'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			'�ݾ��� ���� �� �Ա� û�� ���� ���� ���̰�, ���� �Ա� ���� 1���� ���, 
			'���� ������ �� 1�Ǹ� �Ա� Ȯ��
			whereSQL  = " where tcode = '"& r_tcode &"' and jtcode = '"& r_jtcode &"' "
			whereSQL  = whereSQL & " and Aym >= '"& mid(searchd,1,6) &"' and Aym <= '"& mid(searche,1,6) &"' and flag='1' and idate='' "
			whereSQL2 = " where tcode = '"& r_tcode &"' and jtcode = '"& r_jtcode &"' "
			whereSQL2 = whereSQL2 & " and Aym >= '"& mid(searchd,1,6) &"' and Aym <= '"& mid(searche,1,6) &"' and idate='' "
			'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select top 1 aa.* "
			SQL = sql & " from ( "
			SQL = sql & " select a.seq, b.wdate, b.tcode, b.jtcode, b.Aym, "
			SQL = sql & " (case when c.accountflag = 'y' then b.hmoney Else case when c.accountflag = 'n' then b.kmoney End End) as imsimoney "
			SQL = sql & " from "
			SQL = sql & " 	(select * "
			SQL = sql & " 	from tAccountM "
			SQL = sql & 	whereSQL
			SQL = sql & " 	) a "
			SQL = sql & " left outer join "
			SQL = sql & " 	(select wdate,tcode,jtcode,Aym,sum(hmoney) as hmoney, sum(kmoney) as kmoney  "
			SQL = sql & " 	from tAccountM  "
			SQL = sql & 	whereSQL2
			SQL = sql & " 	group by wdate,tcode,jtcode,Aym "
			SQL = sql & " 	) b "
			SQL = sql & " on a.wdate = b.wdate and a.tcode=b.tcode and a.Aym=b.Aym and a.jtcode=b.jtcode "
			sql = sql & " 	left outer join  "
			sql = sql & " 	( select accountflag,tcode from tb_company where flag='1' ) c "
			sql = sql & " 	on a.tcode = c.tcode "
			sql = sql & ") aa "
			SQL = sql & " where aa.imsimoney = "& r_dep_amt &" "
			SQL = sql & " order by aa.Aym asc "
'response.write sql
'response.end
			rs.Open sql, db, 1
			if not rs.eof then
				r_seq   = rs(0)
				r_wdate = rs(1)
				r_Aym   = rs(4)
			else
				r_seq = ""
			end if
			rs.close
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			if r_seq <> "" then
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				'��꼭���̺� �Ա����ڿ� �Աݾ� ����	flag=1�ΰ� , iflag = 'y' �Աݳ������� ���屸��
				SQL = " update tAccountM set idate = '"& r_tr_il &"', imoney = "& r_dep_amt &", iflag = 'y' "
				SQL = SQL & " where seq = "& r_seq
				db.Execute SQL
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				'��꼭���̺� �Ա����ڿ� �Աݾ� ����	flag=0�ΰ�
				SQL = " update tAccountM set idate = '"& r_tr_il &"', imoney = "& r_dep_amt &", iflag = 'y' "
				SQL = SQL & " where flag='0' and wdate = '"& r_wdate &"' and tcode = '"& r_tcode &"' "
				SQL = SQL & " and jtcode = '"& r_jtcode &"' and Aym = '"& r_Aym &"' "
				db.Execute SQL
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				'�Աݳ׿����̺� �Ա�Ȯ�� ��Ű��
				SQL = " update tb_virtual_acnt set taxReg = 'y' "
				SQL = SQL & " where idx = "& r_idx
				db.Execute SQL
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				upCnt = upCnt+1
			else
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				'�Աݳ׿����̺� �Աݾ׿��� ��Ű��
				SQL = " update tb_virtual_acnt set taxReg = 'i' "
				SQL = SQL & " where idx = "& r_idx
				db.Execute SQL
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			end if
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		next
		db.close
		set db=nothing
		call fReload(upCnt & "���� �Ա�Ȯ�� �Ǿ����ϴ�.")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		db.close
		set db=nothing
		call fReload("�Ա�Ȯ�� ���� �����ϴ�.")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>
