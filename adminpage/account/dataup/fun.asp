<%
	Function FunFirstEdite(fun_firstdata,fun_editedate)	'NULL�϶� �� ��ġ
		if fun_firstdata = "" then
			FunFirstEdite = fun_editedate
		else
			FunFirstEdite = fun_firstdata
		end if
	End Function

	Function FunErrorMsg(errormsg)	'�����޼���
			FunErrorMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg &"');history.go(-1);</SCRIPT>"
			response.write FunErrorMsg
			response.end
	End Function

	Function FunSucMsg(Sucmsgmsg,Sucpage)	'������ �̵��޼���
			FunSucMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& Sucmsgmsg &"');location.href='"& Sucpage &"';</SCRIPT>"
			response.write FunSucMsg
			response.end
	End Function

	Function FunSucMsgF(Sucmsgmsg1)	'����/������ �̵��޼��� �����ӽ�
			FunSucMsgF = "<SCRIPT LANGUAGE=JavaScript>alert('"& Sucmsgmsg1 &"');window.open(""request.asp?er_code=1"", ""_top"");</SCRIPT>"
			response.write FunSucMsgF
			response.end
	End Function

	Function FunErrorMsgClose(errormsg2)	'�����޼����� �ݱ�
			FunErrorMsgClose = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg2 &"');window.close();</SCRIPT>"
			response.write FunErrorMsgClose
			response.end
	End Function

	Function FunWindowrCloseReload()	'�θ�â ���ε�
			FunWindowrCloseReload = "<SCRIPT LANGUAGE=JavaScript>opener.location.reload();window.close();</SCRIPT>"
			response.write FunWindowrCloseReload
			response.end
	End Function

	Function FunWindowrCloseReload2(Reloadmsg)	'�θ�â ���ε�
			FunWindowrCloseReload2 = "<SCRIPT LANGUAGE=JavaScript>alert('"& Reloadmsg &"');opener.location.reload();window.close();</SCRIPT>"
			response.write FunWindowrCloseReload2
			response.end
	End Function

	Function FunZeroCheck(ZeroValue)		'üũ�� ����/�ð��տ� 0���̱�(üũ��)
		if len(ZeroValue)=0 then
			FunZeroCheck = ""
		elseif len(ZeroValue)=1 then
			FunZeroCheck = "0"&ZeroValue
		else
			FunZeroCheck = ZeroValue
		end if
	End Function

	Function FunNullMsg(nullmsgval1,nullmsgval2)
		if trim(nullmsgval1) = "" or isnull(nullmsgval1) then
			FunNullMsg = nullmsgval2
		else
			FunNullMsg = ""
		end if
	End Function

	Function FunDateEdite(Fun_ymdDate,rflag)	'���ڱ��� 20051212�� 2005-12-12
		if Fun_ymdDate<>"" then
			FunDateEdite = mid(Fun_ymdDate,1,4)&rflag&mid(Fun_ymdDate,5,2)&rflag&mid(Fun_ymdDate,7,2)
		else
			FunDateEdite = ""
		end if
	End Function

	Function FunTelEdite(telData1,telData2,telData3)	'��ȭ��ȣ���� 02,2214,0833�� 02-2214-0833
		if telData1<>"" and telData2<>"" and telData3<>"" then
			FunTelEdite = telData1&"-"&telData2&"-"&telData3
		else
			FunTelEdite = ""
		end if
	End Function

	Function FunYMDHMS(fdateval)				'��/��/��/�ð�/��/�� ����
		o_yyy = replace(left(fdateval,10),"-","")
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
		se = cstr(second(time))
		if len(se) = 1 then
			se2 = "0"&se
		else
			se2 = se
		end if
		FunYMDHMS = o_yyy&ho2&mi2&se2
	End Function

	Function FunSGUBUNKIND(sgubunname)	'�п����� 10:�ι����� 11:���� 12:�ܱ��� 13:��ü�� 14:��Ÿ
		select case sgubunname
			case "10"
				FunSGUBUNKIND = "�ι�����"
			case "11"
				FunSGUBUNKIND = "����"
			case "12"
				FunSGUBUNKIND = "�ܱ���"
			case "13"
				FunSGUBUNKIND = "��ü��"
			case "14"
				FunSGUBUNKIND = "��Ÿ"
		end select
	End Function

	Function Funadminadodename(funacode)	'������ã��
		SQL = "SELECT aname FROM tb_adminstore where acode = '"& funacode &"' "
		Set Rsadmin = Db.Execute(SQL)
		Funadminadodename = Rsadmin(0)
		Rsadmin.close
		set Rsadmin=nothing
	End Function

	Function Fungdodename(fungcode)		'������ã��
		SQL = "SELECT gname FROM tb_store where gcode = '"& fungcode &"' "
		Set Rsadmin = Db.Execute(SQL)
		Fungdodename = Rsadmin(0)
		Rsadmin.close
		set Rsadmin=nothing
	End Function

	Function FunHpcompany(funHpcompanyval)		'�ڵ�����Ż� 1:SKT 2:KTF 3:LGT
		select case funHpcompanyval
			case "1"
				FunHpcompany = "SKT"
			case "2"
				FunHpcompany = "KTF"
			case "3"
				FunHpcompany = "LGT"
		end select
	End Function

	Function FunSearchDate(funsdval)	'�˻�����Ÿ�Ժ���
		FunSearchDate = mid(funsdval,1,4)&"-"&mid(funsdval,5,2)&"-"&mid(funsdval,7,2)
	End Function

	Function FunFileDelete(defaultFilepath,deletefilename)	'���ϻ���
		Set fc = server.createobject("scripting.filesystemobject")
		If fc.fileexists(defaultFilepath & deletefilename) Then
			DelFile = defaultFilepath & deletefilename
			fc.deletefile(DelFile)
		End if
		Set fc = Nothing
	End Function

	Function FunHPCut(Hvalnum)	'�ڵ�����ȣ0111111111->011-111-1111
		if Hvalnum<>"" and len(Hvalnum)>=10 then
			imsilenhp  = len(Hvalnum)	'��ü����
			imsilenhp1 = left(Hvalnum,3)	'��Ż��ȣ
			imsilenhp2 = mid(left(Hvalnum,(imsilenhp-4)),4)	'����
			imsilenhp3 = right(Hvalnum,4)	'��ȭ��ȣ
			FunHPCut = imsilenhp1&"-"&imsilenhp2&"-"&imsilenhp3
		end if
	End Function

	sub SelectDateChoice(yearDa,monthDa,dayDa,yvalD,mvalD,dvalD)
		imsiymd = replace(left(now(),10),"-","")
		imsiye = left(imsiymd,4)
		imsimo = mid(imsiymd,5,2)
		imsida = right(imsiymd,2)
		response.write "<select name="&yearDa&">"
					response.write "<option value=>����"
					for i=2005 to (imsiye+1)
						imsiselected = ""
						if yvalD<>"" then
							if cstr(yvalD)=cstr(i) then
								imsiselected = "selected"
							end if
						end if
						response.write "<option value="& i &" "& imsiselected &">"&i&"��"
					next
		response.write "</select>"
		response.write "<select name="&monthDa&">"
					response.write "<option value=>����"
					for i=1 to 12
						if i<10 then
							ii=cstr("0"&i)
						else
							ii=cstr(i)
						end if
						imsiselected = ""
						if mvalD<>"" then
							if mvalD=ii then
								imsiselected = "selected"
							end if
						end if
						response.write "<option value="& ii &" "& imsiselected &">"&ii&"��"
					next
		response.write "</select>"
		if dayDa<>"" then
		response.write "<select name="&dayDa&">"
					response.write "<option value=>����"
					for i=1 to 31
						if i<10 then
							ii=cstr("0"&i)
						else
							ii=cstr(i)
						end if
						imsiselected = ""
						if dvalD<>"" then
							if dvalD=ii then
								imsiselected = "selected"
							end if
						end if
						response.write "<option value="&ii&" "& imsiselected &">"&ii&"��"
					next
		response.write "</select>"
		end if
	end sub

	SUB FunFileMakeStart(fundirval)
		Set fs = Server.CreateObject("Scripting.FileSystemObject")
		fs.CreateTextFile fundirval,true
		Set objFile = fs.OpenTextFile(fundirval,8)
	End SUB

	SUB FunFileMakeEnd()
		objFile.close
		set objFile=nothing
	End SUB
%>
