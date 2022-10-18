<!-- #include file = "Member.Default.asp" -->
<%
	DIM REQ_strBid, REQ_intPage, REQ_intCategory, REQ_strOrderIndex, REQ_strOrderType, REQ_strSearchTarget, REQ_strSearchKeyword
	DIM REQ_strListType, REQ_intSeq

	REQ_strBid           = GetInputReplce(REQUEST.QueryString("bid"), "")
	REQ_intPage          = GetInputReplce(REQUEST.QueryString("page"), "")
	REQ_intCategory      = GetInputReplce(REQUEST.QueryString("category"), "")
	REQ_strOrderIndex    = GetInputReplce(REQUEST.QueryString("order_index"), "")
	REQ_strOrderType     = GetInputReplce(REQUEST.QueryString("order_type"), "")
	REQ_strSearchTarget  = GetInputReplce(REQUEST.QueryString("search_target"), "")
	REQ_strSearchKeyword = GetInputReplce(REQUEST.QueryString("search_keyword"), "")
	REQ_strListType      = GetInputReplce(REQUEST.QueryString("list_style"), "")
	REQ_intSeq           = GetInputReplce(REQUEST.QueryString("seq"), "")

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript">

	jQuery(function($){

		$.memberLoginComplate = function(){

			var strLoginAct_ = "<%=CONF_strLoginAct%>";
			var strLoginActMsg_ = "<%=CONF_strLoginActMsg%>";
			var strLoginActUrl_ = "<%=CONF_strLoginActUrl%>";

			function loginComplateScript(){
				<%=CONF_strLoginActScript%>
			}

			switch (strLoginAct_){
				case "0" : 
				if (strLoginActMsg_!=""){alert(strLoginActMsg_);}
					document.location.href = strLoginActUrl_;
					return false;
					break;
				case "1" : loginComplateScript(); break;
				case "2" : 
					if ($("#strPrevUrl", "#extForm").val()!="")
						document.location.href = $("#strPrevUrl", "#extForm").val();
					else
						document.location.href = strLoginActUrl_;
					return false;
					break;
			}
		}

	});

</script>
<form id="extForm">
<input type="hidden" name="strLoginID" id="strLoginID" value="" />
<input type="hidden" name="strPassword" id="strPassword" value="" />
<input type="hidden" name="bitIdSave" id="bitIdSave" value="" />
<input type="hidden" name="strPrevUrl" id="strPrevUrl" value="<%=REQUEST.FORM("strPrevUrl")%>" />
<input type="hidden" id="act" name="act" value="bbs" />
<input type="hidden" id="subAct" name="subAct" value="<% IF REQ_intSeq = "" THEN %>list<% ELSE %>view<% END IF %>" />
<input type="hidden" id="bid" name="bid" value="<%=REQ_strBid%>" />
<input type="hidden" id="seq" name="seq" value="<%=REQ_intSeq%>" />
<input type="hidden" id="page" name="page" value="<%=REQ_intPage%>" />
<input type="hidden" id="category" name="category" value="<%=REQ_intCategory%>" />
<input type="hidden" id="order_type" name="order_type" value="<%=REQ_strOrderType%>" />
<input type="hidden" id="search_target" name="search_target" value="<%=REQ_strSearchTarget%>" />
<input type="hidden" id="search_keyword" name="search_keyword" value="<%=REQ_strSearchKeyword%>" />
<input type="hidden" id="list_style" name="list_style" value="<%=REQ_strListType%>" />
</form>