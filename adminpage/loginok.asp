<!--#include virtual="/db/db.asp" -->
<%
	imsi_userid = request("mid")
	imsi_userpwd = request("mpwd")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select usercode,username,alevel,flag,dcenteridx,blevel from tb_adminuser where userid = '"&imsi_userid&"' and userpwd = '"&imsi_userpwd&"' "
	rs.Open sql, db, 1
	if not rs.eof then
		imsinum = 1
		usercode = rs(0)
		username = rs(1)
		useralevel = rs(2)
		imsiflag = rs(3)
		dcenteridx = rs(4)
        userblevel = rs(5)
	else
		imsinum = 0
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select filename from tb_adminuser where flag= '2' and usercode = '"& left(usercode,5) &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		filename = rs(0)
	end if
	rs.close

	if imsiflag="4" then
		response.write "<Script language=javascript>"
		response.write "	alert(""체인점 회원님은 인터넷 홈페이지에 로그인 하실수 없습니다."");"
		response.write "	history.go(-1);"
		response.write "</Script>"
	else
		select case imsinum
			case 0

				response.write "<Script language=javascript>"
				response.write "	alert(""아이디 또는 비밀번호가 틀립니다.\n다시 입력하여 주시기 바랍니다."");"
				response.write "	history.go(-1);"
				response.write "</Script>"

			case else

				if usercode="000000000000000" then
					imsisclose = "y"
				else
					set rs = server.CreateObject("ADODB.Recordset")
					SQL = "select sclose,dcenterflag,proflag1,miorderflag,cyberNum,smsflag,choiceDcenter,jsusu,sms_send,UseReturn from tb_company where idx = "& left(usercode,5) &" "
					rs.Open sql, db, 1
					imsisclose = rs(0)
					dcenterflag = rs(1)
					proflag1 = rs(2)	'메뉴화면 설정 1:메뉴1(텍스트 2줄) 2:메뉴2
					miorderflag = rs(3)
					cyberNum = rs(4)
					smsflag = rs(5)
					choiceDcenter = rs(6)
					jsusu = rs(7)
					sms_send = rs(8) 'sms 보내기 저장(2011.04.12)
                    UseReturn = rs(9)'반품하기
					rs.close
				end if

				if imsisclose="y" then
					session("Auserid")  = imsi_userid	'아이디
					session("Auserpwd") = imsi_userpwd	'비밀번호
					session("Ausername") = username		'이름
					session("Ausercode") = usercode		'본사+(지점/체인점)코드
					if session("Ausercode")="000000000000000" then
						Ausergubun = "1"	'슈퍼유져
						filename = "logo.gif"
					else
						if len(session("Ausercode"))=5 then
							Ausergubun = "2"	'본사
						elseif len(session("Ausercode"))=10 then
							Ausergubun = "3"	'지사
							'''''''''''''''''''''''''''''''''''''''''''
							if dcenterflag="y" then	'물류센터 이용시
								session("Adcenteridx") = dcenteridx
							else
								session("Adcenteridx") = ""
							end if
							'''''''''''''''''''''''''''''''''''''''''''

						elseif len(session("Ausercode"))=15 then
							Ausergubun = "4"	'체인점
						end if
					end if
					session("Ausergubun")   = Ausergubun
					session("Auserwrite")   = useralevel
                    session("Buserwrite")   = userblevel
					session("Afilename")    = filename
					session("Aproflag")     = proflag1
					session("Amiorderflag") = miorderflag
					session("AcyberNum")    = cyberNum
					session("Asmsflag")     = smsflag
					session("Ajsusu")       = jsusu
					session("SMS")          = sms_send			'SMS보내기
                    session("UseReturn") = UseReturn
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					'if choiceDcenter="" or choiceDcenter=0 or isnull(choiceDcenter) then
					if session("Adcenteridx")="" then
						session("AchoiceDcenter") = ""
					else
						set rs = server.CreateObject("ADODB.Recordset")
						SQL = "select bname from tb_company_dcenter where bidx = "& session("Adcenteridx")
						rs.Open sql, db, 1
						if not rs.eof then
							imsibbname = rs(0)
						end if
						rs.close
						session("AchoiceDcenter") = imsibbname
					end if
					'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					set rs = server.CreateObject("ADODB.Recordset")
					SQL = "select flag from tb_gongi where loginflag='2' "
					rs.Open sql, db, 1
					if not rs.eof then
						imsiflag = rs(0)
					end if
					rs.close
					db.close
					if session("Ausergubun")="1" then
						imsiflag = ""
					end if

					if session("Ausergubun")="1" and (LCase(session("Auserid"))="admin" or LCase(session("Auserid"))="ADMIN")then
						response.redirect "guestbbs.asp"
						response.end
					end If
					
					if session("Ausergubun")="2" and (LCase(session("Auserid"))="huwloan" or LCase(session("Auserid"))="HUWLOAN")then
						response.redirect "loan/list.asp"
						response.end
					end if

					response.write "<Script language=javascript>"
					response.write "	alert("" "&session("Ausername")&"("&session("Auserid")&")님 안녕하세요!"");"
					response.write "	location.href = ""/adminpage/index2.asp?imsiflag="&imsiflag&""";"
					response.write "</Script>"
				else

					response.write "<Script language=javascript>"
					response.write "	alert(""현재 서비스가 일시정지된 상태입니다.\n관리자에게 문의 하여 주시기 바랍니다."");"
					response.write "	history.go(-1);"
					response.write "</Script>"

				end if
	
		end select
	end if
%>