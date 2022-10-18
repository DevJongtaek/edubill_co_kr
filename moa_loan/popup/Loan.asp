<!--#include virtual="/moa_loan/db/db.asp"-->

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>

  <title>모아론 대출서비스</title>
	<META NAME="keywords" CONTENT="모아론,모아코퍼레이션,대출,신용대출,무보증,무담보,">
	<META NAME="description" CONTENT="모아론 대출서비스 안내">
	<META NAME="robots" CONTENT="ALL">
	<META NAME="author" CONTENT="모아코퍼레이션">

	<META NAME="build" CONTENT="2014.5.12">
	<meta name='viewport' content='initial-scale=1, minimum-scale=0.3,  user-scaleable=yes' />
	<link href='Inc_Files/Css/default.css' rel='stylesheet' type='text/css'>
	<script type='text/javascript' src='Inc_Files/Scripts/Common_Script.js'></script>
	<style>
		html {margin:0px; padding:0px; height:100%;	width:100%;}
		body {margin:0px; padding:0px; overflow-x:hidden;}
		div, ul, li, dl, dt, dd, ol, p, h1, h2, h3, h4, h5, h6, form, {margin:0px; padding:0px; overflow-x:hidden; }
		ul,ol,li{list-style:none; margin:0px;}
		img {border:none; vertical-align:top;}
		div {width:100%; margin:0px auto;}
		table {border:0;margin:0 auto;}
		th	{font-family:돋움; font-size:10pt; color:#000000; font-weight:bold; line-height:25px;}
		td {font-family:돋움; font-size:9pt; color:#000000;line-height:18px;}
		input {border:1px solid #aaaaaa;}
		.wine12		{font-family:돋움; font-size:12px; color:#7d0000; line-height:14px; letter-spacing:-1px;}
	</style>
   <%
      searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	' 검색 조건 추가 
	searchi = request("searchi")
	searchj = request("searchj")
	searchk = request("searchk")
	searchl = request("searchl")

	if searchg="" then
		searchg = "0"
	end if
	if searchc="" then
		searchc = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if

       set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select Idx,Name from tb_Area "
		
		SQL = sql & " order by Seq asc"
       'response.Write SQL
		rs.Open sql, db, 1
		if not rs.eof then
			barray = rs.GetRows
			barrayint = ubound(barray,2)
		else
			barray = ""
			barrayint = ""
		end if
		rs.close
      
        %>
        
<script>
function bIdwrite(frm) {

  if(frm.loanSangho.value == ""){
    alert("상호명을 입력하여 주시기바랍니다.") ;
		frm.loanSangho.focus() ;
		return false ;
  }
  if(frm.loanBizNo1.value == "" || frm.loanBizNo2.value == "" || frm.loanBizNo3.value == ""){
    alert("사업자등록번호를 입력하여 주시기바랍니다.") ;
		frm.loanBizNo1.focus() ;
		return false ;
  }
 
	else if (frm.loanName.value=="") {
		alert("대표자를 입력하여 주시기바랍니다.") ;
		frm.loanName.focus() ;
		return false ;
	}
	else if (frm.loanRegNo1.value==""|| frm.loanRegNo2.value=="") {
		alert("주민등록번호를 입력하여 주시기바랍니다.") ;
		frm.loanRegNo1.focus() ;
		return false ;
	}
	else if (frm.loanTel1.value==""|| frm.loanTel2.value=="" ||  frm.loanTel3.value=="") {
		alert("전화번호를 입력하여 주시기바랍니다.") ;
		frm.loanTel1.focus() ;
		return false ;
	}
	else if (frm.loanHP1.value==""|| frm.loanHP2.value=="" || frm.loanHP3.value == "") {
		alert("휴대폰번호를 입력하여 주시기바랍니다.") ;
		frm.loanHP1.focus() ;
		return false ;
	}
	else if (frm.WishMoney.value=="") {
		alert("대출희망금액을 입력하여 주시기바랍니다.") ;
		frm.WishMoney.focus() ;
		return false ;
	}
	else if (frm.searchc.value==0|| frm.searchf.value==0) {
		alert("지역/소속지사를 선택하여 주시기바랍니다.") ;
		frm.searchc.focus() ;
		return false ;
	}
	else if (frm.loanProposer.value==0|| frm.loanProposer.value==0) {
		alert("추천인을 입력하여 주시기바랍니다.") ;	
		frm.loanProposer.focus() ;
		return false ;
		
	}

	

	frm.submit() ;
}
</script>
</head>
<BODY style='margin:0;'>
<table width='620' border='0' cellspacing='0' cellpadding='0'>
	<tr>
		<td><img src='images/img1.gif'></td>
	</tr>
	<tr>
		<td><img src='images/img2.gif'></td>
	</tr>
	<tr>
		<td style='height:35;background:url(images/boxtop.gif) no-repeat;'></td>
	</tr>
	<tr>
		<td style='height:35;background:url(images/boxbg.gif) repeat;padding:20px 75px;'>
			<div>
■ 아래 내용을 기재하여 대출상담을 신청하시면 모아코퍼레이션과 제휴한 금융기관의<br> &nbsp; &nbsp; 대출 담당자가 당일 전화로 친절한 상담을 해 드립니다.</div>
			<div>
■ 아래 기재된 정보는 대출상담 목적 외에 다른 용도로 절대 사용되지 않습니다.</div>
			<div>

■ [남기고 싶은 말] 입력란에 상담 희망시간, 궁금사항 등을 자유롭게 작성 바랍니다.</div>
			<div style='padding:20px 30px 0 0;'>
                <form action="loanok.asp" name=form method=post >
				<table width='100%' border='0' cellspacing='0' cellpadding='0' align='center'>
					<tr>
						<td style='padding:3px;text-align:right;' class='wine12'>상호명</td>
						<td style='padding:3px 10px;'><input type='text' name='loanSangho'></td>
					</tr>
					<tr>
						<td style='padding:3px;text-align:right;' class='wine12'>사업자등록번호</td>
						<td style='padding:3px 10px;'><input type='text' name='loanBizNo1' style='width:30px;' maxlength='3'> - <input type='text' name='loanBizNo2' style='width:20px;' maxlength='2'> - <input type='text' name='loanBizNo3' style='width:40px;' maxlength='5'></td>
					</tr>
					<tr>
						<td style='padding:3px;text-align:right;' class='wine12'>대표자</td>
						<td style='padding:3px 10px;'><input type='text' name='loanName' style='width:60px;'></td>
					</tr>
					<tr>
						<td style='padding:3px;text-align:right;' class='wine12'>주민등록번호</td>
						<td style='padding:3px 10px;'><input type='text' name='loanRegNo1' style='width:50px;' maxlength='6'> - <input type='text' name='loanRegNo2' style='width:60px;' maxlength='7'></td>
					</tr>
					<tr>
						<td style='padding:3px;text-align:right;' class='wine12'>전화번호</td>
						<td style='padding:3px 10px;'><input type='text' name='loanTel1' style='width:30px;' maxlength='3' OnKeypress="onlyNumber();"> - <input type='text' name='loanTel2' style='width:35px;' maxlength='4'> - <input type='text' name='loanTel3' style='width:35px;' maxlength='4'></td>
					</tr>
					<tr>
						<td style='padding:3px;text-align:right;' class='wine12'>휴대폰번호</td>
						<td style='padding:3px 10px;'><input type='text' name='loanHP1' style='width:30px;' maxlength='5'> - <input type='text' name='loanHP2' style='width:35px;' maxlength='4'> - <input type='text' name='loanHP3' style='width:35px;' maxlength='4'></td>
					</tr>
					<tr>
						<td style='padding:3px;text-align:right;' class='wine12'>대출희망금액</td>
						<td style='padding:3px 10px;'><input type='text' name='WishMoney' style='width:40px;'> 만원</td>
					</tr>
					<tr>
						<td style='padding:3px;text-align:right;' class='wine12'>지역/소속지사</td>
						<td style='padding:3px 10px;'>
                 
                            <!--#include virtual="/moa_loan/Inc_Files/kind.asp"-->
			<select name="searchc" size="1" class="box_work" onChange="Select_cate(this.form2,'');">
	          			<option value="0">지역전체</option>
					<%if barrayint<>"" then%>
						<%for i=0 to barrayint%>
		        	  			<option value="<%=barray(0,i)%>"><%=barray(1,i)%>
						<%next%>
					<%end if%>
        		</select>
              		<select name=searchf class="f">
                		<option value=0>소속지사</option>
              		</select>
			<script language="JavaScript">set_menu();</script>
			           
			
						</td>
					</tr>
					<tr>
						<td style='padding:3px;text-align:right;' class='wine12'>추천인</td>
						<td style='padding:3px 10px;'><input type='text' name='loanProposer' style='width:60px;'></td>
					</tr>
					<tr>
						<td style='padding:3px;text-align:right;' class='wine12'  valign='top'>남기고 싶은 말</td>
						<td style='padding:3px 10px;'><textarea name='contents' maxlength="2000" style='width:100%;height:80px;'></textarea></td>
					</tr>
					<tr>
						<td style='padding:20px 0 0 0;text-align:center;' colspan='2'><input type="image" src='images/btnapp.gif' onclick="return bIdwrite(this.form);"></td>
					</tr>
				</table>


                    </form>
			</div>
		</td>
	</tr>
	<tr>
		<td style='height:49;background:url(images/boxbottom.gif) no-repeat;'></td>
	</tr>
</table>
</body>
</html>
