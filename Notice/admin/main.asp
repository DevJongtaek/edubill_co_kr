<script type="text/javascript">

	$(document).ready(function(){

		$.ajax({type: "POST", url: "action/?subAct=notice", dataType: "json", success: function(responseText){
			if (responseText.length > 0){
				for(var i = 0; i < responseText.length; i++){
					$(".mainNotice").append("<li class='list'><a href=\"" + responseText[i].link + "\" onClick=\"window.open(this.href);return false;\" title=\"" + responseText[i].title + "\">" + responseText[i].title + "</a></li>");
				}
			}
		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		});

		$("a[name=schedule_link]").click(function(){
			$("#extForm #nowYear").val($(this).attr("id").split(",")[0]);
			$("#extForm #nowMonth").val($(this).attr("id").split(",")[1]);
			$("#extForm").attr("action", "?act=schedule");
			$("#extForm").submit();
		});

	 });

</script>
<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 0
	menuID      = "000"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.main.xml"
%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<body>
<!-- #include file = "comm/header.asp" -->
<div id="wrap">
	<div id="container_main">
		<div id="side_main">
			<div id="sideinfo">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & SESSION("memberSeq") & "' ")
%>
				<div class="ownerInfo">
					<div class="profile">
						<img src="images/ico_admin.png" width="16" height="16" alt="admin" class="iconAdmin">
						<span class="nickName"><%=SESSION("nickName")%> (<%=SESSION("userID")%>)</span>
					</div>
					<div class="siteCnt">
						<ul>
							<li><label><%=objXmlLang("text_posts")%></label><span><%=MID(FORMATCURRENCY(RS("intArticle")), 2, LEN(FORMATCURRENCY(RS("intArticle"))))%></span></li>
							<li><label><%=objXmlLang("text_comment")%></label><span><%=MID(FORMATCURRENCY(RS("intComment")), 2, LEN(FORMATCURRENCY(RS("intComment"))))%></span></li>
						</ul>
					</div>
					<ul class="connDate">
						<li><%=objXmlLang("text_last_connect")%> : <%=RS("intVisit")%></li>
						<li><%=RS("strVisitIp")%></li>
						<li><%=RS("strVisitDate")%></li>
					</ul>
				</div>
				<div class="mainNotice">
					<div class="line">
						<h4><a href="http://www.webarty.com/bbs/?bid=notice" target="_blank"><%=objXmlLang("text_webarty_notice")%></a></h4><a href="http://www.webarty.com/bbs/?bid=notice" target="_blank" class="more fr"><%=objXmlLang("btn_more")%></a>
					</div>
					<ul class="bbsList"></ul>
				</div>
			</div>
		</div>


		<div id="content_main">
			<div id="centerContainer">


				<div class="centerItemL">
					<div class="siteSection">
						<ul>
							<li class="titleL"><%=objXmlLang("text_site_state")%></li>
							<li class="date"><%=REPLACE(LEFT(NOW(),10), "-", ".")%></li>
						</ul>
					</div>
					<div class="siteSectionContent">
					<table>
						<col width="106" /><col span="3" width="80" />
						<thead>
						<tr>
							<th><%=objXmlLang("text_state_type")%></th>
							<th><%=objXmlLang("text_yesterday")%></th>
							<th><%=objXmlLang("text_today")%></th>
							<th><%=objXmlLang("text_total")%></th>
						</tr>
						</thead>
						<tbody>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_ADMIN_MAIN] '1' ")

	DIM iCount, strStatTitle
	iCount = 0
	WHILE NOT(RS.EOF)
		iCount = iCount + 1
		SELECT CASE iCount
		CASE 1 : strStatTitle = objXmlLang("text_join")
		CASE 2 : strStatTitle = objXmlLang("text_login")
		CASE 3 : strStatTitle = objXmlLang("text_posts")
		CASE 4 : strStatTitle = objXmlLang("text_comment")
		END SELECT
%>
						<tr>
							<th><%=strStatTitle%></th>
							<td><%=MID(FORMATCURRENCY(RS(0)), 2, LEN(FORMATCURRENCY(RS(0))))%></td>
							<td><%=MID(FORMATCURRENCY(RS(1)), 2, LEN(FORMATCURRENCY(RS(1))))%></td>
							<td><%=MID(FORMATCURRENCY(RS(2)), 2, LEN(FORMATCURRENCY(RS(2))))%></td>
						</tr>
