<!-- #include file = "../../../Include/Member.Out.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.out.js"></script>
<form id="theForm" method="post">
<div id="bodyWrap" class="member_out">
	<div class="page_navi">
		<h4><%=objXmlLang("member_leave")%></h4>
	</div>
	<div class="description"><%=objXmlLang("about_leave")%></div>
	<p class="warning1"><%=objXmlLang("about_leave_reason")%></p>
		<ul class="delreasonlist box01">
<%
	FOR tmpFor = 0 TO UBOUND(CONF_strOutMemo)
%>
			<li>
				<input type="radio" id="outmemo_<%=tmpFor%>" name="outmemo" value="<%=CONF_strOutMemo(tmpFor)%>" class="input_check"  /> <label for="outmemo_<%=tmpFor%>"><%=CONF_strOutMemo(tmpFor)%></label>
			</li>
<%
	NEXT
%>
			<li>
				<input type="radio" id="outmemo_<%=tmpFor+1%>" name="outmemo" value="1" class="input_check"  /> <label for="outmemo_<%=tmpFor+1%>"><%=objXmlLang("user_input")%></label>&nbsp;<input type="text" id="outmemouser" name="outmemouser" class="input_text outmemo" />
			</li>
		</ul>
		<p class="warning1"><%=objXmlLang("about_leave_password")%></p>
		<div class="box01 nodescript">
<fieldset>
    	<dl class="fields">
				<ul>
					<li>
						<dt class="password"><%=objXmlLang("user_id")%></dt>
						<dd class="b"><%=SESSION("userID")%></dd>
					</li>
					<li>
						<dt class="password"><%=objXmlLang("password")%></dt>
						<dd><input type="password" id="password" name="password" class="input_text password" /></dd>
					</li>
				</ul>
			</dl>
			</fieldset>
		</div>
 		<div class="btn_area">
			<span class="button large strong"><input type="submit" value="<%=objXmlLang("cmd_confirm")%>" /></span>&nbsp;
			<span class="button large strong"><a href="/"><%=objXmlLang("cmd_cancel")%></a></span>
 		</div>

</div>
</form>
<!-- #include file = "common.footer.asp" -->