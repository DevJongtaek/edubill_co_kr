<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<body id="bodyMember">
<!-- #include file = "../comm/header.asp" -->
<div id="wrap">
	<div id="container">
		<div id="sidemenu">
			<h3><%=iMenu.topMenuName(topMenu)%></h3>
			<ul id="subMenu">
<%
	FOR tmpFor = 1 TO UBOUND(iMenu.leftMenuID)
		IF iMenu.leftMenuID(tmpFor) <> "" THEN
			IF LEFT(menuID, 1) = LEFT(iMenu.leftMenuID(tmpFor), 1) THEN
%>
				<li<% IF menuID = iMenu.leftMenuID(tmpFor) THEN %> class="curMenu"<% END IF %>><a href="<%=iMenu.leftMenuLink(tmpFor)%>"><%=iMenu.leftMenuName(tmpFor)%></a></li>
<%
			END IF
		END IF
	NEXT
%>
			</ul>
		</div>