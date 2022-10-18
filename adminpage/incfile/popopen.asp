<!-- #include virtual="/db/db.asp" -->
<script>
function setCookie(name, value, expiredays){

var todayDate = new Date();

todayDate.setDate(todayDate.getDate() + expiredays);

document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"

}



function closePop(){

setCookie("close20150406","close20150406",1);



}

function closepop1()
    {
    window.close();
    }
</script>
<%
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

	if imsihflag="n" then
		imsicontent = Replace(imsicontent,chr(13),"<br>")
	end if

%>

<%=imsicontent%>


<div id="popFooter">
     <div class="popChk"  style="position:absolute;">
      <input type="checkbox" name="popcheck" onclick="closePop();" />¿À´Ã ÇÏ·ç ±×¸¸ º¸±â &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="javascript:closepop1();"><span>[´Ý±â]</span></a>
     </div>
    </div>
