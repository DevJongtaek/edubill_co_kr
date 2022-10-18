<%
	Function FunFirstEdite(fun_firstdata,fun_editedate)	'NULL일때 값 대치
		if fun_firstdata = "" then
			FunFirstEdite = fun_editedate
		else
			FunFirstEdite = fun_firstdata
		end if
	End Function

	Function FunErrorMsg(errormsg)	'에러메세지
			FunErrorMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg &"');history.go(-1);</SCRIPT>"
			response.write FunErrorMsg
			response.end
	End Function

	Function FunSucMsg(Sucmsgmsg,Sucpage)	'성공후 이동메세지
			FunSucMsg = "<SCRIPT LANGUAGE=JavaScript>alert('"& Sucmsgmsg &"');location.href='"& Sucpage &"';</SCRIPT>"
			response.write FunSucMsg
			response.end
	End Function

	Function FunSucMsgF(Sucmsgmsg1)	'성공/실패후 이동메세지 프레임시
			FunSucMsgF = "<SCRIPT LANGUAGE=JavaScript>alert('"& Sucmsgmsg1 &"');window.open(""request.asp?er_code=1"", ""_top"");</SCRIPT>"
			response.write FunSucMsgF
			response.end
	End Function

	Function FunErrorMsgClose(errormsg2)	'에러메세지후 닫기
			FunErrorMsgClose = "<SCRIPT LANGUAGE=JavaScript>alert('"& errormsg2 &"');window.close();</SCRIPT>"
			response.write FunErrorMsgClose
			response.end
	End Function

	Function FunWindowrCloseReload()	'부모창 리로드
			FunWindowrCloseReload = "<SCRIPT LANGUAGE=JavaScript>opener.location.reload();window.close();</SCRIPT>"
			response.write FunWindowrCloseReload
			response.end
	End Function

	Function FunWindowrCloseReload2(Reloadmsg)	'부모창 리로드
			FunWindowrCloseReload2 = "<SCRIPT LANGUAGE=JavaScript>alert('"& Reloadmsg &"');opener.location.reload();window.close();</SCRIPT>"
			response.write FunWindowrCloseReload2
			response.end
	End Function

	Function FunZeroCheck(ZeroValue)		'체크후 날자/시간앞에 0붙이기(체크값)
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

	Function FunDateEdite(Fun_ymdDate,rflag)	'날자구분 20051212를 2005-12-12
		if Fun_ymdDate<>"" then
			FunDateEdite = mid(Fun_ymdDate,1,4)&rflag&mid(Fun_ymdDate,5,2)&rflag&mid(Fun_ymdDate,7,2)
		else
			FunDateEdite = ""
		end if
	End Function

	Function FunTelEdite(telData1,telData2,telData3)	'전화번호구분 02,2214,0833를 02-2214-0833
		if telData1<>"" and telData2<>"" and telData3<>"" then
			FunTelEdite = telData1&"-"&telData2&"-"&telData3
		else
			FunTelEdite = ""
		end if
	End Function

	Function FunYMDHMS(fdateval)				'년/월/일/시간/분/초 구함
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

	Function FunSGUBUNKIND(sgubunname)	'학원구분 10:인문교육 11:보습 12:외국어 13:예체능 14:기타
		select case sgubunname
			case "10"
				FunSGUBUNKIND = "인문교육"
			case "11"
				FunSGUBUNKIND = "보습"
			case "12"
				FunSGUBUNKIND = "외국어"
			case "13"
				FunSGUBUNKIND = "예체능"
			case "14"
				FunSGUBUNKIND = "기타"
		end select
	End Function

	Function Funadminadodename(funacode)	'관리점찾기
		SQL = "SELECT aname FROM tb_adminstore where acode = '"& funacode &"' "
		Set Rsadmin = Db.Execute(SQL)
		Funadminadodename = Rsadmin(0)
		Rsadmin.close
		set Rsadmin=nothing
	End Function

	Function Fungdodename(fungcode)		'가맹점찾기
		SQL = "SELECT gname FROM tb_store where gcode = '"& fungcode &"' "
		Set Rsadmin = Db.Execute(SQL)
		Fungdodename = Rsadmin(0)
		Rsadmin.close
		set Rsadmin=nothing
	End Function

	Function FunHpcompany(funHpcompanyval)		'핸드폰통신사 1:SKT 2:KTF 3:LGT
		select case funHpcompanyval
			case "1"
				FunHpcompany = "SKT"
			case "2"
				FunHpcompany = "KTF"
			case "3"
				FunHpcompany = "LGT"
		end select
	End Function

	Function FunSearchDate(funsdval)	'검색날자타입변경
		FunSearchDate = mid(funsdval,1,4)&"-"&mid(funsdval,5,2)&"-"&mid(funsdval,7,2)
	End Function

	Function FunFileDelete(defaultFilepath,deletefilename)	'파일삭제
		Set fc = server.createobject("scripting.filesystemobject")
		If fc.fileexists(defaultFilepath & deletefilename) Then
			DelFile = defaultFilepath & deletefilename
			fc.deletefile(DelFile)
		End if
		Set fc = Nothing
	End Function

	Function FunHPCut(Hvalnum)	'핸드폰번호0111111111->011-111-1111
		if Hvalnum<>"" and len(Hvalnum)>=10 then
			imsilenhp  = len(Hvalnum)	'전체길이
			imsilenhp1 = left(Hvalnum,3)	'통신사번호
			imsilenhp2 = mid(left(Hvalnum,(imsilenhp-4)),4)	'국번
			imsilenhp3 = right(Hvalnum,4)	'전화반호
			FunHPCut = imsilenhp1&"-"&imsilenhp2&"-"&imsilenhp3
		end if
	End Function

	sub SelectDateChoice(yearDa,monthDa,dayDa,yvalD,mvalD,dvalD)
		imsiymd = replace(left(now(),10),"-","")
		imsiye = left(imsiymd,4)
		imsimo = mid(imsiymd,5,2)
		imsida = right(imsiymd,2)
		response.write "<select name="&yearDa&">"
					response.write "<option value=>선택"
					for i=2005 to (imsiye+1)
						imsiselected = ""
						if yvalD<>"" then
							if cstr(yvalD)=cstr(i) then
								imsiselected = "selected"
							end if
						end if
						response.write "<option value="& i &" "& imsiselected &">"&i&"년"
					next
		response.write "</select>"
		response.write "<select name="&monthDa&">"
					response.write "<option value=>선택"
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
						response.write "<option value="& ii &" "& imsiselected &">"&ii&"월"
					next
		response.write "</select>"
		if dayDa<>"" then
		response.write "<select name="&dayDa&">"
					response.write "<option value=>선택"
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
						response.write "<option value="&ii&" "& imsiselected &">"&ii&"일"
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