<%
	RS.MOVENEXT
	WEND
%>

						</tbody>
					</table>
					</div>
				</div>
				<div class="centerItemR">
					<div class="siteSection">
						<ul>
							<li class="titleR"><%=objXmlLang("text_config")%></li>
						</ul>
					</div>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_VERSION] 'R' ")

	
%>
					<div class="siteConfig">
						<ul>
							<li><label><%=objXmlLang("text_version")%></label>&nbsp;<img src="images/line1.gif" alt="" class="vam imgC" /><span><%=RS("strVersion")%> (<%=LEFT(RS("strinstallDate"),10)%>)</span>
							</li>
							<li><label><%=objXmlLang("text_default_domain")%></label>&nbsp;<img src="images/line1.gif" alt="" class="vam imgC" /><span><%=CONF_strSiteUrl%></span>
							</li>
							<li><label><%=objXmlLang("text_install_path")%></label>&nbsp;<img src="images/line1.gif" alt="" class="vam imgC" /><span><%=GetNowFolderPath("../") & "\"%></span>
							</li>
							<li><label><%=objXmlLang("text_last_update")%></label>&nbsp;<img src="images/line1.gif" alt="" class="vam imgC" /><span><%=RS("strinstallDate")%></span>
							<li><label><%=objXmlLang("text_pds_path")%></label>&nbsp;<img src="images/line1.gif" alt="" class="vam imgC" /><span><%=GetNowFolderPath("../") & "\"%><%=CONF_strFilePath%>\</span>
							<li><label><%=objXmlLang("text_upload_componet")%></label>&nbsp;<img src="images/line1.gif" alt="" class="vam imgC" /><span><%=GetOptionArrText(objXmlLang("option_componet"), CONF_strUploadComponet)%></span>
							</li>
						</ul>
					</div>
				</div>


				<div class="centerItemL">
					<div class="centerHeader">
						<h4 class="fl"><a href="?act=boardsearch"  target="_self"><%=objXmlLang("title_new_posts")%></a></h4>
						<a href="?act=boardsearch"  target="_self" class="more fr"><%=objXmlLang("btn_more")%></a>
					</div>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_LIST_ADMIN] 'N', '', '', '', '' ")

	IF RS.EOF THEN
%>
					<div class="noData"><%=objXmlLang("text_no_posts")%></div>
<%
	ELSE
%>
					<div>
						<ul class="listType">
<%
		WHILE NOT(RS.EOF)
%>
							<li>
								<span class="wrapTitle">
								<a href="../?act=bbs&subAct=view&bid=<%=RS("strBoardID")%>&seq=<%=RS("intSeq")%>" class="wrapTitle" title="<%=RS("strTitle")%>" target="_blank"><%=GetCutDispData(RS("strTitle"), 26, "..")%></a>
								</span>
								<span class="date"><%=RIGHT(REPLACE(LEFT(RS("strRegDate"),10), "-", "."),8)%></span>
							</li>
<%
		RS.MOVENEXT
		WEND
%>
						</ul>
					</div>
<%
	END IF
%>
				</div>
				<div class="centerItemR">
					<div class="centerHeader">
						<h4 class="fl"><a href="?act=commentsearch"  target="_self"><%=objXmlLang("title_new_comments")%></a></h4>
						<a href="?act=commentsearch"  target="_self" class="more fr"><%=objXmlLang("btn_more")%></a>
					</div>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_LIST_ADMIN] 'N', '', '', '', '' ")

	IF RS.EOF THEN
%>
					<div class="noData"><%=objXmlLang("text_no_posts")%></div>
<%
	ELSE
%>
					<div>
						<ul class="listType">
<%
		WHILE NOT(RS.EOF)
%>
							<li>
								<span class="wrapTitle"><a href="../?act=bbs&subAct=view&bid=<%=RS("strBoardID")%>&seq=<%=RS("intBoardSeq")%>#comment_id=<%=RS("intSeq")%>" target="_blank"><%=GetCutDispData(GetStripTags(RS("strContent")), 20, "..")%></a></span>
								<span class="date"><%=RIGHT(REPLACE(LEFT(RS("strRegDate"),10), "-", "."),8)%></span>
							</li>
