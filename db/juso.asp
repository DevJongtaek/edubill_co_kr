<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <% 
	inputYn = Request.Form("inputYn")
	roadFullAddr = Request.Form("roadFullAddr")
	roadAddrPart1 = Request.Form("roadAddrPart1")
	roadAddrPart2 = Request.Form("roadAddrPart2")
	engAddr = Request.Form("engAddr")
	jibunAddr = Request.Form("jibunAddr")
	zipNo = Request.Form("zipNo")
	addrDetail = Request.Form("addrDetail")
	admCd = Request.Form("admCd")
	rnMgtSn = Request.Form("rnMgtSn")
	bdMgtSn = Request.Form("bdMgtSn")
	detBdNmList = Request.Form("detBdNmList")
	//**2017년 2월 추가 제공 **/
	bdNm = Request.Form("bdNm")
	bdKdcd = Request.Form("bdKdcd")
	siNm = Request.Form("siNm")
	sggNm = Request.Form("sggNm")
	emdNm = Request.Form("emdNm")
	liNm = Request.Form("liNm")
	rn = Request.Form("rn")
	udrtYn = Request.Form("udrtYn")
	buldMnnm = Request.Form("buldMnnm")
	buldSlno = Request.Form("buldSlno")
	mtYn = Request.Form("mtYn")
	lnbrMnnm = Request.Form("lnbrMnnm")
	lnbrSlno = Request.Form("lnbrSlno")
	//**2017년 3월 추가 제공 **/
	emdNo = Request.Form("emdNo")
	
%>
    <script language="javascript">
        function init() {
            var url = location.href;
            //var url = "Cardpay.kr";
            var confmKey = "U01TX0FVVEgyMDE2MTIyMjE2MTY0NjE3NTky";
            var resultType = "4"; // 도로명주소 검색결과 화면 출력내용, 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명
            var inputYn = "<%=inputYn%>";
            var zipNo = "<%=zipNo%>";
            if (inputYn != "Y") {
                //  alert(url);
                document.form1.confmKey.value = "U01TX0FVVEgyMDE3MDEyNTEwNDMwODE4NjAz";

                document.form1.returnUrl.value = url;
                document.form1.resultType.value = resultType;
                document.form1.action = "http://www.juso.go.kr/addrlink/addrLinkUrl.do";//인터넷망
                document.form1.submit();

                // window.close();
            } else {
                //  alert(url);
                opener.jusoCallBack("<%=roadFullAddr%>", "<%=roadAddrPart1%>", "<%=addrDetail%>", "<%=roadAddrPart2%>", "<%=engAddr%>", "<%=jibunAddr%>", "<%=zipNo%>", "<%=admCd%>", "<%=rnMgtSn%>", "<%=bdMgtSn%>");
                window.close();
            }
        }
</script>
</head>
<body onload="init();">
    <form id="form1" runat="server" name="form1" method="post">
    <div>
   
		<input type="hidden" id="confmKey" name="confmKey" value=""/>
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
		<input type="hidden" id="resultType" name="resultType" value=""/> 
		<!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 START--> 
		<!-- 
		<input type="hidden" id="encodingType" name="encodingType" value="EUC-KR"/>
		 -->
		<!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 END-->
	
    </div>
    </form>
</body>
