<%
	IF SESSION("memberSeq") = "" THEN

		IF isPopup = True THEN
%>
	<script type="text/javascript">

		$(opener.document).find("#theForm").attr("action", "?act=login&strPrevUrl=" + $(opener.document).find("#theForm").attr("action")).submit();

	</script>
<%
			RESPONSE.End()
		ELSE

			RESPONSE.REDIRECT "?act=login&strPrevUrl=" & REPLACE(LCASE(Request.ServerVariables("url")), "default.asp", "") & "?" & Replace(Request.ServerVariables("QUERY_STRING"), "&", "--**--" )

		END IF

		RESPONSE.End()

	ELSE

		SELECT CASE SESSION("staff")
		CASE "N"

			IF isPopup = True THEN

				RESPONSE.WRITE ActWinJsScript("?act=login&strPrevUrl=" & REPLACE(LCASE(Request.ServerVariables("url")), "default.asp", "") & "?" & Replace(Request.ServerVariables("QUERY_STRING"), "&", "--**--" ))

			ELSE

				RESPONSE.REDIRECT "?act=login&strPrevUrl=" & REPLACE(LCASE(Request.ServerVariables("url")), "default.asp", "") & "?" & Replace(Request.ServerVariables("QUERY_STRING"), "&", "--**--" )

			END IF

			RESPONSE.End()

		CASE "S"

			IF menuID <> "" AND menuID <> "000" THEN

				SET RS = DBCON.EXECUTE("[ARTY30_SP_STAFF_MENU_CHECK] '" & SESSION("memberSeq") & "', '" & menuID & "' ")

				IF RS(0) = 0 THEN

					RESPONSE.WRITE ActJsAlertMsg("접근 권한이 없습니다.", "", "")
					RESPONSE.End()

				END IF

			END IF

		END SELECT

	END IF
%>