<%
		RS.MOVENEXT
		WEND
%>
						</ul>
					</div>
<%
	END IF
%>
				</div>
				<div class="centerItemL" style="float:left;">
					<div class="centerHeader">
						<h4 class="fl"><a href="?act=boarddeclared"  target="_self"><%=objXmlLang("title_declared_posts")%></a></h4>
						<a href="?act=boarddeclared"  target="_self" class="more fr"><%=objXmlLang("btn_more")%></a>
					</div>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_DECLARED_LIST] 'L', 'B', '1', '6' ")

	IF RS.EOF THEN
%>
					<div class="noData"><%=objXmlLang("text_no_posts")%></div>
<%
	ELSE
%>
					<div>
						<ul class="listType">
<%
		WHILE NOT(RS.EOF)
%>
							<li>
								<span class="wrapTitle"><a href="../?act=bbs&subAct=view&bid=<%=RS("strBoardID")%>&seq=<%=RS("intBoardSeq")%>" target="_blank"><%=GetCutDispData(GetStripTags(RS("strTitle")), 20, "..")%></a></span>
								<span class="date"><%=RIGHT(REPLACE(LEFT(RS("strRegDate"),10), "-", "."),8)%></span>
							</li>
<%
		RS.MOVENEXT
		WEND
%>
						</ul>
					</div>
<%
	END IF
%>
				</div>
				<div class="centerItemR">
					<div class="centerHeader">
						<h4 class="fl"><a href="?act=commentdeclared"  target="_self"><%=objXmlLang("title_declared_comments")%></a></h4>
						<a href="?act=commentdeclared"  target="_self" class="more fr"><%=objXmlLang("btn_more")%></a>
					</div>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_DECLARED_LIST] 'L', 'C', '1', '6' ")

	IF RS.EOF THEN
%>
					<div class="noData"><%=objXmlLang("text_no_posts")%></div>
<%
	ELSE
%>
					<div>
						<ul class="listType">
<%
		WHILE NOT(RS.EOF)
%>
							<li>
								<span class="wrapTitle"><a href="../?act=bbs&subAct=view&bid=<%=RS("strBoardID")%>&seq=<%=RS("intBoardSeq")%>#comment_id=<%=RS("intSeq")%>" target="_blank"><%=GetCutDispData(GetStripTags(RS("strComment")), 20, "..")%></a></span>
								<span class="date"><%=RIGHT(REPLACE(LEFT(RS("strRegDate"),10), "-", "."),8)%></span>
							</li>
<%
		RS.MOVENEXT
		WEND
%>
						</ul>
					</div>
<%
	END IF
%>
				</div>
				<div class="centerItemL">
					<div class="centerHeader">
						<h4 class="fl"><a href="?act=schedule"  target="_self"><%=objXmlLang("title_schedule")%></a></h4>
						<a href="?act=schedule"  target="_self" class="more fr"><%=objXmlLang("btn_more")%></a>
					</div>
<%
	DIM intNowDate
	intNowDate = YEAR(NOW)
	IF LEN(MONTH(NOW)) = 1 THEN intNowDate = intNowDate & "0"
	intNowDate = intNowDate & MONTH(NOW)
	IF LEN(DAY(NOW)) = 1 THEN intNowDate = intNowDate & "0"
	intNowDate = intNowDate & DAY(NOW)

	SET RS = DBCON.EXECUTE("[ARTY30_SP_SCHEDULE_LIST] '" & intNowDate & "', '1' ")

	IF RS.EOF THEN
%>
					<div class="noData"><%=objXmlLang("text_no_schedules")%></div>
<%
	ELSE
%>
					<div>
						<ul class="listType">
<%
		WHILE NOT(RS.EOF)
%>
							<li>
								<span class="wrapTitle"><a href="#" name="schedule_link" id="<%=YEAR(RS("strStartDate"))%>,<%=MONTH(RS("strStartDate"))%>" onClick="return false;"><%=RS("strTitle")%></a></span>
								<span class="date"><%=RIGHT(REPLACE(LEFT(RS("strStartDate"),10), "-", "."),8)%></span>
							</li>
