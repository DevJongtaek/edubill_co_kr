<style type="text/css">

	.dimTable {width:100%; border-collapse:collapse; font-size:12px;}
	.dimTable th, .dimTable td {border:1px solid #CCCCCC; padding:3px; text-align:center;}
	.dimTable th {background:#E7E7E7;}
	.dimTable td.memo {text-align:left;}
	.info {padding:10px; border:1px solid #CCC; font-size:12px; margin:10px 0 20px 0; clear:both;}
	.info ul {list-style:none; margin:0; padding:0;}

</style>
<table border="0" cellspacing="0" cellpadding="0" class="dimTable">
<col width="100"><col width="100"><col width="80"><col width="*">
	<tr>
		<th>변수명</th>
		<th>변수타입</th>
		<th>길이</th>
		<th>설명</th>
	</tr>
	<tr>
		<td>intSeq</td>
		<td>bigint (숫자형)</td>
		<td>bigint</td>
		<td class="memo">댓글 고유번호</td>
	</tr>
	<tr>
		<td>intSrl</td>
		<td>int (숫자형)</td>
		<td>int</td>
		<td class="memo">게시판 고유번호</td>
	</tr>
	<tr>
		<td>intBoardSeq</td>
		<td>bigint (숫자형)</td>
		<td>30자</td>
		<td class="memo">게시글 고유번호</td>
	</tr>
	<tr>
		<td>strBoardID</td>
		<td>varchar(30)</td>
		<td>30자</td>
		<td class="memo">게시판 아이디</td>
	</tr>
	<tr>
		<td>intMemberSrl</td>
		<td>int (숫자형)</td>
		<td>int</td>
		<td class="memo">회원 고유 일련번호</td>
	</tr>
	<tr>
		<td>strUserID</td>
		<td>varchar(32)</td>
		<td>32자</td>
		<td class="memo">회원 아이디</td>
	</tr>
	<tr>
		<td>strUserName</td>
		<td>nvarchar(50)</td>
		<td>50자</td>
		<td class="memo">회원 이름</td>
	</tr>
	<tr>
		<td>strNickName</td>
		<td>nvarchar(50)</td>
		<td>50자</td>
		<td class="memo">회원 닉네임</td>
	</tr>
	<tr>
		<td>strEmail</td>
		<td>nvarchar(250)</td>
		<td>250자</td>
		<td class="memo">메일주소</td>
	</tr>
	<tr>
		<td>strHomepage</td>
		<td>nvarchar(250)</td>
		<td>250자</td>
		<td class="memo">홈페이지 주소</td>
	</tr>
	<tr>
		<td>strContent</td>
		<td>ntext</td>
		<td>text</td>
		<td class="memo">댓글 내용</td>
	</tr>
	<tr>
		<td>bitSecret</td>
		<td>bit</td>
		<td>True, False</td>
		<td class="memo">비밀 댓글 여부 (True : 비밀 댓글, False : 일반 댓글)</td>
	</tr>
	<tr>
		<td>intVote</td>
		<td>int (숫자형)</td>
		<td>int</td>
		<td class="memo">추천수</td>
	</tr>
	<tr>
		<td>intBlamed</td>
		<td>int (숫자형)</td>
		<td>int</td>
		<td class="memo">비추천수</td>
	</tr>
	<tr>
		<td>strIpAddr</td>
		<td>varchar(15)</td>
		<td>15자</td>
		<td class="memo">댓글 등록자 아이피 주소</td>
	</tr>
	<tr>
		<td>intFileCount</td>
		<td>int (숫자형)</td>
		<td>int</td>
		<td class="memo">등록된 파일 개수</td>
	</tr>
	<tr>
		<td>strRegDate</td>
		<td>date (날짜형)</td>
		<td>datetime</td>
		<td class="memo">댓글 등록일자 (년-월-일 시:분:초)</td>
	</tr>
</table>
<div class="info">
	<ul>
		<li>※ 위의 목록은 최신글 출력시 추가적으로 사용가능한 DB 필드명입니다.</li>
		<li>사용방법 : &lt;%=RS("변수명")%&gt; 형식 또는 사용자가 변수를 만들어 저장해서 가공하여 사용이 가능합니다.</li>
	</ul>
</div>
<br />