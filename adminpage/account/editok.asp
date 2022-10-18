<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/account/dataup/fun.asp"-->
<!--#include virtual="/db/db.asp" -->
<%
	stxt1 = request("stxt1")
	stxt2 = request("stxt2")
	seq   = request("seq")

	textName   = request("textName")
	Aymd       = request("Aymd")
	textPname  = request("textPname")

	companynum    = request("companynum")
	companyAddr   = request("companyAddr")
	companyName   = request("companyName")
	companyUptae  = request("companyUptae")
	companyUpjong = request("companyUpjong")

	textPname2 = request("textPname2")
	Anum       = request("Anum")
	umoney     = request("umoney")

	seqA        = request("seqA")
	textPname2A = request("textPname2A")
	AnumA       = request("AnumA")
	umoneyA     = request("umoneyA")
	textBigo    = request("textBigo")
	hname	    = request("hname")

	if seqA<>"" then
		seqArry        = split(seqA,",")
		textPname2Arry = split(textPname2A,",")
		AnumArry       = split(AnumA,",")
		umoneyArry     = split(umoneyA,",")

		imsiAcnt       = ubound(seqArry)

		if imsiAcnt=ubound(textPname2Arry) and imsiAcnt=ubound(AnumArry) and imsiAcnt=ubound(umoneyArry) then
			
		else
			call FunErrorMsg("품목명에 콤마(,)는 사용 하시면 안됩니다.")
		end if
	end if

	Sql = " update tAccountM set  "
	Sql = Sql & " textName = '"& textName &"'  "
	Sql = Sql & " ,Aymd = '"& Aymd &"'  "

	Sql = Sql & " ,companynum    = '"& companynum &"' "
	Sql = Sql & " ,companyAddr   = '"& companyAddr &"' "
	Sql = Sql & " ,companyName   = '"& companyName &"' "
	Sql = Sql & " ,companyUptae  = '"& companyUptae &"' "
	Sql = Sql & " ,companyUpjong = '"& companyUpjong &"' "

	Sql = Sql & " ,textBigo = '"& textBigo &"'  "
	Sql = Sql & " ,hname = '"& hname &"'  "
	Sql = Sql & " ,textPname = '"& textPname &"'  "
	Sql = Sql & " ,textPname2 = '"& textPname2 &"'  "
	Sql = Sql & " ,Anum   = "& Anum   &"  "
	Sql = Sql & " ,umoney = "& umoney &"  "
	Sql = Sql & " ,kmoney = "& Anum*umoney &"  "
	Sql = Sql & " ,smoney = "& int((Anum*umoney)*0.1) &"  "
	Sql = Sql & " ,hmoney = "& int((Anum*umoney)*0.1)+Anum*umoney &"  "
	Sql = Sql & " where seq = "& seq
	db.Execute(Sql)

	if seqA<>"" then
		for i=o to imsiAcnt
			a_seq		= trim(seqArry(i))
			a_textPname2	= trim(textPname2Arry(i))
			a_Anum		= trim(AnumArry(i))
			a_umoney	= trim(umoneyArry(i))

			Sql = " update tAccountM set  "
			Sql = Sql & " textPname2 	= '"& a_textPname2 &"'  "
			Sql = Sql & " ,Anum   		=  "& a_Anum   &"  "
			Sql = Sql & " ,umoney 		=  "& a_umoney &"  "
			Sql = Sql & " ,kmoney 		=  "& a_Anum*a_umoney &"  "
			Sql = Sql & " ,smoney 		=  "& int((a_Anum*a_umoney)*0.1) &"  "
			Sql = Sql & " ,hmoney 		=  "& int((a_Anum*a_umoney)*0.1)+a_Anum*a_umoney &"  "
			Sql = Sql & " where seq = "& a_seq
			db.Execute(Sql)
		next
	end if
	db.close

	url = "content.asp?seq="&seq&"&stxt1="&stxt1&"&stxt2="&stxt2
	call FunSucMsg("수정 되었습니다.",url)
	'response.redirect "content.asp?seq="&seq&"&stxt1="&stxt1&"&stxt2="&stxt2
%>
