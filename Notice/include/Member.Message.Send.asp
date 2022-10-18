<!-- #include file = "Member.Default.asp" -->
<%
	DIM intMemberSrl, bitMailing, strNickName
	intMemberSrl = GetInputReplce(REQUEST.QueryString("member_srl"), "")

	IF SESSION("memberSeq") = "" THEN

		RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_session_error"), "close", "")
		RESPONSE.End()

	END IF

	DIM SEND_intMemberSrl, SEND_strNickName, SEND_bitMailing, SEND_intMemberCount, SEND_intReceiveCount

	SEND_intMemberCount  = 0
	SEND_intReceiveCount = 0

	FOR EACH tmp_intMemberSrl IN SPLIT(intMemberSrl, ",")

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & tmp_intMemberSrl & "' ")

		IF NOT(RS.EOF) THEN

			SEND_intMemberCount = SEND_intMemberCount + 1

			IF RS("bitMemo") = True THEN

				SEND_intReceiveCount = SEND_intReceiveCount + 1

				IF SEND_intMemberSrl <> "" THEN

					SEND_intMemberSrl = SEND_intMemberSrl & ","
					SEND_strNickName  = SEND_strNickName & ","
					SEND_bitMailing   = SEND_bitMailing & ","

				END IF

				SEND_intMemberSrl = SEND_intMemberSrl & tmp_intMemberSrl
				SEND_strNickName  = SEND_strNickName & RS("strNickName")
				SEND_bitMailing   = SEND_bitMailing & GetBitTypeNumberChg(RS("bitMailing"))

			END IF

		END IF		

	NEXT

	IF intMemberSrl <> "" THEN

		IF SEND_intMemberCount = 0 THEN
	
			RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_membership"), "close", "")
			RESPONSE.End()
	
		END IF
	
		IF SEND_intReceiveCount = 0 THEN
	
			RESPONSE.WRITE ActJsAlertMsg(objXmlLang("msg_not_message"), "close", "")
			RESPONSE.End()
	
		END IF

	END IF

	DIM strEditorLangFile
	strEditorLangFile = Server.MapPath("./") & "\daum\lang\lang." & GetEditorUtfCode(CONF_strLangType) & ".xml"
%>
<link rel="stylesheet" href="daum/css/editor_<%=GetEditorUtfCode(CONF_strLangType)%>.css" type="text/css"  charset="utf-8"/>
<script src="daum/js/editor_<%=GetEditorUtfCode(CONF_strLangType)%>.js" type="text/javascript" charset="utf-8"></script>
<script src="daum/js/editor_config.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

	var set_editor = {
		config: {
			path : '/<%=REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")%>',
			pdspath : '<%=CONF_strFilePath%>',
			imagepath : 'site/page/',
			filepath : 'site/page/',
			boardsrl : '',
			editorMode : 'site',
			usefile : false,
			useimage : false
		}
	};

	window.onload = function() {

		new Editor({
			txHost: '',
			txPath: set_editor.config.path + 'daum/',
			txVersion: '5.4.0',
			txService: 'sample',
			txProject: 'sample',
			initializedId: "",
			wrapper: "tx_trex_container"+"",
			form: 'theForm'+"",
			txIconPath: set_editor.config.path + "daum/images/icon/<%=CONF_strLangType%>/",
			txDecoPath: set_editor.config.path + "daum/images/deco/",
			canvas: {
				styles: {color: "#666666", fontFamily: "gulim", fontSize: "12px", backgroundColor: "#fff", lineHeight: "1.5", padding: "8px"}
			},
			sidebar: {
				attachbox: {show:false},
				attacher: {
					image: {
						objattr: {width: set_editor.config.imagewidth}
					},
					file: {}
				}
			}
		})

		$(".tx-canvas iframe").css("height", "250px");

		if (set_editor.config.usefile == false){
			$("#editor_file_upload").hide();
		}

		if (set_editor.config.useimage == false){
			$("#editor_image_upload").hide();
		}

		loadContent();

	};

	function loadContent() {

		var attachments = {};

		Editor.modify({
			"attachments": function() {
				var allattachments = [];
				for(var i in attachments) {
					allattachments = allattachments.concat(attachments[i]);
				}
				return allattachments;
			}(),
			"content": $tx("strContent")
		});
	}

</script>
<form id="extForm" name="extForm" method="post">
<input type="hidden" id="intSenderSrl" name="intSenderSrl" value="<%=SESSION("memberSeq")%>" />
<input type="hidden" id="intReceiverSrl" name="intReceiverSrl" value="<%=SEND_intMemberSrl%>" />
<input type="hidden" id="strNickName" name="strNickName" />
<input type="hidden" id="bitSendMail" name="bitSendMail" />
<input type="hidden" id="bitMailing" name="bitMailing" value="<%=SEND_bitMailing%>" />
<input type="hidden" id="strTitle" name="strTitle" />
<textarea id="strContent" name="strContent" style="display:none;"><%=strContent%></textarea>
</form>