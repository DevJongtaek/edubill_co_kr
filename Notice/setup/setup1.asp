<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/arty.css" type="text/css" media="all" charset="utf-8" />
<title>아티보드설치</title>
</head>
<body>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">

	$(document).ready(function() {

		if ($("#theForm #site_path").val() == "")
			$("#theForm #site_path").val("http://" + location.href.split("//")[1].substr(0,location.href.split("//")[1].indexOf("/")) + "/");

		if ($("#theForm #board_path").val() == "")
			$("#theForm #board_path").val("http://" + location.href.split("//")[1].substr(0,location.href.split("//")[1].indexOf("/")) + "/bbs/");

		$("#theForm").submit(function(){

			if ($("#theForm #db_ip").val().replace(/\s/g, "").length == 0) {
				alert("DB 호스트 네임 정보를 입력하세요.");$("#theForm #db_ip").focus();return false;
			}

			if ($("#theForm #db_port").val().replace(/\s/g, "").length == 0) {
				alert("DB Port 정보를 입력하세요.");$("#theForm #db_port").focus();return false;
			}

			if ($("#theForm #db_name").val().replace(/\s/g, "").length == 0) {
				alert("DB 이름 정보를 입력하세요.");$("#theForm #db_name").focus();return false;
			}

			if ($("#theForm #db_id").val().replace(/\s/g, "").length == 0) {
				alert("DB 아이디 정보를 입력하세요.");$("#theForm #db_id").focus();return false;
			}

			if ($("#theForm #db_password").val().replace(/\s/g, "").length == 0) {
				alert("DB 비밀번호 정보를 입력하세요.");$("#theForm #db_password").focus();return false;
			}

			if ($("#theForm #site_path").val().replace(/\s/g, "").length == 0) {
				alert("웹사이트 경로 정보를 입력하세요.");$("#theForm #site_path").focus();return false;
			}

			if ($("#theForm #board_path").val().replace(/\s/g, "").length == 0) {
				alert("아티보드 웹 경로 정보를 입력하세요.");$("#theForm #board_path").focus();return false;
			}

			$("#theForm").attr("method", "post");
			$("#theForm").attr("action", "setup1_ok.asp");

		});

	});

</script>
<%
	DIM sitePath, boardPath

	sitePath = "http://" & Request.ServerVariables("SERVER_NAME") & "/"
	boardPath = LCASE(REPLACE(UCASE("http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("PATH_INFO")), "SETUP/SETUP1.ASP", ""))
%>
<form id="theForm">
<input type="hidden" name="p_version" value="V000000001" />
<div class="wrap">
	<h1 class="logo"><img src="images/logo.jpg" /></h1>
	<div class="content_wrap">
		<div class="content">
			<h2><img src="images/title_install.jpg" /></h2>
			<h3><img src="images/sub_title2.jpg" /></h3>
			<div class="text">
			<p>아티보드 3.0 버전 설치시 DB 정보는 웹아티 (http://webarty.com) 에 접속되어 신규 설치시 최신정보로 설치가 됩니다.<br/>
			사용하실 <span style="color:#F00">DB 서버가 외부에서 접근이 가능할 경우에만 설치를 하셔서 사용이 가능</span>하며, <span style="color:#F00">DB 정보는 설치시에만 사용되며 어떠한 정보도 저장되지 않습니다.</span></p><br/>
<span style="color:#7389F8; font-weight:bold; letter-spacing:-1px;">아티보드경로 하위 폴더에 있는 pds 및 files 폴더에 쓰기, 수정, 삭제 권한이 있어야 정상적으로 설치 및 사용할 수 있습니다.11</span><br/><br />
			<table class="table_db">
			<colspan><col width="160" /><col width="*" /></colspan>
				<tr>
					<th>DB 호스트 네임</th>
					<td>
						<input name="db_ip" type="text" class="input_text" id="db_ip" />
						<p><span class="ex">설치 프로그램은 웹아티에서 실행되므로 외부에서 접근이 가능한 아이피 정보를 입력하세요.</span></p>
					</td>
				</tr>
				<tr>
					<th>DB Port</th>
					<td>
						<input name="db_port" type="text" class="input_text" id="db_port" value="1433">
						<span class="ex">기본포트는 1433이며, 포트가 다를 경우 포트번호를 입력하세요.</span>
					</td>
				</tr>
				<tr>
					<th>DB 이름</th>
					<td>
						<input name="db_name" type="text" class="input_text" id="db_name">
						<span class="ex">아티보드가 설치될 DB의 이름을 입력하세요.</span>
					</td>
				</tr>
				<tr>
					<th>DB 아이디</th>
					<td>
						<input name="db_id" type="text" class="input_text" id="db_id">
						<span class="ex">아티보드가 설치될 DB의 접속 아이디를 입력하세요.</span>
					</td>
				</tr>

				<tr>
					<th>DB 비밀번호</th>
					<td>
						<input name="db_password" type="text" class="input_text" id="db_password">
						<span class="ex">DB 접속 비밀번호를 입력하세요.</span>
					</td>
				</tr>
				<tr>
					<th>웹사이트 경로</th>
					<td>
						<input name="site_path" type="text" class="input_text" id="site_path" value="<%=sitePath%>">
						<span class="ex">예) http://webarty.com/</span>
					</td>
				</tr>
				<tr>
					<th>아티보드 웹 경로</th>
					<td>
						<input name="board_path" type="text" class="input_text" id="board_path" value="<%=boardPath%>">
						<span class="ex">예) http://webarty.com/bbs/</span>
					</td>
				</tr>
				<tr>
					<th>업로드 컴포넌트</th>
					<td>
						<select id="upload_componet" name="upload_componet">
						<option value="dext">Dext Upload Pro (http://devpia.com)</option>
						<option value="abc">Abc Upload (http://websupergoo.com)</option>
						<option value="tabs">Tabs Upload (http://tabslab.com)</option>
						</select>
					</td>
				</tr>
			</table>
			</div>
			<div class="btn_wrap">
				<ul>
					<li><input type="image" src="images/blank.gif" class="btn_next" alt="다음"></li>
				</ul>
			</div>
		</div>
		<div class="copyright">
			<img src="images/copyright.jpg" alt="copyright">
		</div>
	</div>
</div>
</form>
</body>
</html>