<%
		RS.MOVENEXT
		WEND
%>
						</ul>
					</div>
<%
	END IF
%>
				</div>
				<div class="centerItemR">
					<div class="centerHeader">
						<h4 class="fl"><a href="?act=memberlist"  target="_self"><%=objXmlLang("title_new_members")%></a></h4>
						<a href="?act=memberlist"  target="_self" class="more fr"><%=objXmlLang("btn_more")%></a>
					</div>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LIST] 'N', 6, 1 ")

	IF RS.EOF THEN
%>
					<div class="noData"><%=objXmlLang("text_no_members")%></div>
<%
	ELSE
%>
					<div>
						<ul class="listType">
<%
		WHILE NOT(RS.EOF)
%>
							<li>
								<span class="wrapTitle"><a href="?act=memberdisp&intSeq=<%=RS("intSeq")%>"><%=RS("strNickName")%> (<%=RS("strLoginID")%>)</a></span>
								<span class="date"><%=RIGHT(REPLACE(LEFT(RS("strRegDate"),10), "-", "."),8)%></span>
							</li>
<%
		RS.MOVENEXT
		WEND
%>
						</ul>
					</div>
<%
	END IF
%>
				</div>
				<div class="centerItemL">
					<div class="centerHeader">
						<h4 class="fl"><a href="?act=statmemberjoindate"  target="_self"><%=objXmlLang("title_members_stat")%></a></h4>
						<a href="?act=statmemberjoindate"  target="_self" class="more fr"><%=objXmlLang("btn_more")%></a>
					</div>
					<div>
<%
	DIM strPrevMonthDay(7)
	DIM intDayCount1, intDayCount2, intDayCount3, intDayCount4, intDayCount5, intDayCount6, intDayCount7
	DIM intDayPerc1, intDayPerc2, intDayPerc3, intDayPerc4, intDayPerc5, intDayPerc6, intDayPerc7

	FOR tmpFor = 1 TO 7
		SELECT CASE tmpFor
		CASE 1 : strPrevMonthDay(tmpFor) = MONTH(DATEADD("d", -7, NOW())) & "/" & DAY(DATEADD("d", -7, NOW()))
		CASE 2 : strPrevMonthDay(tmpFor) = MONTH(DATEADD("d", -6, NOW())) & "/" & DAY(DATEADD("d", -6, NOW()))
		CASE 3 : strPrevMonthDay(tmpFor) = MONTH(DATEADD("d", -5, NOW())) & "/" & DAY(DATEADD("d", -5, NOW()))
		CASE 4 : strPrevMonthDay(tmpFor) = MONTH(DATEADD("d", -4, NOW())) & "/" & DAY(DATEADD("d", -4, NOW()))
		CASE 5 : strPrevMonthDay(tmpFor) = MONTH(DATEADD("d", -3, NOW())) & "/" & DAY(DATEADD("d", -3, NOW()))
		CASE 6 : strPrevMonthDay(tmpFor) = MONTH(DATEADD("d", -2, NOW())) & "/" & DAY(DATEADD("d", -2, NOW()))
		CASE 7 : strPrevMonthDay(tmpFor) = MONTH(DATEADD("d", -1, NOW())) & "/" & DAY(DATEADD("d", -1, NOW()))
		END SELECT
	NEXT

	SET RS = DBCON.EXECUTE("[ARTY30_SP_ADMIN_MAIN] '2' ")

	IF RS(0) = 0 THEN
		intDayCount1 = 0 : intDayPerc1  = "0%"
		intDayCount2 = 0 : intDayPerc2  = "0%"
		intDayCount3 = 0 : intDayPerc3  = "0%"
		intDayCount4 = 0 : intDayPerc4  = "0%"
		intDayCount5 = 0 : intDayPerc5  = "0%"
		intDayCount6 = 0 : intDayPerc6  = "0%"
		intDayCount7 = 0 : intDayPerc7  = "0%"
	ELSE
		intDayCount1 = RS(1) : intDayPerc1 = FormatPercent(RS(1) / RS(0))
		intDayCount2 = RS(2) : intDayPerc2 = FormatPercent(RS(2) / RS(0))
		intDayCount3 = RS(3) : intDayPerc3 = FormatPercent(RS(3) / RS(0))
		intDayCount4 = RS(4) : intDayPerc4 = FormatPercent(RS(4) / RS(0))
		intDayCount5 = RS(5) : intDayPerc5 = FormatPercent(RS(5) / RS(0))
		intDayCount6 = RS(6) : intDayPerc6 = FormatPercent(RS(6) / RS(0))
		intDayCount7 = RS(7) : intDayPerc7 = FormatPercent(RS(7) / RS(0))
	END IF
