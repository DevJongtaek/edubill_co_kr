<% page_num_depth_01 = "1" %>
<% page_num_depth_02 = "2" %>



<!--#include virtual = '/inc/header.asp'-->

<body>
<!--top-->
<table width="980" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left">
<!--#include virtual = '/inc/sub_top.asp'-->
    </td>
  </tr>
</table>
<!--/top-->

<!--컨텐츠-->
<table width="980" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top"> 
    <td width="242">
<!--#include virtual = '/intranet/left_menu.asp'-->
    </td>
    <td><!--타이틀--><table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:30">
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="300" height="40" align="left"><img src="../images/intranet/title_02.gif" width="106" height="26" /></td>
                <td align="right" valign="middle"><img src="../images/common/b_1.gif" width="10" height="9" />&nbsp;HOME&nbsp;<img src="../images/common/b_2.gif" width="3" height="10" />&nbsp;인트라넷&nbsp;<img src="../images/common/b_2.gif" width="3" height="10" /><span class="style1"> 
                  <strong>가상계좌
</strong></span></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="144" height="1" bgcolor="327bc7"></td>
                <td height="1" bgcolor="c7c7c7"></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <!--/타이틀-->
	  <!--내용시작-->

	  <br>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="300" align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td height="400" align="center" valign="top"><table border="0" cellspacing="0" cellpadding="0">
	          <tr>
	            <td><img src="../images/intranet/gate_01.jpg"></td>
	            </tr>
	          <tr>
	            <td background="../images/intranet/login_18.jpg"><table border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td><img src="../images/intranet/gate_02.jpg"></td>
	                <td width="20" valign="top">&nbsp;</td>
	                <td valign="top"><table border="0" cellspacing="0" cellpadding="0">
	                  <tr>
	                    <td width="320"><span style="PADDING-left: 5px; WORD-BREAK: break-all;"><img src="../images/intranet/gate_04.jpg"></span></td>
	                    </tr>
	                  <tr>
	                    <td height="30">&nbsp;</td>
	                    </tr>
	                  <tr>
	                    <td align="center"><table border="0" cellpadding="0" cellspacing="0">
	                      <form action="login_ok.asp" method="post" name="login" id="login" onsubmit="mainLoginInputSendit(login);event.returnValue = false;">
	                        <input type='hidden' name='guestCHK' value='<%=guestCHK%>' />
	                        <tr>
	                          <td align="left" valign="middle"><img src="../images/intranet/login_07.jpg"></td>
	                          <td align="left" valign="middle"><input name="userid" type="text" class="input" maxlength='15' onkeydown="mainLoginInputSendit(login)" size='20' /></td>
	                          <td rowspan="3" align="right" valign="middle" style="PADDING-left: 5px; WORD-BREAK: break-all;"><img src="../images/intranet/login_09.jpg"></td>
	                          </tr>
	                        <tr>
	                          <td height="5" align="left" valign="middle"></td>
	                          <td height="5" align="left" valign="middle"></td>
	                          </tr>
	                        <tr>
	                          <td align="left" valign="middle"><img src="../images/intranet/login_11.jpg"></td>
	                          <td align="left" valign="middle"><input name="userid2" type="text" class="input" maxlength='15' onkeydown="mainLoginInputSendit(login)" size='20' /></td>
	                          </tr>
	                        </form>
	                      </table></td>
	                    </tr>
	                  <tr>
	                    <td height="30">&nbsp;</td>
	                    </tr>
	                  <tr>
	                    <td align="right"><table border="0" cellspacing="0" cellpadding="0">
	                      <!--<tr>
	                        <td><a href="#" onclick="window. open ('use_app.asp', 'use_app', 'width=570, height=320, scrollbars=yes')"><img src="../images/intranet/gate_08.jpg"></a></td>
	                        <td><img src="../images/intranet/gate_09.jpg"></td>
	                        <td width="22">&nbsp;</td>
	                        </tr>//-->
	                      </table></td>
	                    </tr>
	                  </table></td>
	                </tr>
	              </table></td>
	            </tr>
	          <tr>
	            <td><img src="../images/intranet/login_19.jpg"></td>
	            </tr>
	          </table></td>
	        </tr>
	      </table></td>
	  </tr>
	  </table><!--/내용시작--></td>
  </tr>
</table>
<!--/컨텐츠-->


<!--bottom-->
<table width="980" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><!--#include virtual = '/inc/foot.asp'--></td>
  </tr>
</table>
<!--/bottom-->
</body>
</html>
