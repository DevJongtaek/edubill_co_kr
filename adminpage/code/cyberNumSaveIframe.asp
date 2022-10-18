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
	searchd = trim(request("searchd"))
	searche = trim(request("searche"))
	idx     = trim(request("fidx"))		'입금테이블키값
	tcode   = trim(request("ftcode"))	'회원사코드
	dep_amt = trim(request("dep_amt"))	'입금액
	tr_il   = trim(request("tr_il"))	'입금일자
	comflag = trim(request("comflag"))	'본사/지사 구분
	comidx  = trim(request("comidx"))	'본사/지사 내부키값
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
			if r_comflag="2" then	'지사일경우 본사코드와 지사코드 가져옴
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
			'금액이 같은 미 입금 청구 건은 여러 건이고, 실제 입금 건은 1건인 경우, 
			'가장 오래된 월 1건만 입금 확인
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
				'계산서테이블에 입금일자와 입금액 저장	flag=1인거 , iflag = 'y' 입금내역에서 저장구분
				SQL = " update tAccountM set idate = '"& r_tr_il &"', imoney = "& r_dep_amt &", iflag = 'y' "
				SQL = SQL & " where seq = "& r_seq
				db.Execute SQL
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				'계산서테이블에 입금일자와 입금액 저장	flag=0인거
				SQL = " update tAccountM set idate = '"& r_tr_il &"', imoney = "& r_dep_amt &", iflag = 'y' "
				SQL = SQL & " where flag='0' and wdate = '"& r_wdate &"' and tcode = '"& r_tcode &"' "
				SQL = SQL & " and jtcode = '"& r_jtcode &"' and Aym = '"& r_Aym &"' "
				db.Execute SQL
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				'입금네역테이블에 입금확인 시키기
				SQL = " update tb_virtual_acnt set taxReg = 'y' "
				SQL = SQL & " where idx = "& r_idx
				db.Execute SQL
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				upCnt = upCnt+1
			else
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				'입금네역테이블에 입금액오류 시키기
				SQL = " update tb_virtual_acnt set taxReg = 'i' "
				SQL = SQL & " where idx = "& r_idx
				db.Execute SQL
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			end if
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		next
		db.close
		set db=nothing
		call fReload(upCnt & "건이 입금확인 되었습니다.")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		db.close
		set db=nothing
		call fReload("입금확인 건이 없습니다.")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>
