<% page_num_depth_01 = "1" %>
<% page_num_depth_02 = "1" %>



<!--#include virtual = '/inc/header.asp'-->
<head>
<script language="JavaScript">
<!--
	function focus()
	{
		document.login.mid.focus();
		return 0;
	}
	function leave()
	{
		document.login.mpwd.focus();
		return 0;
	}
//-->
</script>
     <link rel="stylesheet" href="../css/common.css" type="text/css">
</head>
<body onload="return focus();">


<!--컨텐츠-->

	 <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
         
                              <br />
                              <br />
                              <br />
                            <br />
                              <br />
                              <br />
                             <br />
                             
                              
        <tr height="47">
            <td align="center">

                <table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
                    <tr height="47">
                        <td align="center">




                            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" align="center">

                              

                                 
                                    <tr>
                                        <td align="center">

                                            <table width="540" height="350" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td valign="top" background="../images/intranet/intranetLogin.jpg">

                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td height="220">&nbsp;</td>
                                                            </tr>

                                                            <tr>
                                                                <td align="right">

                                                                 <table border="0" cellspacing="0" cellpadding="0">
	                
	                     <tr> 
                          <td style="font-size:13px;color:red" align="right">'관리자' 아이디/비밀번호를 입력해 주세요. 

                        </tr>
	                  <tr>
	                    <td align="center">
                            <table border="0"  align="right">
	                      <form action="/info/loginok.asp" name=login onsubmit="return logincheck();" />
	                        <tr>
	                          <td align="right" valign="middle" style="font-size:12px;">아이디 :</td>
	                          <td align="right" valign="middle"><input name="mid" type="text" class="input" maxlength='10' onkeyup="characterCheck()" onkeydown="characterCheck()" tabindex="1"  onblur="return leave();" size="12" style="font-size:12px;"  /></td>
	                          <td rowspan="3" align="right" valign="middle" style="PADDING-left: 5px; WORD-BREAK: break-all;"><input type=image src="../images/main/login_02.gif" width="58" height="42" border="0"></td>
	                          </tr>
	                      
	                         <td align="right" valign="middle" style="font-size:12px;"> 비밀번호 :</td>
	                          <td align="right" valign="middle"><input name="mpwd" type="password" class="input" maxlength='10' tabindex="2" onkeydown="mainLoginInputSendit(login)" size="12" style="font-size:12px;" /></td>
	                          </tr>
	                        </form>
	                      </table></td>
                                                                <td style="width:20px;">&nbsp;</td>
	                    </tr>
	                 
	                
	                  </table>

                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                              

                            </table>

                        </td>
                    </tr>
                </table>

            </td>
        </tr>
    </table>
                    
                  



<!--/bottom-->
</body>
</html>
