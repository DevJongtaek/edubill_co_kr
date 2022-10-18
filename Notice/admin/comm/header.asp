<%
	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop, tmpFor

	SET xmlDOM = server.CreateObject("MSXML2.DOMDOCUMENT.3.0")

	xmlDOM.async = false

	xmlDOM.Load langXmlPath & "lang\" & CONF_strLangType & "\lang.comm.menu.xml"
	Set objRoot = xmlDOM.documentElement

	SET rootNode = xmlDOM.selectNodes(LCASE("/root"))

	CLASS adminMenuClass

		DIM topMenuID(10), topMenuName(10), topMenuLink(10), leftMenuID(100), leftMenuName(100), leftMenuLink(100)
		DIM miniMenuName(10), miniMenuLink(10), miniMenuLinkTarget(10)

	END CLASS

	SET iMenu = New adminMenuClass

	WITH iMenu

		DIM tMenuCount, lMenuCount, mMenuCount
		FOR firstLoop = 0 To objRoot.childNodes.Length-1
			FOR secondLoop = 0 to objRoot.childNodes(firstLoop).childNodes.Length - 1
				SELECT CASE LCASE(rootNode(0).childNodes(firstLoop).nodename)
				CASE "topmenu"
					tMenuCount = tMenuCount + 1
					.topMenuID(tMenuCount)     = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("id")
					.topMenuName(tMenuCount)   = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).text
					.topMenuLink(tMenuCount)   = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("link")
				CASE "leftmenu"
					IF menuID <> "" THEN
						lMenuCount = lMenuCount + 1
						.leftMenuID(lMenuCount)   = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("id")
						.leftMenuName(lMenuCount) = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).text
						.leftMenuLink(lMenuCount) = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("link")
					END IF
				CASE "minimenu"
					mMenuCount = mMenuCount + 1
					.miniMenuName(mMenuCount) = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).text
					.miniMenuLink(mMenuCount) = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("link")
					.miniMenuLinkTarget(mMenuCount) = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("target")
				END SELECT
			NEXT
		NEXT

	END WITH
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<!-- #include file = "staff.check.asp" -->
<iframe src="../libs/blank.asp" style="width:0; height:0; display:none;"></iframe>
	<div id="header">
		<div id="menu" class="menu">
			<div class="inset">
				<div class="major">
					<ul>
						<li class="m0"><a href="?act=main" class="logo">Logo</a></li>
	<%
		FOR tmpFor = 1 TO UBOUND(iMenu.topMenuName)
			IF iMenu.topMenuName(tmpFor) <> "" THEN
	%>
						<li class="m<%=tmpFor%>" style="padding:8px 0 0 0;"><a href="#"><span<% IF tmpFor = topMenu THEN %> class="menu_on"<% END IF %>><%=iMenu.topMenuName(tmpFor)%></span></a>
							<div class="sub">
								<ul>
	<%
			FOR tmpSubFor = 1 TO UBOUND(iMenu.leftMenuID)
				IF iMenu.leftMenuID(tmpSubFor) <> "" THEN
					IF iMenu.topMenuID(tmpFor) = LEFT(iMenu.leftMenuID(tmpSubFor), 1) THEN
	%>
									<li><a href="<%=iMenu.leftMenuLink(tmpSubFor)%>"><span><%=iMenu.leftMenuName(tmpSubFor)%></span></a></li>
	<%
					END IF
				END IF
			NEXT
	%>
								</ul>
							</div>
						</li>
	<%
			END IF
		NEXT
	%>
					</ul>
				</div>
				<div class="aside">
					<ul>
<%
	FOR tmpFor = 1 TO UBOUND(iMenu.miniMenuName)
		IF iMenu.miniMenuName(tmpFor) <> "" THEN
			IF LEFT(iMenu.miniMenuLinkTarget(tmpFor), 6) = "window" THEN
%>
				<li class="m<%=tmpFor%>"><span><a href="#" onclick="openWindows('<%=iMenu.miniMenuLink(tmpFor)%>','','<%=SPLIT(iMenu.miniMenuLinkTarget(tmpFor), ",")(1)%>',<%=SPLIT(iMenu.miniMenuLinkTarget(tmpFor), ",")(2)%>,<%=SPLIT(iMenu.miniMenuLinkTarget(tmpFor), ",")(3)%>);return false;"><%=iMenu.miniMenuName(tmpFor)%></a></span></li>
<%
			ELSE
%>
					<li class="m<%=tmpFor%>"><span><a href="<%=iMenu.miniMenuLink(tmpFor)%>" target="<%=iMenu.miniMenuLinkTarget(tmpFor)%>"><%=iMenu.miniMenuName(tmpFor)%></a></span></li>
<%
			END IF
		END IF
	NEXT
%>
					</ul>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">

	var arApplMsg = new Array();

	$(document).ready(function() {

		$.ajax({
			url: "lang/<%=CONF_strLangType%>/<%=REPLACE(langXmlFile, "\", "/")%>", data: "xml",
			success: function(xml){
				$(xml).find("alert").find("item").each(function(idx) {
					arApplMsg[$(this).attr("name")] = $(this).text();
				});
			}, error: function(xhr){alert(xhr.status);}
		});

		$("#checkall").click(function(){
			if ($(this)[0].cid == "n" || $(this)[0].cid == null){
				$('input[type=checkbox]').prop("checked", true);
				$(this)[0].cid = "y";
			}else{
				$('input[type=checkbox]').prop("checked", false);
				$(this)[0].cid = "n";
			}
			return false;
		});

	});

jQuery(function($){
	
	// Menu
	var menu = $('div.menu');
	var major = $('div.major');
	var li_list = major.find('>ul>li');
	
	// Selected
	function onselectmenu(){
		var myclass = [];
		
		$(this).parent('li').each(function(){
			myclass.push( $(this).attr('class') );
		});
		
		myclass = myclass.join(' ');
		if (!major.hasClass(myclass)) major.attr('class','major').addClass(myclass);
	}
	
	// Show Menu
	function show_menu(){
		t = $(this);
		li_list.removeClass('active');
		t.parent('li').addClass('active');
		// IE7 or IE7 documentMode bug fix
		if($.browser.msie) {
			var v = document.documentMode || parseInt($.browser.version);
			if (v == 7) {
				var subWidth = t.next('div.sub').eq(-1).width();
				t.next('div.sub').css('width',subWidth);
			}
		}
	}

	li_list.find('>a').click(onselectmenu).mouseover(show_menu).focus(show_menu);
	
	// Hide Menu
	function hide_menu(){
		li_list.removeClass('active');
	}
	menu.mouseleave(hide_menu);
	li_list.find('div.sub>ul').mouseleave(hide_menu);
	
	//icon
	major.find('div.sub').prev('a').find('>span').append('<span class="i"></span>');
	
});

</script>