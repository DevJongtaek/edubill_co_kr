<!-- #include file = "../../../Include/Member.Info.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="js/Calendar.js"></script>
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.info.js"></script>
<div id="bodyWrap" class="member_info">
	<div class="page_navi">
		<h4><%=objXmlLang("profile")%></h4>
	</div>
	<div class="description"><%=objXmlLang("about_profile_safety")%></div>
 		<div class="table01">
		<table width="100%">
<%
	DIM tmpArrData
	iCount = 0
%>
		<tr class="first">
			<th class="require"><%=objXmlLang("member_group")%></th>
			<td class="default"><%=objMemberInfo("strGroupName")%></td>
		</tr>
<%
	FOR tmpFor = 0 TO UBOUND(info.fieldName)
		IF info.fieldName(tmpFor) <> "" THEN
			iCount = iCount + 1
			SELECT CASE info.formType(tmpFor)
			CASE "userid", "nick", "text", "url", "tel", "mobile", "textarea", "sign", "checkbox", "corpnum"
%>
		<tr>
			<th class="require"><%=info.title(tmpFor)%></th>
			<td class="default"><%=objMemberInfo(info.fieldName(tmpFor))%></td>
		</tr>
<%
			CASE "email"
%>
		<tr>
			<th class="require"><%=info.title(tmpFor)%></th>
			<td class="default"><%=objMemberInfo(info.fieldName(tmpFor) & "1")%>@<%=objMemberInfo(info.fieldName(tmpFor) & "2")%></td>
		</tr>
<%
			CASE "select", "radio"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
<%
	SELECT CASE info.fieldName(tmpFor)
	CASE "strSex", "bitMailing", "bitOpenInfo", "bitMemo"
		RESPONSE.WRITE GetOptionArrText("1,0$$$" & REPLACE(info.formData(tmpFor), CHR(13)&CHR(10), ","), objMemberInfo(info.fieldName(tmpFor)))
	CASE ELSE
		RESPONSE.WRITE GetOptionArrText(REPLACE(info.formData(tmpFor), CHR(13)&CHR(10), ",") & "$$$" & REPLACE(info.formData(tmpFor), CHR(13)&CHR(10), ","), objMemberInfo(info.fieldName(tmpFor)))
	END SELECT
%>
      </td>
		</tr>
<%
			CASE "birthday"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<%=GetReplaceDateStr(objMemberInfo(info.fieldName(tmpFor)), ".")%>&nbsp;<%=GetOptionArrText(objXmlLang("option_lunar_gregorian"), RIGHT(objMemberInfo(info.fieldName(tmpFor)), 1))%>
      </td>
		</tr>
<%
			CASE "date"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default"><%=GetReplaceDateStr(objMemberInfo(info.fieldName(tmpFor)), ".")%></td>
		</tr>
<%
			CASE "marry"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<%=GetOptionArrText(objXmlLang("option_married"), LEFT(objMemberInfo(info.fieldName(tmpFor)), 1))%><% IF LEFT(objMemberInfo(info.fieldName(tmpFor)), 1) = "1" THEN %>&nbsp;<%=GetReplaceDateStr(RIGHT(objMemberInfo(info.fieldName(tmpFor)), 8), ".")%><% END IF %>
      </td>
		</tr>
<%
			CASE "addr"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
<%
			tmpArrData = objMemberInfo(info.fieldName(tmpFor))
			IF tmpArrData <> "" AND ISNULL(tmpArrData) = False THEN
				tmpArrData = SPLIT(tmpArrData, "$$$")
				IF UBOUND(tmpArrData) <> 2 THEN tmpArrData = SPLIT("$$$$$$", "$$$")
			ELSE
				tmpArrData = SPLIT("$$$$$$", "$$$")
			END IF
			IF tmpArrData(0) <> "" THEN tmpArrData(0) = LEFT(tmpArrData(0), 3) & "-" & RIGHT(tmpArrData(0), 3)
%>
			<%=tmpArrData(0)%>&nbsp;<%=tmpArrData(1)%>&nbsp;<%=tmpArrData(2)%>
			</td>
		</tr>
<%
			END SELECT
		END IF
	NEXT
%>
		<tr>
			<th class="require"><%=objXmlLang("activity_information")%></th>
			<td class="default"><%=objXmlLang("posts")%> : <%=objMemberInfo("intArticle")%> / <%=objXmlLang("comments")%> : <%=objMemberInfo("intComment")%> / <%=objXmlLang("point")%> : <%=objMemberInfo("intPoint")%></td>
		</tr>
		<tr>
			<th class="require"><%=objXmlLang("last_login")%></th>
			<td class="default"><%=objMemberInfo("strVisitDate")%></td>
		</tr>
		<tr>
			<th class="require"><%=objXmlLang("join_date")%></th>
			<td class="default"><%=objMemberInfo("strRegDate")%></td>
		</tr>
		</table>
		</div>
		<div class="btn_area">
			<span class="button large strong"><input type="button" id="btn_member_modify" value="<%=objXmlLang("cmd_member_modify")%>" /></span>
			<span class="button large strong"><input type="button" id="btn_prev_page" value="<%=objXmlLang("cmd_prev_page")%>" /></span>
		</div>
	</div>
<!-- #include file = "common.footer.asp" -->