<!-- #include file = "../../../Include/Account.Pwd.Result.asp" -->
<!-- #include file = "common.header.asp" -->
<div id="bodyWrap" class="accountpwd_result">
	<div class="page_navi">
		<h4><%=objXmlLang("find_password")%></h4>
	</div>
	<div class="description"><%=objXmlLang("about_find_password_result")%></div>
	<div class="accountDiv">
		<h4><%=objXmlLang("temporary_password")%></h4>
		<div class="box01">
    	<fieldset>
<% IF FIND_Password <> "" THEN %>
			<ul>
				<li><b><%=FIND_Password%></b></li>
			</ul>
<% END IF %>
			<ul class="field_desc">
<%
	SELECT CASE CONF_strAccountFind
	CASE "0", "2"
%>
				<li class="list"><%=objXmlLang("about_temporary_password")%></li>
<%
	CASE "1"
%>
				<li class="list"><%=objXmlLang("about_temporary_password_email")%></li>
<%
	END SELECT
%>
			</ul>
  		</fieldset>
		</div>
		<div class="btn_area">
			<span class="button large strong"><a href="?act=member&subAct=findpwd"><%=objXmlLang("cmd_confirm")%></a></span>
		</div>
	</div>
</div>
<!-- #include file = "common.footer.asp" -->