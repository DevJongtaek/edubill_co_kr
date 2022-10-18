<!-- #include file = "Board.Default.asp" -->
<!-- #include file = "../libs/md5.asp" -->
<%
	DIM CONF_intUploadedFileCount, CONF_intUploadedFileSize

	SELECT CASE LCASE(subAct)
	CASE "write"

		IF CONF_strWriteLevel = False THEN
			IF REQ_intSeq = "" THEN
				RESPONSE.REDIRECT GetBoardAuthScript(CONF_strWriteLevelUrl, CONF_strWriteLevelLogin, "", "", "", "list", "msg_not_permitted")
			ELSE
				RESPONSE.REDIRECT GetBoardAuthScript(CONF_strWriteLevelUrl, CONF_strWriteLevelLogin, REQ_intSeq, "", "", "view", "msg_not_permitted")
			END IF
			RESPONSE.End()
		END IF

		IF CONF_bitUsePoint = True AND CONF_intWritePoint <> 0 THEN
			IF SESSION("memberSeq") = "" THEN
				IF CONF_intWritePoint < 0 THEN
					IF REQ_intSeq = "" THEN
						RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "list", "msg_disallow_by_point")
					ELSE
						RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "view", "msg_disallow_by_point")
					END IF
					RESPONSE.End()
				END IF
			ELSE
				IF CONF_intWritePoint < 0 THEN
					SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & SESSION("memberSeq") & "' ")
					IF INT(RS("intPoint")) - (CONF_intWritePoint * -1) < 0 THEN
						IF REQ_intSeq = "" THEN
							RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "list", "msg_disallow_by_point")
						ELSE
							RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "view", "msg_disallow_by_point")
						END IF
						RESPONSE.End()
					END IF
				END IF
			END IF
		END IF

		WRITE_intMemberSrl = SESSION("memberSeq")
		WRITE_strUserID    = SESSION("userID")
		WRITE_strUserName  = SESSION("userName")
		WRITE_strNickName  = SESSION("nickName")

		IF SESSION("memberSeq") <> "" THEN

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & SESSION("memberSeq") & "' ")

			WRITE_strEmail        = RS("strEmail")
			WRITE_strHomepage     = RS("strHomepage")

		END IF

		IF WRITE_intMemberSrl = "" THEN WRITE_intMemberSrl = 0

		CONF_intUploadedFileSize = 0

		IF CONF_strDocumentCode <> "" AND ISNULL(CONF_strDocumentCode) = False THEN

			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_DOCUMENT_READ] '" & CONF_strDocumentCode & "' ")

			IF RS("bitUse") = True THEN WRITE_strContent = RS("strContent")

		END IF

	CASE "modify"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_READ] '" & CONF_intSrl & "', '" & REQ_intSeq & "', '', '', '0' ")

		DIM AdRs_List
		IF NOT(RS.EOF) THEN AdRs_List = RS.GetRows() ELSE AdRs_List = ""

		WRITE_intCategory     = AdRs_List(2, 0)
		WRITE_intMemberSrl    = AdRs_List(4, 0)
		WRITE_strUserID       = AdRs_List(5, 0)
		WRITE_strPassword     = AdRs_List(6, 0)
		WRITE_strUserName     = GetReplaceTag2Text(AdRs_List(7, 0))
		WRITE_strNickName     = GetReplaceTag2Text(AdRs_List(8, 0))
		WRITE_strEmail        = GetReplaceTag2Text(AdRs_List(9, 0))
		WRITE_strHomepage     = GetReplaceTag2Text(AdRs_List(10, 0))
		WRITE_strTitle        = GetReplaceTag2Text(AdRs_List(11, 0))
		WRITE_strTitleSize    = AdRs_List(12, 0)
		WRITE_strTitleColor   = AdRs_List(13, 0)
		WRITE_strTitleBold    = AdRs_List(14, 0)
		IF WRITE_strTitleBold = True THEN WRITE_strTitleBold = "b" ELSE WRITE_strTitleBold = ""
		WRITE_strContent      = AdRs_List(15, 0)


		WRITE_strTag          = GetReplaceTag2Text(AdRs_List(17, 0))
		WRITE_bitNotice       = GetBitTypeNumberChg(AdRs_List(18, 0))
		WRITE_bitDelete       = AdRs_List(19, 0)
		WRITE_bitBad          = AdRs_List(20, 0)
		WRITE_bitSecret       = GetBitTypeNumberChg(AdRs_List(21, 0))
		WRITE_bitMessage      = GetBitTypeNumberChg(AdRs_List(22, 0))
		WRITE_bitAllowComment = GetBitTypeNumberChg(AdRs_List(23, 0))
		WRITE_bitAllowScrap   = GetBitTypeNumberChg(AdRs_List(24, 0))
		WRITE_strFile         = AdRs_List(25, 0)
		WRITE_strImage        = AdRs_List(26, 0)
		WRITE_strAddData1     = GetReplaceTag2Text(AdRs_List(34, 0))
		WRITE_strAddData2     = GetReplaceTag2Text(AdRs_List(35, 0))
		WRITE_strAddData3     = GetReplaceTag2Text(AdRs_List(36, 0))
		WRITE_strAddData4     = GetReplaceTag2Text(AdRs_List(37, 0))
		WRITE_strAddData5     = GetReplaceTag2Text(AdRs_List(38, 0))
		WRITE_strAddData6     = GetReplaceTag2Text(AdRs_List(39, 0))
		WRITE_strAddData7     = GetReplaceTag2Text(AdRs_List(40, 0))
		WRITE_strAddData8     = GetReplaceTag2Text(AdRs_List(41, 0))
		WRITE_strAddData9     = GetReplaceTag2Text(AdRs_List(42, 0))
		WRITE_strAddData10    = GetReplaceTag2Text(AdRs_List(43, 0))
		WRITE_strAddData11    = GetReplaceTag2Text(AdRs_List(44, 0))
		WRITE_strAddData12    = GetReplaceTag2Text(AdRs_List(45, 0))
		WRITE_strAddData13    = GetReplaceTag2Text(AdRs_List(46, 0))
		WRITE_strAddData14    = GetReplaceTag2Text(AdRs_List(47, 0))
		WRITE_strAddData15    = GetReplaceTag2Text(AdRs_List(48, 0))

		IF CONF_bitBoardAdmin = False THEN
			IF WRITE_intMemberSrl = 0 THEN
				IF GetPasswordSessionCheck(REQ_intSeq, SESSION("boardSeq")) = False THEN
					RESPONSE.REDIRECT GetPasswordFormScript(REQ_intSeq, "", "", "view", "modify")
					RESPONSE.End()
				END IF
			ELSE
				IF SESSION("memberSeq") = "" THEN
					RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "view", "msg_not_permitted")
					RESPONSE.End()
				ELSE
					IF INT(WRITE_intMemberSrl) <> INT(SESSION("memberSeq")) THEN
						RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "view", "msg_not_permitted")
						RESPONSE.End()
					END IF
				END IF
			END IF
		END IF

		SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_READ] 'I', '', '" & CONF_intSrl & "', '" & REQ_intSeq & "', '' ")
	
		CONF_intUploadedFileCount = RS(0)
		CONF_intUploadedFileSize  = RS(1)

	END SELECT

	DIM strEditorLangFile
	strEditorLangFile = Server.MapPath(".") & "\daum\lang\lang." & GetEditorUtfCode(CONF_strSkinLang) & ".xml"
