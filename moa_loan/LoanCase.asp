<!--#include virtual="/moa_loan/Inc_Files/sessionend.asp"-->
<!--#include virtual="/moa_loan/db/db.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>상담 신청 내역</title>
<%

    set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select StaticOptionId,Name "
	SQL = sql & " from StaticOptions "
	SQL = sql & " where Div = 'Bank' "
	SQL = sql & " order by Seq asc"
	rs.Open sql, db, 1
	if not rs.eof then
		hcararray = rs.GetRows
		hcararrayint = ubound(hcararray,2)
	else
		hcararray = ""
		hcararrayint = ""
	end if
	rs.close


	seq = request("seq")

	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select convert(varchar(10), a.RequestDay, 111)+' '+convert(varchar(8), a.RequestDay, 114)  RequestDay ,a.RequestSangho,a.RequestBizNo,a.RequestName  ,a.RequestRegNo, a.RequestTel  ,a.RequestHP "
	sql = sql + " ,a.WishMoney,a.RequestProposer, a.contents, a.LoanOrg  ,a.LoanProduct  ,a.LoanMoney  ,a.[InterestRate ]  ,convert(varchar(10), a.LoanDay, 111) LoanDay"
	sql = sql + ", a.StatusMemo,b.name as area_name ,c.name as branch_name, d.name as bank_name from tb_loan a "
	sql = sql + " left join tb_area b on a.loan_area = b.idx left join tb_branch c on a.loan_branch = c.idx and a.loan_area = c.areaidx"
	sql = sql + " left join staticoptions d on a.LoanOrg = d.Value and d.div = 'Bank'   where a.seq = " & seq
	rs.Open sql, db, 1
   ' response.Write SQL
	RequestDay = rs(0)
    RequestSangho = rs(1)
    RequestBizNo = rs(2)
	RequestName = rs(3)
	RequestRegNo = rs(4)
	RequestTel = rs(5)
	RequestHP = rs(6)
	WishMoney = rs(7)
    RequestProposer = rs(8)
	contents = rs(9)
	LoanOrg = rs(10)
	LoanProduct = rs(11)
	LoanMoney = rs(12)
	InterestRate = rs(13)
	LoanDay = rs(14)
	StatusMemo = rs(15)
    areaname = rs(16)
    branchname = rs(17)
    bankname = rs(18)

    rs.close

%>
<script language="JavaScript">

    function onlyNumber() {
        if ((event.keyCode < 48) || (event.keyCode > 57))
            event.returnValue = false;
    }

    function FloatNumber() {
        if ((event.keyCode < 46) || (event.keyCode > 57) && (event.keyCode = 47))
            event.returnValue = false;
    }

    function DateNumber() {
        if ((event.keyCode < 47) || (event.keyCode > 57))
            event.returnValue = false;
    }
</script>

<SCRIPT LANGUAGE="JavaScript">
function CheckDate(frm) {

 var objvalue = frm.LoanDay.value;


var regExp = /^\d{4}\/\d{2}\/\d{2}$/;
 if(objvalue==""){
  return;
 } 
 else {
  if(!regExp.test(objvalue)) { 
   alert("날짜 형식이 맞지않습니다.\n\nYYYY/MM/DD 형식으로 입력해 주세요."); 
   frm.LoanDay.value="";
   frm.LoanDay.focus();
   return false; 
   }
 }
 
 
 if(regExp.test(objvalue)  &&  frm.searchg.value == 0)
 {
   alert("금융기관을 선택하세요");
   frm.searchg.focus();
   return false;
 }
  frm.submit();
}
function fn_Enter() { fn_Enter
  if (event.keyCode == 13) {
   CheckDate();
   
  }
 }

</SCRIPT>



    <style type="text/css">
        .auto-style1 {
            height: 28px;
        }
    </style>
