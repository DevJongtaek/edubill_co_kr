<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"
	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C10"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	
		SELECT CASE Act
	
		CASE "mailingetcadd", "mailingetcedit"

			DIM intSeq, strName, strEmail, strCompany, strPostion, strClass, strTel, strMobile, strFax, strPost, strAddr1, strAddr2
			DIM strMemo, bitSend
	
			WITH REQUEST

				intSeq     = GetInputReplce(.FORM("intSeq"), "")
				strName    = GetInputReplce(.FORM("strName"), "")
				strEmail   = GetInputReplce(.FORM("strEmail"), "")
				strCompany = GetInputReplce(.FORM("strCompany"), "")
				strPostion = GetInputReplce(.FORM("strPostion"), "")
				strClass   = GetInputReplce(.FORM("strClass"), "")
				strTel     = GetInputReplce(.FORM("strTel"), "")
				strMobile  = GetInputReplce(.FORM("strMobile"), "")
				strFax     = GetInputReplce(.FORM("strFax"), "")
				strPost    = REPLACE(GetInputReplce(.FORM("strAddr3"), ""), "-", "")
				strAddr1   = GetInputReplce(.FORM("strAddr4"), "")
				strAddr2   = GetInputReplce(.FORM("strAddr5"), "")
				strMemo    = GetInputReplce(.FORM("strMemo"), "")
				bitSend    = GetInputReplce(.FORM("bitSend"), "")
	
			END WITH
	
			SELECT CASE Act
			CASE "mailingetcadd"
	
				DBCON.EXECUTE("[ARTY30_SP_MAILING_ETC_ADD] 'W', '" & intSeq & "', N'" & strName & "', N'" & strEmail & "', N'" & strCompany & "', N'" & strPostion & "', N'" & strClass & "', N'" & strTel & "', N'" & strMobile & "', N'" & strFax & "', '" & strPost & "', N'" & strAddr1 & "', N'" & strAddr2 & "', N'" & strMemo & "', '" & bitSend & "' ")
	
				RESPONSE.WRITE "SW"
	
			CASE "mailingetcedit"
	
				DBCON.EXECUTE("[ARTY30_SP_MAILING_ETC_ADD] 'E', '" & intSeq & "', N'" & strName & "', N'" & strEmail & "', N'" & strCompany & "', N'" & strPostion & "', N'" & strClass & "', N'" & strTel & "', N'" & strMobile & "', N'" & strFax & "', '" & strPost & "', N'" & strAddr1 & "', N'" & strAddr2 & "', N'" & strMemo & "', '" & bitSend & "' ")
	
				RESPONSE.WRITE "SE"
	
			END SELECT

		CASE "mailingetcremove"

			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MAILING_ETC_REMOVE] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")

			NEXT

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>