<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C04"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	
		SELECT CASE Act
		CASE "formorder"
	
			DIM jfield, ordernum, nowOrder, resetlist
	
			jfield    = GetInputReplce(REQUEST.FORM("jfield"), "")
			ordernum  = GetInputReplce(REQUEST.FORM("ordernum"), "")
			resetlist = GetInputReplce(REQUEST.FORM("resetlist"), "")
	
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_READ] '" & jfield & "' ")
	
			nowOrder = RS("intOrder")
			
			IF INT(nowOrder) > INT(ordernum) THEN
				DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_UPDATE_ORDER] '" & jfield & "', '" & nowOrder & "', '" & ordernum & "', 'P' ")
			ELSE
				DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_UPDATE_ORDER] '" & jfield & "', '" & nowOrder & "', '" & ordernum & "', 'M' ")
			END IF
	
			IF resetlist = "yes" THEN
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_LIST]")
			
				DIM listClass
			
				WHILE NOT(RS.EOF)
					IF RS("bitUse") = False THEN
						listClass = "point3"
					ELSE
						IF RS("strDefault") = "0" THEN listClass = "point1" ELSE listClass = "point2"
					END IF
			
					RESPONSE.WRITE "							<li id=""" & RS("strFieldName") & """ order=""" & RS("intOrder") & """ unselectable=""on"""
					IF jfield = RS("strFieldName") THEN RESPONSE.WRITE " class=""menu_container_selected"""
					RESPONSE.WRITE ">" & CHR(10)
					RESPONSE.WRITE "								<div unselectable=""on"" class=""" & listClass & """>" & CHR(10)
					RESPONSE.WRITE RS("strTitle")
					IF RS("strDefault") = "2" THEN RESPONSE.WRITE " [add]"
					RESPONSE.WRITE "</div>" & CHR(10)
					RESPONSE.WRITE "							</li>" & CHR(10)
			
				RS.MOVENEXT
				WEND
	
			END IF
	
		CASE "formreset"
		
			DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_UPDATE_ORDER] 'empty', '0', '0', 'R' ")
	
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_LIST]")
			
			WHILE NOT(RS.EOF)
				IF RS("bitUse") = False THEN
					listClass = "point3"
				ELSE
					IF RS("strDefault") = "0" THEN listClass = "point1" ELSE listClass = "point2"
				END IF
			
				RESPONSE.WRITE "							<li id=""" & RS("strFieldName") & """ order=""" & RS("intOrder") & """ unselectable=""on"""
				IF jfield = RS("strFieldName") THEN RESPONSE.WRITE " class=""menu_container_selected"""
				RESPONSE.WRITE ">" & CHR(10)
				RESPONSE.WRITE "								<div unselectable=""on"" class=""" & listClass & """>" & CHR(10)
				RESPONSE.WRITE RS("strTitle")
				IF RS("strDefault") = "2" THEN RESPONSE.WRITE " [add]"
				RESPONSE.WRITE "</div>" & CHR(10)
				RESPONSE.WRITE "							</li>" & CHR(10)
		
			RS.MOVENEXT
			WEND
	
		CASE "formmodify"
	
			DIM strFieldName, strTitle, strSubTitle, strFormType, bitUse, bitRquired, strAlertMsg, intWidth, strDescription
	
			WITH REQUEST
	
				strFieldName   = GetInputReplce(.FORM("strFieldName"), "")
				strTitle       = GetInputReplce(.FORM("strTitle"), "")
				strSubTitle    = GetInputReplce(.FORM("strSubTitle"), "")
				strFormType    = .FORM("strFormType")
				strFormData    = REPLACE(GetInputReplce(.FORM("strFormData"), ""), ",", "")
				bitUse         = GetInputReplce(.FORM("bitUse"), "")
				bitRquired     = GetInputReplce(.FORM("bitRquired"), "")
				strAlertMsg    = GetInputReplce(.FORM("strAlertMsg"), "")
				intWidth       = GetInputReplce(.FORM("intWidth"), "")
				strDescription = GetInputReplce(.FORM("strDescription"), "")
	
			END WITH
	
			IF intWidth = "" THEN intWidth = 0

			DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_UPDATE] '" & strFieldName & "', N'" & strTitle & "', N'" & strSubTitle & "', N'" & strAlertMsg & "', '" & bitUse & "', '" & bitRquired & "', '" & strFormType & "', N'" & strFormData & "', '" & intWidth & "', N'" & strDescription & "' ")
	
		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>