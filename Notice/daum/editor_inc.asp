<%
	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
	xmlDOM.Load strEditorLangFile
	SET rootNode = xmlDOM.selectNodes(LCASE("/root"))	

	DIM objLangEditor
	SET objLangEditor = Server.CreateObject("Scripting.Dictionary")

	WITH objLangEditor

		FOR firstLoop = 0 To rootNode(0).childNodes.Length-1

			.Add rootNode(0).childNodes(firstLoop).getAttribute("name"), rootNode(0).childNodes(firstLoop).text

		NEXT

	END WITH
%>
<div class="editor_wrapper">
	<div id="tx_trex_container" class="tx-editor-container">
		<div id="tx_sidebar" class="tx-sidebar">
			<div class="tx-sidebar-boundary">
				<ul class="tx-bar tx-bar-left tx-nav-attach">
					<li id="editor_image_upload" class="tx-list">
						<div unselectable="on" id="tx_image" class="tx-image tx-btn-trans">
							<a href="#editor_toolbar" onclick="return false;"  title="<%=objLangEditor("photo")%>" class="tx-text"><%=objLangEditor("photo")%></a>
						</div>
					</li>
					<li id="editor_file_upload" class="tx-list">
						<div unselectable="on" id="tx_file" class="tx-file tx-btn-trans">
							<a href="#editor_toolbar" onclick="return false;"  title="<%=objLangEditor("file")%>" class="tx-text"><%=objLangEditor("file")%></a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" id="tx_media" class="tx-media tx-btn-trans">
							<a href="#editor_toolbar" onclick="return false;"  title="<%=objLangEditor("media")%>" class="tx-text"><%=objLangEditor("media")%></a>
						</div>
					</li>
					<li class="tx-list tx-list-extra">
						<div unselectable="on" class="tx-btn-nlrbg tx-extra">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("btn_more")%>"><%=objLangEditor("btn_more")%></a>
						</div>
						<ul class="tx-extra-menu tx-menu" style="left:-48px;" unselectable="on">
							<!-- 
								@decsription
							-->
						</ul>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-right tx-nav-opt">
					<li class="tx-list">
						<div unselectable="on" class="tx-switchtoggle" id="tx_switchertoggle">
							<a href="#editor_toolbar" onclick="return false;"  title="<%=objLangEditor("editor_type")%>"><%=objLangEditor("editor")%></a>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div id="tx_toolbar_basic" class="tx-toolbar tx-toolbar-basic">
			<div class="tx-toolbar-boundary">
				<ul class="tx-bar tx-bar-left">
					<li class="tx-list">
						<div id="tx_fontfamily" unselectable="on" class="tx-slt-70bg tx-fontfamily">
							<a href="#editor_toolbar" onclick="return false;"  title="<%=objLangEditor("font")%>"><%=objLangEditor("gulim")%></a>
						</div>
						<div id="tx_fontfamily_menu" class="tx-fontfamily-menu tx-menu" unselectable="on"></div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-left">
					<li class="tx-list">
						<div unselectable="on" class="tx-slt-42bg tx-fontsize" id="tx_fontsize">
							<a href="#editor_toolbar" onclick="return false;"  title="<%=objLangEditor("font_size")%>">9pt</a>
						</div>
						<div id="tx_fontsize_menu" class="tx-fontsize-menu tx-menu" unselectable="on"></div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-left tx-group-font"> 
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-lbg 	tx-bold" id="tx_bold">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("bold")%> (Ctrl+B)"><%=objLangEditor("bold")%></a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-bg 	tx-underline" id="tx_underline">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("underline")%> (Ctrl+U)"><%=objLangEditor("underline")%></a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-bg 	tx-italic" id="tx_italic">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("italic")%> (Ctrl+I)"><%=objLangEditor("italic")%></a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-bg 	tx-strike" id="tx_strike">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("strike")%> (Ctrl+D)"><%=objLangEditor("strike")%></a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-slt-tbg 	tx-forecolor" style="background-color:#5c7fb0;" id="tx_forecolor">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("forecolor")%>"><%=objLangEditor("forecolor")%></a>
							<a href="#editor_toolbar" onclick="return false;"  class="tx-arrow" title="<%=objLangEditor("forecolor")%> <%=objLangEditor("select")%>"><%=objLangEditor("forecolor")%> <%=objLangEditor("select")%></a>
						</div>
						<div id="tx_forecolor_menu" class="tx-menu tx-forecolor-menu tx-colorpallete" unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-slt-brbg 	tx-backcolor" style="background-color:#5c7fb0;" id="tx_backcolor">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("backcolor")%>"><%=objLangEditor("backcolor")%></a>
							<a href="#editor_toolbar" onclick="return false;"  class="tx-arrow" title="<%=objLangEditor("backcolor")%> <%=objLangEditor("select")%>"><%=objLangEditor("backcolor")%> <%=objLangEditor("select")%></a>
						</div>
						<div id="tx_backcolor_menu" class="tx-menu tx-backcolor-menu tx-colorpallete" unselectable="on"></div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-left tx-group-align"> 
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-lbg 	tx-alignleft" id="tx_alignleft">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("alignleft")%> (Ctrl+,)"><%=objLangEditor("alignleft")%></a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-bg 	tx-aligncenter" id="tx_aligncenter">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("aligncenter")%> (Ctrl+.)"><%=objLangEditor("aligncenter")%></a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-bg 	tx-alignright" id="tx_alignright">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("alignright")%> (Ctrl+/)"><%=objLangEditor("alignright")%></a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-rbg 	tx-alignfull" id="tx_alignfull">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("alignfull")%>"><%=objLangEditor("alignfull")%></a>
						</div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-left tx-group-tab"> 
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-lbg 	tx-indent" id="tx_indent">
							<a href="#editor_toolbar" onclick="return false;"  title="<%=objLangEditor("indent")%> (Tab)" class="tx-icon"><%=objLangEditor("indent")%></a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-rbg 	tx-outdent" id="tx_outdent">
							<a href="#editor_toolbar" onclick="return false;"  title="<%=objLangEditor("outdent")%> (Shift+Tab)" class="tx-icon"><%=objLangEditor("outdent")%></a>
						</div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-left tx-group-list">
					<li class="tx-list">
						<div unselectable="on" class="tx-slt-31lbg tx-lineheight" id="tx_lineheight">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("lineheight")%>"><%=objLangEditor("lineheight")%></a>
							<a href="#editor_toolbar" onclick="return false;"  class="tx-arrow" title="<%=objLangEditor("lineheight")%>"><%=objLangEditor("lineheight")%> <%=objLangEditor("select")%></a>
						</div>
						<div id="tx_lineheight_menu" class="tx-lineheight-menu tx-menu" unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="tx-slt-31rbg tx-styledlist" id="tx_styledlist">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("styledlist")%>"><%=objLangEditor("styledlist")%></a>
							<a href="#editor_toolbar" onclick="return false;"  class="tx-arrow" title="<%=objLangEditor("styledlist")%>"><%=objLangEditor("styledlist")%> <%=objLangEditor("select")%></a>
						</div>
						<div id="tx_styledlist_menu" class="tx-styledlist-menu tx-menu" unselectable="on"></div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-left tx-group-etc">
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-lbg 	tx-emoticon" id="tx_emoticon">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("emoticon")%>"><%=objLangEditor("emoticon")%></a>
						</div>
						<div id="tx_emoticon_menu" class="tx-emoticon-menu tx-menu" unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-bg 	tx-link" id="tx_link">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("link")%> (Ctrl+K)"><%=objLangEditor("link")%></a>
						</div>
						<div id="tx_link_menu" class="tx-link-menu tx-menu"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-bg 	tx-specialchar" id="tx_specialchar">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("specialchar")%>"><%=objLangEditor("specialchar")%></a>
						</div>
						<div id="tx_specialchar_menu" class="tx-specialchar-menu tx-menu"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-bg 	tx-table" id="tx_table">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("table")%>"><%=objLangEditor("table")%></a>
						</div>
						<div id="tx_table_menu" class="tx-table-menu tx-menu" unselectable="on">
							<div class="tx-menu-inner">
								<div class="tx-menu-preview"></div>
								<div class="tx-menu-rowcol"></div>
								<div class="tx-menu-deco"></div>
								<div class="tx-menu-enter"></div>
							</div>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-rbg 	tx-horizontalrule" id="tx_horizontalrule">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("horizontalrule")%>"><%=objLangEditor("horizontalrule")%></a>
						</div>
						<div id="tx_horizontalrule_menu" class="tx-horizontalrule-menu tx-menu" unselectable="on"></div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-right">
					<li class="tx-list">
						<div unselectable="on" class="tx-btn-nlrbg tx-advanced" id="tx_advanced">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("advanced")%>"><%=objLangEditor("advanced")%></a>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div id="tx_toolbar_advanced" class="tx-toolbar tx-toolbar-advanced">
			<div class="tx-toolbar-boundary">
				<ul class="tx-bar tx-bar-left"> 
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-lbg 	tx-textbox" id="tx_textbox">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("textbox")%>"><%=objLangEditor("textbox")%></a>
						</div>		
						<div id="tx_textbox_menu" class="tx-textbox-menu tx-menu"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-bg 	tx-quote" id="tx_quote">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("quote")%> (Ctrl+Q)"><%=objLangEditor("quote")%></a>
						</div>
						<div id="tx_quote_menu" class="tx-quote-menu tx-menu" unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-bg 	tx-background" id="tx_background">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("background")%>"><%=objLangEditor("background")%></a>
						</div>
						<div id="tx_background_menu" class="tx-menu tx-background-menu tx-colorpallete" unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-rbg 	tx-dictionary" id="tx_dictionary">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("dictionary")%>"><%=objLangEditor("dictionary")%></a>
						</div>
					</li>
				</ul> 
				<ul class="tx-bar tx-bar-left tx-group-undo"> 
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-lbg 	tx-undo" id="tx_undo">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("undo")%> (Ctrl+Z)"><%=objLangEditor("undo")%></a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-rbg 	tx-redo" id="tx_redo">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("redo")%> (Ctrl+Y)"><%=objLangEditor("redo")%></a>
						</div>
					</li>
				</ul> 
				<ul class="tx-bar tx-bar-right">
					<li class="tx-list">
						<div unselectable="on" class="tx-btn-lrbg tx-fullscreen" id="tx_fullscreen">
							<a href="#editor_toolbar" onclick="return false;"  class="tx-icon" title="<%=objLangEditor("fullscreen")%> (Ctrl+M)"><%=objLangEditor("fullscreen")%></a>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div id="tx_canvas" class="tx-canvas">
			<div id="tx_loading" class="tx-loading">
				<div><img src="<%=CONF_strBbsUrl%>daum/images/icon/loading2.png?rv=1.0.1" width="113" height="21" align="absmiddle" alt="Loading" /></div>
			</div>
			<div id="tx_canvas_wysiwyg_holder" class="tx-holder" style="display:block;">
				<iframe id="tx_canvas_wysiwyg" name="tx_canvas_wysiwyg" allowtransparency="true" frameborder="0" title="tx_canvas_wysiwyg"></iframe>
			</div>
			<div class="tx-source-deco">
				<div id="tx_canvas_source_holder" class="tx-holder">
					<textarea id="tx_canvas_source" rows="30" cols="30" title="tx_canvas_source"></textarea>
				</div>
			</div>
			<div id="tx_canvas_text_holder" class="tx-holder">
				<textarea id="tx_canvas_text" rows="30" cols="30" title="tx_canvas_text"></textarea>
			</div>	
		</div>
		<div id="tx_resizer" class="tx-resize-bar">
			<div class="tx-resize-bar-bg"></div>
			<img id="tx_resize_holder" src="<%=CONF_strBbsUrl%>daum/images/icon/btn_drag01.gif" width="58" height="12" unselectable="on" alt="" />
		</div>
		<div class="tx-side-bi" id="tx_side_bi"></div>
		<div id="tx_attach_div" class="tx-attach-div">
			<div id="tx_attach_txt" class="tx-attach-txt"><%=objLangEditor("file_add")%></div>
			<div id="tx_attach_box" class="tx-attach-box">
				<div class="tx-attach-box-inner">
					<div id="tx_attach_preview" class="tx-attach-preview"><p></p><img src="<%=CONF_strBbsUrl%>daum/images/icon/<%=CONF_strSkinLang%>/pn_preview.gif" width="147" height="108" unselectable="on" alt="preview" /></div>
					<div class="tx-attach-main">
						<div id="tx_upload_progress" class="tx-upload-progress"><div>0%</div><p><%=objLangEditor("file_uploading")%></p></div>
						<ul class="tx-attach-top">
							<li id="tx_attach_delete" class="tx-attach-delete"><a><%=objLangEditor("delete_all")%></a></li>
							<li id="tx_attach_size" class="tx-attach-size">
								<%=objLangEditor("file")%>: <span id="tx_attach_up_size" class="tx-attach-size-up"></span> / <span id="tx_attach_max_size"><%=CONF_intUploadFileTotalSize%>MB</span>
							</li>
							<li id="tx_attach_tools" class="tx-attach-tools">
							</li>
						</ul>
						<ul id="tx_attach_list" class="tx-attach-list"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
	SET objLangEditor = NOTHING
%>