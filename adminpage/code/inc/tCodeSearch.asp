<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	tcode = request("tcode")
	if left(tcode,1) = "0" then tcode = mid(tcode,2)
	if left(tcode,1) = "0" then tcode = mid(tcode,2)
	scnt = tcode
	ecnt = 9999
	if scnt="" then scnt=0
	for i=scnt+1 to ecnt
		if i=scnt then 
			allCnt = i
		else
			allCnt = allCnt &","& i
		end if
	next
	if allCnt <> "" then
		allCntArr = split(allCnt,",")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset") '대분류
	SQL = "select tcode from tb_company where flag = '1' "
	SQL = SQL & " and tcode > '"& scnt &"' "
	SQL = SQL & " order by tcode asc "
	rs.Open sql, db, 1
	if not rs.eof then
		tcodeArr    = rs.GetRows
		tcodeArrint = ubound(tcodeArr,2)
	else
		tcodeArr    = ""
		tcodeArrint = ""
	end if
	rs.close
	set rs=nothing
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if tcodeArrint<>"" then
		for i=0 to tcodeArrint
			imsival = trim(tcodeArr(0,i))
			if i=0 then
				inCnt = imsival
			else
				inCnt = inCnt &","& imsival
			end if
		next
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if allCnt <> "" then
		for i=0 to ubound(allCntArr)
			imsival = trim(allCntArr(i))
			if instr(inCnt,imsival) = 0 then	'없음
				if i=0 then
					real_val = imsival
				else
					real_val = real_val &","& imsival
				end if
			end if
		next
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if real_val<>"" then real_valArr = split(real_val,",")
%>
<script>

	/////////////////////////////////////////////////////////////////////
	var selectobj  = parent.document.getElementById('ch_tcode2');
	while (selectobj.length > 0) selectobj.remove(0);	     //초기화
	/////////////////////////////////////////////////////////////////////
	var objOption   = parent.document.createElement('option');
	objOption.text  = "선택";
	objOption.value = "";
	selectobj.add(objOption);
	/////////////////////////////////////////////////////////////////////
	<%
	if real_val<>"" then
		for i=1 to ubound(real_valArr)
	%>
	////////////////////////////////////////////////////////////////////////////
			var objOption   = parent.document.createElement('option');
			objOption.text  = "<%=trim(real_valArr(i))%>";
			objOption.value = "<%=trim(real_valArr(i))%>";
			selectobj.add(objOption);
	////////////////////////////////////////////////////////////////////////////
	<%
		next
	end if
	%>
	/////////////////////////////////////////////////////////////////////
</script>
