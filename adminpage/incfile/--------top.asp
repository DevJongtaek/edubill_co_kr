<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>edubill.co.kr</title>

<script language="JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
//-->
</script>
<script language="javascript" src="/adminpage/incfile/javascript_data.js"></script>
<script language="JavaScript">
<!--
<%
searchimsiday1 = replace(left(now(),10),"-","")
searchimsiday2 = replace(left(now(),10),"-","")
%>
function serchtodaycheck(val1,val2){
	val1.value = <%=searchimsiday1%>;
	val2.value = <%=searchimsiday2%>;
}

function cyberNumchb(){
	alert("<%=session("Ausername")%>은(는) 미 신청 회원사이므로 이 서비스를 제공하지 않습니다.!!") ;
}
//-->
</script>
</head>

<%

	imsiflagpopup = request("imsiflag")
	if imsiflagpopup="y" then
		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select content,flag,hflag,wsize,hsize"
		SQL = sql & " from tb_gongi "
		rslist.Open sql, db, 1
		imsicontent = rslist(0)
		imsiflag = rslist(1)
		imsihflag = rslist(2)
		imsiwsize = rslist(3)
		imsihsize = rslist(4)
		rslist.close
%>
		<script language="JavaScript" type="text/JavaScript">
		<!--
			function imsiwinpopopen() {
			window.open('/adminpage/incfile/popopen.asp' , '_blank','left=100, top=100, width=<%=imsiwsize%>, height=<%=imsihsize%>, scrollbars=no, toolbar=no');
			}
		//-->
		</script>
		<body leftmargin="0" topmargin="0" onLoad="MM_preloadImages('admin/menu01_1.gif','admin/menu02_1.gif','admin/menu03_1.gif','admin/menu04_1.gif','admin/menu05_1.gif');imsiwinpopopen();">
<%
	else
%>
		<body leftmargin="0" topmargin="0" onLoad="MM_preloadImages('admin/menu01_1.gif','admin/menu02_1.gif','admin/menu03_1.gif','admin/menu04_1.gif','admin/menu05_1.gif')">
<%
	end if
%>

