﻿<%
	LIST_iCount         = List_iCount + 1
	LIST_intNumber      = INT(CONF_intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - LIST_iCount + 1
	LIST_intSeq         = AdRs_List(0, tmpFor)

	IF strMessageType = "R" THEN
		LIST_intMemberSrl = AdRs_List(1, tmpFor)
		LIST_strNickName  = AdRs_List(2, tmpFor)
	ELSE
		LIST_intMemberSrl = AdRs_List(3, tmpFor)
		LIST_strNickName  = AdRs_List(4, tmpFor)
	END IF

	LIST_strMessageType = AdRs_List(5, tmpFor)
	LIST_strTitle       = AdRs_List(6, tmpFor)
	LIST_strContent     = AdRs_List(7, tmpFor)
	LIST_bitReaded      = AdRs_List(8, tmpFor)
	LIST_strReadedDate  = AdRs_List(9, tmpFor)
	LIST_strRegDate     = AdRs_List(10, tmpFor)
%>