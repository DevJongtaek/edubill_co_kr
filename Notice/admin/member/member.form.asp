<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C04"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.form.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<script type="text/javascript" src="../js/jquery.dragsort.js"></script>
<script type="text/javascript" src="member/js/member.form.js"></script>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description")%>
			</p>
			<div id="subBody" class="fl">
				<div id="menutree_wrap">
					<div id="menuListAndAddBtnWrap">
					<%=objXmlLang("page_sub_title_1")%>
					</div>
          <div class="menu_container_box scroll">
						<ul id="menu_container">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_LIST]")

	DIM listClass

	WHILE NOT(RS.EOF)

		IF RS("bitUse") = False THEN
			listClass = "point3"
		ELSE
			IF RS("strDefault") = "0" THEN
				listClass = "point1"
			ELSE
				listClass = "point2"
				IF RS("bitRquired") = True THEN listClass = listClass & " b"
			END IF
		END IF

		IF RS("bitCorp") = False THEN
%>
							<li id="<%=RS("strFieldName")%>" order="<%=RS("intOrder")%>" unselectable="on">
								<div unselectable="on" class="<%=listClass%>">
								<%=RS("strTitle")%>
								<% IF RS("strDefault") = "2" THEN %> [add]<% END IF %>
								</div>
							</li>
<%
		END IF
	RS.MOVENEXT
	WEND
%>
						</ul>
						<ul id="menu_container_fix">
<%
	RS.MOVEFIRST

	WHILE NOT(RS.EOF)

		IF RS("bitCorp") = True THEN
%>
							<li id="<%=RS("strFieldName")%>" order="<%=RS("intOrder")%>">
								<div><%=RS("strTitle")%></div>
							</li>
<%
		END IF

	RS.MOVENEXT
	WEND
%>
            </ul>
						</div>
						<div id="menu_btn_wrap">
							<div class="fl">
								<a href="#" onClick="MemberForm.MenuMove('pe'); return false;"><img src="images/blank.gif" width="20" height="20" class="btnMenuDown_02" /></a><a href="#" onClick="MemberForm.MenuMove('m'); return false;"><img src="images/blank.gif" width="20" height="20" class="btnMenuUp_01" /></a><a href="#" onClick="MemberForm.MenuMove('p'); return false;"><img src="images/blank.gif" width="20" height="20"class="btnMenuDown_01" /></a><a href="#" onClick="MemberForm.MenuMove('me'); return false;"><img src="images/blank.gif" width="20" height="20" class="btnMenuUp_02" /></a>
							</div>
							<div class="fr">
								<span class="button small"><input type="button" id="btn_order_reset" value="<%=objXmlLang("btn_order_reset")%>"></span>
							</div>
						</div>
					</div>
					<div id="detail_wrap">
						<h4><%=objXmlLang("page_sub_title_1")%></h4>
							<div id="detail_table"></div>
							<ul id="notice_default" class="menu_notice none">
								<li>
									<%=objXmlLang("page_sub_description_1")%>
								</li>
							</ul>
						</div>
					</div>
				</div>
<!-- #include file = "../comm/sub.foot.asp" -->