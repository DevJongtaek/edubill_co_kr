<!--#include virtual="/db/Noticedb.asp" -->
<script language="javascript">
function newwinB(){
	window.open ('/adminpage/index.asp','CheckID','scrollbars=yes,width=800,height='+screen.availHeight+'');
}

	function noticeopenWin() 
	{ 
		document.all['notice'].style.display = "";
	}

	function noticecloseWin() 
	{ 
		document.all['notice'].style.display = "none";
    }
   
</script>

<body onload="login.mid.focus()">
<table width="100%" >
    <tr>
        <td align="center">
            
                              <br />
                              <br />
                              <br />
                            <br />
                              <br />
                              <br />
                             <br />
                              <br />
                              <br />
              <table width="540" height="350" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td valign="top" style="background-image:url('/adminpage/images/Login2.jpg')">
                  
                  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="220">&nbsp;</td>
                </tr>
                
                <tr>
                  <td>

<table height=100% border="0" cellspacing="0" cellpadding="0" align="right">
    
    <tr>
        
        <td>

            <form action="/adminpage/loginok.asp" name=login onsubmit="return logincheck();">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">

                  <tr valign="top"> 
                      <td width="197" align="right"> 
                        <!--멤버 로그인 영역-->
                        <table width="300" border="0">
       
                        <tr> 
                          <td style="font-size:13px;color:red" align="right">'체인본사' 아이디/비밀번호를 입력해 주세요. 

</td>
                        </tr>
                        <tr> 
                          <td> <% If session("userid") = "" Then %> 
                            <!-- 로그인 -->
                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                              <tr> 
                                  <td width="20%"></td>
                               <td align="right" valign="middle" style="font-size:12px;">아이디 :</td>
                                <td align="right" > <input name="mid" class="input01" id="m_id2" size="15" onkeyup="characterCheck()" tabindex="1" onkeydown="characterCheck()" onblur="return leave();">&nbsp;
                                </td>
                                <td width="58" rowspan="3" align="right"><input name="image" type=image src="../images/main/login_02.gif" width="58" height="42" border="0" tabindex="3"></td>
                              </tr>
                              <tr> 
                                <td height="3" colspan="4"></td>
                              </tr>
                              <tr> 
                                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                  <td align="right" valign="middle" style="font-size:12px;">비밀번호 :</td>
                                <td align="right"> <input name="mpwd" type="password" class="input01" id="m_pwd2" size="15" tabindex="2">&nbsp;
                                </td>
                              </tr>
                            </table>
                            <!-- /로그인 -->
                            <% Else %> 
                            <!-- 로그아웃 -->
<!--                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr> 
                                <td><span style="PADDING:0 0 0 10"> 아이디 </span></td>
                                <td width="58" rowspan="3" align="right"> <A href="../join/logout.asp"><img src="../images/main/login_021.gif" width="58" height="42" border="0"></a></td>
                              </tr>
                              <tr> 
                                <td height="3"></td>
                              </tr>
                              <tr> 
                                <td><span style="PADDING:0 0 0 10"> 이름</span></td>
                              </tr>
                            </table>-->
                            <!-- /로그아웃 -->
                            <% End If %> 
                        
       
                      </table>
                      <!--/멤버 로그인 영역 끝-->
                    </td>
  <td style="width:20px;">&nbsp;</td>
                  </tr>


                </table>
            </form>
        </td>
        <td>&nbsp;</td>
    </tr>

    </table>
                      </td>
                    </tr>
                      </table>

        </td>
    </tr>
</table>

