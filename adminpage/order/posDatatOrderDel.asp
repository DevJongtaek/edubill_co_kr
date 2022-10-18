<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/fun.asp"-->
<!--#include virtual="/db/db.asp"-->
<%

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	ymd1   = request("ymd1")
	ymd2   = request("ymd2")
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'if ymd1-ymd2=0 then
		sql = "delete PosData_order where OD_DATE >= '"& ymd1 &"' and OD_DATE <= '"& ymd2 &"' "
		db.execute sql
		db.close
		call FunSucMsg("임시테이블 데이타 삭제가 성공적으로 이루어 졌습니다.","posDatatOrder.asp")
	'else
	'	call FunErrorMsg("1일 데이타만 삭제 가능합니다.")
	'end if
%>