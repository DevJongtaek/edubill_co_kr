<%
	Response.Expires = -1
	response.AddHeader "Pragma", "no-cache"
	response.AddHeader "cache-control", "no-store"
%>
<!--#include virtual="/db/db.asp" -->
<%
	imsi_userid = request("mid")
	imsi_userpwd = request("mpwd")

	pwd = request("pwd")
	bccode = replace(request("bccode")," ","")
	bcode = left(bccode,4)	'�����Է��ڵ�
	ccode = right(bccode,4)	'ü�����Է��ڵ�

	'2011-08-25 ����,�÷����� ��� �߰�
	set rsTel = server.CreateObject("ADODB.Recordset")
	SQL = " select "
	SQL = SQL & " (select '('+tel1 + ') ' + tel2 + '-' +tel3 tel from tb_company "
	SQL = SQL & " where idx = '19209') gnfood, "
	SQL = SQL & " (select '('+tel1 + ') ' + tel2 + '-' +tel3 tel from tb_company "
	SQL = SQL & " where idx = '77275') pluson "
	rsTel.Open SQL, db, 1
	If Not rsTel.eof Then
		gnfood = rsTel(0)
		pluson = rsTel(1)
	End If 
	rsTel.close

	'ü��������	tcode = �������Է����ڵ尪
	set rs = server.CreateObject("ADODB.Recordset")	
'	SQL = "select (select comname from tb_company where flag='1' and tcode = '"& bcode &"'),comname,bidxsub,idxsub,idx"
'	SQL = SQL & " from tb_company "
'	SQL = SQL & " where flag = '3' "
'	SQL = SQL & " and bidxsub in ( "
'	SQL = SQL & " 			select idx from tb_company where flag='1' and tcode = '"& bcode &"' "
'	SQL = SQL & " 		     ) "
'	SQL = SQL & " and tcode = '"& ccode &"' "

	SQL = "select a.comname,b.comname,b.bidxsub,b.idxsub,b.idx,b.soundfile,isnull(b.orderflag,'') as orderflag,a.timecheck1,a.timecheck2,"
	SQL = SQL & " b.order_weekgubun,b.order_weekchoice,b.order_checkStime,b.order_checkEtime,a.myflag, b.mi_money, b.ye_money,a.tel1,a.tel2,a.tel3,a.sclose,a.proflag1,a.myflag_select "
	SQL = SQL & " from tb_company a, tb_company b "
	SQL = SQL & " where a.idx=b.bidxsub "
	SQL = SQL & " and a.flag = '1' and b.flag='3' "
	SQL = SQL & " and a.tcode = '"& bcode &"' "
	SQL = SQL & " and b.tcode = '"& ccode &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		username1 = rs(0)	'ȸ�����
		username2 = rs(1)	'ü������
		username = username1&" "&username2

		bcode = rs(2)		'���� �����ڵ�� ��ȯ
		jcode = rs(3)		'���� �����ڵ�� ��ȯ
		ccode = rs(4)		'���� ü�����ڵ�� ��ȯ
		soundfile = rs(5)	'��й�ȣ
		orderflag = rs(6)	'�����������y/n
		if orderflag = "" then
			orderflag = "n"
		end if
		imsinum = 1
		timecheck1 = rs(7)
		timecheck2 = rs(8)

		imsitimecheck1 = timecheck1
		imsitimecheck2 = timecheck2

		rs_order_weekgubun  = rs(9)
		rs_order_weekchoice = rs(10)
		rs_order_checkStime = rs(11)
		rs_order_checkEtime = rs(12)

		rs_myflag = rs(13)
		rs_mi_money = rs(14)	'�̼�
		rs_ye_money = rs(15)	'����
		rs_tel1     = rs(16)
		rs_tel2     = rs(17)
		rs_tel3     = rs(18)
		rs_tel = rs_tel1&"-"&rs_tel2&"-"&rs_tel3
		rs_sclose   = rs(19)
		rs_proflag1 = rs(20)
		rs_myflag_select = rs(21)
	else
		imsinum = 0
	end if
	rs.close

	if imsinum = 0 then
		response.write "<Script language=javascript>"
		response.write "	alert(""�����ڵ� �Ǵ� ü�����ڵ尡 Ʋ���ϴ�.\n�ٽ� �Է��Ͽ� �ֽñ� �ٶ��ϴ�."");"
		response.write "	history.go(-1);"
		response.write "</Script>"
	end if

	if rs_sclose = "n" then
		response.write "<Script language=javascript>"
		response.write "	alert(""���� ���񽺰� �Ͻ������� �����Դϴ�.\n�����ڿ��� ���� �Ͽ� �ֽñ� �ٶ��ϴ�."");"
		response.write "	history.go(-1);"
		response.write "</Script>"
	end if

	if orderflag="1" or orderflag="2" or orderflag="3" Or orderflag = "6" then
		response.write "<Script language=javascript>"

		'y:�����ֹ�, 1:�̼���(����), 2:���(����), 3,����(����) 
		If orderflag="1" And bcode = "19209" Then 
			response.write "	alert(""���� �̼��� �������� �Դϴ�.\n\n����Ǫ�� �������̳� ����ڿ��� ���� �ٶ��ϴ�.!\n����Ǫ�� : " + gnfood + "(����:5)" + """);"	
			
		ElseIf orderflag="6" And bcode = "19209" Then 
			response.write "	alert(""���� �̼��� �������� �Դϴ�.\n\n�÷������̳� ����ڿ��� ���� �ٶ��ϴ�.!\n�÷����� : " + pluson + """);"	
		ElseIf orderflag="1" then
			response.write "	alert(""���� �̼��� �������� �Դϴ�.\n\nü�κ��γ� �������ͷ� ���� �ٶ��ϴ�.!"");"
		elseif orderflag="2" then
			response.write "	alert(""���� ������� �����Դϴ�.\n\nü�κ��η� ���� �ٶ��ϴ�.!"");"
		elseif orderflag="3" then
			response.write "	alert(""���� �������� �����Դϴ�.\n\nü�κ��η� ���� �ٶ��ϴ�.!"");"
		end if

		response.write "	history.go(-1);"
		response.write "</Script>"
		response.end
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if timecheck1<>"" and timecheck2<>"" then
		ho = cstr(hour(time))
		if len(ho) = 1 then
			ho2 = "0"&ho
		else
			ho2 = ho
		end if
		mi = cstr(minute(time))
		if len(mi) = 1 then
			mi2 = "0"&mi
		else
			mi2 = mi
		end if
		now_time   = "1"&ho2&mi2	'����ð�
		gijun_time1 = 12400		'���ؽð�1
		gijun_time2 = 10000		'���ؽð�2
		timecheck1 = "1"&timecheck1	'�����ð�1
		timecheck2 = "1"&timecheck2	'�����ð�2