%>
<link rel="stylesheet" href="daum/css/editor_<%=GetEditorUtfCode(CONF_strSkinLang)%>.css" type="text/css" charset="utf-8"/>
<script type="text/javascript">

	var set_bbs_write = {
		use_notice : "<%=GetBitTypeNumberChg(CONF_bitBoardAdmin)%>",
		use_secret : "<%=GetBitTypeNumberChg(CONF_bitUseSecret)%>",
		use_category : "<%=GetBitTypeNumberChg(CONF_bitUseCategory)%>",
		staff_user : "<%=GetBitTypeNumberChg(CONF_bitBoardAdmin)%>",
		write_move_opt : "<%=CONF_strWriteMoveOpt(0)%>",
		write_move_url : "<%=CONF_strWriteMoveOpt(1)%>",
		modify_move_opt : "<%=CONF_strModifyMoveOpt(0)%>",
		modify_move_url : "<%=CONF_strModifyMoveOpt(1)%>"
	}

	var set_fileupload = {
		file_size_total : <%=CONF_intUploadFileTotalSize * 1024 * 1024 %>,
		file_size_limit : <%=CONF_intUploadFileSize * 1024 * 1024 %>,
		file_size_uploaded : <%=CONF_intUploadedFileSize%>,
		file_types : "<%=CONF_strUploadFileExt%>",
		file_upload_limit : 0,
		file_queue_limit : 0
	}

	var set_editor = {
		config: {
			path : '/<%=REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")%>',
			pdspath : '<%=CONF_strFilePath%>',
			imagepath : 'board/<%=CONF_intSrl%>/images/',
			filepath : 'board/<%=CONF_intSrl%>/files/',
			boardsrl : '<%=CONF_intSrl%>',
			editorMode : 'board',
			usefile : <% IF CONF_bitUseUpload = True THEN %>true<% ELSE %>false<% END IF %>,
			useimage : true,
			imageWidth : <%=CONF_strWriteEditorImageWidth%>,
			imageHeight : <%=CONF_strWriteEditorImageHeight%>
		}
	};

	var set_extra_form = {
		config: [
<% FOR tmpFor = 0 TO AdRs_ExtraForm_Count %>
			{field : "<%=AdRs_ExtraForm(0, tmpFor)%>", title : "<%=AdRs_ExtraForm(1, tmpFor)%>", formType : "<%=AdRs_ExtraForm(2, tmpFor)%>", use : "<%=AdRs_ExtraForm(8, tmpFor)%>", rquired : "<%=AdRs_ExtraForm(9, tmpFor)%>", search : "<%=AdRs_ExtraForm(11, tmpFor)%>"}<% IF tmpFor <> AdRs_ExtraForm_Count THEN %>,<% END IF %>
<% NEXT %>
		]
	};

	var attacher_list = {
		files: [
<%
	IF LCASE(subAct) = "modify" THEN
		SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_LIST] '" & CONF_intSrl & "', '" & REQ_intSeq & "', '', 'B', '' ")
	
		tmpFor = 0
		WHILE NOT(RS.EOF)
	
			IF tmpFor > 0 THEN RESPONSE.WRITE ","
			RESPONSE.WRITE "			{seq : """ & RS("intSeq") & """, filename : """ & RS("strFileName") & """, uploadfile : """ & RS("strUploadedFilename") & """, size : """ & RS("intSize") & """, image : """ & GetBitTypeNumberChg(RS("bitImage")) & """}" & CHR(10)
			tmpFor = tmpFor + 1
	
		RS.MOVENEXT
		WEND
	END IF
%>
		]
	};

</script>
<script src="daum/js/editor_<%=GetEditorUtfCode(CONF_strSkinLang)%>.js" type="text/javascript" charset="utf-8"></script>
<script src="daum/js/editor_config.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

	$(document).ready(function() {

		Trex.module("notify removed attachments",
			function(editor, toolbar, sidebar, canvas, config){
				editor.getAttachBox().observeJob(Trex.Ev.__ENTRYBOX_ENTRY_REMOVED, function(entry) {
					console.log(entry.data);
					if (entry.data.imageurl == null){
						if (attacher_list.files.length < entry.data.dataSeq){
							uploadFileImageRemove("file", entry.data.originalurl, '', set_editor.config.filepath);
						}else{
							uploadFileImageRemove("file", entry.data.originalurl, attacher_list.files[entry.data.dataSeq-1].seq, set_editor.config.filepath);
						}
						set_fileupload.file_size_uploaded = Number(set_fileupload.file_size_uploaded) - Number(entry.data.filesize);
						if (set_fileupload.file_size_uploaded != 0)
							$("#tx_attach_up_size").text(getUploadedFileSize(set_fileupload.file_size_uploaded));
					}else{
						if (attacher_list.files.length < entry.data.dataSeq){
							uploadFileImageRemove("image", entry.data.filename, '', set_editor.config.imagepath);
						}else{
							uploadFileImageRemove("image", entry.data.filename, attacher_list.files[entry.data.dataSeq-1].seq, set_editor.config.imagepath);
						}
						boardContentModify(Editor.getContent());
					}
				});
	
				canvas.observeJob(Trex.Ev.__CANVAS_BEFORE_UNLOAD, function() {
					console.log('unload')
					if ($("#writeForm #strTempFiles").val() != ""){
						var tmp_files = "";
						var _attachments = Editor.getAttachments('file', true);
						for(var i=0,len=_attachments.length;i<len;i++) {
							if (attacher_list.files.length < _attachments[i].data.dataSeq){
								if (tmp_files != "")
									tmp_files = tmp_files + ",";
								tmp_files = tmp_files + _attachments[i].data.originalurl;
							}
						}
						if (tmp_files!= ""){
							uploadFileImageRemove("files", tmp_files, "", set_editor.config.filepath);
						}
					}

					if ($("#writeForm #strTempImages").val() != ""){
						uploadFileImageRemove("images", $("#writeForm #strTempImages").val(), "", set_editor.config.imagepath);
					}

				});
				//등록버튼을 눌러 form을 submit할 때
				editor.observeJob(Trex.Ev.__ON_SUBMIT, function() {
					alert("전송");
					console.log('submit')
				});
			}
		);

		if (set_fileupload.file_size_uploaded != 0)
			$("#tx_attach_up_size").text(getUploadedFileSize(set_fileupload.file_size_uploaded));

		new Editor({
			txHost: '',
			txPath: set_editor.config.path + 'daum/',
			txVersion: '5.4.0',
			txService: 'sample',
			txProject: 'sample',
			initializedId: "",
			wrapper: "tx_trex_container"+"",
			form: 'theForm'+"",
			txIconPath: set_editor.config.path + "daum/images/icon/<%=GetEditorUtfCode(CONF_strSkinLang)%>/",
			txDecoPath: set_editor.config.path + "daum/images/deco/",
			events: {
				preventUnload: false
			},
			canvas: {
				styles: {color: "#666666", fontFamily: "gulim", fontSize: "12px", backgroundColor: "<%=CONF_strWriteEditorBgColor%>", lineHeight: "1.5", padding: "8px"}
			},
			sidebar: {
				attachbox: {show:true},
				attacher: {
					image: {
						objattr: {width: set_editor.config.imagewidth}
					},
					file: {boxonly: true}
				}
			}
		})

		$(".tx-canvas iframe").css("height", "<%=CONF_intWriteEditorHeight%>px");

		if (set_editor.config.usefile == false){
			$("#editor_file_upload").hide();
		}

		if (set_editor.config.useimage == false){
			$("#editor_image_upload").hide();
		}

		if ($("#extForm #subAct").val() == "modify"){

			var path = "http://" + document.location.host + "/" + set_editor.config.path + set_editor.config.pdspath + "/";
			var attachments = {};
			attachments['image'] = [];

			for(var i = 0; i < attacher_list.files.length; i++){
				if (attacher_list.files[i].image == "1"){
					attachments['image'].push( { 
						'attacher': 'image', 
						'data': { 
								'fileseq' : attacher_list.files[i].seq,
								'imageurl': path + set_editor.config.imagepath + attacher_list.files[i].filename,
								'filename': attacher_list.files[i].filename,
								'filesize': attacher_list.files[i].size,
								'originalurl': attacher_list.files[i].filename,
								'thumburl': path + set_editor.config.imagepath + attacher_list.files[i].filename,
								'width' : 500,
								'height' : 500
								}
					});
				}
			}

			attachments['file'] = [];

			for(var i = 0; i < attacher_list.files.length; i++){
				if (attacher_list.files[i].image == "0"){
					attachments['file'].push({
						'attacher': 'file', 
						'data': {
							'fileseq' : attacher_list.files[i].seq,
							'attachurl': path + set_editor.config.filepath + attacher_list.files[i].filename,
							'filename': attacher_list.files[i].filename,
							'originalurl': attacher_list.files[i].uploadfile,
							'filesize': attacher_list.files[i].size
						}
					});
				}
			}

		}

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

	});

	function uploadFileImageRemove(filetype, filename, fileseq, path){
		$.ajax({
			type: "post", url: "action/?Act=uploadfileremove", data : "filetype=" + filetype + "&filename=" + filename + "&userpath=" + path + "&editorMode=" + set_editor.config.editorMode + "&board_srl=" + set_editor.config.boardsrl +  "&board_seq=" + $("#extForm #seq").val() + "&comment_seq=0&file_seq=" + fileseq, 
			success:function(responseText){
			}, error:function(response){alert('error\n\n' + response.responseText);}
		});
	}

	function boardContentModify(content){

		$("#writeTemp #strTempContent").val(content);

		$("#writeTemp").ajaxSubmit({
			success: function(responseText){
			}, 
		 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=contentmodify&board_srl=' + set_bbs_default.srl + '&board_seq=' + $("#extForm #seq").val()
		});

	}

	function getUploadedFileSize(size){
		
		if (size > 1048576){
			val = getRound(((size / 1048576) * 1000 / 1000),1) + " MB";
		}else if (size > 1024) {
			val = getRound(((size / 1024) * 10 / 10),1) + " KB";
		}else {
			val = size + " Byte";
		}
	
		return val;
	
	}
	
	function getRound(val, precision) { 
		val = val * Math.pow(10,precision); 
		val = Math.round(val); 
		return val/Math.pow(10,precision); 
	}

</script>
<form name="writeTemp" id="writeTemp" method="post">
<textarea name="strTempContent" id="strTempContent" style="display:none;" title="temp_content" /></textarea>
<input type="submit" class="none" />
</form>
<form name="writeForm" id="writeForm" method="post">
<input type="hidden" id="writeAct" name="writeAct" value="<%=subAct%>" />
<input type="hidden" id="intSrl" name="intSrl" value="<%=CONF_intSrl%>" />
<input type="hidden" id="intSeq" name="intSeq" value="<%=REQ_intSeq%>" />
<input type="hidden" id="intCategory" name="intCategory" value="<%=WRITE_intCategory%>" />
<input type="hidden" id="intMemberSrl" name="intMemberSrl" value="<%=WRITE_intMemberSrl%>" />
<input type="hidden" id="strUserID" name="strUserID" value="<%=WRITE_strUserID%>" />
<input type="hidden" id="strPassword" name="strPassword" />
<input name="strUserName" type="hidden" id="strUserName" value="<%=WRITE_strUserName%>" />
<input name="strNickName" type="hidden" id="strNickName" value="<%=WRITE_strNickName%>" />
<input name="strEmail" type="hidden" id="strEmail" value="<%=WRITE_strEmail%>" />
<input name="strHomepage" type="hidden" id="strHomepage" value="<%=WRITE_strHomepage%>" />
<input name="strTitle" type="hidden" id="strTitle" value="<%=WRITE_strTitle%>" />
<input name="strTitleSize" type="hidden" id="strTitleSize" value="<%=WRITE_strTitleSize%>" />
<input name="strTitleColor" type="hidden" id="strTitleColor" value="<%=WRITE_strTitleColor%>" />
<input name="bitTitleBold" type="hidden" id="bitTitleBold" value="<%=WRITE_strTitleBold%>" />
<textarea name="strContent" id="strContent" style="display:none;" title="temp_content" /><%=WRITE_strContent%></textarea>
<input name="strTag" type="hidden" id="strTag" value="<%=WRITE_strTag%>" />
<input type="hidden" id="strUploadFile" name="strUploadFile" />
<input type="hidden" id="strUploadImg" name="strUploadImg" />
<input type="hidden" id="strTempFiles" name="strTempFiles" />
<input type="hidden" id="strTempImages" name="strTempImages" />
<input type="hidden" id="bitNotice" name="bitNotice" value="<%=WRITE_bitNotice%>" />
<input type="hidden" id="bitSecret" name="bitSecret" value="<%=WRITE_bitSecret%>" />
<input type="hidden" id="bitMessage" name="bitMessage" value="<%=WRITE_bitMessage%>" />
<input type="hidden" id="bitAllowComment" name="bitAllowComment" value="<%=WRITE_bitAllowComment%>" />
<input type="hidden" id="bitAllowScrap" name="bitAllowScrap" value="<%=WRITE_bitAllowScrap%>" />
<input type="hidden" id="strAddData1_" name="strAddData1_" value="<%=WRITE_strAddData1%>" />
<input type="hidden" id="strAddData2_" name="strAddData2_" value="<%=WRITE_strAddData2%>" />
<input type="hidden" id="strAddData3_" name="strAddData3_" value="<%=WRITE_strAddData3%>" />
<input type="hidden" id="strAddData4_" name="strAddData4_" value="<%=WRITE_strAddData4%>" />
<input type="hidden" id="strAddData5_" name="strAddData5_" value="<%=WRITE_strAddData5%>" />
<input type="hidden" id="strAddData6_" name="strAddData6_" value="<%=WRITE_strAddData6%>" />
<input type="hidden" id="strAddData7_" name="strAddData7_" value="<%=WRITE_strAddData7%>" />
<input type="hidden" id="strAddData8_" name="strAddData8_" value="<%=WRITE_strAddData8%>" />
<input type="hidden" id="strAddData9_" name="strAddData9_" value="<%=WRITE_strAddData9%>" />
<input type="hidden" id="strAddData10_" name="strAddData10_" value="<%=WRITE_strAddData10%>" />
<input type="hidden" id="strAddData11_" name="strAddData11_" value="<%=WRITE_strAddData11%>" />
<input type="hidden" id="strAddData12_" name="strAddData12_" value="<%=WRITE_strAddData12%>" />
<input type="hidden" id="strAddData13_" name="strAddData13_" value="<%=WRITE_strAddData13%>" />
<input type="hidden" id="strAddData14_" name="strAddData14_" value="<%=WRITE_strAddData14%>" />
<input type="hidden" id="strAddData15_" name="strAddData15_" value="<%=WRITE_strAddData15%>" />
<input type="hidden" id="strCaptcha" name="strCaptcha" />
<input type="submit" class="none" />
</form>
<%
	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
	SET AdRs_ExtraForm = NOTHING : SET AdRs_ExtraForm_Count = NOTHING
%>
<script type="text/javascript" src="js/Calendar.js"></script>
<script type="text/javascript" src="js/jquery.zip.js"></script>