<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SUB fReload(fsmval)	'아이프레임에서 부모창 리로드
			response.write "<SCRIPT LANGUAGE=JavaScript>"
			response.write "	alert('"& fsmval &"');parent.location.reload();"
			response.write "</SCRIPT>"
			response.end
	End SUB
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	inkey   = request("cancleidx")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if inkey<>"" then
		arr_inkey   = split(inkey,",")
		arr_cnt     = ubound(arr_inkey)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		for i=0 to arr_cnt
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			imsi_inkey   = trim(arr_inkey(i))
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				a_imsi_inkey = split(imsi_inkey,"/")
				wdate        = a_imsi_inkey(0)
				tcode        = a_imsi_inkey(1)	'본사코드
				jtcode       = a_imsi_inkey(2)	'지사코드
				Aym          = a_imsi_inkey(3)	'청구년월
				Aymd         = a_imsi_inkey(4)
				hmoney	     = a_imsi_inkey(5)	'합계
				if imsi_inmoney="" then imsi_inmoney=0
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				'금액이 같은 미 입금 청구 건은 여러 건이고, 실제 입금 건은 1건인 경우, 
				'가장 오래된 월 1건만 입금 확인
				whereSQL = " where tcode = '"& tcode &"' and jtcode = '"& jtcode &"' and wdate = '"& wdate &"' "
				whereSQL = whereSQL & " and Aym >= '"& Aym &"' and Aym <= '"& Aym &"' and flag='1' "
				whereSQL2 = " where tcode = '"& tcode &"' and jtcode = '"& jtcode &"' and wdate = '"& wdate &"' "
				whereSQL2 = whereSQL2 & " and Aym >= '"& Aym &"' and Aym <= '"& Aym &"' and idate<>''  "
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
				SQL = sql & 	whereSQL2
				SQL = sql & " 	group by wdate,tcode,jtcode,Aym "
				SQL = sql & " 	) b "
				SQL = sql & " on a.wdate = b.wdate and a.tcode=b.tcode and a.Aym=b.Aym and a.jtcode=b.jtcode "
				SQL = sql & " where b.hmoney = "& hmoney &" "
'response.write sql
'response.end
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
					SQL = " update tAccountM set idate = '', imoney = 0 "
					SQL = SQL & " where seq in ( "& r_seq &" ) "
					db.Execute SQL

					SQL = " update tAccountM set idate = '', imoney = 0 "
					SQL = SQL & " where flag='0' and wdate = '"& wdate &"' and tcode='"& tcode &"' "
					SQL = SQL & " and jtcode = '"& jtcode &"' and Aym='"& Aym &"' "
					db.Execute SQL
				end if
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		next
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		db.close
		set db=nothing
		call fReload("성공적으로 수정 되었습니다.")
	else
		db.close
		set db=nothing
		call fReload("수정 건이 없습니다.")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>
