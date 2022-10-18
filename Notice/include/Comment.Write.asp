<%
	CONF_intUploadedFileSize = 0

	DIM strEditorLangFile
	strEditorLangFile = Server.MapPath(".") & "\daum\lang\lang." & GetEditorUtfCode(CONF_strSkinLang) & ".xml"

	SELECT CASE LCASE(subAct)
	CASE "view", "comment_reply"

		COMMENT_intMemberSrl = SESSION("memberSeq")
		COMMENT_strUserID    = SESSION("userID")
		COMMENT_strUserName  = SESSION("userName")
		COMMENT_strNickName  = SESSION("nickName")

		IF SESSION("memberSeq") <> "" THEN

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & SESSION("memberSeq") & "' ")

			COMMENT_strEmail        = RS("strEmail")
			COMMENT_strHomepage     = RS("strHomepage")

		END IF

		IF LCASE(subAct) = "comment_reply" THEN

			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_READ] '" & CONF_intSrl & "', '" & REQ_intSeq & "', '" & SESSION("memberSeq") & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "', '0' ")

			IF RS("bitAllowComment") = False THEN CONF_bitUseComment = False

			SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_READ] '" & REQ_intCommentSeq & "' ")

			IF CONF_bitUseComment = False OR CONF_bitUseCommentReply = False OR CONF_strCmtWriteLevel = False THEN

				RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, REQ_intCommentSeq, REQ_intCommentPage, "view", "comment_reply", "")
				RESPONSE.End()

			END IF

			COMMENT_intThread  = RS("intThread")
			LIST_intMemberSrl  = RS("intMemberSrl")
			LIST_strGroupLevel = RS("strGroupLevel")
			LIST_strUserID     = RS("strUserID")
			LIST_strUserName   = RS("strUserName")
			LIST_strNickName   = RS("strNickName")
			LIST_strContent    = RS("strContent")
			LIST_bitSecret     = RS("bitSecret")
			LIST_intVote       = RS("intVote")
			LIST_intBlamed     = RS("intBlamed")
			LIST_strIpAddr     = "*." & SPLIT(RS("strIpAddr"), ".")(1) & "." & SPLIT(RS("strIpAddr"), ".")(2) & "." & SPLIT(RS("strIpAddr"), ".")(3)
			LIST_strModifyDate = RS("strModifyDate")
			LIST_strRegDate    = RS("strRegDate")
			
			LIST_strGroupLevelImg = GetMemberGroupLevelIcon(LIST_strGroupLevel, CONF_bitDispLevelIcon, CONF_strLevelIconFolder, CONF_strFilePath)
			LIST_strPhotoImg      = GetMemberImage(LIST_intMemberSrl, CONF_bitUsePhoto, "profile", CONF_strFilePath, "image", CONF_strPhotoSize(0), CONF_strPhotoSize(1))
			LIST_strMarkImg       = GetMemberImage(LIST_intMemberSrl, CONF_bitUseMarkImg, "mark", CONF_strFilePath, "image", CONF_strMarkImgSize(0), CONF_strMarkImgSize(1))
			LIST_strNameImg       = GetMemberImage(LIST_intMemberSrl, CONF_bitUseNameImg, "name", CONF_strFilePath, "image", CONF_strNameImgSize(0), CONF_strNameImgSize(1))
		
			IF LIST_strNameImg = "" THEN
				LIST_strNickName = LIST_strGroupLevelImg & LIST_strMarkImg & LIST_strNickName
			ELSE
				LIST_strNickName = LIST_strGroupLevelImg & LIST_strMarkImg & LIST_strNameImg
			END IF
		
			IF LIST_intMemberSrl = "0" THEN
				IF LIST_strHomepage <> "" AND ISNULL(LIST_strHomepage) = False THEN
					LIST_strNickName = "<a href=""" & LIST_strHomePage & """ onclick=""window.open(this.href);return false;"">" & LIST_strNickName & "</a>"
				END IF
			ELSE
				LIST_strNickName = "<a href=""#popup_menu_area"" name=""popup_menu_area"" class=""member_" & LIST_intMemberSrl & """ onclick=""return false;"">" & LIST_strNickName & "</a>"
			END IF

			IF LIST_bitSecret = True THEN
				IF CONF_bitBoardAdmin = False THEN
					IF LIST_intMemberSrl = 0 THEN
						IF GetPasswordSessionCheck(REQ_intCommentSeq, SESSION("commentSeq")) = False THEN
							RESPONSE.REDIRECT GetPasswordFormScript(REQ_intSeq, REQ_intCommentSeq, REQ_intCommentPage, "view", "comment_reply")
							RESPONSE.End()
						END IF
		
					ELSE
						IF SESSION("memberSeq") = "" THEN
							RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, REQ_intCommentSeq, REQ_intCommentPage, "view", "view", "code05")
							RESPONSE.End()
						ELSE
							IF INT(COMMENT_intMemberSrl) <> INT(SESSION("memberSeq")) THEN
								RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, REQ_intCommentSeq, REQ_intCommentPage, "view", "view", "code05")
								RESPONSE.End()
							END IF
						END IF
					END IF
				END IF
			END IF

		END IF

	CASE "comment_modify"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_READ] '" & REQ_intCommentSeq & "' ")

		COMMENT_intThread    = RS("intThread")
		COMMENT_intMemberSrl = RS("intMemberSrl")
		COMMENT_strUserID    = RS("strUserID")
		COMMENT_strUserName  = RS("strUserName")
		COMMENT_strNickName  = RS("strNickName")
		COMMENT_strPassword  = RS("strPassword")
		COMMENT_strEmail     = RS("strEmail")
		COMMENT_strHomepage  = RS("strHomepage")
		COMMENT_strContent   = RS("strContent")
		COMMENT_bitSecret    = GetBitTypeNumberChg(RS("bitSecret"))
		COMMENT_bitMessage   = GetBitTypeNumberChg(RS("bitMessage"))

		IF CONF_bitBoardAdmin = False THEN
			IF COMMENT_intMemberSrl = 0 THEN
				IF GetPasswordSessionCheck(REQ_intCommentSeq, SESSION("commentSeq")) = False THEN
					RESPONSE.REDIRECT GetPasswordFormScript(REQ_intSeq, REQ_intCommentSeq, REQ_intCommentPage, "view", "comment_modify")
					RESPONSE.End()
				END IF

			ELSE
				IF SESSION("memberSeq") = "" THEN
					RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, REQ_intCommentSeq, REQ_intCommentPage, "view", "view", "code05")
					RESPONSE.End()
				ELSE
					IF INT(COMMENT_intMemberSrl) <> INT(SESSION("memberSeq")) THEN
						RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, REQ_intCommentSeq, REQ_intCommentPage, "view", "view", "code05")
						RESPONSE.End()
					END IF
				END IF
			END IF
		END IF

		SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_READ] 'I', '', '" & CONF_intSrl & "', '" & REQ_intSeq & "', '" & REQ_intCommentSeq & "' ")
	
		CONF_intUploadedFileCount = RS(0)
		CONF_intUploadedFileSize  = RS(1)

	END SELECT