'response.write timecheck1&"<BR>"
'response.write timecheck2&"<BR>"
'response.write now_time&"<BR>"
'response.end

		if timecheck1 < timecheck2 then
			if now_time >= timecheck1 and now_time <= timecheck2 then
				session("Aordertimeout") = "y"
				'response.write "<Script language=javascript>"
				'response.write "	alert(""���� �ֹ����� �ð��Դϴ�.\n\nü�κ��η� ���� �ٶ��ϴ�.!"");"
				'response.write "	history.go(-1);"
				'response.write "</Script>"
				'response.end
			end if
		else
			if now_time >= timecheck2 and now_time <= timecheck1 then

			else
			'if (now_time >= timecheck1 and now_time <= gijun_time1) or (now_time >= gijun_time2 and now_time <= timecheck2) then
				session("Aordertimeout") = "y"
				'response.write "<Script language=javascript>"
				'response.write "	alert(""���� �ֹ����� �ð��Դϴ�.\n\nü�κ��η� ���� �ٶ��ϴ�.!"");"
				'response.write "	history.go(-1);"
				'response.write "</Script>"
				'response.end
			end if
		end if

	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	Function Funloginok(fundata,funtime1,funtime2)
		ho = cstr(hour(time))
		if len(ho) = 1 then
			ho2 = "0"&ho
		else
			ho2 = ho
		end if
		mi = cstr(minute(time))
		if len(mi) = 1 then
			mi2 = "0"&mi
		else
			mi2 = mi
		end if
		now_time   = int("1"&ho2&mi2)		'����ð�
		timecheck1 = int("1"&funtime1)		'�����ð�1
		timecheck2 = int("1"&funtime2)		'�����ð�2
		today_week = int(WeekDay(Now()))	'���ÿ���
		fundata    = int(fundata)

		if fundata=1 then
			if today_week=7 or today_week=1 then
				if today_week = 7 then
					if now_time >= timecheck1 then
						loginokynflag = "y"
					else
						loginokynflag = "n"
					end if
				else
					if now_time <= timecheck2 then
						loginokynflag = "y"
					else
						loginokynflag = "n"
					end if
				end if
			else
				loginokynflag = "n"
			end if
		else
			if today_week=fundata-1 then
				if now_time >= timecheck1 then
					loginokynflag = "y"
				else
					loginokynflag = "n"
				end if
			elseif today_week=fundata then
				if now_time <= timecheck2 then
					loginokynflag = "y"
				else
					loginokynflag = "n"
				end if
			else
				loginokynflag = "n"
			end if
		end if

		Funloginok = loginokynflag

	End Function

	'rs_order_weekchoice- 1�� ~ 7��
	'rs_order_checkStime
	'rs_order_checkEtime

	if rs_order_weekgubun = "2" then	'�����ֹ�
		if rs_order_weekchoice<>"" and rs_order_checkStime<>"" and rs_order_checkEtime<>"" then

			for i=1 to len(rs_order_weekchoice)
				if i=1 then
					rs_order_weekchoice1 = mid(rs_order_weekchoice,1,1)
				elseif i=2 then
					rs_order_weekchoice2 = mid(rs_order_weekchoice,2,1)
				elseif i=3 then
					rs_order_weekchoice3 = mid(rs_order_weekchoice,3,1)
				elseif i=4 then
					rs_order_weekchoice4 = mid(rs_order_weekchoice,4,1)
				elseif i=5 then
					rs_order_weekchoice5 = mid(rs_order_weekchoice,5,1)
				elseif i=6 then
					rs_order_weekchoice6 = mid(rs_order_weekchoice,6,1)
				elseif i=7 then
					rs_order_weekchoice7 = mid(rs_order_weekchoice,7,1)
				end if
			next

			if rs_order_weekchoice1<>"" then
				imsiloginok1 = Funloginok(rs_order_weekchoice1,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok1 = "n"
			end if
			if rs_order_weekchoice2<>"" then
				imsiloginok2 = Funloginok(rs_order_weekchoice2,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok2 = "n"
			end if
			if rs_order_weekchoice3<>"" then
				imsiloginok3 = Funloginok(rs_order_weekchoice3,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok3 = "n"
			end if
			if rs_order_weekchoice4<>"" then
				imsiloginok4 = Funloginok(rs_order_weekchoice4,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok4 = "n"
			end if
			if rs_order_weekchoice5<>"" then
				imsiloginok5 = Funloginok(rs_order_weekchoice5,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok5 = "n"
			end if
			if rs_order_weekchoice6<>"" then
				imsiloginok6 = Funloginok(rs_order_weekchoice6,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok6 = "n"
			end if
			if rs_order_weekchoice7<>"" then
				imsiloginok7 = Funloginok(rs_order_weekchoice7,rs_order_checkStime,rs_order_checkEtime)
			else
				imsiloginok7 = "n"
			end if
		end if
'response.write imsiloginok1&"<BR>"&imsiloginok2&"<BR>"&imsiloginok3&"<BR>"&imsiloginok4&"<BR>"&imsiloginok5&"<BR>"&imsiloginok6&"<BR>"&imsiloginok7
'response.end
		if imsiloginok1="n" and imsiloginok2="n" and imsiloginok3="n" and imsiloginok4="n" and imsiloginok5="n" and imsiloginok6="n" and imsiloginok7="n" then
			session("Aordertimeout") = "y"
			'response.write "<Script language=javascript>"
			'response.write "	alert(""���� �ֹ����� �ð��Դϴ�.\n\nü�κ��η� ���� �ٶ��ϴ�.!"");"
			'response.write "	history.go(-1);"
			'response.write "</Script>"
			'response.end
		end if

	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select filename from tb_adminuser where flag= '2' and usercode = '"& bcode &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		filename = rs(0)
	end if
	rs.close

	'imsiusercodeimsi = trim(bcode&jcode&ccode)
	'set rs = server.CreateObject("ADODB.Recordset")
	'SQL = "select userpwd from tb_adminuser where flag= '4' and usercode = '"& imsiusercodeimsi &"' "
	'rs.Open sql, db, 1
	'if not rs.eof then
	'	imsipwd = rs(0)
	'end if
	'rs.close
	imsipwd = soundfile

	if imsipwd <> "" then
		if imsipwd <> pwd then
			response.write "<Script language=javascript>"
			response.write "	alert(""��й�ȣ�� Ʋ���ϴ�.\n�ٽ� �Է��Ͽ� �ֽñ� �ٶ��ϴ�."");"
			response.write "	history.go(-1);"
			response.write "</Script>"
			response.end
		end if
	end if

	select case imsinum
		case 0

			response.write "<Script language=javascript>"
			response.write "	alert(""�����ڵ� �Ǵ� ü�����ڵ尡 Ʋ���ϴ�.\n�ٽ� �Է��Ͽ� �ֽñ� �ٶ��ϴ�."");"
			response.write "	history.go(-1);"
			response.write "</Script>"

		case else

			session("AAcomname")  = ""	'ȸ����+ü������
			session("AAusercode") = ""	'����+����+ü�����ڵ�
			session("AAfilename") = ""
			session("AAtel")      = ""	'ȸ���翬��ó

			session("AAcomname")  = username		'ȸ����+ü������
			session("AAusercode") = bcode&jcode&ccode	'����+����+ü�����ڵ�
			session("AAfilename") = filename
			session("AAtel")      = rs_tel			'ȸ���翬��ó
			session("AAproflag")  = rs_proflag1		'�ֹ���� 1:�ؽ�Ʈ 2:����Ŵ�
			session("AAtcode")    = right(bccode,4)		'tcode

			orderYN = 0
			set rsorder = server.CreateObject("ADODB.Recordset")
			SQL = " select count(idx) from tb_order "
			SQL = SQL & " where orderday = CONVERT(CHAR(8), GETDATE(), 112) "
			SQL = SQL & " and usercode = '" & session("AAusercode") & "' "
			rsorder.Open SQL, db, 1
			If Not rsorder.eof Then
				orderYN = rsorder(0)
			End If 
			rsorder.close

			if rs_myflag="y" then	'����:�̼� ����
				If rs_myflag_select = "3" And orderYN > 0 Then '3�̸� ���� �ֹ����� ������ �߰� �ֹ� ����
					session("ymflag") = ""
					orderMoney       = rs_ye_money-rs_mi_money
					imsi_rs_ye_money = FormatCurrency(rs_ye_money,0)
					imsi_rs_mi_money = FormatCurrency(rs_mi_money,0)
					imsijavamsg = "\n\n����, �ܻ��ѵ��� : "& FormatNumber(rs_ye_money,0) &" �� "
					imsijavamsg = imsijavamsg & "\n\n        �ѹ̼��ݾ� : "& FormatNumber(rs_mi_money,0) &" ��"
					If bcode <> "25782" Then 
					imsijavamsg = imsijavamsg & "\n\n        �ֹ����ɾ� : "& FormatNumber(orderMoney,0) &" �� �Դϴ�."
					End If 
					response.write "<Script language=javascript>"
					response.write "	alert("""&session("AAcomname")&"���� �α��� �ϼ̽��ϴ�."& imsijavamsg &""");"
					if session("AAproflag")="1" then	'�ֹ���� 1:�ؽ�Ʈ 2:����Ŵ�
						response.write "	location.href = ""/adminpage/index4.asp?gongi=1"";"
					else
						''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
						If session("ABasket") = "y" then
						SQL = "delete tb_product_cart where usercode = '"& session("AAusercode") &"' "	'��ٱ��ϻ���
                        SQL2 = "delete tb_product_cart_Return where usercode = '"& session("AAusercode") &"' "	'��ٱ��ϻ���
						db.Execute SQL
                        db.Execute SQL2
						db.close
						End If 
						''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
						response.write "	location.href = ""/adminpage/agency/AgencyOrderFRM.asp?gongi=1&basket=" & rsResetBasket &""";"
					end if
					response.write "</Script>"
				Else
					orderMoney       = rs_ye_money-rs_mi_money
					imsi_rs_ye_money = FormatCurrency(rs_ye_money,0)
					imsi_rs_mi_money = FormatCurrency(rs_mi_money,0)
					imsijavamsg = "\n\n����, �ܻ��ѵ��� : "& FormatNumber(rs_ye_money,0) &" ��"
					imsijavamsg = imsijavamsg & "\n\n        �ѹ̼��ݾ� : "& FormatNumber(rs_mi_money,0) &" ��"
					If bcode <> "25782" Then 
					imsijavamsg = imsijavamsg & "\n\n        �ֹ����ɾ� : "& FormatNumber(orderMoney,0) &" �� �Դϴ�."
					End if 

					'rs_ye_money >= rs_mi_money then ���� >= �̼� : ���������� �ֹ� ����
					if rs_ye_money < rs_mi_money then	'���� < �̼�   : �ֹ��� ���� �ʰ� Comment �Է¸� ����
						session("ymflag") = "y"
						response.write "<Script language=javascript>"
						response.write "	alert("""&session("AAcomname")&"���� �α��� �ϼ̽��ϴ�."& imsijavamsg &""");"
						response.write "	location.href = ""/adminpage/comment.asp?gongi=1"";"
						response.write "</Script>"
						response.end
					end If
				End if
			end if

			if session("Aordertimeout") = "y" then
				'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				if timecheck1<>"" and timecheck2<>"" then
					close_timecheck1 = left(imsitimecheck1,2) &":"& right(imsitimecheck1,2)
					close_timecheck2 = left(imsitimecheck2,2) &":"& right(imsitimecheck2,2)
					close_timecheck  = close_timecheck1 &" �� "& close_timecheck2
				end if
				'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				imsival  = ""
				imsival2  = ""
				if len(rs_order_weekchoice)>0 and rs_order_weekgubun="2" then
					for k=1 to len(rs_order_weekchoice)
						select case trim(mid(rs_order_weekchoice,k,1))
							case "2"
								imsival = "��"
							case "3"
								imsival = "ȭ"
							case "4"
								imsival = "��"
							case "5"
								imsival = "��"
							case "6"
								imsival = "��"
							case "7"
								imsival = "��"
							case "1"
								imsival = "��"
						end select

						if imsival2="" then
							imsival2 = imsival
						else
							imsival2 = imsival2 &"/"& imsival
						end if
					next
					close_weekgubun = imsival2
				end if
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				if rs_order_checkStime<>"" and rs_order_checkEtime<>"" then
					close_order_checkStime = left(rs_order_checkStime,2) &":"& right(rs_order_checkStime,2)
					close_order_checkEtime = left(rs_order_checkEtime,2) &":"& right(rs_order_checkEtime,2)
					close_checktime        = " ( ���� " & close_order_checkStime &" �� ���� "& close_order_checkEtime &" )"
				end if
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				closemsg = "�ֹ����� �ð��̹Ƿ� �ֹ��� �Ͻ� �� �����ϴ�.!! "
				closemsg = closemsg & "\n���ܽð�(����) : "& close_timecheck
				if rs_order_weekgubun="2" then
					closemsg = closemsg & "\n"
					if close_weekgubun<>"" then
						closemsg = closemsg & "���ð�(����) : " & close_weekgubun
					end if
					if close_checktime<>"" then
						closemsg = closemsg & close_checktime & " " & Date() & " " & Time()
					end if
				end if
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				response.write "<Script language=javascript>"
				'response.write "	alert(""���� �ֹ����� �ð��Դϴ�.\n\n"&session("AAcomname")&"���� �α��� �ϼ̽��ϴ�."& imsijavamsg &""");"
				response.write "	alert("""& closemsg &"\n\n"&session("AAcomname")&"���� �α��� �ϼ̽��ϴ�."& imsijavamsg &""");"
				response.write "	location.href = ""/adminpage/agency/list.asp"";"
				response.write "</Script>"
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			else
				response.write "<Script language=javascript>"
				response.write "	alert("""&session("AAcomname")&"���� �α��� �ϼ̽��ϴ�."& imsijavamsg &""");"
				if session("AAproflag")="1" then	'�ֹ���� 1:�ؽ�Ʈ 2:����Ŵ�
					response.write "	location.href = ""/adminpage/index4.asp?gongi=1"";"
				else
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

					SQL = "delete tb_product_cart where usercode = '"& session("AAusercode") &"'  AND Wdate != CONVERT(CHAR(8), GETDATE(), 112) "	'��ٱ��ϻ���
                    SQL2 = "delete tb_product_cart_Return where usercode = '"& session("AAusercode") &"'  AND Wdate != CONVERT(CHAR(8), GETDATE(), 112) "	'��ٱ��ϻ���
					db.Execute SQL
                    db.Execute SQL2
					db.close
					''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
					response.write "	location.href = ""/adminpage/agency/AgencyOrderFRM.asp?gongi=1"";"
				end if
				response.write "</Script>"
			end if


	
	end select
%>