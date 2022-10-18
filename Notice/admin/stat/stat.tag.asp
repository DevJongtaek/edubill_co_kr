<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 6
	menuID      = "F08"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.stat.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intToalCount

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_TAG_LIST] '', 'Y' ")

	IF RS.EOF THEN intTotalCount = 0 ELSE intTotalCount = RS(0)
%>
		<div id="content">
			<form id="theForm" method="post" action="?act=statsite">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_tag")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_tag")%></p>
			<div id="subBody">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalNum"><%=intTotalCount%></span></p>
					</div>
				</div>
				<div class="tag_box tagCloud fg">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_TAG_LIST] '', 'N' ")

	IF RS.EOF THEN
%>
				<%=objXmlLang("text_no_tag")%>
<%
	ELSE
%>
					<ul>
<%
		DIM strTagClss

		WHILE NOT(RS.EOF)

			IF RS("intCount") < 5 THEN
				strTagClss = "i1"
			ELSEIF RS("intCount") < 10 THEN
				strTagClss = "i2"
			ELSEIF RS("intCount") < 20 THEN
				strTagClss = "i3"
			ELSEIF RS("intCount") < 30 THEN
				strTagClss = "i4"
			ELSEIF RS("intCount") < 50 THEN
				strTagClss = "i5"
			END IF
%>
						<li class="<%=strTagClss%>"><%=RS("strTag")%> <span class="num">(<%=RS("intCount")%>)</span></li>
<%
		RS.MOVENEXT
		WEND
%>
					</ul>
<%
	END IF
%>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->