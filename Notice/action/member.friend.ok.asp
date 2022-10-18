<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	IF INSTR(CONF_strSiteUrl, "http://" & REQUEST.ServerVariables("HTTP_HOST")) = 0 THEN

		RESPONSE.WRITE "ERROR"
		RESPONSE.End()

	ELSE

		DIM Act, tmpFor
		Act = GetInputReplce(REQUEST.QueryString("Act"), "")

		DIM intSeq, intMemberSrl, intGroupSrl, intFriendSrl, strMemo

		SELECT CASE LCASE(Act)
		CASE "friendlist"

			DIM iCount

			RESPONSE.WRITE "["

				intMemberSrl = GetInputReplce(REQUEST.FORM("member_srl"), "")

				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FRIENDS_LIST] 'L', '" & intMemberSrl & "', '', '', '' ")

				iCount = 0

				WHILE NOT(RS.EOF)

					iCount = iCount + 1
					IF iCount > 1 THEN RESPONSE.WRITE ","
			
					RESPONSE.WRITE "{""seq"":""" & RS("intSeq") & """, ""group_name"":""" & RS("strGroupName") & """, ""friend_srl"":""" & RS("intFriendSrl") & """, ""user_id"":""" & RS("strLoginID") & """, ""user_name"":""" & RS("strUserName") & """, ""nick_name"":""" & RS("strNickName") & """, ""email"":""" & RS("strEmail") & """, ""reg_date"":""" & RS("StrRegDate") & """}" & CHR(10)
			
				RS.MOVENEXT
				WEND

			RESPONSE.WRITE "]"

		CASE "friendadd", "friendmodify"

			intSeq       = GetInputReplce(REQUEST.FORM("seq"), "")
			intMemberSrl = GetInputReplce(REQUEST.FORM("member_srl"), "")
			intGroupSrl  = GetInputReplce(REQUEST.FORM("group_srl"), "")
			intFriendSrl = GetInputReplce(REQUEST.FORM("friend_srl"), "")
			strMemo      = GetInputReplce(REQUEST.FORM("friend_memo"), "")

			IF intGroupSrl  = "" THEN intGroupSrl  = "0"
			IF intMemberSrl = "" THEN intMemberSrl = SESSION("memberSeq")

			SELECT CASE LCASE(Act)
			CASE "friendadd"

				IF intMemberSrl = "" OR intFriendSrl = "" THEN
		
					RESPONSE.WRITE "ERROR01"
					RESPONSE.End()
		
				END IF
	
				IF INT(intMemberSrl) = INT(intFriendSrl) THEN
	
					RESPONSE.WRITE "ERROR01"
					RESPONSE.End()
	
				END IF
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FRIENDS_ADD] 'A', '" & intGroupSrl & "', '" & intMemberSrl & "', '" & intFriendSrl & "', N'" & strMemo & "' ")
				
				IF RS(0) = "0" THEN
					RESPONSE.WRITE "ERROR02"
					RESPONSE.End()
				END IF

			CASE "friendmodify"

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_FRIENDS_ADD] 'E', '" & intGroupSrl & "', '" & intMemberSrl & "', '" & intFriendSrl & "', N'" & strMemo & "', '" & intSeq & "' ")

			END SELECT

		CASE "friendgroup"

			intGroupSrl = GetInputReplce(REQUEST.QueryString("intGroupSrl"), "")

			FOR tmpFor = 1 TO REQUEST.FORM("seq").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_FRIENDS_ADD] 'M', '" & intGroupSrl & "', '', '', '', '" & REQUEST.FORM("seq")(tmpFor) & "' ")
				response.write "[ARTY30_SP_MEMBER_FRIENDS_ADD] 'M', '" & intGroupSrl & "', '', '', '', '" & REQUEST.FORM("seq")(tmpFor) & "' "

			NEXT

		CASE "friendremove"

			FOR tmpFor = 1 TO REQUEST.FORM("seq").COUNT

				DBCON.EXECUTE("[ARTY30_SP_MEMBER_FRIENDS_REMOVE] '" & REQUEST.FORM("seq")(tmpFor) & "', '" & SESSION("memberSeq") & "' ")

			NEXT

		END SELECT

	END IF
	
	SET RS = NOTHING : DBCON.CLOSE
%>