%>
						<div class="vGraph">
							<ul>
								<li><span class="gTerm"><%=strPrevMonthDay(1)%></span><span class="gBar" style="height:<%=intDayPerc1%>"><span><%=RS(1)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(2)%></span><span class="gBar" style="height:<%=intDayPerc2%>"><span><%=RS(2)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(3)%></span><span class="gBar" style="height:<%=intDayPerc3%>"><span><%=RS(3)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(4)%></span><span class="gBar" style="height:<%=intDayPerc4%>"><span><%=RS(4)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(5)%></span><span class="gBar" style="height:<%=intDayPerc5%>"><span><%=RS(5)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(6)%></span><span class="gBar" style="height:<%=intDayPerc6%>"><span><%=RS(6)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(7)%></span><span class="gBar" style="height:<%=intDayPerc7%>"><span><%=RS(7)%></span></span></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="centerItemR">
					<div class="centerHeader">
						<h4 class="fl"><a href="?act=statsite"  target="_self"><%=objXmlLang("title_site_stat")%></a></h4>
						<a href="?act=statsite"  target="_self" class="more fr"><%=objXmlLang("btn_more")%></a>
					</div>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_ADMIN_MAIN] '3' ")

	IF RS(0) = 0 OR ISNULL(RS(0)) = True THEN
		intDayCount1 = 0 : intDayPerc1  = "0%"
		intDayCount2 = 0 : intDayPerc2  = "0%"
		intDayCount3 = 0 : intDayPerc3  = "0%"
		intDayCount4 = 0 : intDayPerc4  = "0%"
		intDayCount5 = 0 : intDayPerc5  = "0%"
		intDayCount6 = 0 : intDayPerc6  = "0%"
		intDayCount7 = 0 : intDayPerc7  = "0%"
	ELSE
		intDayCount1 = RS(1) : intDayPerc1 = FormatPercent(RS(1) / RS(0))
		intDayCount2 = RS(2) : intDayPerc2 = FormatPercent(RS(2) / RS(0))
		intDayCount3 = RS(3) : intDayPerc3 = FormatPercent(RS(3) / RS(0))
		intDayCount4 = RS(4) : intDayPerc4 = FormatPercent(RS(4) / RS(0))
		intDayCount5 = RS(5) : intDayPerc5 = FormatPercent(RS(5) / RS(0))
		intDayCount6 = RS(6) : intDayPerc6 = FormatPercent(RS(6) / RS(0))
		intDayCount7 = RS(7) : intDayPerc7 = FormatPercent(RS(7) / RS(0))
	END IF
%>
					<div>
						<div class="vGraph">
							<ul>
								<li><span class="gTerm"><%=strPrevMonthDay(1)%></span><span class="gBar" style="height:<%=intDayPerc1%>"><span><%=RS(1)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(2)%></span><span class="gBar" style="height:<%=intDayPerc2%>"><span><%=RS(2)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(3)%></span><span class="gBar" style="height:<%=intDayPerc3%>"><span><%=RS(3)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(4)%></span><span class="gBar" style="height:<%=intDayPerc4%>"><span><%=RS(4)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(5)%></span><span class="gBar" style="height:<%=intDayPerc5%>"><span><%=RS(5)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(6)%></span><span class="gBar" style="height:<%=intDayPerc6%>"><span><%=RS(6)%></span></span></li>
								<li><span class="gTerm"><%=strPrevMonthDay(7)%></span><span class="gBar" style="height:<%=intDayPerc7%>"><span><%=RS(7)%></span></span></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form id="extForm" name="extForm" method="post">
<input type="hidden" id="nowYear" name="nowYear">
<input type="hidden" id="nowMonth" name="nowMonth">
</form>
</body>
<!-- #include file = "comm/footer.asp" -->