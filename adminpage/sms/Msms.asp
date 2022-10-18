<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	idx = request("idx")
	if idx<>"" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bidx,idx,bname "
		SQL = sql & " from tb_company_brand "
		SQL = sql & " where idx = "& idx
		rs.Open sql, db, 1
	end if


    smscnt = request("sms")
    tcode = request("tcode")

   tcodeA = split(tcode,",")
 
    tcount = ubound(tcodeA)

    tcodeE = mid(tcode,1,len(tcode)-1)

%>

<html>
<head>
     <meta http-equiv="Content-Type" content="text-html; charset=utf-8" />
<!--<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">-->
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>문자전송</title>

<script language="JavaScript">
<!--
    function maxLengthCheck(maxSize, lineSize, obj, remainObj) {
        var temp;
        var f = obj.value.length;
        var msglen = parseInt(maxSize);
        var tmpstr = "";
        var enter = 0;
        var strlen;

        if (f == 0)//남은 글자 byte 수 보여 주기
        {
            if (remainObj != null)//null 옵션이 아닐 때 만 보여준다.
            {
                remainObj.value = (80 - msglen) + "/80 Byte";
            }
        }
        else {
            for (k = 0; k < f ; k++) {
                temp = obj.value.charAt(k);

                if (temp == "\n") {
                    enter++;
                }
                if (escape(temp).length > 4)
                    msglen -= 2;
                else
                    msglen--;

                if (msglen < 0) {
                    alert("총 영문 " + (maxSize * 2) + "자 한글 " + maxSize + "자 까지 쓰실 수 있습니다.");
                    obj.value = tmpstr;
                    break;
                }
                else if (lineSize != null & enter > parseInt(lineSize))// lineSize 옵션이 nulldl 아닐 때만 사용
                {
                    alert("라인수 " + lineSize + "라인을 넘을 수 없습니다.")
                    enter = 0;
                    strlen = tmpstr.length - 1;
                    obj.value = tmpstr.substring(0, strlen);
                    break;
                }
                else {
                    if (remainObj != null) {
                        remainObj.value = (80 - msglen) + "/80 Byte";
                    }
                    tmpstr += temp;
                }
            }
        }
    }

  
function bkindwrite(frm) {
    if (frm.searche.value == "") {
        alert("문자내용을을 입력하여 주시기바랍니다.");
        frm.searche.focus();
        return false;
    }
    else {

        var msg;
        msg = confirm("전송하시하겠습니까?");
        if (msg) {
           //form.dflag.value = "1"
           //form.action = "msmsok.asp?searche =tcode";
            frm.submit();
          //  return false;
            
        }
    }
	//frm.submit() ;
}

function bkindwrite2(form) {
    this.close();
}
//-->
</script>
</head>

<body leftmargin="0" topmargin="0">
    <form action="msmsok.asp">
     <input type=hidden name=searcha value="<%=tcodeE%>">
      
<table width="470" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 문자전송 ]</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% >
      <tr height=70 bgcolor=#F7F7FF align=center>
		<td width=100% colspan="2">
            <textarea name="searche" maxlength="80" style="width:100%;height:70px;BORDER-RIGHT: #BDBEBD 1px solid; BORDER-TOP: #BDBEBD 1px solid; BORDER-LEFT: #BDBEBD 1px solid; BORDER-BOTTOM: #BDBEBD 1px solid" class="box_work" value="<%=searchf%>" onKeyup="javascript:maxLengthCheck('80', null, this, byteprint);"></textarea>
     <!--  <%=tcode%>-->
		</td>
		
	</tr>
    <tr height=28 bgcolor=#F7F7FF align=center>
		<td width=100% colspan="2"> <input type="Text" name="byteprint" size="10" maxlength="80" class="box_work" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" readonly="true" value="0/80 Byte">	</td>
		
	</tr>

       

    
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=20%><B>전송건수:</td>
		<td width=80%><B><%=smscnt%>건</td>
   
		
	</tr>

    <tr height=28 bgcolor=#F7F7FF align=center>
		<td width=100% colspan="2"><B>위 문자를 전송하시겠습니까?</td>
		
	</tr>

      <tr height=28 bgcolor=#F7F7FF align=center>
		<td width=100% colspan="2">

            <input type="button" value="전 송" style='background-color:#C1C184;' style="width:20%;" onclick="return bkindwrite(this.form);"">
             <input type="button" value="취 소" style='background-color:#C1C184;' style="width:20%;" onclick="    return bkindwrite2(this.form);">
		</td>
		
	</tr>




</table>


				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>
        </form>
</body>
</html>