</head>
<body onload="winResize()">
<table width="360" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>
		<table border="0" cellspacing="1" cellpadding="1" width=360 bgcolor=#BDCBE7 id="searchlist">
			<tr height=28 bgcolor=#F7F7FF>
				<td width="110" align=left colspan=2>&nbsp;* 상담 신청 내역</td>
			</tr>
              <tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>상호명&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestSangho%></td>
			</tr>
              <tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>사업자등록번호&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestBizNo%></td>
			</tr>
			<tr height=28 >
				<td width="110" align=right bgcolor=#F7F7FF>대표자&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestName%></td>
			</tr>
          <tr height=28 >
				<td width="110" align=right bgcolor=#F7F7FF>주민등록번호&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestRegNo%></td>
			</tr>
			
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>전화번호&nbsp;</td>
				<td  bgcolor=#FFFFFF>&nbsp;<%=RequestTel%></td>
			</tr>
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>휴대폰번호&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestHP%></td>
			</tr>
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>대출희망금액&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=WishMoney%>만원</td>
			</tr>
            <tr>
				<td width="110" align=right bgcolor=#F7F7FF class="auto-style1">지역/소속지사&nbsp;</td>
				<td bgcolor=#FFFFFF class="auto-style1">&nbsp;<%=areaname%>><%=branchname%></td>
			</tr>
            <tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>추천인&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestProposer%></td>
			</tr>
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>남기고 싶은 말&nbsp;</td>
				<td bgcolor=#FFFFFF><textarea name="contents" cols="30" rows="3" style="border:1 solid #C7C7C7;back-color :black;" readonly><%=contents%></textarea></td>
			</tr>
			<tr height=28>
				<td width="110" align=right bgcolor=#F7F7FF>상담신청일시&nbsp;</td>
				<td bgcolor=#FFFFFF>&nbsp;<%=RequestDay%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="5">
		</td>
	</tr>
	<tr>
		<td>
		<form name = "form" action="loancaseok.asp">
			<table border="0" cellspacing="1" cellpadding="1" width=360 bgcolor=#BDCBE7 id="Table1">
					<tr height=28 bgcolor=#F7F7FF>
						<td width="110" align=left colspan=2>&nbsp;* 대출내역</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>금융기관&nbsp;</td>

                       
						<td bgcolor=#FFFFFF>
                             <%if session("AuserGubunName") = "관리자" then %>
                                      
                                       <%if isNull(LoanDay) and session("Awriteyn") = 1 then %>
                                         <select name="searchg" size="1" class="box_work">
            				                      <%if hcararrayint<>"" then%>
            	          			 <option value="0">금융기관</option>
                        			            <%for i=0 to hcararrayint%>
                        			            
                            		        	  	<option value="<%=hcararray(0,i)%>" <%if hcararray(0,i)=LoanOrg then%>selected<%end if%>>
                            		        	  	<%=hcararray(1,i)%>
                            						      <%next%>
                        				          <%end if%>
                                      
                    		                </select>
                    		               
                                      <%else%>
                                       <select name="searchg" size="1" disabled=true  class="box_work">
            				                      <%if hcararrayint<>"" then%>
            	          			 <option value="0">금융기관</option>
                        			            <%for i=0 to hcararrayint%>
                            		        	  	<option value="<%=hcararray(0,i)%>" <%if hcararray(0,i)=LoanOrg then%>selected<%end if%>>
                            		        	  	<%=hcararray(1,i)%>
                            						      <%next%>
                        				          <%end if%>
                                      
                    		                </select>
                    		              
                                      <%end if%>
                             <%else%>
                          
                                      <input type="text" name="LoanOrg" maxlength="10" style="width:100;" size="11" value="<%=bankname%>"  disabled=true>
				            
                            <%end if %>
						</td>
					</tr>
					 <%if session("AuserGubun") = "3" then %>
					 
  					<tr height=28>
  						<td width="110" align=right bgcolor=#F7F7FF>대출상품&nbsp;</td>
  						<td bgcolor=#FFFFFF><input type="text" name="LoanProduct" maxlength="20" style="width:100;" size="11" value="<%=LoanProduct%>"></td>
  					</tr>
  					<tr height=28>
  						<td width="110" align=right bgcolor=#F7F7FF>대출금액&nbsp;</td>
  						<td bgcolor=#FFFFFF><input type="text" name="LoanMoney" maxlength="4" style="width:40;" size="11" value="<%=LoanMoney%>" OnKeypress="onlyNumber();">만원</td>
  					</tr>
  					<tr height=28>
  						<td width="110" align=right bgcolor=#F7F7FF>금리&nbsp;</td>
  						<td bgcolor=#FFFFFF><input type="text" name="InterestRate" maxlength="4" style="width:40;" size="11" value="<%=InterestRate%>"  OnKeypress="FloatNumber();">(%)</td>
  					</tr>
  					<tr height=28>
  						<td width="110" align=right bgcolor=#F7F7FF>대출완료일&nbsp;</td>
  						<td bgcolor=#FFFFFF><input type="text" name="LoanDay" maxlength="10" style="width:100;" size="11" value="<%=LoanDay%>" > (예:2011/03/15)</td>
  					</tr>
  					<tr height=28>
  						<td width="110" align=right bgcolor=#F7F7FF>진행상황&nbsp;</td>
  						<td bgcolor=#FFFFFF><textarea name="StatusMemo" cols="30" rows="3" style="border:1 solid #C7C7C7;back-color :black;" ><%=StatusMemo%></textarea></td>
  					</tr>
  					<tr  bgcolor=#FFFFFF>
  						<td align="center" colspan=2><input type="image" src="/images/admin/l_bu03.gif" border=0 onclick="return CheckDate(this.form);">&nbsp;
  						<!--<input type="button" name="del" value="닫기"  class="box_work" onclick="javascript:window.close();">--></td>
  					</tr>
  					<%elseif session("AuserGubun") = "1" then%>
    					<tr height=28>
    						<td width="110" align=right bgcolor=#F7F7FF>대출상품&nbsp;</td>
    						<td bgcolor=#FFFFFF><input type="text" name="LoanProduct" maxlength="20" style="width:100;" size="11" value="<%=LoanProduct%>"></td>
    					</tr>
    					<tr height=28>
    						<td width="110" align=right bgcolor=#F7F7FF>대출금액&nbsp;</td>
    						<td bgcolor=#FFFFFF><input type="text" name="LoanMoney" maxlength="4" style="width:40;" size="11" value="<%=LoanMoney%>" OnKeypress="onlyNumber();">만원</td>
    					</tr>
    					<tr height=28>
    						<td width="110" align=right bgcolor=#F7F7FF>금리&nbsp;</td>
    						<td bgcolor=#FFFFFF><input type="text" name="InterestRate" maxlength="4" style="width:40;" size="11" value="<%=InterestRate%>"  OnKeypress="FloatNumber();">(%)</td>
    					</tr>
    					<tr height=28>
    						<td width="110" align=right bgcolor=#F7F7FF>대출완료일&nbsp;</td>
    						<td bgcolor=#FFFFFF><input type="text" name="LoanDay" maxlength="10" style="width:100;" size="11" value="<%=LoanDay%>" > (예:2011/03/15)</td>
    					</tr>
    					<tr height=28>
    						<td width="110" align=right bgcolor=#F7F7FF>진행상황&nbsp;</td>
    						<td bgcolor=#FFFFFF><textarea name="StatusMemo" cols="30" rows="3" style="border:1 solid #C7C7C7;back-color :black;" ><%=StatusMemo%></textarea></td>
    					</tr>
    					<tr  bgcolor=#FFFFFF>
    						<td align="center" colspan=2><input type="image" src="/images/admin/l_bu03.gif" border=0 onclick="return CheckDate(this.form);">&nbsp;
    						<!--<input type="button" name="del" value="닫기"  class="box_work" onclick="javascript:window.close();">--></td>
    					</tr>
					<%elseif session("AuserGubun") = "2" then%>
  					<tr height=28>
  						<td width="110" align=right bgcolor=#F7F7FF>대출상품&nbsp;</td>
  						<td bgcolor=#FFFFFF><input type="text" name="LoanProduct" maxlength="20" style="width:100;" disabled=true size="11" value="<%=LoanProduct%>"></td>
  					</tr>
  					<tr height=28>
  						<td width="110" align=right bgcolor=#F7F7FF>대출금액&nbsp;</td>
  						<td bgcolor=#FFFFFF><input type="text" name="LoanMoney" maxlength="4" style="width:40;" disabled=true size="11" value="<%=LoanMoney%>" OnKeypress="onlyNumber();">만원</td>
  					</tr>
  					<tr height=28>
  						<td width="110" align=right bgcolor=#F7F7FF>금리&nbsp;</td>
  						<td bgcolor=#FFFFFF><input type="text" name="InterestRate" maxlength="4" style="width:40;" disabled=true size="11" value="<%=InterestRate%>"  OnKeypress="FloatNumber();">(%)</td>
  					</tr>
  					<tr height=28>
  						<td width="110" align=right bgcolor=#F7F7FF>대출완료일&nbsp;</td>
  						<td bgcolor=#FFFFFF><input type="text" name="LoanDay" maxlength="10" style="width:100;" disabled=true size="11" value="<%=LoanDay%>" > (예:2011/03/15)</td>
  					</tr>
  					<tr height=28>
  						<td width="110" align=right bgcolor=#F7F7FF>진행상황&nbsp;</td>
  						<td bgcolor=#FFFFFF><textarea name="StatusMemo" cols="30" rows="3" disabled=true style="border:1 solid #C7C7C7;back-color :black;" ><%=StatusMemo%></textarea></td>
  					</tr>
  					<tr  bgcolor=#FFFFFF>
  						<td align="center" colspan=2><input type="image" src="/images/admin/l_bu03.gif"  disabled=true border=0 onclick="return CheckDate(this.form);">&nbsp;
  						<!--<input type="button" name="del" value="닫기"  class="box_work" onclick="javascript:window.close();">--></td>
  					</tr>
					<%end if%>
					<input name="Seq" type=hidden value="<%=seq%>">
					</form>
				</table>
		</td>
	</tr>
</table>
</body>
</html>
