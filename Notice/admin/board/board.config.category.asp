<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intSrl
	intSrl = GetInputReplce(REQUEST.QueryString("intSrl"), "")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '" & intSrl & "' ")

	DIM bitUseCategory

	bitUseCategory = GetBitTypeNumberChg(RS("bitUseCategory"))
%>
<link type="text/css" href="../style/jquery.colorpicker.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery.colorPicker.js"></script>
<script type="text/javascript" src="board/js/board.config.category.js"></script>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_config_category")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_config_category")%></p>
			<div id="subBody">
			<form id="theForm">
			<input type="hidden" name="intSrl" id="intSrl" value="<%=intSrl%>">
<!-- #include file = "board.config.comm.asp" -->
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_use_category")%></th>
						<td>
							<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUseCategory, "bitUseCategory", "<dd>", "</dd>")%>
							</dl>
						</td>
					</tr>
				</table>
				<div class="formButtonBox2">
					<span class="button large strong"><input name="submit" type="submit" value="<%=objXmlLang("btn_save")%>"></span>
				</div>
			</form>
			<div class="fl categoryBox">
				<iframe name="frameCategoryList" id="frameCategoryList" src="?Act=boardconfigcategorytree&intSrl=<%=intSrl%>" frameborder="0" width="300" height="500" scrolling="auto"></iframe>
			</div>
			<div class="fl ml10" style="width:480px;">
				<h4><%=objXmlLang("page_sub_title_7")%></h4>
				<div id="detail_table"></div>
				<ul id="notice_default" class="menu_notice">
					<li><%=objXmlLang("text_info")%></li>
				</ul>
			</div>

		</div>
	</div>
<!-- #include file = "../comm/sub.foot.asp" -->