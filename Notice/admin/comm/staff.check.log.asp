<%
	isStaffCheck = False

	IF SESSION("memberSeq") = "" THEN
		isStaffCheck = False
	ELSE
		SELECT CASE SESSION("staff")
		CASE "N"
			isStaffCheck = False
		CASE "S"
			IF menuID = "" THEN
				isStaffCheck = True
			ELSE
				SET RS = DBCON.EXECUTE("[ARTY30_SP_STAFF_MENU_CHECK] '" & SESSION("memberSeq") & "', '" & menuID & "' ")
				IF NOT(RS.EOF) THEN isStaffCheck = True
			END IF
		CASE "A"
			isStaffCheck = True
		END SELECT
	END IF

	IF isStaffCheck = True THEN
		IF isStaffAddLog = True THEN
			IF menuID <> "" THEN  DBCON.EXECUTE("[ARTY30_SP_STAFF_LOG_ADD] '" & SESSION("memberSeq") & "', '" & menuID & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "' ")
		END IF
	END IF
%>