%>
<link rel="stylesheet" href="daum/css/editor_<%=GetEditorUtfCode(CONF_strSkinLang)%>.css" type="text/css" charset="utf-8"/>
<script type="text/javascript">

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
			imagepath : 'comment/<%=CONF_intSrl%>/images/',
			filepath : 'comment/<%=CONF_intSrl%>/files/',
			boardsrl : '<%=CONF_intSrl%>',
			editorMode : 'comment',
			usefile : <% IF CONF_bitUseUpload = True THEN %>true<% ELSE %>false<% END IF %>,
			useimage : true,
			imageWidth : <%=CONF_strCommentEditorImageWidth%>,
			imageHeight : <%=CONF_strCommentEditorImageHeight%>
		}
	};

	var attacher_list = {
		files: [
<%
	IF LCASE(subAct) = "comment_modify" THEN
		SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_LIST] '" & CONF_intSrl & "', '" & REQ_intSeq & "', '" & REQ_intCommentSeq & "', 'C', '' ")
	
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
							uploadFileImageRemove("image", entry.data.originalurl, '', set_editor.config.imagepath);
						}else{
							uploadFileImageRemove("image", entry.data.originalurl, attacher_list.files[entry.data.dataSeq-1].seq, set_editor.config.imagepath);
							commentContentModify(Editor.getContent());
						}
					}
				});
	
				canvas.observeJob(Trex.Ev.__CANVAS_BEFORE_UNLOAD, function() {
					console.log('unload')

					if ($("#writeForm #strTempFiles").val() != "")
						uploadFileImageRemove("files", $("#writeForm #strTempFiles").val(), "", set_editor.config.filepath);

					if ($("#writeForm #strTempImages").val() != "")
						uploadFileImageRemove("images", $("#writeForm #strTempImages").val(), "", set_editor.config.imagepath);

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
				styles: {color: "#666666", fontFamily: "gulim", fontSize: "12px", backgroundColor: "<%=CONF_strCommentEditorBgColor%>", lineHeight: "1.5", padding: "8px", height: "400px"}
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
		}).focusOnForm();

		$(".tx-canvas iframe").css("height", "<%=CONF_intCommentEditorHeight%>px");

		if (set_editor.config.usefile == false){
			$("#editor_file_upload").hide();
		}

		if (set_editor.config.useimage == false){
			$("#editor_image_upload").hide();
		}

		if ($("#writeForm #writeAct").val() == "comment_modify"){

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
								'width' : <%=CONF_strCommentEditorImageWidth%>,
								'height' : <%=CONF_strCommentEditorImageHeight%>
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

	});

	function uploadFileImageRemove(filetype, filename, fileseq, path){

		$.ajax({
			type: "post", url: "action/?Act=uploadfileremove", data : "filetype=" + filetype + "&filename=" + filename + "&userpath=" + path + "&editorMode=" + set_editor.config.editorMode + "&board_srl=" + set_editor.config.boardsrl +  "&board_seq=" + $("#extForm #seq").val() + "&comment_seq=" + $("#writeForm #intCommentSeq").val() + "&file_seq=" + fileseq, 
			success:function(responseText){
			}, error:function(response){alert('error\n\n' + response.responseText);}
		});

	}

	function commentContentModify(content){

		$("#writeTemp #strTempContent").val(content);

		$("#writeTemp").ajaxSubmit({
			success: function(responseText){
			}, 
		 error:function(response){alert('error\n\n' + response.responseText);}, type:'post', url: 'action/?Act=contentmodify&board_srl=' + set_bbs_default.srl + '&comment_seq=' + $("#writeForm #intCommentSeq").val()
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
<textarea name="strTempContent" id="strTempContent" style="display:none;" title="strTempContent"></textarea>
<input type="submit" class="none" />
</form>
<form name="writeForm" id="writeForm" method="post">
<input type="hidden" id="writeAct" name="writeAct" value="<%=subAct%>" />
<input type="hidden" id="intCommentSeq" name="intCommentSeq" value="<%=REQ_intCommentSeq%>" />
<input type="hidden" id="intSrl" name="intSrl" value="<%=CONF_intSrl%>" />
<input type="hidden" id="intBoardSeq" name="intBoardSeq" value="<%=REQ_intSeq%>" />
<input type="hidden" id="intThread" name="intThread" value="<%=COMMENT_intThread%>" />
<input type="hidden" id="intMemberSrl" name="intMemberSrl" value="<%=COMMENT_intMemberSrl%>" />
<input type="hidden" id="strUserID" name="strUserID" value="<%=COMMENT_strUserID%>" />
<input type="hidden" id="strUserName" name="strUserName" value="<%=COMMENT_strUserName%>" />
<input type="hidden" id="strNickName" name="strNickName" value="<%=COMMENT_strNickName%>" />
<input type="hidden" id="strPassword" name="strPassword" value="<%=COMMENT_strPassword%>" />
<input type="hidden" id="strEmail" name="strEmail" value="<%=COMMENT_strEmail%>" />
<input type="hidden" id="strHomepage" name="strHomepage" value="<%=COMMENT_strHomepage%>" />
<textarea name="strContent" id="strContent" class="none" title="content"><%=COMMENT_strContent%></textarea>
<input type="hidden" id="strUploadFile" name="strUploadFile" />
<input type="hidden" id="strUploadImg" name="strUploadImg" />
<input type="hidden" id="strTempFiles" name="strTempFiles" />
<input type="hidden" id="strTempImages" name="strTempImages" />
<input type="hidden" id="bitSecret" name="bitSecret" value="<%=COMMENT_bitSecret%>" />
<input type="hidden" id="bitMessage" name="bitMessage" value="<%=COMMENT_bitMessage%>" />
<input type="submit" class="none" />
</form>