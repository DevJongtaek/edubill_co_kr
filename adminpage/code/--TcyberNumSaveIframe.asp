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
	inkey   = request("inkey")
	inymd   = request("inymd")
	inmoney = request("inmoney")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if inkey<>"" then
		arr_inkey   = split(inkey,",")
		arr_inymd   = split(inymd,",")
		arr_inmoney = split(inmoney,",")
		arr_cnt     = ubound(arr_inkey)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		for i=0 to arr_cnt
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			imsi_inkey   = trim(arr_inkey(i))
			imsi_inymd   = trim(arr_inymd(i))
			imsi_inmoney = trim(arr_inmoney(i))
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			if imsi_inymd<>"" and imsi_inmoney<>"" then
				a_imsi_inkey = split(imsi_inkey,"/")
				wdate        = a_imsi_inkey(0)
				tcode        = a_imsi_inkey(1)	'�����ڵ�
				jtcode       = a_imsi_inkey(2)	'�����ڵ�
				Aym          = a_imsi_inkey(3)	'û�����
				Aymd         = a_imsi_inkey(4)
				hmoney	     = a_imsi_inkey(5)	'�հ�
				if imsi_inmoney="" then imsi_inmoney=0
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				'�ݾ��� ���� �� �Ա� û�� ���� ���� ���̰�, ���� �Ա� ���� 1���� ���, 
				'���� ������ �� 1�Ǹ� �Ա� Ȯ��
				whereSQL = " where tcode = '"& tcode &"' and jtcode = '"& jtcode &"' "
				whereSQL = whereSQL & " and Aym >= '"& Aym &"' and Aym <= '"& Aym &"' "
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				set rs = server.CreateObject("ADODB.Recordset")
				SQL = " select a.seq,b.* "
				SQL = sql & " from "
				SQL = sql & " 	(select * "
				SQL = sql & " 	from tAccountM "
				SQL = sql & 	whereSQL
				SQL = sql & " 	) a "
				SQL = sql & " left outer join "
				SQL = sql & " 	(select wdate,tcode,jtcode,Aym,sum(hmoney) as hmoney  "
				SQL = sql & " 	from tAccountM  "
				SQL = sql & 	whereSQL
				SQL = sql & " 	group by wdate,tcode,jtcode,Aym "
				SQL = sql & " 	) b "
				SQL = sql & " on a.wdate = b.wdate and a.tcode=b.tcode and a.Aym=b.Aym and a.jtcode=b.jtcode "
				SQL = sql & " where b.hmoney = "& hmoney &" "
				rs.Open sql, db, 1
				if not rs.eof then
					p=1
					do until rs.eof
						if p=1 then
							r_seq = rs(0)
						else
							r_seq = r_seq &","& rs(0)
						end if
					rs.movenext
					p=p+1
					loop
				else
					r_seq = ""
				end if
				rs.close
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				if r_seq<>"" then
					SQL = " update tAccountM set idate = '"& imsi_inymd &"', imoney = "& imsi_inmoney &" "
					SQL = SQL & " where seq in ( "& r_seq &" ) "
					db.Execute SQL
				end if
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			end if
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		next
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		db.close
		set db=nothing
		call fReload("���������� ���� �Ǿ����ϴ�.")
	else
		db.close
		set db=nothing
		call fReload("���� ���� �����ϴ�.")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>
