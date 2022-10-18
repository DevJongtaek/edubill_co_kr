<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM langXmlPath, langXmlFile

	langXmlPath = Server.MapPath("../") & "\"
	langXmlFile = "lang.filebox.xml"

	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop

	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), False)
	IF isNumeric(intPage) = False THEN intPage = ""
	IF intPage = "" THEN intPage = 1

	intPageSize = 10

	DIM strCateCode
	strCateCode = GetInputReplce(REQUEST.QueryString("strCateCode"), "")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_FILEBOX_LIST] '" & strCateCode & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="comm/js/folebox.body.js"></script>
					<div class="fileboxListBox"> 
						<div class="fileboxList"> 
							<ul>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_FILEBOX_LIST] '" & strCateCode & "', 'N', '" & intPage & "', '" & intPageSize & "' ")

	DIM iCount, tCount, intNumber, intWidth, intHeight, intRatio

	tCount = 0
	
	WHILE NOT(RS.EOF)

		iCount = iCount + 1
		tCount = tCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1

		intWidth  = RS("intWidth")
		intHeight = RS("intHeight")


		IF intWidth > 120 THEN

			intRatio  = 120 / intWidth
			intWidth  = 120
			intHeight = intHeight * intRatio

		END IF

		IF intHeight > 120 THEN

			intRatio  = 120 / intHeight
			intHeight = 120
			intWidth  = intWidth * intRatio

		END IF
%>
								<li<% IF tCount = 5 THEN %> class="last"<% END IF %>>
									<dl>
										<dt><a href="<%=RS("strFileNameFull")%>" target="_blank"><img src="<%=RS("strFileNameFull")%>" width="<%=intWidth%>" height="<%=intHeight%>" /></a></dt>
											<dd><input type="checkbox" name="intSeq" value="<%=RS("intSeq")%>" /><a href="#" onclick="opener.FileSelect('<%=RS("strFileName")%>', '<%=RS("strFileNameFull")%>', '<%=RS("intWidth")%>', '<%=RS("intHeight")%>');self.close();"><%=RS("strFileName")%></a></dd>
										<dd class="stxt_999"><%=objXmlLang("title_num")%> <span class="num"><%=intNumber%></span> <span class="bar">|</span> <span class="num"><%=RIGHT(REPLACE(LEFT(RS("strRegDate"),10),"-","."),8)%></span></dd>
										<dd><a href="javascript:;" name="urlCopy" id="<%=RS("strFileNameFull")%>" ><img src="images/icon_copy.gif" /></a></dd>
									</dl>
								</li>
<%
		IF tCount = 5 THEN tCount = 0
	RS.MOVENEXT
	WEND

	IF tCount <> 0 THEN
		FOR tmpFor = tCount TO 4
%>
								<li<% IF tmpFor = 4 THEN %> class="last"<% END IF %>>
									<div class="blank_thumb"><p>&nbsp;</p></div>
								</li>
<%
		NEXT
	END IF
%>
							</ul>
						</div>
					</div>
					<div class="fileboxListFoot"></div>
					<div id="pagingArea">
					<%=GetPageHTML(intPage, intPageCount, objXmlLang("btn_prev_page"), objXmlLang("btn_next_page"), "goPage") %>
					</div>
<%
	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET objRoot = NOTHING : SET rootNode = NOTHING
%>