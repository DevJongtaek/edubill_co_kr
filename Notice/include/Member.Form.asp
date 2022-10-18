<%
	DIM info
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_LIST] 'R' ")

	CLASS memberDispClass

		DIM fieldName(35), title(35), subtitle(35), alertMsg(35), default(35), use(35), rquired(35), formType(35), formData(35)
		DIM width(35), dataValue(100), memo(35)

	END CLASS

	SET info = New memberDispClass

	tmpFor = 0

	WHILE NOT(RS.EOF)

		IF RS("bitCorp") = True THEN

			IF REQUEST.FORM("checkMemberType") = "C" OR REQUEST.FORM("strMemberType") = "C" THEN

				info.fieldName(tmpFor) = RS("strFieldName")
				info.title(tmpFor)     = RS("strTitle")
				info.subtitle(tmpFor)  = RS("strSubTitle")
				info.alertMsg(tmpFor)  = RS("strAlertMsg")
				info.default(tmpFor)   = RS("strDefault")
				info.rquired(tmpFor)   = RS("bitRquired")
				info.formType(tmpFor)  = RS("strFormType")
				info.formData(tmpFor)  = RS("strFormData")
				info.width(tmpFor)     = RS("intWidth")
				info.memo(tmpFor)      = RS("strDescription")

				tmpFor = tmpFor + 1

			END IF

		ELSE

			info.fieldName(tmpFor) = RS("strFieldName")
			info.title(tmpFor)     = RS("strTitle")
			info.subtitle(tmpFor)  = RS("strSubTitle")
			info.alertMsg(tmpFor)  = RS("strAlertMsg")
			info.default(tmpFor)   = RS("strDefault")
			info.rquired(tmpFor)   = RS("bitRquired")
			info.formType(tmpFor)  = RS("strFormType")
			info.formData(tmpFor)  = RS("strFormData")
			info.width(tmpFor)     = RS("intWidth")
			info.memo(tmpFor)      = RS("strDescription")
	
			tmpFor = tmpFor + 1

		END IF

	RS.MOVENEXT
	WEND

	DIM iCount
	iCount = 0
%>
<script type="text/javascript">

		var arrMemberForm = {
			options:[
<%
	FOR tmpFor = 0 TO UBOUND(info.fieldName)
		IF info.fieldName(tmpFor) <> "" THEN
			IF iCount > 0 THEN RESPONSE.WRITE ","
			RESPONSE.WRITE CHR(10)
			RESPONSE.WRITE "{field:""" & info.fieldName(tmpFor) & """, fieldtype:""" & info.default(tmpFor) & """, title:""" & info.title(tmpFor) & """, message:""" & info.alertMsg(tmpFor) & """, rquired:""" & info.rquired(tmpFor) & """, formtype:""" & info.formType(tmpFor) & """}"
			iCount = iCount + 1
		END IF
	NEXT
%>
			]
		};

</script>