<table width="800"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" align="right">

		<table  border=0 cellspacing="0" cellpadding="0">
			<tr>


				<%if session("AchoiceDcenter")<>"" then%>
	        			<td>[ Login ID : <%=session("Auserid")%>(<%=session("AchoiceDcenter")%>) ] &nbsp;&nbsp; </td>
				<%else%>
	        			<td>[ Login ID : <%=session("Auserid")%>(<%=session("Ausername")%>) ] &nbsp;&nbsp; </td>
				<%end if%>
        			<td><!--<a href="/"><img src="/images/admin/top_menu01.gif" width="57" height="17" border="0"></a>--></td>
        			<td><a href="/adminpage/logout.asp"><img src="/images/admin/top_menu02.gif" width="60" height="17" border=0></a></td>
      			</tr>
    		</table>

		</td>
	</tr>
	<tr>
		<td>

	<%if session("Ausergubun")="1" then%>

		<%if session("Auserid")="admin" then%>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr height="38">
        				<td rowspan="2"><img src="/fileupdown/logo/<%=session("Afilename")%>" width="141" height="71" border="0"></td>
        				<td width="83" ></td>
        				<td width="128"></td>
	        			<td width="126"></td>
        				<td width="125"></td>
        				<td width="126"></td>
      				</tr>
      				<tr>
        				<td height="35" colspan="5"></td>
        			</tr>
			</table>
		<%else%>
			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr height="38">
        				<td rowspan="2"><img src="/fileupdown/logo/<%=session("Afilename")%>" width="141" height="71" border="0"></td>
        				<td width="83" ><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/admin/m_menu01_1.gif',1)"><img src="/images/admin/m_menu01.gif" name="Image5" border="0" onMouseOver="MM_showHideLayers('Layer1','','show','Layer2','','hide','Layer3','','hide')"></a></td>
        				<td width="128"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/admin/m_menu02_1.gif',1)"><img src="/images/admin/m_menu02.gif" name="Image6" border="0" onMouseOver="MM_showHideLayers('Layer1','','hide','Layer2','','show','Layer3','','hide')"></a></td>
	      	  			<td width="126"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/admin/m_menu03_1.gif',1)"><img src="/images/admin/m_menu03.gif" name="Image7" border="0" onMouseOver="MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','show')" alt="세금계산서관리"></a></td>
        				<td width="125"></td>
        				<td width="126"></td>
      				</tr>
      				<tr>
        				<td height="35" colspan="5">
					<div id="Layer1" style="position:absolute; left:160px; top:70px; width:630px; height:22px; z-index:1; visibility: hidden;">
        	  			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
            					<tr>
              						<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
              						<td align="center" bgcolor="E9E9E9">
								<a href="/adminpage/code/list.asp?flag=1">회원사관리</a> | 
								<a href="/adminpage/code/regfile.asp">청구화일생성</a> | 
								<a href="/adminpage/dealer/list.asp">딜러관리</a> | 
								<a href="/adminpage/code/updel.asp">멘트관리</a> | 
								<a href="/adminpage/code/ulist.asp">아이디관리</a> | 
								<a href="/adminpage/code/alldel2.asp">데이타삭제</a> | 
								<a href="/adminpage/code/root.asp">Root비번변경</a> |
								<a href="/adminpage/code/gongi.asp">회원사공지사항</a>
							</td>
              						<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
            					</tr>
          				</table>
        				</div>
					<div id="Layer2" style="position:absolute; left:326px; top:70px; width:360px; height:22px; z-index:2; visibility: hidden;">
					<table width="100%"  border="0" cellspacing="0" cellpadding="0">
						<tr>
      							<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
      							<td align="center" bgcolor="E9E9E9">
								<a href="/adminpage/logo/list.asp">로고관리</a> | 
								<a href="/adminpage/bbs/list.asp?uid=faq">FAQ</a> | 
								<a href="/adminpage/bbs/list.asp?uid=customer">고객의소리</a> | 
								<a href="/adminpage/bbs/list.asp?uid=gongi">공지사항</a> | 
								<a href="/adminpage/bbs/list.asp?uid=news">뉴스</a> | 
								<a href="/adminpage/bbs/list.asp?uid=pds">자료실</a>
							</td>
      							<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
    						</tr>
  					</table>
					</div>
					<div id="Layer3" style="position:absolute; left:450px; top:70px; width:320px; height:22px; z-index:2; visibility: hidden;">
					<table width="100%"  border="0" cellspacing="0" cellpadding="0">
						<tr>
      							<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
      							<td align="center" bgcolor="E9E9E9">
								<a href="/adminpage/account/list.asp">세금계산서관리</a> | 
								<a href="/adminpage/account/list2.asp">세금계산서조회</a> |  
								<a href="/adminpage/code/cyberNum.asp">입금내역조회</a>
								<!--<a href="/adminpage/account/olist.asp">주문조회</a>-->
							</td>
      							<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
    						</tr>
  					</table>
					</div>
					</td>
        			</tr>
			</table>
		<%end if%>

	<%elseif session("Ausergubun")="4" then%>

		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			<tr height="38">
        			<td><a href="/"><img src="/images/admin/logo.gif" width="141" height="71" border="0"></a></td>
        			<td width="83" ></td>
        			<td width="128"></td>
        			<td width="126"></td>
        			<td width="125"></td>
        			<td width="126"></td>
      			</tr>
		</table>

	<%elseif session("Ausergubun")="3" and session("Auserwrite")="n" then%>

		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			<tr>
        			<td rowspan="2"><img src="/fileupdown/logo/<%=session("Afilename")%>" width="141" height="71" border="0"></td>
        			<td width="83" height="38"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/admin/menu01_1.gif',1)"><img src="/images/admin/menu01.gif" name="Image5" width="83" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','show','Laye4','','hide','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="128"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/admin/menu02_1.gif',1)"><img src="/images/admin/menu02.gif" name="Image6" width="128" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','show','Layer1','','hide','Laye4','','hide','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="126"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/admin/menu03_1.gif',1)"><img src="/images/admin/menu03.gif" name="Image7" width="126" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','hide','Laye3','','show','Laye5','','hide')"></a></td>
        			<td width="125"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/admin/menu04_1.gif',1)"><img src="/images/admin/menu04.gif" name="Image8" width="125" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','show','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="126"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/admin/menu05_1.gif',1)"><img src="/images/admin/menu05.gif" name="Image9" width="126" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','hide','Laye3','','hide','Laye5','','show')"></a></td>
      			</tr>
      			<tr>
        			<td height="35" colspan="5">

				<div id="Layer1" style="position:absolute; left:225px; top:70px; width:430px; height:22px; z-index:1; visibility: hidden;">
          			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
            				<tr>
              					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
              					<td align="center" bgcolor="E9E9E9">
							<A href="/adminpage/order/list.asp">주문내역</a> | 
							<A href="/adminpage/order/tlist.asp">상품별집계표</a> | 
							<A href="/adminpage/order/filemake/dlist.asp">다운로드</a>
							| <A href="/adminpage/order/rfilemake/dlist.asp">재생성</a>
							<%if session("Amiorderflag")="y" then%>| <A href="/adminpage/order/MOrderList.asp">미주문내역</a><%end if%>
							| <A href="#" onclick="javascript:newwinB();">체인점주문</a>
						</td>
              					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
            				</tr>
          			</table>
        			</div>

				<div id="Layer2" style="position:absolute; left:326px; top:70px; width:129px; height:22px; z-index:2; visibility: hidden;">
				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
					<tr>
      						<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
      						<td align="center" bgcolor="E9E9E9"><A href="/adminpage/delivery/list.asp">배달내역</td>
      						<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
    					</tr>
  				</table>
				</div>

				<div id="Laye4" style="position:absolute; left:592px; top:70px; width:155px; height:22px; z-index:4; visibility: hidden;">
            			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              				<tr>
                				<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                				<td align="center" bgcolor="E9E9E9">
							<a href="#" onclick="javascript:topmenucheck();">URL전송</a> |
							업무연락
						</td>
                				<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              				</tr>
            			</table>
          			</div>

				<%if session("AcyberNum")="y" then%>
					<div id="Laye3" style="position:absolute; left:335px; top:70px; width:410px; height:22px; z-index:3; visibility: hidden;">
            				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td align="center" bgcolor="E9E9E9">
								<A href="#" onclick="javascript:topmenucheck();">전표출력</a> | 
								<A href="#" onclick="javascript:topmenucheck();">전표출력내역</a> | 
								<A href="#" onclick="javascript:topmenucheck();">매출집계표</a> | 
								<A href="#" onclick="javascript:topmenucheck();">입금내역1</a> | 
								<A href="#" onclick="javascript:topmenucheck();">입금내역2</a>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%else%>
					<div id="Laye3" style="position:absolute; left:465px; top:70px; width:250px; height:22px; z-index:3; visibility: hidden;">
            				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td align="center" bgcolor="E9E9E9">
								<A href="#" onclick="javascript:topmenucheck();">전표출력</a> | 
								<A href="#" onclick="javascript:topmenucheck();">전표출력내역</a> | 
								<A href="#" onclick="javascript:topmenucheck();">매출집계표</a>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%end if%>

				<%if session("Ajsusu")="y" then%>
					<div id="Laye5" style="position:absolute; left:320px; top:70px; width:<%if session("Ajsusu")="y" and session("Ausergubun")="3" then%>500<%else%>420<%end if%>px; height:22px; z-index:5; visibility: hidden;">
            				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td bgcolor="E9E9E9">
								<a href="#" onclick="javascript:topmenucheck();">상품관리</a> | 
								<a href="#" onclick="javascript:topmenucheck();">호차관리</a> |
								<%if session("Ausergubun")<>"3" then%>
									<a href="/adminpage/code/list.asp?flag=2">지사(점)관리</a> | 
								<%end if%>
								<a href="#" onclick="javascript:topmenucheck();">체인점관리</a> | 
								<%if session("Ausergubun")<>"3" then%><a href="/adminpage/code/ulist.asp">아이디관리</a> | <%end if%>
								<%if session("Ausergubun")="2" then%>
									<a href="/adminpage/account/hlist.asp">세금계산서</a> |
									<a href="/adminpage/code/bonsa.asp">본사정보수정</a>
								<%elseif session("Ausergubun")="3" then%>
									<a href="/adminpage/account/hlist.asp">세금계산서</a> |
									<%if session("Ajsusu")="y" then%><a href="/adminpage/code/jisaSu.asp">수수료정산내역</a> |<%end if%> 
									<a href="#" onclick="javascript:topmenucheck();">지사(점)정보수정</a>
								<%end if%>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%else%>
					<div id="Laye5" style="position:absolute; left:380px; top:70px; width:<%if session("Ajsusu")="y" and session("Ausergubun")="3" then%>500<%else%>430<%end if%>px; height:22px; z-index:5; visibility: hidden;">
            				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td bgcolor="E9E9E9">
								<a href="#" onclick="javascript:topmenucheck();">상품관리</a> | 
								<a href="#" onclick="javascript:topmenucheck();">호차관리</a> |
								<%if session("Ausergubun")<>"3" then%>
									<a href="/adminpage/code/list.asp?flag=2">지사(점)관리</a> | 
								<%end if%>
								<a href="#" onclick="javascript:topmenucheck();">체인점관리</a> | 
								<%if session("Ausergubun")<>"3" then%><a href="/adminpage/code/ulist.asp">아이디관리</a> | <%end if%>
								<%if session("Ausergubun")="2" then%>
									<a href="/adminpage/account/hlist.asp">세금계산서</a> |
									<a href="/adminpage/code/bonsa.asp">본사정보수정</a>
								<%elseif session("Ausergubun")="3" then%>
									<a href="/adminpage/account/hlist.asp">세금계산서</a> |
									<%if session("Ajsusu")="y" then%><a href="/adminpage/code/jisaSu.asp">수수료정산내역</a> |<%end if%> 
									<a href="#" onclick="javascript:topmenucheck();">지사(점)정보수정</a>
								<%end if%>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%end if%>
				</td>
        		</tr>
		</table>

	<%else%>

		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
			<tr>
        			<td rowspan="2"><img src="/fileupdown/logo/<%=session("Afilename")%>" width="141" height="71" border="0"></td>
        			<td width="83" height="38"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/admin/menu01_1.gif',1)"><img src="/images/admin/menu01.gif" name="Image5" width="83" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','show','Laye4','','hide','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="128"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/admin/menu02_1.gif',1)"><img src="/images/admin/menu02.gif" name="Image6" width="128" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','show','Layer1','','hide','Laye4','','hide','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="126"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/admin/menu03_1.gif',1)"><img src="/images/admin/menu03.gif" name="Image7" width="126" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','hide','Laye3','','show','Laye5','','hide')"></a></td>
        			<td width="125"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/admin/menu04_1.gif',1)"><img src="/images/admin/menu04.gif" name="Image8" width="125" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','show','Laye3','','hide','Laye5','','hide')"></a></td>
        			<td width="126"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/admin/menu05_1.gif',1)"><img src="/images/admin/menu05.gif" name="Image9" width="126" height="38" border="0" onMouseOver="MM_showHideLayers('Layer2','','hide','Layer1','','hide','Laye4','','hide','Laye3','','hide','Laye5','','show')"></a></td>
      			</tr>
      			<tr>
        			<td height="35" colspan="5">

				<div id="Layer1" style="position:absolute; left:225px; top:70px; width:430px; height:22px; z-index:1; visibility: hidden;">
          			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
            				<tr>
              					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
              					<td align="center" bgcolor="E9E9E9">
							<A href="/adminpage/order/list.asp">주문내역</a> | 
							<A href="/adminpage/order/tlist.asp">상품별집계표</a>
							| <A href="/adminpage/order/filemake/dlist.asp">다운로드</a>
							| <A href="/adminpage/order/rfilemake/dlist.asp">재생성</a>
							<%if session("Amiorderflag")="y" then%>| <A href="/adminpage/order/MOrderList.asp">미주문내역</a><%end if%>
							| <A href="#" onclick="javascript:newwinB();">체인점주문</a>
						</td>
              					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
            				</tr>
          			</table>
        			</div>
				<div id="Layer2" style="position:absolute; left:326px; top:70px; width:129px; height:22px; z-index:2; visibility: hidden;">
				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
					<tr>
      						<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
      						<td align="center" bgcolor="E9E9E9"><A href="/adminpage/delivery/list.asp">배달내역</td>
      						<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
    					</tr>
  				</table>
				</div>
				<div id="Laye4" style="position:absolute; left:542px; top:70px; width:225px; height:22px; z-index:4; visibility: hidden;">
            			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              				<tr>
                				<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                				<td align="center" bgcolor="E9E9E9">
							<a href="/adminpage/sms/write.asp">URL전송</a> |
							<%if session("Ausergubun")="2" then%>
								<%if session("Asmsflag")="y" then%>
									<a href="/adminpage/sms/SendList.asp">SMS전송내역</a> |
								<%else%>
									<a href="#" onclick="cyberNumchb()">SMS전송내역</a> |
								<%end if%>
							<%end if%>
							업무연락
						</td>
                				<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              				</tr>
            			</table>
          			</div>
				<%if session("AcyberNum")="y" then%>
					<div id="Laye3" style="position:absolute; left:335px; top:70px; width:410px; height:22px; z-index:3; visibility: hidden;">
        	    			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td align="center" bgcolor="E9E9E9">
								<A href="/adminpage/tax/list2.asp">전표출력</a> | 
								<A href="/adminpage/tax/list4.asp">전표출력내역</a> | 
								<A href="/adminpage/tax/list3.asp">매출집계표</a> | 
								<A href="https://www.wgbpay.com/login_p.asp?id=<%=session("Auserid")%>&pwd=<%=session("Auserpwd")%>" target=_blank>입금내역1</a> | 
								<A href="/adminpage/tax/cyberNum.asp">입금내역2</a>
							</td>
        	        				<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%else%>
					<div id="Laye3" style="position:absolute; left:465px; top:70px; width:250px; height:22px; z-index:3; visibility: hidden;">
            				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td align="center" bgcolor="E9E9E9">
								<A href="/adminpage/tax/list2.asp">전표출력</a> | 
								<A href="/adminpage/tax/list4.asp">전표출력내역</a> | 
								<A href="/adminpage/tax/list3.asp">매출집계표</a>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
          				</div>
				<%end if%>

				<%if session("Ajsusu")="y" then%>
					<div id="Laye5" style="position:absolute; left:<%if session("Ausergubun")="3" then%>290<%else%><%if session("Ausergubun")="2" then%>190<%else%>249<%end if%><%end if%>px; top:70px; width:<%if session("Ausergubun")<>"3" then%><%if session("Ausergubun")="2" then%>600<%else%>450<%end if%><%else%>500<%end if%>px; height:22px; z-index:5; visibility: hidden;">
        	    			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td bgcolor="E9E9E9">
								<a href="/adminpage/code/plist.asp">상품관리</a> | 
								<a href="/adminpage/code/clist.asp">호차관리</a> |
								<%if session("Ausergubun")<>"3" then%>
									<a href="/adminpage/code/list.asp?flag=2">지사(점)관리</a> | 
								<%end if%>
								<a href="/adminpage/code/list.asp?flag=3">체인점관리</a> | 
								<%if session("Ausergubun")<>"3" then%><a href="/adminpage/code/ulist.asp">아이디관리</a> | <%end if%>
								<%if session("Ausergubun")="2" then%><a href="/adminpage/code/alldel.asp">데이타삭제</a> | <%end if%>
								<%if session("Ausergubun")="2" then%>
									<a href="/adminpage/account/hlist.asp">세금계산서</a> |
									<a href="/adminpage/code/bonsa.asp">본사정보수정</a>
								<%elseif session("Ausergubun")="3" then%>
									<a href="/adminpage/account/hlist.asp">세금계산서</a> |
									<%if session("Ajsusu")="y" then%><a href="/adminpage/code/jisaSu.asp">수수료정산내역</a> |<%end if%> 
									<a href="/adminpage/code/jisa.asp">지사(점)정보수정</a>
								<%end if%>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
	          			</div>
				<%else%>
					<div id="Laye5" style="position:absolute; left:<%if session("Ausergubun")="3" then%>380<%else%><%if session("Ausergubun")="2" then%>190<%else%>249<%end if%><%end if%>px; top:70px; width:<%if session("Ausergubun")<>"3" then%><%if session("Ausergubun")="2" then%>600<%else%>450<%end if%><%else%>420<%end if%>px; height:22px; z-index:5; visibility: hidden;">
        	    			<table width="100%"  border="0" cellspacing="0" cellpadding="0">
              					<tr>
                					<td width="8"><img src="/images/admin/lef_sub.gif" width="8" height="22"></td>
                					<td bgcolor="E9E9E9">
								<a href="/adminpage/code/plist.asp">상품관리</a> | 
								<a href="/adminpage/code/clist.asp">호차관리</a> |
								<%if session("Ausergubun")<>"3" then%>
									<a href="/adminpage/code/list.asp?flag=2">지사(점)관리</a> | 
								<%end if%>
								<a href="/adminpage/code/list.asp?flag=3">체인점관리</a> | 
								<%if session("Ausergubun")<>"3" then%><a href="/adminpage/code/ulist.asp">아이디관리</a> | <%end if%>
								<%if session("Ausergubun")="2" then%><a href="/adminpage/code/alldel.asp">데이타삭제</a> | <%end if%>
								<%if session("Ausergubun")="2" then%>
									<a href="/adminpage/account/hlist.asp">세금계산서</a> |
									<a href="/adminpage/code/bonsa.asp">본사정보수정</a>
								<%elseif session("Ausergubun")="3" then%>
									<a href="/adminpage/account/hlist.asp">세금계산서</a> |
									<%if session("Ajsusu")="y" then%><a href="/adminpage/code/jisaSu.asp">수수료정산내역</a> |<%end if%> 
									<a href="/adminpage/code/jisa.asp">지사(점)정보수정</a>
								<%end if%>
							</td>
                					<td width="8"><img src="/images/admin/right_sub.gif" width="8" height="22"></td>
              					</tr>
            				</table>
	          			</div>
				<%end if%>

				</td>
        		</tr>
		</table>

	<%end if%>

		</td>
	</tr>
	<tr>
		<td><img src="/images/admin/top_img.gif" width="800" height="144"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
