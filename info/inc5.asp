<%
	'--------------------------------------------------------------------------------------------------------------------
	'# 날짜관련 함수
	'# FunYMDHMS(dflag)	년월일시분초 가져오는 함수
	'#    			4:yyyy    6:yyyymm    8:yyyymmdd    10:yyyymmddhh    12:yyyymmddhhmm    14:yyyymmddhhmmss
	'# DateFormatReplace	20090605123541 -->> 2009-06-05 12:35:41
	'#    			psDate:데이타	psDateflag:날짜구분값	psDategubun:1=날짜전체 2=시간만
	'# SelectDateChoice	년월일 콤보박스
	'#    			yearDa:년도값    monthDa:월값    dayDa:일값    yvalD:년도이름    mvalD:월이름    dvalD:일이름
	'# alertURL	 이동할 주소
	'--------------------------------------------------------------------------------------------------------------------
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = "select tcode, comname, userID, CertNo from tb_badmi_cert"
	SQL = sql & " where username is null"
	rslist.Open sql, db, 1
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	select case request("uid")
		case "gongi"
			imsibbstitle = "공지사항"
		case "news"
			imsibbstitle = "뉴스"
		case "faq"
			imsibbstitle = "FAQ "
		case "customer"
			imsibbstitle = "고객의소리"
		case "pds"
			imsibbstitle = "자료실"
		case "guestbbs"
			imsibbstitle = "자료실"
		case "agencyboard"
			imsibbstitle = "자료실"
	end select
	tablename = "tb_pds"
%>

<script language="JavaScript">
<!--
function onlyNumber(){
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}
function posorderwin(){
	window.open ('posDatatorder.asp','dssdsd','width=300,height=180,left=100,top=100');
	return false ;
}

//금지 단어 검색 시작
function nottxtfield(word) {
var NotWord = ",";
var SP = NotWord.split('|');
	for(var i=0; i<SP.length; i++)
	{
        	var NotStr = word.indexOf(SP[i], 0);
        	if( NotStr >= 0 )
        	{
                	alert(SP[i]+' 콤마는 절대 사용 하지 마세요.');
			//word = "";
                	return;
        	}
	}
}
//금지단어 검색 끝

function allsavechb(){
	form1.action = "cyberNumSave.asp";
	form1.submit();
	return false ;
}

function allsavechb2(){
	form1.target = "ifrm";
	form1.method = "post";
	form1.action = "TcyberNumSaveIframe.asp";
	form1.submit();
	return false ;
}

function allsavechb3(){
	form1.target = "ifrm";
	form1.method = "post";
	form1.action = "TcyberNumSaveIframeCancle.asp";
	form1.submit();
	return false ;
}
function kindsearchok2(form) {
	form.submit() ;
}

function frmzerocheck(form,url) {
	location.href = url;
}
//-->
</script>
<form action="list.asp" method="POST" name=form1>
<input type=hidden name=pagegubun value=5>

</form>
<form name=form1 method=post>
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=searchd value="<%=searchd%>">
<input type=hidden name=searche value="<%=searche%>">
<input type=hidden name=searchf value="<%=searchf%>">
<input type=hidden name=searchg value="<%=searchg%>">
<input type=hidden name=gotopage value="<%=gotopage%>">


<!--#include virtual="/db/db.asp" -->

<%
	searcha = request("searcha1")
	searchb = replace(request("searchb1"),"'","")

	if searcha = "" then
		searcha = ""
	else
		imsisearcha_1 = InStrRev(searcha, "1")
		if imsisearcha_1 > 0 then
			imsisearcha_1 = "1"
		else
			imsisearcha_1 = "0"
		end if

		imsisearcha_2 = InStrRev(searcha, "2")
		if imsisearcha_2 > 0 then
			imsisearcha_2 = "2"
		else
			imsisearcha_2 = "0"
		end if

		imsisearcha_3 = InStrRev(searcha, "3")
		if imsisearcha_3 > 0 then
			imsisearcha_3 = "3"
		else
			imsisearcha_3 = "0"
		end if

		imsisearcha_tot = imsisearcha_1&imsisearcha_2&imsisearcha_3
		if (imsisearcha_tot = "123" and searchb <> "") then
			imsisqlgubun = 1
		elseif (imsisearcha_tot = "120" and searchb <> "") then
			imsisqlgubun = 2
		elseif (imsisearcha_tot = "103" and searchb <> "") then
			imsisqlgubun = 3
		elseif (imsisearcha_tot = "023" and searchb <> "") then
			imsisqlgubun = 4
		elseif (imsisearcha_tot = "100" and searchb <> "") then
			imsisqlgubun = 5
		elseif (imsisearcha_tot = "020" and searchb <> "") then
			imsisqlgubun = 6
		elseif (imsisearcha_tot = "003" and searchb <> "") then
			imsisqlgubun = 7
		end if

	end if


	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	uid = request("uid")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT * FROM "& tablename &" where uid = '"& uid &"' "

	select case imsisqlgubun
		case 1
			SQL = SQL & " and ((name like '%"& searchb &"%') or (title like '%"& searchb &"%') or (content like '%"& searchb &"%')) "
		case 2
			SQL = SQL & " and ((name like '%"& searchb &"%') or (title like '%"& searchb &"%')) "
		case 3
			SQL = SQL & " and ((name like '%"& searchb &"%') or (content like '%"& searchb &"%')) "
		case 4
			SQL = SQL & " and ((title like '%"& searchb &"%') or (content like '%"& searchb &"%')) "
		case 5
			SQL = SQL & " and name like '%"& searchb &"%' "
		case 6
			SQL = SQL & " and title like '%"& searchb &"%' "
		case 7
			SQL = SQL & " and content like '%"& searchb &"%' "
	end select

	if uid="agencyboard" then
		SQL = SQL & " and bkind = '"& left(session("AAusercode"),5) &"' "
	end if

	SQL = SQL & " ORDER BY ref desc, re_step asc, re_level asc"
	rs.PageSize=20
	'response.write SQL
	rs.Open sql, db, 1

	tot_n = rs.recordcount
	if not rs.EOF then
		rs.AbsolutePage=int(gotopage)
	end if	
%>

<%select case uid%>
	<%case "notice","cookpds","best","healthcampaign","faq1","faq2","faq3","faq4","faq5","faq6","faq7"%>
	<!--#include virtual="/adminpage/bbs/list_inc2.asp" -->
	<%case else%>
	<!--#include virtual="/adminpage/bbs/list_inc.asp" -->
<%end select%>

</table>
