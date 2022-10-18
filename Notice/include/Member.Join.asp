<!-- #include file = "Member.Default.asp" -->
<%
	IF CONF_bitDispAgree = True THEN
		IF REQUEST.FORM("checkMemberAgree") = "" OR REQUEST.FORM("checkMemberType") = "" THEN
			RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_access_page"), "url", "/")
			RESPONSE.End()
		END IF

		REQ_checkMemberType      = REQUEST.FORM("checkMemberType")
		REQ_checkMemberAgree     = REQUEST.FORM("checkMemberAgree")
		REQ_checkMemberSsn       = REQUEST.FORM("checkMemberSsn")
		REQ_checkMemberSsnData1  = REQUEST.FORM("checkMemberSsnData1")
		REQ_checkMemberSsnData2  = REQUEST.FORM("checkMemberSsnData2")
		REQ_checkMemberAuth      = REQUEST.FORM("checkMemberAuth")
		REQ_checkMemberAuthEmail = REQUEST.FORM("checkMemberAuthEmail")

	ELSE

		REQ_checkMemberType      = "D"

	END IF

	DIM CONF_strMemberDocument1, CONF_strMemberDocument2

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_READ] 'R', '', 'D001' ")
	CONF_strMemberDocument1 = RS("strContent")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_READ] 'R', '', 'D002' ")
	CONF_strMemberDocument2 = RS("strContent")
	
	IF CONF_bitUseNameCheck = True THEN
		IF REQUEST.FORM("checkMemberSsn") = "" THEN
			RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_access_page"), "url", "/")
			RESPONSE.End()
		END IF
	END IF
	
	IF CONF_bitUseCertified = True AND CONF_bitUseEmailCheck = True THEN
		IF REQUEST.FORM("checkMemberAuth") = "" THEN
			RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_access_page"), "url", "/")
			RESPONSE.End()
		END IF
	END IF

	DIM strEditorLangFile
	strEditorLangFile = Server.MapPath(".") & "\daum\lang\lang." & GetEditorUtfCode(CONF_strSkinLang) & ".xml"
%>
<!-- #include file = "../include/Member.Form.asp" -->
<script type="text/javascript">

	jQuery(function($){

		$.memberJoinComplate = function(){

			var strJoinAct_ = "<%=CONF_strJoinAct%>";
			var strJoinActMsg_ = "<%=CONF_strJoinActMsg%>";
			var strJoinActUrl_ = "<%=CONF_strJoinActUrl%>";

			function memberJoinComplateScript(){
				<%=CONF_strJoinActScript%>
			}

			switch (strJoinAct_){
				case "0" :
					if (strJoinActMsg_!= "")
						alert(strJoinActMsg_);
					document.location.href = strJoinActUrl_;
					return false;
					break;
				case "1" : memberJoinComplateScript(); break;
				case "2" :
					$("#userid", "#resultForm").val($("#strLoginID", "#theForm").val());
					$("#resultForm").attr("action", "?act=member&subAct=joinresult");
					$("#resultForm").submit();
					break;
			}

		}
	});

</script>
<%
	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="extForm">
<input type="hidden" id="checkMemberType" name="checkMemberType" value="<%=REQ_checkMemberType%>" />
<input type="hidden" id="checkMemberAgree" name="checkMemberAgree" value="<%=REQ_checkMemberAgree%>" />
<input type="hidden" id="checkMemberSsn" name="checkMemberSsn" value="<%=REQ_checkMemberSsn%>" />
<input type="hidden" id="checkMemberSsnData1" name="checkMemberSsnData1" value="<%=REQ_checkMemberSsnData1%>" />
<input type="hidden" id="checkMemberSsnData2" name="checkMemberSsnData2" value="<%=REQ_checkMemberSsnData2%>" />
<input type="hidden" id="checkMemberAuth" name="checkMemberAuth" value="<%=REQ_checkMemberAuth%>" />
<input type="hidden" id="checkMemberAuthEmail" name="checkMemberAuthEmail" value="<%=REQ_checkMemberAuthEmail%>" />
</form>
<form id="resultForm" method="post">
<input type="hidden" id="userid" name="userid" />
<input type="hidden" id="userpwd" name="userpwd" />
</form>
<script type="text/javascript">

	var set_editor = {
		config: {
			path : '/<%=REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")%>',
			pdspath : '<%=CONF_strFilePath%>',
			imagepath : 'member/sign/',
			filepath : 'member/sign/',
			boardsrl : '',
			editorMode : 'member',
			usefile : false,
			useimage : true,
			iconpath : '<%=GetEditorUtfCode(CONF_strSkinLang)%>'
		}
	};
</script>
<link rel="stylesheet" href="daum/css/editor_<%=GetEditorUtfCode(CONF_strSkinLang)%>.css" type="text/css" charset="utf-8"/>
<script src="daum/js/editor_<%=GetEditorUtfCode(CONF_strSkinLang)%>.js" type="text/javascript" charset="utf-8"></script>
<script src="daum/js/editor_config.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="js/Calendar.js"></script>
<script type="text/javascript" src="js/jquery.zip.js"></script>