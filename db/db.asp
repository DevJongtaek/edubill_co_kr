<%
set db = server.CreateObject("ADODB.Connection")   '������ü db����
 'db.Open "provider=sqloledb;server=220.73.136.46;database=edubill_co_kr_test;uid=sa;pwd=qsefofedubill;"	'db�� ���� ( OdbcEdubill )
    db.Open "provider=sqloledb;server=.;database=edubill_co_kr;uid=sa;pwd=qsefofedubill;"	'db�� ���� ( OdbcEdubill )
 db.CommandTimeout = 120


SUB ordertimechb(bonsacode)
	if bonsacode<>"" then
		set rsClose = server.CreateObject("ADODB.Recordset")
		SQL = " select timecheck1,timecheck2 from tb_company where idx = "& bonsacode &" and flag='1' "
		rsClose.Open sql, db, 1
		if not rsClose.eof then
			closetime1 = rsClose(0)
			closetime2 = rsClose(1)
		end if
		rsClose.close
		timecheck1 = closetime1
		timecheck2 = closetime2
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
			now_time    = "1"&ho2&mi2	'����ð�
			gijun_time1 = 12400		'���ؽð�1
			gijun_time2 = 10000		'���ؽð�2
			timecheck1  = "1"&timecheck1	'�����ð�1
			timecheck2  = "1"&timecheck2	'�����ð�2

			if timecheck1 < timecheck2 then
				if now_time >= timecheck1 and now_time <= timecheck2 then
					'response.write "1"
					response.write "<Script language=javascript>"
					response.write "	alert(""���� �ֹ����� �ð��Դϴ�.\n\nü�κ��γ� �������ͷ� ���� �ٶ��ϴ�.!"");"
					response.write "	history.go(-1);"
					response.write "</Script>"
					response.end
				end if
			else
				if (now_time >= timecheck1 and now_time <= gijun_time1) or (now_time >= gijun_time2 and now_time <= timecheck2) then
					'response.write "2"
					response.write "<Script language=javascript>"
					response.write "	alert(""���� �ֹ����� �ð��Դϴ�.\n\nü�κ��γ� �������ͷ� ���� �ٶ��ϴ�.!"");"
					response.write "	history.go(-1);"
					response.write "</Script>"
					response.end
				end if
			end if
		end if
	end if
End SUB
%>