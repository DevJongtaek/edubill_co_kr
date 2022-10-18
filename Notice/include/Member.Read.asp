<%
	DIM AdRs_intSeq, AdRs_strMemberType, AdRs_strGroupCode, AdRs_strGroupName, AdRs_intLevel, AdRs_strLevelName
	DIM AdRs_strLoginID, AdRs_strPassword, AdRs_strEmail, AdRs_strUserName, AdRs_strNickName, AdRs_strSex, AdRs_strSSN
	DIM AdRs_strBirthday, AdRs_strHomePage, AdRs_strHomeTel, AdRs_strMobile, AdRs_strHomeAddr, AdRs_strJob, AdRs_strMarry
	DIM AdRs_strMyMemo, AdRs_strUserSign, AdRs_bitMailing, AdRs_bitMemo, AdRs_bitAuth, AdRs_bitOpenInfo, AdRs_strAdmin
	DIM AdRs_strSido, AdRs_intArticle, AdRs_intComment, AdRs_intPoint, AdRs_intVisit, AdRs_strVisitIp, AdRs_strVisitDate
	DIM AdRs_bitStop, AdRs_strLoginNoDate, AdRs_bitLeave, AdRs_strLeaveMemo, AdRs_strLeaveDate, AdRs_strRegDate
	DIM AdRs_strCorpNum, AdRs_strCorpName, AdRs_strCorpJob1, AdRs_strCorpJob2, AdRs_strCorpAddr
	DIM AdRs_strAddData1, AdRs_strAddData2, AdRs_strAddData3, AdRs_strAddData4, AdRs_strAddData5, AdRs_strAddData6
	DIM AdRs_strAddData7, AdRs_strAddData8, AdRs_strAddData9, AdRs_strAddData10, AdRs_strAdminMemo, AdRs_strProfile
	DIM AdRs_strNameFile, AdRs_strMarkFile

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & memberSeq & "' ")

	AdRs_intSeq         = RS("intSeq")
	AdRs_strMemberType  = RS("strMemberType")
	AdRs_strGroupCode   = RS("strGroupCode")
	AdRs_strGroupName   = RS("strGroupName")
	AdRs_intLevel       = RS("intLevel")
	AdRs_strLevelName   = RS("strLevelName")
	AdRs_strLoginID     = RS("strLoginID")
	AdRs_strPassword    = RS("strPassword")
	AdRs_strEmail       = SPLIT(RS("strEmail"), "@")
	AdRs_strUserName    = RS("strUserName")
	AdRs_strNickName    = RS("strNickName")
	AdRs_strSex         = RS("strSex")
	AdRs_strSSN         = RS("strSSN")
	AdRs_strBirthday    = RS("strBirthday")
	AdRs_strHomePage    = RS("strHomePage")
	AdRs_strHomeTel     = RS("strHomeTel")
	AdRs_strMobile      = RS("strMobile")
	AdRs_strHomeAddr    = RS("strHomeAddr")
	AdRs_strJob         = RS("strJob")
	AdRs_strMarry       = RS("strMarry")
	AdRs_strMyMemo      = RS("strMyMemo")
	AdRs_strUserSign    = RS("strUserSign")
	AdRs_bitMailing     = RS("bitMailing")
	AdRs_bitMemo        = RS("bitMemo")
	AdRs_bitAuth        = RS("bitAuth")
	AdRs_bitOpenInfo    = RS("bitOpenInfo")
	AdRs_strAdmin       = RS("strAdmin")
	AdRs_strSido        = RS("strSido")
	AdRs_intArticle     = RS("intArticle")
	AdRs_intComment     = RS("intComment")
	AdRs_intPoint       = RS("intPoint")
	AdRs_intVisit       = RS("intVisit")
	AdRs_strVisitIp     = RS("strVisitIp")
	AdRs_strVisitDate   = RS("strVisitDate")
	AdRs_bitStop        = RS("bitStop")
	AdRs_strLoginNoDate = RS("strLoginNoDate")
	AdRs_bitLeave       = RS("bitLeave")
	AdRs_strLeaveMemo   = RS("strLeaveMemo")
	AdRs_strLeaveDate   = RS("strLeaveDate")
	AdRs_strRegDate     = RS("strRegDate")
	AdRs_strCorpNum     = RS("strCorpNum")
	AdRs_strCorpName    = RS("strCorpName")
	AdRs_strCorpJob1    = RS("strCorpJob1")
	AdRs_strCorpJob2    = RS("strCorpJob2")
	AdRs_strCorpAddr    = RS("strCorpAddr")
	AdRs_strAddData1    = RS("strAddData1")
	AdRs_strAddData2    = RS("strAddData2")
	AdRs_strAddData3    = RS("strAddData3")
	AdRs_strAddData4    = RS("strAddData4")
	AdRs_strAddData5    = RS("strAddData5")
	AdRs_strAddData6    = RS("strAddData6")
	AdRs_strAddData7    = RS("strAddData7")
	AdRs_strAddData8    = RS("strAddData8")
	AdRs_strAddData9    = RS("strAddData9")
	AdRs_strAddData10   = RS("strAddData10")
	AdRs_strAdminMemo   = RS("strAdminMemo")

	IF AdRs_strSex = "2" THEN AdRs_strSex = "0"

	CALL ActFolderMake(memberFilePath & "profile\" & AdRs_intSeq)
	CALL ActFolderMake(memberFilePath & "name\" & AdRs_intSeq)
	CALL ActFolderMake(memberFilePath & "mark\" & AdRs_intSeq)

	AdRs_strProfile  = GetFolderFileList(memberFilePath & "profile\" & AdRs_intSeq  & "\")
	AdRs_strNameFile = GetFolderFileList(memberFilePath & "name\" & AdRs_intSeq  & "\")
	AdRs_strMarkFile = GetFolderFileList(memberFilePath & "mark\" & AdRs_intSeq  & "\")

	DIM objMemberInfo
	SET objMemberInfo = Server.CreateObject("Scripting.Dictionary")

	WITH objMemberInfo

		.Add "intSeq",         AdRs_intSeq
		.Add "strMemberType",  AdRs_strMemberType
		.Add "strGroupCode",   AdRs_strGroupCode
		.Add "strGroupName",   AdRs_strGroupName
		.Add "intLevel",       AdRs_intLevel
		.Add "strLevelName",   AdRs_strLevelName
		.Add "strLoginID",     AdRs_strLoginID
		.Add "strPassword",    AdRs_strPassword
		.Add "strEmail1",      AdRs_strEmail(0)
		.Add "strEmail2",      AdRs_strEmail(1)
		.Add "strUserName",    AdRs_strUserName
		.Add "strNickName",    AdRs_strNickName
		.Add "strSex",         AdRs_strSex
		.Add "strSSN",         AdRs_strSSN
		.Add "strBirthday",    AdRs_strBirthday
		.Add "strHomePage",    AdRs_strHomePage
		.Add "strHomeTel",     AdRs_strHomeTel
		.Add "strMobile",      AdRs_strMobile
		.Add "strHomeAddr",    AdRs_strHomeAddr
		.Add "strJob",         AdRs_strJob
		.Add "strMarry",       AdRs_strMarry
		.Add "strMyMemo",      AdRs_strMyMemo
		.Add "strUserSign",    AdRs_strUserSign
		.Add "bitMailing",     GetBitTypeNumberChg(AdRs_bitMailing)
		.Add "bitMemo",        GetBitTypeNumberChg(AdRs_bitMemo)
		.Add "bitAuth",        AdRs_bitAuth
		.Add "bitOpenInfo",    GetBitTypeNumberChg(AdRs_bitOpenInfo)
		.Add "strAdmin",       AdRs_strAdmin
		.Add "strSido",        AdRs_strSido
		.Add "intArticle",     AdRs_intArticle
		.Add "intComment",     AdRs_intComment
		.Add "intPoint",       AdRs_intPoint
		.Add "intVisit",       AdRs_intVisit
		.Add "strVisitIp",     AdRs_strVisitIp
		.Add "strVisitDate",   AdRs_strVisitDate
		.Add "bitStop",        AdRs_bitStop
		.Add "strLoginNoDate", AdRsstrLoginNoDate
		.Add "bitLeave",       AdRs_bitLeave
		.Add "strLeaveMemo",   AdRs_strLeaveMemo
		.Add "strLeaveDate",   AdRs_strLeaveDate
		.Add "strRegDate",     AdRs_strRegDate
		.Add "strCorpNum",     AdRs_strCorpNum
		.Add "strCorpName",    AdRs_strCorpName
		.Add "strCorpJob1",    AdRs_strCorpJob1
		.Add "strCorpJob2",    AdRs_strCorpJob2
		.Add "strCorpAddr",    AdRs_strCorpAddr
		.Add "strAddData1",    AdRs_strAddData1
		.Add "strAddData2",    AdRs_strAddData2
		.Add "strAddData3",    AdRs_strAddData3
		.Add "strAddData4",    AdRs_strAddData4
		.Add "strAddData5",    AdRs_strAddData5
		.Add "strAddData6",    AdRs_strAddData6
		.Add "strAddData7",    AdRs_strAddData7
		.Add "strAddData8",    AdRs_strAddData8
		.Add "strAddData9",    AdRs_strAddData9
		.Add "strAddData10",   AdRs_strAddData10
		.Add "strAdminMemo",   AdRs_strAdminMemo
		.Add "strProfile",     AdRs_strProfile
		.Add "strNameFile",    AdRs_strNameFile
		.Add "strMarkFile",    AdRs_strMarkFile

	END WITH
%>