<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM langXmlPath, langXmlFile

	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.xml"

	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop
	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<script type="text/javascript" src="../js/jstree/_lib/jquery.cookie.js"></script>
<script type="text/javascript" src="../js/jstree/_lib/jquery.hotkeys.js"></script>
<script type="text/javascript" src="../js/jstree/jquery.jstree.js"></script>
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

		$.ajax({type: "POST", url: "action/?subAct=boardcategorylist", data: "intSrl=" + $("#intSrl", parent.document).val(), dataType: "json",
		success: function(responseText){

			$("#tree_menu").html('<ul><li id="0" rel="root"><a href="#"><ins>&nbsp;</ins><%=objXmlLang("text_root")%></a></li></ul>');

			for(var i = 0; i < responseText.length; i++){
				var text = responseText[i].title;
				var node_srl = responseText[i].code;
				var parent_srl = responseText[i].parentcode;
				var color = responseText[i].color;
				var document_count = responseText[i].document_count;
				var node = '';

				node = '<li id="' + node_srl + '"><a href="#"><ins>&nbsp;</ins>' + text

				if (document_count > 0)
					node += ' <span style="font-size:11px; color:#5768D7;">[' + document_count + ']</span>';
					
				node += '</a></li>';
				node = jQuery(node);

				if($("#" + parent_srl + "> ul").length == 0)
					$("#" + parent_srl).append($("<ul>"));
				$("#" + parent_srl + "> ul").append(node);
			}

			$("#tree_menu").jstree({ 
				"ui" : {
					"initially_select" : [ "tree_root" ]
				},
				"core" : { "initially_open" : [ "0" ] },
				"dnd" : {
					"drop_finish" : function () { 
						alert("DROP"); 
					},
					"drag_check" : function (data) {
						if(data.r.attr("id") == "0") {
							return false;
						}
						return { 
							after : false, 
							before : false, 
							inside : true 
						};
					},
					"drag_finish" : function () { 
						alert("DRAG OK"); 
					}
				},
				"themes" : {
					"theme" : "default", "dots" : true, "icons" : true
				},  
		
				"types" : {
					"valid_children" : [ "root" ],
					"types" : {
						"root" : {
							"valid_children" : [ "default" ],
								"start_drag" : false,
								"move_node" : false,
								"remove" : false,
								"rename" : false
						},
						"default" : {
							"valid_children" : [ "default" ]
						}
					}
				},
				"plugins" : ["themes", "html_data", "ui", "crrm", "dnd", "types", "hotkeys", "cookies", "contextmenu"]
			}).bind("create.jstree", function (e, data) {
		
					var parent_srl = data.rslt.parent.attr("id").replace("node_","");
					var node_position = data.rslt.position;
					var node_name = data.rslt.name;

					$.ajax({type: "POST", url: "action/?subAct=boardconfigcategory&Act=add&intSrl=" + $("#intSrl", parent.document).val(), data: "parent_srl=" + parent_srl + "&node_position=" + node_position + "&node_name=" + node_name, 
						success: function(responseText){
							$(data.rslt.obj).attr("id", responseText);
						 },
						 error: function(response){alert('error\n\n' + response.responseText);return false;}
					});
		
				}).bind("rename.jstree", function (e, data) {
		
					var node_srl = data.rslt.obj.attr("id").replace("node_","");
					var node_name = data.rslt.new_name;
		
					$.ajax({type: "POST", url: "action/?subAct=boardconfigcategory&Act=rename&intSrl=" + $("#intSrl", parent.document).val(), data: "node_srl=" + node_srl + "&node_name=" + node_name, 
						success: function(responseText){
						 },
						 error: function(response){alert('error\n\n' + response.responseText);return false;}
					});
				}).bind("remove.jstree", function (e, data) {
					data.rslt.obj.each(function () {
		
						var node_srl = this.id.replace("node_","");
		
						$.ajax({type: "POST", url: "action/?subAct=boardconfigcategory&Act=remove&intSrl=" + $("#intSrl", parent.document).val(), data: "node_srl=" + node_srl, 
							success: function(responseText){
								if (responseText != "0"){
									alert(arApplMsg["node_first_delete"]);
									$.jstree.rollback(data.rlbk);
									return false;
								}
							 },
							 error: function(response){alert('error\n\n' + response.responseText);return false;}
						});
					});
				}).bind("select_node.jstree", function(e, data){ 
		
					if (data.inst.get_selected().attr("id") != "0")
						parent.CategoryDetail(data.inst.get_selected().attr("id"));
		
				}).bind("move_node.jstree", function (e, data) { 
					data.rslt.o.each( function (i) { 
		
						var source_srl = $(this).attr("id").replace("node_","");
						var target_srl = data.rslt.np.attr("id").replace("node_","");
						var position = Number(data.rslt.cp + i);
		
						$.ajax({type: "POST", url: "action/?subAct=boardconfigcategory&Act=move&intSrl=" + $("#intSrl", parent.document).val(), data: "source_srl=" + source_srl + "&target_srl=" + target_srl + "&position=" + position, 
							success: function(responseText){
							 },
							 error: function(response){alert('error\n\n' + response.responseText);return false;}
						});
					});
				});

		 },
			 error: function(response){alert('error\n\n' + response.responseText);return false;}
		 
		});

		$("#btn_cate_add").click(function() {
			$("#tree_menu").jstree("create"); 
		});

		$("#btn_cate_modify").click(function() {
			$("#tree_menu").jstree("rename");
		});

		$("#btn_cate_remove").click(function() {
			$("#tree_menu").jstree("remove");
		});

		$("#btn_document_move").click(function() {
			parent.CategoryDocumentMove($("#tree_menu").jstree('get_selected').attr("id"));
		});

	});

</script>
				<div style="background:#f2f2f2; padding:10px 5px 10px 5px; color:#333; float:left; width:273px;">
					<span class="button medium icon"><span class="add"></span><a id="btn_cate_add"><%=objXmlLang("btn_add")%></a></span>
					<span class="button medium icon"><span class="refresh"></span><a id="btn_cate_modify"><%=objXmlLang("btn_modify")%></a></span>
					<span class="button medium icon"><span class="delete"></span><a id="btn_cate_remove"><%=objXmlLang("btn_remove")%></a></span>
					<span class="button medium"><a id="btn_document_move"><%=objXmlLang("btn_article_move")%></a></span>
				</div>
				<div id="tree_menu" class="tree_list" style="clear:both;"></div>
<%
	SET RS = NOTHING : DBCON.CLOSE
%>