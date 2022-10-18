<%
	' ***************************************************************************************
	' * 함수설명 : 자바스크립트 ALERT MSG                                                   *
	' * 변수설명 : strMsg = 출력 메시지                                                     *
	' *            act = 메시지 출력 후 액션 : clase : 창닫기, etc : 뒤로                   *
	' ***************************************************************************************
	FUNCTION ActJsAlertMsg(strMsg, act, url)

		DIM str
		str = "<script type=""text/javascript"">" & CHR(10)
		str = str & "alert('" & strMsg & "');" & CHR(10)

		SELECT CASE act
		CASE "close" : str = str & "self.close();" & CHR(10)
		CASE "url"   : str = str & "document.location.href='" & url & "';" & CHR(10)
		CASE ELSE   : str = str & "history.go(-1);" & CHR(10)
		END SELECT

		ActJsAlertMsg = str & "</script>" & CHR(10)

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 자바스크립트 FORM값 넘기기                                               *
	' * 변수설명 : strMsg = 출력 메시지                                                     *
	' *            url = 이동할 URL                                                         *
	' *            FormType = GET OR POST (폼 전송방식)                                     *
	' *            FormsName = FORM ID 및 이름 (배열은 $$$로 구분)                          *
	' *            FormsValue = FORM 값 (배열은 $$$로 구분)                                 *
	' ***************************************************************************************
	FUNCTION ActFormSubmit(strMsg, url, FormType, FormsName, FormsValue)

		DIM str, tmpFor
		str = "<form id=""urlForm"" name=""urlForm"" method=""" & FormType & """ action=""" & url & """>" & CHR(10)
		
		FormsName  = SPLIT(FormsName, "$$$")
		FormsValue = SPLIT(FormsValue, "$$$")

		FOR tmpFor = 0 TO UBOUND(FormsName)
			str = str & "<input type=""hidden"" id=""" & FormsName(tmpFor) & """ name=""" & FormsName(tmpFor) & """ value=""" & FormsValue(tmpFor) & """>" & CHR(10)
		NEXT

		str = str & "</form>" & CHR(10)
		str = str & "<script type=""text/javascript"">" & CHR(10)
		IF strMsg <> "" THEN str = str & "alert('" & strMsg & "');" & CHR(10)
		str = str & "		document.getElementById(""urlForm"").submit();" & CHR(10)
		str = str & "</script>" & CHR(10)
		
		ActFormSubmit = str

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 공백제거 및 작은 쉼표 SQL 저장값으로 변경                                *
	' * 변수설명 : strValue = 입력값                                                        *
	' *            tagCheck = 태그체크 : False = 체크안함                                   *
	' ***************************************************************************************
	FUNCTION GetInputReplce(strValue, tagCheck)

		DIM str
		IF strValue <> "" AND ISNULL(strValue) = False THEN
			str = GetReplaceInjection(LTRIM(RTRIM(strValue)), tagCheck)
		ELSE
			str = strValue
		END IF

		GetInputReplce = str

	END FUNCTION

	Public Function eregi_replace(ByVal pattern, ByVal replacestr, ByVal text)
	
		Dim eregObj
		Set eregObj = New RegExp
		eregObj.Pattern = pattern
		eregObj.IgnoreCase = True
		eregObj.Global = True
		eregi_replace = eregObj.Replace(text, replacestr)
		Set eregObj = NOTHING
	
	End Function

	Function GetReplaceInjection(str, tagCheck)

		str = REPLACE( str, "\", "")
		str = REPLACE( str, "|", "l")
'		str = REPLACE( str, ";", ";;")
		str = REPLACE( str, "'", "''")
		str = REPLACE( str, "--", "" )

		IF tagCheck = False THEN
		ELSE
			str = eregi_replace("<html(.*|)<body([^>]*)>","",str)
			str = eregi_replace("</body(.*)</html>(.*)","",str)
			str = eregi_replace("<[/]*(body|html|head|meta|form|input|select|textarea|base)[^>]*>","",str)
			str = eregi_replace("<(|iframe|script|title|link)(.*)</(iframe|script|title)>","",str)
			str = eregi_replace("<[/]*(script|style|title|xmp|iframe)>","",str)
			str = eregi_replace("([a-z0-9]*script:)","",str)
			str = eregi_replace("(\n*[\n])",vblf,str)
		END IF

		GetReplaceInjection = str
	
	End Function

	' ***************************************************************************************
	' * 함수설명 : SELECT BOX 생성                                                          *
	' * 변수설명 : optName   : SELECT 텍스트 (,로 분류)                                     *
	' *            optVal    : SELECT 값 (,로 분류)                                         *
	' *            arrType   : 0 = ,로 구분된 타입, 1 = 엔터로 구분된 타입                  *
	' *            selectVal : 선택 값 (selected)                                           *
	' ***************************************************************************************
	FUNCTION GetMakeSelectForm(optItem, arrType, selectVal, selectValType)

		DIM str, tmpArrName, tmpArrVal, tmpFor

		optItem = SPLIT(optItem, "$$$")

		tmpArrName = SPLIT(optItem(1), arrType)
		tmpArrVal  = SPLIT(optItem(0), arrType)

		FOR tmpFor = 0 TO UBOUND(tmpArrName)
			IF UBOUND(tmpArrVal) < 0 THEN
				str = str & "<option value=''"
			ELSE
				str = str & "<option value='" & tmpArrVal(tmpFor) & "'"
					IF selectValType = "int" THEN
						IF INT(tmpArrVal(tmpFor)) = INT(selectVal) THEN str = str & " selected"
					ELSE
						IF TRIM(tmpArrVal(tmpFor)) = selectVal THEN str = str & " selected"
					END IF
			END IF
			str = str & ">" & tmpArrName(tmpFor) & "</option>" & CHR(13)
		NEXT

		GetMakeSelectForm = str

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : RADIO BUTTON 생성                                                        *
	' * 변수설명 : optName   : SELECT 텍스트 (,로 분류)                                     *
	' *            optVal    : SELECT 값 (,로 분류)                                         *
	' *            arrType   : 0 = ,로 구분된 타입, 1 = 엔터로 구분된 타입                  *
	' *            selectVal : 선택 값 (checked)                                            *
	' *            formName  : 폼 이름                                                      *
	' *            firstTag  : 추가 태그 (앞)                                               *
	' *            endTag    : 폼 이름 (뒤)                                                 *
	' ***************************************************************************************
	FUNCTION GetMakeRadioForm(optItem, arrType, selectVal, formName, firstTag, endTag)

		DIM str, tmpArrName, tmpArrVal, tmpFor

		optItem    = SPLIT(optItem, "$$$")
		tmpArrName = SPLIT(optItem(1), arrType)
		tmpArrVal  = SPLIT(optItem(0), arrType)

		FOR tmpFor = 0 TO UBOUND(tmpArrName)

			IF firstTag <> "" THEN str = str & firstTag
			str = str & "<input name=""" & formName & """ type=""radio"" id=""" & formName & tmpFor + 1 & """ value=""" & tmpArrVal(tmpFor) & """"
			IF TRIM(tmpArrVal(tmpFor)) = TRIM(selectVal) THEN str = str & " checked"
				
			str = str & "><LABEL FOR=""" & formName & tmpFor + 1 & """>" & tmpArrName(tmpFor) & "</LABEL>"
			IF endTag <> "" THEN str = str & endTag
			str = str & CHR(13)

		NEXT

		GetMakeRadioForm = str

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : CHECKBOX 생성                                                            *
	' * 변수설명 : optName   : SELECT 텍스트 (,로 분류)                                     *
	' *            optVal    : SELECT 값 (,로 분류)                                         *
	' *            arrType   : 0 = ,로 구분된 타입, 1 = 엔터로 구분된 타입                  *
	' *            selectVal : 선택 값 (checked)                                            *
	' *            formName  : 폼 이름                                                      *
	' *            firstTag  : 추가 태그 (앞)                                               *
	' *            endTag    : 폼 이름 (뒤)                                                 *
	' ***************************************************************************************
	FUNCTION GetMakeCheckForm(optItem, arrType, selectVal, formName, firstTag, endTag)

		DIM str, tmpArrName, tmpArrVal, tmpFor

		optItem    = SPLIT(optItem, "$$$")
		tmpArrName = SPLIT(optItem(1), arrType)
		tmpArrVal  = SPLIT(optItem(0), arrType)

		FOR tmpFor = 0 TO UBOUND(tmpArrName)

			IF firstTag <> "" THEN str = str & firstTag
			str = str & "<input name=""" & formName & """ type=""checkbox"" id=""" & formName & tmpFor + 1 & """ value=""" & tmpArrVal(tmpFor) & """"

			IF (INSTR(selectVal, tmpArrVal(tmpFor)) > 0) THEN str = str & " checked"
					
			str = str & "><LABEL FOR=""" & formName & tmpFor + 1 & """>" & tmpArrName(tmpFor) & "</LABEL>"
			IF endTag <> "" THEN str = str & endTag
			str = str & CHR(13)

		NEXT

		GetMakeCheckForm = str

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 옵션 선택값 반환                                                         *
	' * 변수설명 : optName   : 배열 텍스트 (,로 분류)                                       *
	' *            optVal    : 배열 값 (,로 분류)                                           *
	' *            selectVal : 선택값 (저장값)                                              *
	' ***************************************************************************************
	FUNCTION GetOptionArrText(optItem, selectVal)

		DIM tmpArrName, tmpArrVal, tmpFor, str

		optItem = SPLIT(optItem, "$$$")

		tmpArrName = SPLIT(optItem(1), ",")
		tmpArrVal  = SPLIT(optItem(0), ",")

		FOR tmpFor = 0 TO UBOUND(tmpArrName)
			IF tmpArrVal(tmpFor) = selectVal THEN
				str = tmpArrName(tmpFor)
				EXIT FOR
			END IF
		NEXT

		GetOptionArrText = str

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : True, False 숫자로 변환하는 함수                                         *
	' * 변수설명 : text   : True, False 값                                                  *
	' ***************************************************************************************
	FUNCTION GetBitTypeNumberChg(text)

		IF text = True THEN GetBitTypeNumberChg = "1" ELSE GetBitTypeNumberChg = "0"

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 숫자 타입을 BIT 타입으로 함수                                            *
	' * 변수설명 : num   : 0, 1 값                                                          *
	' ***************************************************************************************
	FUNCTION GetNumberTypeBitChg(num)

		IF num = 1 THEN GetNumberTypeBitChg = True ELSE GetNumberTypeBitChg = False

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 페이징 HTML 생성함수                                                     *
	' * 변수설명 : intPage     : 현재 페이지 값                                             *
	' *            intPageSize : 페이지 크기                                                *
	' *            prevText    : 이전 TEXT (언어별)                                         *
	' *            prevText    : 다음 TEXT (언어별)                                         *
	' *            scriptName  : 실행될 자바스크립트 함수명 (함수명만 기재)                 *
	' ***************************************************************************************
	FUNCTION GetPageHTML(intPage, intPageCount, prevText, nextText, scriptName)

		DIM intBlockPage, I, rtnHtml
		intBlockPage = INT((intPage - 1) / 10) * 10 + 1

		IF intBlockPage = 1 THEN rtnHtml = "<a class=""btn_prev_disabled"">" & prevText & "</a>" ELSE rtnHtml = "<a href=""javascript:;"" OnClick=""" & scriptName & "('" & intBlockPage - 10 & "');return false;"" class=""btn_prev_page"">" & prevText & "</a>"

		rtnHtml = rtnHtml & "<span>"

		i = 1
		
		DO UNTIL i > 10 OR intBlockPage > intPageCount

			IF INT(intBlockPage) = INT(intPage) THEN rtnHtml = rtnHtml & "<a class=""current_page"">" & intBlockPage & "</a>" ELSE rtnHtml = rtnHtml & "<a href=""javascript:;"" onClick=""" & scriptName & "('" & intBlockPage & "');return false;"">" & intBlockPage & "</a>"

			intBlockPage = intBlockPage + 1
			I = I + 1
		
		LOOP

		rtnHtml = rtnHtml & "</span>"

    IF intBlockPage > intPageCount THEN rtnHtml = rtnHtml & "<a class=""btn_next_disabled"">" & nextText & "</a>" ELSE rtnHtml = rtnHtml & "<a href=""javascript:;"" OnClick=""" & scriptName & "('" & intBlockPage & "');return false;"" class=""btn_next_page"">" & nextText & "</a>"

		GetPageHTML = rtnHtml

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 현재 경로 반환                                                           *
	' * 변수설명 : sPath : 경로                                                             *
	' ***************************************************************************************
	FUNCTION GetNowFolderPath(sPath)

		IF sPath = "" THEN sPath = "."
		GetNowFolderPath = SERVER.MAPPATH(sPath)

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 폴더 생성                                                                *
	' * 변수설명 : strPath = 생성할 폴더 경로 및 폴더명                                     *
	' ***************************************************************************************
	FUNCTION ActFolderMake(strPath)
		DIM FSO, fldr
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF NOT(fso.FolderExists(strPath)) THEN
			SET fldr = fso.CreateFolder(strPath)
		END IF
		SET FSO = NOTHING
	End Function

	' ***************************************************************************************
	' * 함수설명 : 폴더 리스트 가져오기                                                     *
	' * 변수설명 : strPath = 경로                                                           *
	' ***************************************************************************************
	FUNCTION GetFolderList(strPath)

		DIM FSO, F, F1, rtnList

		SET FSO = CreateObject("Scripting.FileSystemObject")
		SET F   = FSO.GetFolder(strPath)
		SET SF  = F.SubFolders

		FOR EACH F1 IN SF
			IF rtnList <> "" THEN rtnList = rtnList & ","
			rtnList = rtnList & F1.NAME
		NEXT

		GetFolderList = rtnList

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 폴더 삭제 함수                                                           *
	' * 변수설명 : path : 경로                                                              *
	' ***************************************************************************************
	FUNCTION ActFolderDelete(path)
		DIM FSO
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF (FSO.FolderExists(path)) THEN FSO.DeleteFolder(path)
		SET FSO = NOTHING
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일 리스트 출력 함수                                                    *
	' * 변수설명 : strPath : 경로                                                           *
	' ***************************************************************************************
	FUNCTION GetFolderFileList(path)
		DIM FSO, F, F1, S, SF
		SET FSO = CreateObject("Scripting.FileSystemObject")
		IF NOT(FSO.FolderExists(path)) THEN SET fldr = fso.CreateFolder(path)
		SET F = FSO.GetFolder(path)
		SET SF = F.Files

		FOR EACH F1 IN SF
			IF S <> "" THEN S = S & "|"
			S = S & F1.NAME
		NEXT
		GetFolderFileList = S
		SET FSO = NOTHING : SET F = NOTHING : SET SF = NOTHING
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일존재 유무 체크                                                       *
	' * 변수설명 : filename : 전체경로 + 파일명                                             *
	' ***************************************************************************************
	FUNCTION GetFileExists(filename)
		DIM FSO
		SET FSO = Server.CreateObject("scripting.FileSystemObject")
		IF FSO.FileExists(filename) THEN GetFileExists = True ELSE GetFileExists = False
		SET FSO = NOTHING
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일삭제 함수                                                            *
	' * 변수설명 : strFileName : 삭제할 파일의 경로 및 이름                                 *
	' ***************************************************************************************
	FUNCTION ActFileDelete(filename)
		Dim FSO
		SET FSO = Server.CreateObject("scripting.FileSystemObject")
		response.write filename
		IF FSO.FileExists(filename) THEN FSO.DeleteFile(filename)
		SET FSO = NOTHING
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 중복파일명 변환                                                          *
	' * 변수설명 : strPath     = 파일을 저장할 경로                                         *
	' *            strFileName = 저장할 파일명                                              *
	' ***************************************************************************************
	FUNCTION GetChgSameFile(strPath, strFileName)

		strFileName = REPLACE(strFileName, " ", "_")
		strFileName = REPLACE(strFileName, "%", "")

		DIM FSO, strFileNameOnly, strFileExt
		SET FSO = Server.CreateObject("scripting.FileSystemObject")

		IF FSO.fileExists(strPath & strFileName) THEN
			IF InStrRev(strFileName, ".") <> 0 THEN
				strFileNameOnly = LEFT(strFileName,InstrRev(strFileName, ".")-1)
				strFileExt = MID(strFileName, InStrRev(strFileName, "."))
			ELSE
				strFileNameOnly = strFileName
				strFileExt = ""
			END IF

			DIM i
			i = 0
			DO WHILE (1)
				strFileName = strFileNameOnly & "[" & i & "]" & strFileExt
				IF NOT FSO.fileExists(strPath & strFileName) THEN EXIT DO
				i = i + 1
			LOOP
		END IF

		SET FSO = NOTHING
		GetChgSameFile = strFileName

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일 확장자 반환                                                         *
	' * 변수설명 : strFileName = 파일명                                                     *
	' ***************************************************************************************
	FUNCTION GetFileExt(strFileName)

		strFileName = MID(strFileName, InStrRev(strFileName, "."))
		GetFileExt = REPLACE(strFileName, ".", "")

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 업로드 파일명 및 파일크기 반환 함수                                      *
	' * 변수설명 : uploadComponet = 업로드 컴포넌트 (ABC, DEXT, TABS)                       *
	' *            strFileField   = 업로드 폼 SET                                           *
	' *            rtnType        = (name : 파일명, size : 크기)                            *
	' ***************************************************************************************
	FUNCTION GetUploadFileInfo(uploadComponet, strFileField, rtnType)

		SELECT CASE LCASE(uploadComponet)
		CASE "abc"
			IF LCASE(rtnType) = "name" THEN GetUploadFileInfo = strFileField.SafeFileName ELSE GetUploadFileInfo = strFileField.Length
		CASE "dext"
			IF LCASE(rtnType) = "name" THEN GetUploadFileInfo = strFileField.FileName ELSE GetUploadFileInfo = strFileField.FIleLen
		CASE "tabs"
			IF LCASE(rtnType) = "name" THEN GetUploadFileInfo = strFileField.FileName ELSE GetUploadFileInfo = strFileField.FileSize
		END SELECT		

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일 저장 함수                                                           *
	' * 변수설명 : uploadComponet = 업로드 컴포넌트 (ABC, DEXT, TABS)                       *
	' *            strFileField   = 파일폼                                                  *
	'	*            intUploadSize  = 업로드 제한 사이즈                                      *
	'	*            strPath        = 저장경로                                                *
	' ***************************************************************************************
	FUNCTION ActFileUpload(uploadComponet, strFileField, intUploadSize, strPath, bitThrum, strThrumOption, bitUseWaterMark, strWaterMarkOption)

		DIM nowFileSize, nowFileName, FileExe, strSaveFIleName, strFileNameOnly, I, strUploadNotFileTmp

		nowFileSize = GetUploadFileInfo(uploadComponet, strFileField, "size")
		nowFileName = GetUploadFileInfo(uploadComponet, strFileField, "name")

		IF nowFileName = "" OR ISNULL(nowFileName) = True THEN
			ActFileUpload = False
			EXIT FUNCTION
		END IF

		IF INT(nowFileSize) > INT(intUploadSize) THEN
			ActFileUpload = False
			EXIT FUNCTION
		END IF

		strSaveFileName = GetChgSameFile(strPath, nowFileName)
		FileExe         = REPLACE(MID(strSaveFileName, INSTRREV(strSaveFileName, ".") + 1), ".", "")
		strFileNameOnly = REPLACE(LEFT(strSaveFileName, INSTRREV(strSaveFileName, ".") - 1), "'", "")

		IF LEN(strFileNameOnly) > 60 THEN strFileNameOnly = LEFT(strFileNameOnly, 60)

		DIM strUploadNotFile
		strUploadNotFile = SPLIT("php,php3,php4,ph,phtml,asp,js,css,jsp,pl,c,cpp,stb,shtml,shtm,vbs,htm,html", ",")

		FOR I = 0 TO UBOUND(strUploadNotFile)
			IF TRIM(strUploadNotFile(I)) <> "" THEN
				IF UCASE(FileExe) = UCASE(strUploadNotFile(I)) THEN
					IF UCASE(strUploadNotFile(I)) = UCASE(FileExe) THEN
						strSaveFIleName = strFileNameOnly & ".txt"
						EXIT FOR
					END IF
				END IF 
			END IF
		NEXT
	
		CALL ActFolderMake(strPath)

		strSaveFIleName = REPLACE(strSaveFIleName, "'", "_")

		SELECT CASE LCASE(uploadComponet)
		CASE "abc" : strFileField.SAVE strPath & REPLACE(strSaveFIleName, ";", "")
		CASE "dext" : strFileField.saveAS strPath & REPLACE(strSaveFIleName, ";", "")
		CASE "tabs" : strFileField.SAVEAS strPath & REPLACE(strSaveFIleName, ";", "")
		END SELECT
	
		SELECT CASE UCASE(FileExe)
		CASE "JPG", "GIF", "BMP", "PNG", "TIF"

			IF bitThrum = True THEN CALL ActThrumImage(strSaveFIleName, strPath, strThrumOption)
			IF bitUseWaterMark = True AND uploadComponet = "dext" THEN CALL ActDextWaterMark(strSaveFIleName, strPath, strWaterMarkOption)

		END SELECT
	
		ActFileUpload = strSaveFIleName
	
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일 저장 함수 (MD5 암호화)                                              *
	' * 변수설명 : uploadComponet = 업로드 컴포넌트 (ABC, DEXT, TABS)                       *
	' *            strFileField   = 파일폼                                                  *
	'	*            intUploadSize  = 업로드 제한 사이즈                                      *
	'	*            strPath        = 저장경로                                                *
	' ***************************************************************************************
	FUNCTION ActFileUploadMD5(uploadComponet, strFileField, intUploadSize, strPath)

		DIM nowFileSize, nowFileName, FileExe, strSaveFIleName, strFileNameOnly, I, strUploadNotFileTmp

		nowFileSize = GetUploadFileInfo(uploadComponet, strFileField, "size")
		nowFileName = GetUploadFileInfo(uploadComponet, strFileField, "name")

		IF nowFileName = "" OR ISNULL(nowFileName) = True THEN
			ActFileUploadMD5 = False
			EXIT FUNCTION
		END IF

		IF INT(nowFileSize) > INT(intUploadSize) THEN
			ActFileUploadMD5 = False
			EXIT FUNCTION
		END IF

		FileExe         = REPLACE(MID(nowFileName, INSTRREV(nowFileName, ".") + 1), ".", "")
		strFileNameOnly = REPLACE(LEFT(nowFileName, INSTRREV(nowFileName, ".") - 1), "'", "")
		strSaveFileName = MD5(strFileNameOnly & YEAR(NOW) & MONTH(NOW) & DAY(NOW) & HOUR(NOW) & MINUTE(NOW) & SECOND(NOW))

		DIM strUploadNotFile
		strUploadNotFile = SPLIT("php,php3,php4,ph,phtml,asp,js,css,jsp,pl,c,cpp,stb,shtml,shtm,vbs,htm,html", ",")

		FOR I = 0 TO UBOUND(strUploadNotFile)
			IF TRIM(strUploadNotFile(I)) <> "" THEN
				IF UCASE(FileExe) = UCASE(strUploadNotFile(I)) THEN
					IF UCASE(strUploadNotFile(I)) = UCASE(FileExe) THEN
						strSaveFIleName = strFileNameOnly & ".txt"
						EXIT FOR
					END IF
				END IF 
			END IF
		NEXT
	
		CALL ActFolderMake(strPath)

		SELECT CASE LCASE(uploadComponet)
		CASE "abc" : strFileField.SAVE strPath & strSaveFIleName
		CASE "dext" : strFileField.saveAS strPath & strSaveFIleName
		CASE "tabs" : strFileField.SAVEAS strPath & strSaveFIleName
		END SELECT
	
		ActFileUploadMD5 = strSaveFIleName
	
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 워터마크 저장함수 (DEXT UPLOAD PRO)                                      *
	' * 변수설명 : strFileName         = 저장된 파일명                                      *
	'	*            strPath             = 저장경로                                           *
	'	*            strWaterMarkOption  = 워터마크옵션                                       *
	' ***************************************************************************************
	FUNCTION ActDextWaterMark(strFIleName, strPath, strWaterMarkOption)

		strWaterMarkOption = SPLIT(strWaterMarkOption, "$^^$")

		SET objImage = SERVER.CreateObject("DEXT.ImageProc")

		IF True = objImage.SetSourceFile(strPath & strFileName) THEN
			SELECT CASE strWaterMarkOption(0)
			CASE "1"
				tmpFile = objImage.SaveAsWatermarkImage("/" & REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "") & CONF_strFilePath & "/Board/" & strWaterMarkOption(6) & "/config/" & strWaterMarkOption(1), strPath & "temp\" & strFileName, strWaterMarkOption(3), strWaterMarkOption(4), True) 
			CASE "2"
				tmpFile = objImage.SaveAsWatermarkText(strWaterMarkOption(2), strPath & "temp\" & strFileName, strWaterMarkOption(3),strWaterMarkOption(4),strWaterMarkOption(5), True)
			END SELECT

			CALL ActFileDelete(strPath & strFileName)
			CALL ActDefaultFileCopy(strPath & "temp\" & strFileName, strPath & strFileName)
			CALL ActFileDelete(strPath & "temp\" & strFileName)

		END IF

		SET objImage = NOTHING

	END FUNCTION
	
	' ***************************************************************************************
	' * 함수설명 : 썸네일 저장 함수                                                         *
	' * 변수설명 : strFileName    = 저장된 파일명                                           *
	'	*            strPath        = 저장경로                                                *
	'	*            strThrumOption = 썸네일 옵션 (배열)                                     *
	' ***************************************************************************************
	FUNCTION ActThrumImage(strFileName, strPath, strThrumOption)

		strThrumOption = SPLIT(strThrumOption, ",")

		DIM objImage

		SELECT CASE strThrumOption(0)
		CASE "dext"

			SET objImage = SERVER.CREATEOBJECT("DEXT.ImageProc")
	
			IF True = objImage.SetSourceFile(strPath & strFileName) THEN
				ActThrumImage = objImage.SaveasThumbnail(strPath & "thrum\" & strFileName, strThrumOption(1), strThrumOption(2),  GetNumberTypeBitChg(strThrumOption(3)))
			END IF
	
		CASE "nanumi"

			SET objImage = Server.CreateObject("Nanumi.ImagePlus")

			objImage.OpenImageFile strPath & strFileName
			objImage.KeepAspect = GetNumberTypeBitChg(strThrumOption(3))
			objImage.ChangeSize strThrumOption(1), strThrumOption(2)
			objImage.SaveFile strPath & "thrum\" & strFileName
			objImage.Dispose

		END SELECT

		SET objImage = NOTHING

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 파일복사 함수                                                            *
	' * 변수설명 : strFileName1 : 소스파일(경로포함)                                        *
	' *            strFileName2 : 대상파일(경로포함)                                        *
	' ***************************************************************************************
	FUNCTION ActDefaultFileCopy(strFileName1, strFileName2)

		SET FSO = SERVER.CREATEOBJECT("scripting.FileSystemObject")

		IF FSO.FileExists(strFileName1) THEN FSO.CopyFile strFileName1, strFileName2
		SET FSO = NOTHING

		ActDefaultFileCopy = True

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 이미지 파일 체크                                                         *
	' * 변수설명 : strFileName    = 저장된 파일명                                           *
	' ***************************************************************************************
	FUNCTION GetUploadFileImage(uploadComponet, strField)

		DIM strFileName

		SELECT CASE uploadComponet
		CASE "abc" : strFileName = strField.SafeFileName
		CASE "dext" : strFileName = strField.FileName
		CASE "tabs" : strFileName = strField.FileName
		END SELECT

		IF strFileName = "" OR ISNULL(strFileName) = True THEN
			GetUploadFileImage = False
		ELSE
			DIM FileExe
			FileExe = REPLACE(MID(strFileName, INSTRREV(strFileName, ".") + 1), ".", "")
			SELECT CASE UCASE(FileExe)
			CASE "JPG", "GIF", "BMP", "PNG", "TIF"
				GetUploadFileImage = True
			CASE ELSE
				GetUploadFileImage = False
			END SELECT
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 저장파일 사이즈 체크 함수                                                *
	' * 변수설명 : uploadComponet = 업로드 컴포넌트                                         *
	' *            strField       = 파일폼                                                  *
	' ***************************************************************************************
	FUNCTION GetFIleUploadSize(uploadComponet, strField)

		SELECT CASE uploadComponet
		CASE "abc"  : GetFIleUploadSize = strFileField.Length
		CASE "dext" : GetFIleUploadSize = strFileField.FIleLen
		CASE "tabs" : GetFIleUploadSize = strFileField.FileSize
		END SELECT

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : DB 저장 입력값 자르기                                                    *
	' * 변수설명 : str = 입력값                                                             *
	' *            cutLen = 입력길이                                                        *
	' ***************************************************************************************
	FUNCTION GetCutInputData(str, cutLen)

		IF LEN(str) > cutLen THEN GetCutInputData = LEFT(str, cutLen) ELSE GetCutInputData = str

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 출력 길이 자르기                                                         *
	' * 변수설명 : str = 입력값                                                             *
	' *            intCutSize = 입력길이                                                    *
	' *            strAddText = 글자 자르기 표시                                            *
	' ***************************************************************************************
	FUNCTION GetCutDispData(str, intCutSize, strAddText)

		IF intCutSize = 0 THEN
			GetCutDispData = str
		ELSE
			IF INT(GetTextLen(str)) > INT(intCutSize) THEN GetCutDispData = GetTextLeft(str, intCutSize - 2) & strAddText ELSE GetCutDispData = str
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 문자 길이 체크                                                           *
	' * 변수설명 : str = 문자                                                               *
	' ***************************************************************************************
	FUNCTION GetTextLen(str)
		IF str <> "" AND ISNULL(str) = False THEN
			DIM I
			GetTextLen = 0
			FOR I = 1 TO LEN(str)
				IF ASC(MID(str, I, 1)) < 0 THEN GetTextLen = GetTextLen + 2 ELSE GetTextLen = GetTextLen + 1
			NEXT
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 문자 좌측 길이                                                           *
	' * 변수설명 : str = 문자                                                               *
	' *            intCutSize = 길이                                                        *
	' ***************************************************************************************
	FUNCTION GetTextLeft(str, intCutSize)

		DIM intNum, I
		intNum = 0

		FOR I = 1 TO LEN(str)
			GetTextLeft = GetTextLeft & MID(str, I, 1)
			IF ASC(MID(str, I, 1)) < 0 THEN intNum = intNum + 2 ELSE intNum = intNum + 1
			IF intNum >= intCutSize THEN EXIT FOR
		NEXT

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 숫자 체크                                                                *
	' * 변수설명 : numeric : 체크할 숫자값                                                  *
	' *            intType : 숫자 타입                                                      *
	' ***************************************************************************************
	FUNCTION GetNumericCheck(numeric, intType)

		DIM intCheckNum

		IF numeric = "" THEN
			GetNumericCheck = False
		ELSE
			IF isNumeric(numeric) = False THEN
				GetNumericCheck = False
			ELSE
				IF numeric < 0 THEN
					GetNumericCheck = False
				ELSE
					SELECT CASE LCASE(intType)
					CASE "i" : intCheckNum = CLNG(2147483647) : numeric = CLNG(numeric)
					CASE "s" : intCheckNum = INT(32767)       : numeric = INT(numeric)
					CASE "t" : intCheckNum = CBYTE(255)       : numeric = CBYTE(numeric)
					END SELECT
					IF numeric > intCheckNum THEN GetNumericCheck = False ELSE GetNumericCheck = True
				END IF
			END IF
		END IF

	END FUNCTION


	' ***************************************************************************************
	' * 함수설명 : 양력을 음력으로 변환하는 함수                                            *
	' * 변수설명 : pYear = 년도, pMonth = 월, pDay = 일                                     *
	' ***************************************************************************************
	FUNCTION GetLunar(pYear,pMonth,pDay)

		DIM sLunarTableString
		DIM sLunarTable, nDay
    
		sLunarTableString = "1212122322121-1212121221220-1121121222120-2112132122122-2112112121220-2121211212120-2212321121212-2122121121210-2122121212120-1232122121212-1212121221220-1121123221222-1121121212220-1212112121220-2121231212121-2221211212120-1221212121210-2123221212121-2121212212120-1211212232212-1211212122210-2121121212220-1212132112212-2212112112210-2212211212120-1221412121212-1212122121210-2112212122120-1231212122212-1211212122210-2121123122122-2121121122120-2212112112120-2212231212112-2122121212120-1212122121210-2132122122121-2112121222120-1211212322122-1211211221220-2121121121220-2122132112122-1221212121120-2121221212110-2122321221212-1121212212210-2112121221220-1231211221222-1211211212220-1221123121221-2221121121210-2221212112120-1221241212112-1212212212120-1121212212210-2114121212221-2112112122210-2211211412212-2211211212120-2212121121210-2212214112121-2122122121120-1212122122120-1121412122122-1121121222120-2112112122120-2231211212122-2121211212120-2212121321212-2122121121210-2122121212120-1212142121212-1211221221220-1121121221220-2114112121222-1212112121220-2121211232122-1221211212120-1221212121210-2121223212121-2121212212120-1211212212210-2121321212221-2121121212220-1212112112210-2223211211221-2212211212120-1221212321212-1212122121210-2112212122120-1211232122212-1211212122210-2121121122210-2212312112212-2212112112120-2212121232112-2122121212110-2212122121210-2112124122121-2112121221220-1211211221220-2121321122122-2121121121220-2122112112322-1221212112120-1221221212110-2122123221212-1121212212210-2112121221220-1211231212222-1211211212220-1221121121220-1223212112121-2221212112120-1221221232112-1212212122120-1121212212210-2112132212221-2112112122210-2211211212210-2221321121212-2212121121210-2212212112120-1232212122112-1212122122120-1121212322122-1121121222120-2112112122120-2211231212122-2121211212120-2122121121210-2124212112121-2122121212120-1212121223212-1211212221220-1121121221220-2112132121222-1212112121220-2121211212120-2122321121212-1221212121210-2121221212120-1232121221212-1211212212210-2121123212221-2121121212220-1212112112220-1221231211221-2212211211220-1212212121210-2123212212121-2112122122120-1211212322212-1211212122210-2121121122120-2212114112122-2212112112120-2212121211210-2212232121211-2122122121210-2112122122120-1231212122212-1211211221220-2121121321222-2121121121220-2122112112120-2122141211212-1221221212110-2121221221210-2114121221221" '2050
		sLunarTable = Split(sLunarTableString, "-")
		nDay = Split("31-0-31-30-31-30-31-31-30-31-30-31", "-")
 
		DIM i, j
		DIM nDayTable(170)
		DIM nLunarMonth
    
		FOR i = 0 to 169
			nDayTable(i) = 0
			FOR j = 1 to 13
				nLunarMonth = CInt(Mid(sLunarTable(i), j, 1))
				SELECT CASE nLunarMonth
				CASE 1, 3
					nDayTable(i) = nDayTable(i) + 29
				CASE 2, 4
					nDayTable(i) = nDayTable(i) + 30
				END SELECT
			NEXT
		NEXT
    
		DIM nYear, nDays1, nDays2, nDays3
 
		nYear = pYear - 1
		nDays1 = 1880 * 365 + 1880 \ 4 - 1880 \ 100 + 1880 \ 400 + 30
		nDays2 = nYear * 365 + nYear \ 4 - nYear \ 100 + nYear \ 400
    
		IF GetLeapMonth(pYear) THEN nDay(1) = 29 ELSE nDay(1) = 28

		FOR i = 0 to pMonth - 2
			nDays2 = nDays2 + nDay(i)
		NEXT

		nDays2 = nDays2 + pDay

		nRetDay = nDays2 - nDays1 + 1
		nDays3 = nDayTable(0)
    
		DIM nRetDay, nRetMonth, nRetYear
    
		FOR i = 0 to 169
			IF nRetDay <= nDays3 THEN EXIT FOR
			nDays3 = nDays3 + nDayTable(i + 1)
		NEXT

		nRetYear = i + 1881
		nDays3 = nDays3 - nDayTable(i)
		nRetDay = nRetDay - nDays3
    
		DIM nMonthCount, nDayPerMonth
    
		nMonthCount = 11 : IF Mid(sLunarTable(i), 13, 1) > 0 THEN nMonthCount = 12
		nRetMonth = 0
		
		FOR j = 0 to nMonthCount
			nLunarMonth = CInt(Mid(sLunarTable(i), j + 1, 1))
			IF nLunarMonth > 2 THEN
				nDayPerMonth = nLunarMonth + 26
			ELSE
				nRetMonth = nRetMonth + 1
				nDayPerMonth = nLunarMonth + 28
			END IF
			IF nRetDay <= nDayPerMonth THEN EXIT FOR
			nRetDay = nRetDay - nDayPerMonth
		NEXT
 
		GetLunar = CStr(nRetYear) & "-" & RIGHT("0" & nRetMonth, 2) & "-" & RIGHT("0" & nRetDay, 2)

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 해당 년도 윤달 여부 반환                                                 *
	' * 변수설명 : pYear = 년도                                                             *
	' ***************************************************************************************
	FUNCTION GetLeapMonth(pYear)
		IF (pYear MOD 100 <> 0 AND pYear MOD 4 = 0) OR pYear MOD 400 = 0 THEN
			GetLeapMonth = True
		ELSE
			GetLeapMonth = False
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 해당 월의 마지막일 반환                                                  *
	' * 변수설명 : pYear = 년도 : pMonth : 월                                               *
	' ***************************************************************************************
	FUNCTION GetMonthCount(pYear, pMonth)
		DIM aMonthNum
		aMonthNum = SPLIT("31-0-31-30-31-30-31-31-30-31-30-31-", "-")
	 
		IF GetLeapMonth(pYear) THEN aMonthNum(1) = 29 ELSE aMonthNum(1) = 28
		
		GetMonthCount = CINT(aMonthNum(CINT(pMonth)-1))
	 
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 전화번호 또는 휴대폰번호 앞자리 반환                                     *
	' * 변수설명 : numberType = 구분 (all : 전체, tel : 지역번호, mobile : 휴대폰)          *
	' *            selectVal = 선택값                                                       *
	' ***************************************************************************************
	FUNCTION GetPhoneFirstNumber(numberType, selectVal)

		DIM str, strArrData, telValue, mobileValue, tmpFor

		telValue    = "02,031,032,033,041,042,043,0502,0505,051,052,053,054,055,061,062,063,064,070"
		mobileValue = "010,011,013,016,017,018,019,0502,0505,0506"

		SELECT CASE numberType
		CASE "all" : strArrData = telValue & "," & mobileValue
		CASE "tel" : strArrData = telValue
		CASE "mobile" : strArrData = mobileValue
		END SELECT

		strArrData = SPLIT(strArrData, ",")

		FOR tmpFor = 0 TO UBOUND(strArrData)
			str = str & "<option value=""" & strArrData(tmpFor) & """"
			IF strArrData(tmpFor) = selectVal THEN str = str & " selected"
			 str = str & ">" & strArrData(tmpFor) & "</option>" & chr(10)
		NEXT

		GetPhoneFirstNumber = str

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 날짜 SELECT FORM 생성                                                    *
	' * 변수설명 : dateType = 월 또는 일자 (2자리로 표현시)                                 *
	' *            selectVal = 선택값                                                       *
	' *            sInt = 시작값                                                            *
	' *            eInt = 종료값                                                            *
	' *            stepInt = 증가값                                                         *
	' *            strText = 추가 표현 문자                                                 *
	' ***************************************************************************************
	FUNCTION GetMakeDateSelectForm(dateType, selectVal, sInt, eInt, stepInt, strText)

		DIM str, tmpFor

		FOR tmpFor = sInt TO eInt STEP stepInt
			str = str & "<option value="""
			IF dateType = "month" OR dateType = "day" OR dateType = "hour" OR dateType = "minute" THEN
				IF LEN(tmpFor) = 1 THEN str = str & "0"
			END IF
			str = str & tmpFor & """"
			IF selectVal <> "" THEN
				IF INT(tmpFor) = INT(selectVal) THEN str = str & " selected"
			END IF
			str = str & ">" & tmpFor
			IF strText <> "" THEN str = str & strText
			str = str & "</option>" & CHR(10)
		NEXT

		GetMakeDateSelectForm = str

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 에디터 태그 변환 함수                                                    *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceTag2Editor(str)
		IF ISNULL(str) = False THEN
			str = REPLACE(str,"&amp;","&amp;amp;")
			str = REPLACE(str,"&quot;","&amp;quot;")
			str = REPLACE(str,CHR(34),"&quot;")
			GetReplaceTag2Editor = str
		END IF
	End Function

	' ***************************************************************************************
	' * 함수설명 : TEXT 태그 변환 함수                                                      *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceTag2Text(str)
		IF ISNULL(str) = False THEN
			str = REPLACE(str,"&amp;","&amp;amp;")
			str = REPLACE(str,"&quot;","&amp;quot;")
			str = REPLACE(str, "<", "&lt;")
			str = REPLACE(str, ">", "&gt;")
			str = REPLACE(str,"  ","&nbsp; ")
			str = REPLACE(str,"	","&nbsp; &nbsp; ")
			str = REPLACE(str,CHR(13) & CHR(10),"<br />")
			str = REPLACE(str,CHR(13),"<br />")
			str = REPLACE(str,CHR(10),"<br />")
			str = REPLACE(str,CHR(34),"&quot;")
			GetReplaceTag2Text = str
		END IF
	End Function

	' ***************************************************************************************
	' * 함수설명 : HTML 태그 변환 함수 (사용자)                                             *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceTag2UserHtml(str)
		IF ISNULL(str) = False THEN
			str = REPLACE(str,"&amp;amp;","&amp;")
			str = REPLACE(str,"&amp;quot;","&quot;")
			str = REPLACE(str, "&nbsp;", "&amp;nbsp;")
			str = REPLACE(str, "&lt;", "<")
			str = REPLACE(str, "&gt;", ">")
			str = REPLACE(str,"  ","&nbsp; ")
			GetReplaceTag2UserHtml = str
		END IF
	End Function

	' ***************************************************************************************
	' * 함수설명 : HTML 태그 변환 함수                                                      *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceTag2Html(str)
		IF ISNULL(str) = False THEN
			DIM allowTagList
			allowTagList = "!--|br|hr|table|tbody|tr|td|img|embed|strong|center|a|p|font|li||hr|span|h1|h2|h3|h4|h5|div"

			str = GetEregiReplace("<(\/?)(?!\/|" & allowTagList & ")([^<>]*)?>", "&lt;$1$2&gt;", str)
			str = GetEregiReplace("(javascript\:|vbscript\:)+","$1//",str)
			str = GetEregiReplace("(\.location|location\.|\.cookie|alert\(|window\.open\(|onmouse|onkey|view\-source\:)+", "//", str)
			str = REPLACE(str,"<" & "%","&lt;%")
			str = REPLACE(str,"%" & ">","&lt;%")
			str = REPLACE(str,"&amp;amp;","&amp;")
			str = REPLACE(str,"&amp;quot;","&quot;")
			str = REPLACE(str, "&nbsp;", "&amp;nbsp;")
			str = REPLACE(str, "&lt;", "<")
			str = REPLACE(str, "&gt;", ">")
			str = REPLACE(str,"  ","&nbsp; ")
			GetReplaceTag2Html = str
		END IF
	End Function

	FUNCTION GetEregiReplace(pattern, replacestr, text)
		DIM eregObj
		SET eregObj = New RegExp
		eregObj.Pattern = pattern
		eregObj.IgnoreCase = True
		eregObj.Global = True
		GetEregiReplace = eregObj.Replace(text, replacestr)
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : HTML BR 태그 변환 함수                                                   *
	' * 변수설명 : str : 변환할 변수 값                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceTag2HtmlBr(str)
		IF ISNULL(str) = False THEN
			DIM allowTagList
			allowTagList = "!--|br|hr|table|tbody|tr|td|img|embed|strong|center|a|p|font|li||hr|span|h1|h2|h3|h4|h5|div"

			str = GetEregiReplace("<(\/?)(?!\/|" & allowTagList & ")([^<>]*)?>", "&lt;$1$2&gt;", str)
			str = GetEregiReplace("(javascript\:|vbscript\:)+","$1//",str)
			str = GetEregiReplace("(\.location|location\.|\.cookie|alert\(|window\.open\(|onmouse|onkey|view\-source\:)+", "//", str)
			str = REPLACE(str,"<" & "%","&lt;%")
			str = REPLACE(str,"%" & ">","&lt;%") 
			str = REPLACE(str,Chr(13),"<br />")
			GetReplaceTag2HtmlBr = str
		END IF
	End Function

	' ***************************************************************************************
	' * 함수설명 : 태그제거                                                                 *
	' * 변수설명 : htmlDoc : HTML 태그로 된 내용                                            *
	' ***************************************************************************************
	FUNCTION GetStripTags(htmlDoc)
		DIM rex
		SET rex = new Regexp
		rex.Pattern= "<[^>]+>"
		rex.Global = true
		GetStripTags = rex.Replace(htmlDoc,"")
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 날짜 형태로 변환                                                         *
	' * 변수설명 : intDate   : 변환할 날짜값 (8자리)                                        *
	' *          : strcharac : 구분문자                                                     *
	' ***************************************************************************************
	FUNCTION GetReplaceDateStr(intDate, strcharac)
		IF ISNULL(intDate) = False THEN GetReplaceDateStr = LEFT(intDate, 4) & strcharac & MID(intDate, 5, 2) & strcharac & MID(intDate, 7, 2)
	End Function

	' ***************************************************************************************
	' * 함수설명 : 자바스크립트 새창 ALERT MSG                                              *
	' * 변수설명 : url = 이동할 URL                                                         *
	' ***************************************************************************************
	FUNCTION ActWinJsScript(url)
		DIM str
		str = "<script  type=""text/javascript"">" & CHR(10)
		str = str & "opener.location.href = '" & url & "';" & CHR(10)
		str = str & "self.close();" & CHR(10)
		ActWinJsScript = str & "</script>" & CHR(10)
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 폼메일 발송 함수                                                         *
	' * 변수설명 : strSendName    : 보내는 사람 이름                                        *
	' *            strSendMail    : 보내는 사람의 메일주소                                  *
	' *            strRecvName    : 받는 사람 이름                                          *
	' *            strRecvMail    : 받는 사람의 메일주소                                    *
	' *            strSubject     : 메일 제목                                               *
	' *            strContent     : 메일내용                                                *
	' *            strRecvBccMail : 참조                                                    *
	' *            strRecvCcMail  : 숨은참조                                                *
	' *            sendFileName1  : 첨부파일 #1                                             *
	' *            sendFileName2  : 첨부파일 #2                                             *
	' ***************************************************************************************
	FUNCTION ActSendEmail(strSendName, strSendMail, strRecvName, strRecvMail, strSubject, strContent, strRecvBccMail, strRecvCcMail, sendFileName1, sendFileName2)

		Const cdoSendUsingPort = 1  '1일 경우 로컬(SMTP), 2일 경우 외부(SMTP)로 메일전송
		Const strSmartHost = "localhost" 			'Host 설정
		Const strRoot = "C:\Inetpub\mailroot\Pickup"

		SET objMail = Server.CreateObject("CDO.Message")
		SET iConf = objMail.Configuration

		With iConf.Fields
		 .item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
		 .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = strRoot
		 .item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = strSmartHost
		 .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
		 .Update
		End With

		objMail.From = strSendName & "<" & strSendMail & ">"
		objMail.ReplyTo = tomail
		objMail.To = strRecvName & "<" & strRecvMail & ">"
		IF strRecvBccMail <> "" THEN objMail.Bcc = strRecvBccMail
		IF strRecvCcMail  <> "" THEN objMail.cc  = strRecvCcMail
		objMail.Subject = strSubject
		objMail.HTMLBody = strContent

		IF sendFileName1 <> "" THEN objMail.AddAttachment(sendFileName1)
		IF sendFileName2 <> "" THEN objMail.AddAttachment(sendFileName2)
		objMail.SEND

		SET Fields = NOTHING : SET objMail = NOTHING : SET objConfig = NOTHING : SET iConf = NOTHING

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 사용자 입력값의 오류시 기본값으로 변환                                   *
	' * 변수설명 : inputStr       : 입력값                                                  *
	' *            defaultStr     : 기본값                                                  *
	' *            bitInteger     : 숫자유무                                                *
	' ***************************************************************************************
	FUNCTION GetUserInputDefault(inputStr, defaultStr, bitInteger)

		IF bitInteger = True THEN
			IF inputStr = "" OR inputStr = 0 THEN GetUserInputDefault = defaultStr ELSE GetUserInputDefault = inputStr
		ELSE
			IF inputStr = "" THEN GetUserInputDefault = defaultStr ELSE GetUserInputDefault = inputStr
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : TEXT 파일 내용 반환                                                      *
	' * 변수설명 : FileUrl : 파일 경로 및 파일명                                            *
	' *            CharSet : charset                                                        *
	' ***************************************************************************************
	FUNCTION GetReadFromTextFile(FileUrl, CharSet)

		DIM str
		SET stm = server.CreateObject("adodb.stream")

		stm.Type=2
		stm.mode=3 
		stm.charset=CharSet
		stm.open
		stm.loadfromfile FileUrl
    
		str = stm.readtext
    GetReadFromTextFile = str

    stm.CLOSE : SET stm = NOTHING

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : CSS 특정단어 변환                                                        *
	' * 변수설명 : input_string : 변환할 내용                                               *
	' ***************************************************************************************
	FUNCTION GetStrDuplication(ByVal input_string)
	
		DIM input_array, input_length, i, j, t, t_length, temp_count, check_count, last_check
	
		input_array  = SPLIT(input_string, ",")
		input_length = UBOUND(input_array)
	
		FOR i = 0 TO input_length
	
			t = CInt(i + 1)
			t_length = input_length - 1
	
			FOR j = t TO t_length
				IF input_array(i) = input_array(j) THEN check_count = check_count + CInt(1)
			NEXT
	
			temp_count = temp_count + check_count
	
			IF check_count = 0 THEN
				IF i = input_length THEN
					last_check = INSTR(temp_input, input_array(i))
					IF last_check = 0 THEN temp_input = temp_input & input_array(i)
				ELSE
					temp_input = temp_input & input_array(i)
					temp_input = temp_input & ","
				END IF
			END IF
	
			check_count = CInt(0)
	
		NEXT
	
		temp_length = LEN(temp_input) - 1
	
		GetStrDuplication = LEFT(temp_input, temp_length)
	
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 회원 로그인 함수                                                         *
	' * 변수설명 : userid  : 아이디                                                         *
	' *            userpwd : 비밀번호                                                       *
	' *            adminPage : 관리자 페이지 유무 (Trur or False)                           *
	' ***************************************************************************************
	FUNCTION ActMemberLogin(userid, userpwd, adminPage)

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LOGIN] '" & userid & "', '" & userpwd & "' ")

		IF RS.EOF THEN
			ActMemberLogin = "ERROR01"
			EXIT FUNCTION
		END IF
	
		IF RS("bitAuth") = False THEN
			ActMemberLogin = "ERROR02"
			EXIT FUNCTION
		END IF

		IF ISNULL(RS("strLoginNoDate")) = False THEN
			IF INT(REPLACE(LEFT(RS("strLoginNoDate"), 10), "-","")) >= INT(REPLACE(LEFT(NOW(), 10), "-", "")) THEN
				ActMemberLogin = "ERROR03"
				EXIT FUNCTION
			END IF
		END IF

		IF RS("bitLeave") = True THEN
			ActMemberLogin = "ERROR04"
			EXIT FUNCTION
		END IF
	
		IF adminPage = True THEN
			IF RS("strAdmin") = "N" THEN
				RESPONSE.WRITE "ERROR05"
				RESPONSE.End()
			END IF
		END IF
	
		SESSION("memberSeq")   = RS("intSeq")
		SESSION("userID")      = RS("strLoginID")
		SESSION("userName")    = RS("strUserName")
		SESSION("nickName")    = RS("strNickName")
		SESSION("memberGroup") = RS("strGroupCode")
		SESSION("staff")       = RS("strAdmin")

		ActMemberLogin = "SUCCESS"

		DBCON.EXECUTE("[ARTY30_SP_MEMBER_LOGIN_UPDATE] '" & SESSION("memberSeq") & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "' ")

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 회원 로그아웃 함수                                                       *
	' ***************************************************************************************
	FUNCTION ActMemberLogout()

		SESSION("memberSeq") = ""
		SESSION("userID")    = ""
		SESSION("userName")  = ""
		SESSION("nickName")  = ""
		SESSION("staff")     = ""

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 회원 삭제 함수                                                           *
	' * 변수설명 : intSeq      : 회원 고유번호                                              *
	' *            strAdmin    : 관리자 여부                                                *
	'	*            strFilePath : 사진, 이름이미지, 마크이미지 업로드 경로                   *
	' ***************************************************************************************
	FUNCTION ActMemberRemove(intSeq, strAdmin, strFilePath)

		CALL ActFolderDelete(strFilePath & "\member\profile" & "\" & intSeq)
		CALL ActFolderDelete(strFilePath & "\member\name" & "\" & intSeq)
		CALL ActFolderDelete(strFilePath & "\member\mark" & "\" & intSeq)

		DBCON.EXECUTE("[ARTY30_SP_MEMBER_REMOVE] '" & intSeq & "' ")

		IF strAdmin = "S" THEN DBCON.EXECUTE("[ARTY30_SP_STAFF_REMOVE] '" & intSeq & "' ")

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 레이아웃 스타일 반환                                                     *
	' * 변수설명 : inputStr       : 입력값                                                  *
	' *            defaultStr     : 기본값                                                  *
	' *            bitInteger     : 숫자유무                                                *
	' ***************************************************************************************
	FUNCTION GetLayoutStyle(strAlign, intWidth, strWidthOpt, strPadding, strBgType, strBgColor, strBgFile, strRepeat, strFilePath)

		DIM str
		str = " style="""
		
		IF strAlign = "center" THEN str = str & "margin:0 auto;"
		IF intWidth > 0 THEN str = str & "width:" & intWidth & strWidthOpt & ";"
		
		IF strPadding <> ",,," THEN
			strPadding = SPLIT(strPadding, ",")
			str = str & " padding:"
			IF strPadding(0) = "" THEN str = str & "0" ELSE str = str & strPadding(0)
			IF strPadding(1) = "" THEN str = str & " 0" ELSE str = str & " " & strPadding(1)
			IF strPadding(2) = "" THEN str = str & " 0" ELSE str = str & " " & strPadding(2)
			IF strPadding(3) = "" THEN str = str & " 0" ELSE str = str & " " & strPadding(3) & ";"
		END IF

		SELECT CASE strBgType
		CASE "1" : str = str & " background-color:" & strBgColor & ";"
		CASE "2" :
			str = str & " background:url('" & strFilePath & strBgFile & "') "
			SELECT CASE strRepeat
			CASE "n" : str = str & ";"
			CASE "a" : str = str & "repeat;"
			CASE "x" : str = str & "repeat-x;"
			CASE "y" : str = str & "repeat-y;"
			END SELECT
		END SELECT

		IF str <> "" THEN str = str & """"
		GetLayoutStyle = str

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 관리자 확인                                                       *
	' * 변수설명 : intSrl    : 게시판 고유번휴                                              *
	' *            memberSeq : 회원 고유번호                                                *
	' *            staff     : 전체관리자 유무                                              *
	' ***************************************************************************************
	FUNCTION GetBoardAdminCheck(intSrl, memberSeq, staff)

		IF memberSeq = "" THEN
			GetBoardAdminCheck = False
		ELSE
			IF staff = "A" THEN
				GetBoardAdminCheck = True
			ELSE
				SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_ADMIN_READ] '" & intSrl & "', '" & SESSION("memberSeq") & "', '2' ")
				IF NOT(RS.EOF) THEN GetBoardAdminCheck = True ELSE GetBoardAdminCheck = False
			END IF
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 권환 반환                                                         *
	' * 변수설명 : strLevel      : 게시판 권한 구분                                         *
	' *            memberSeq     : 회원 고유번호                                            *
	' *            memberGroup   : 회원 그룹코드                                            *
	' *            bbsGroup      : 게시판 권한 그룹                                         *
	' *            bitAdmin      : 관리자 유무 (True or False)                              *
	' *            bitUseConsult : 상담게시판 여부 (True or False)                          *
	' ***************************************************************************************
	FUNCTION GetBoardLevelCheck(strLevel, memberSeq, memberGroup, bbsGroup, bitAdmin, bitUseConsult)

		IF bitAdmin = True THEN
			GetBoardLevelCheck = True
		ELSE
			IF bitUseConsult = True THEN
				IF memberSeq = "" THEN GetBoardLevelCheck = False ELSE GetBoardLevelCheck = True
			ELSE	
				SELECT CASE strLevel
				CASE "0" : GetBoardLevelCheck = True
				CASE "1" : IF memberSeq = "" THEN GetBoardLevelCheck = False ELSE GetBoardLevelCheck = True
				CASE "2"
					IF memberSeq = "" THEN
						GetBoardLevelCheck = False
					ELSE
						IF INSTR(bbsGroup, memberGroup) > 0 THEN GetBoardLevelCheck = True ELSE GetBoardLevelCheck = False
					END IF
				END SELECT
			END IF
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시글 타이틀 스타일 반환                                                *
	' * 변수설명 : fontSize    : 글자크기                                                   *
	' *            fontColor   : 글자색상                                                   *
	' *            bold        : 굵음표시                                                   *
	' ***************************************************************************************
	FUNCTION GetBoardTitleStyle(strTitle, fontSize, fontColor, bold)

		DIM str
		str = ""
		
		IF fontSize <> "" AND ISNULL(fontSize) = False THEN str = str & "font-size:" & fontSize & "; "
		IF fontColor <> "" AND ISNULL(fontColor) = False THEN str = str & "color:" & fontColor & "; "
		IF bold = True THEN str = str & "font-weight:bold;"

		IF str = "" THEN GetBoardTitleStyle = strTitle ELSE GetBoardTitleStyle = "<span style=""" & str & """>" & strTitle & "</span>"

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 에디터 다국어 지원 언어 체크 (추후 언어 추가시 변경됨)                   *
	' * 변수설명 : strLang : 언어구분값                                                     *
	' ***************************************************************************************
	FUNCTION GetEditorUtfCode(strLang)

		SELECT CASE LCASE(strLang)
		CASE "ko", "en" : GetEditorUtfCode = strLang
		CASE ELSE : GetEditorUtfCode = "en"
		END SELECT

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 자동등록방지 입력문자 체크                                               *
	' * 변수설명 : valSession : 문자세션값, valCaptcha : 입력값                             *
	' ***************************************************************************************
	FUNCTION ActCaptchaCheck(byval valSession, byval valCaptcha)
		DIM tmpSession
		valSession = TRIM(valSession)
		valCaptcha = TRIM(valCaptcha)
		IF (valSession = vbNullString) OR (valCaptcha = vbNullString) THEN
			ActCaptchaCheck = False
		ELSE
			tmpSession = valSession
			valSession = TRIM(SESSION(valSession))
'			SESSION(tmpSession) = vbNullString
			IF valSession = vbNullString THEN
				ActCaptchaCheck = False
			ELSE
				valCaptcha = Replace(valCaptcha,"i","I")
				IF STRCOMP(valSession, valCaptcha, 1) = 0 THEN ActCaptchaCheck = True ELSE ActCaptchaCheck = False
			END IF
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 공백값 체크                                                              *
	' * 변수설명 : str : 체크변수                                                           *
	' ***************************************************************************************
	FUNCTION GetTrimSpaceCheck(str)
		IF TRIM(str) = "" THEN GetTrimSpaceCheck = False ELSE GetTrimSpaceCheck = True
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 접근 권한 부족시 처리되는 스크립트 생성                           *
	' * 변수설명 : strLinkPage    : 이동할 페이지                                           *
	' *            strLinkLogin   : 0 : 메지시 출력, 1 : 로그인 페이지 이동                 *
	' *            strBoardID     : 게시판 아이디                                           *
	' *            intBoardSeq    : 게시글 번호                                             *
	' *            intCommentSeq  : 댓글번호                                                *
	' *            intCommentPage : 댓글 페이지                                             *
	' *            prevAct        : 이전 액션값                                             *
	' *            msgCode        : 메시지코드                                              *
	' ***************************************************************************************
	FUNCTION GetBoardAuthScript(strLinkPage, strLinkLogin, intBoardSeq, intCommentSeq, intCommentPage, prevAct, msgCode)

		IF strLinkPage <> "" AND ISNULL(strLinkPage) = False THEN
			GetBoardAuthScript = strLinkPage
		ELSE
			IF strLinkLogin = "0" THEN
				GetBoardAuthScript = GetBoardUrl("message", "seq=" & intBoardSeq & ",comment_seq=" & intCommentSeq & ",comment_page=" & intCommentPage & ",prevAct=" & prevAct & ",msgCode=" & msgCode)
			ELSE
				IF SESSION("memberSeq") = "" THEN
					GetBoardAuthScript = GetBoardUrl("login", "")
				ELSE
					GetBoardAuthScript = GetBoardUrl("message", "seq=" & intBoardSeq & ",comment_seq=" & intCommentSeq & ",comment_page=" & intCommentPage & ",prevAct=" & prevAct & ",msgCode=" & msgCode)
				END IF
			END IF
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 비밀번호 입력 (글수정, 글삭제, 댓글삭제)                                 *
	' * 변수설명 : intBoardSeq    : 게시글번호                                              *
	' *            intCommentSeq  : 댓글번호                                                *
	' *            intCommentPage : 댓글페이지                                              *
	' *            prevAct        : 이전 액션값                                             *
	' *            nextAct        : 다음 액션값                                             *
	' ***************************************************************************************
	FUNCTION GetPasswordFormScript(intBoardSeq, intCommentSeq, intCommentPage, prevAct, nextAct)

		GetPasswordFormScript = GetBoardUrl("password", "seq=" & intBoardSeq & ",comment_seq=" & intCommentSeq & ",comment_page=" & intCommentPage & ",prevAct=" & prevAct & ",nextAct=" & nextAct)

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 정렬 항목 DB 필드명으로 변경                                      *
	' * 변수설명 : strField   : 정렬 항목                                                   *
	' ***************************************************************************************
	FUNCTION GetBoardOrderField(strField)

		SELECT CASE strField
		CASE "no"            : GetBoardOrderField = "intSeq"
		CASE "update"        : GetBoardOrderField = "strModifyDate"
		CASE "regdate"       : GetBoardOrderField = "strRegDate"
		CASE "voted_count"   : GetBoardOrderField = "intVote"
		CASE "blamed_count"  : GetBoardOrderField = "intBlamed"
		CASE "readed_count"  : GetBoardOrderField = "intRead"
		CASE "comment_count" : GetBoardOrderField = "intComment"
		CASE "title"         : GetBoardOrderField = "strTitle"
		CASE ELSE            : GetBoardOrderField = "intSeq"
		END SELECT
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 검색 항목 DB 필드명으로 변경                                      *
	' * 변수설명 : strField   : 검색 항목                                                   *
	' ***************************************************************************************
	FUNCTION GetBoardSearchField(strField)

		SELECT CASE strField
		CASE "title"         : GetBoardSearchField = "strTitle"
		CASE "content"       : GetBoardSearchField = "strContent"
		CASE "title_content" : GetBoardSearchField = "title_content"
		CASE "user_name"     : GetBoardSearchField = "strUserName"
		CASE "nick_name"     : GetBoardSearchField = "strNickName"
		CASE "user_id"       : GetBoardSearchField = "strUserID"
		CASE "tag"           : GetBoardSearchField = "strTag"
		CASE "strAddData1", "strAddData2", "strAddData3", "strAddData4", "strAddData5", "strAddData6", "strAddData7", "strAddData8", "strAddData9", "strAddData10", "strAddData11", "strAddData12", "strAddData13", "strAddData14", "strAddData15"
			GetBoardSearchField : strField
		CASE ELSE 
			GetBoardSearchField = ""
		END SELECT
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 첨부파일 사이즈 반환                                                     *
	' * 변수설명 : intSize : 파일크기                                                       *
	' ***************************************************************************************
	FUNCTION GetFilesize(intSize)
		IF intSize <> "" AND ISNULL(intSize) = False THEN
			IF INT(intSize) > 1048576 THEN
				GetFilesize = ROUND((intSize / 1048576) * 1000 / 1000) & " MB"
			ELSEIF INT(intSize) > 1024 THEN
				GetFilesize = ROUND((intSize / 1024) * 10 / 10) & " KB"
			ELSE
				GetFilesize = intSize & " Byte"
			END IF
		END IF
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시글 수정 및 삭제권한 체크                                             *
	' * 변수설명 : staff            : 관리자 여부 (True or False)                           *
	' *            intDocMemmberSrl : 게시글 소유자 회원 고유번호                           *
	' *            intMemberSrl     : 회원고유번호                                          *
	' ***************************************************************************************
	FUNCTION GetDocumentModifyCheck(staff, intDocMemmberSrl, intMemberSrl)

		IF staff = True THEN
			GetDocumentModifyCheck = True
		ELSE
			IF intDocMemmberSrl = 0 THEN
				GetDocumentModifyCheck = True
			ELSE
				IF intMemberSrl = "" THEN
					GetDocumentModifyCheck = False
				ELSE
					IF INT(intDocMemmberSrl) = INT(intMemberSrl) THEN GetDocumentModifyCheck = True ELSE GetDocumentModifyCheck = False
				END IF
			END IF
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 댓글 삭제 또는 휴지통 넣기 함수                                          *
	' * 변수설명 : intSrl        : 게시판 고유번호                                          *
	' *            intBoardSeq   : 게시글 고유번호                                          *
	' *            intCommentSeq : 댓글 고유번호                                            *
	' *            intMemberSrl  : 회원 고유번호                                            *
	' *            bitUseTrash   : 삭제 (0), 휴지통 (1)                                     *
	' *            strPath       : 첨부파일 기본경로                                        *
	' ***************************************************************************************
	FUNCTION ActCommentRemove(intSrl, intBoardSeq, intCommentSeq, intMemberSrl, bitUseTrash, strPath)

		SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_READ] '" & intCommentSeq & "', 'Y' ")

		IF RS(0) = 0 THEN

			IF intMemberSrl <> "0" THEN

				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & intMemberSrl & "' ")

				IF GetBoardAdminCheck(intSrl, intMemberSrl, RS("strAdmin")) = False THEN

					SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_READ] '', '" & intMemberSrl & "', '', '', '" & intCommentSeq & "', '', 'comment' ")
	
					IF NOT(RS.EOF) THEN DBCON.EXECUTE("[ARTY30_SP_POINT_REMOVE] '" & RS("intSeq") & "', '" & bitUseTrash & "' ")

				END IF

			END IF

			IF bitUseTrash = "0" THEN

				SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_LIST] '', '', '" & intCommentSeq & "', 'C', '' ")

				WHILE NOT(RS.EOF)

					strPath = strPath & "\comment\" & RS("intSrl")

					IF RS("bitImage") = True THEN
						strPath = strPath & "\images\"
						CALL ActFileDelete(strPath & RS("strFilename"))
						CALL ActFileDelete(strPath & "temp\" & RS("strFilename"))
						CALL ActFileDelete(strPath & "thrum\" & RS("strFilename"))
					ELSE
						strPath = strPath & "\files\"
						CALL ActFileDelete(strPath & RS("strSid"))
					END IF

					DBCON.EXECUTE("[ARTY30_SP_FILES_REMOVE] '" & RS("intSeq") & "' ")

				RS.MOVENEXT
				WEND

			END IF

			DBCON.EXECUTE("[ARTY30_SP_COMMENTS_REMOVE] '" & intCommentSeq & "', '" & intBoardSeq & "', '" & bitUseTrash & "', '" & intMemberSrl & "' ")

			ActCommentRemove = True

		ELSE

			ActCommentRemove = False

		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시글 삭제 또는 휴지통 넣기 함수                                        *
	' * 변수설명 : intSrl         : 게시판 고유번호                                         *
	' *            intBoardSeq    : 게시글 고유번호                                         *
	' *            intMemberSrl   : 회원 고유번호                                           *
	' *            bitUseTrash    : 삭제 (0), 휴지통 (1)                                    *
	' *            strDefaultPath : 첨부파일 기본경로                                       *
	' ***************************************************************************************
	FUNCTION ActBoardRemove(intSrl, intBoardSeq, intMemberSrl, bitUseTrash, strDefaultPath)

		IF intMemberSrl <> "0" THEN

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & intMemberSrl & "' ")

			IF GetBoardAdminCheck(intSrl, intMemberSrl, RS("strAdmin")) = False THEN

				SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_READ] '', '" & intMemberSrl & "', '', '" & intBoardSeq & "', '', '', 'write' ")
				
				IF NOT(RS.EOF) THEN DBCON.EXECUTE("[ARTY30_SP_POINT_REMOVE] '" & RS("intSeq") & "', '" & bitUseTrash & "' ")

				SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_LIST] 'R', '" & intSrl & "', '" & intBoardSeq & "' ")

				DIM tmpCommentSeq

				WHILE NOT(RS.EOF)

					IF INT(RS("intMemberSrl")) = INT(intMemberSrl) THEN
						IF tmpCommentSeq <> "" THEN tmpCommentSeq = tmpCommentSeq & ","
						tmpCommentSeq = tmpCommentSeq & RS("intSeq")
					END IF

				RS.MOVENEXT
				WEND

				IF tmpCommentSeq <> "" THEN
					FOR EACH intCommentSeq IN SPLIT(tmpCommentSeq, ",")
						SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_READ] '', '" & intMemberSrl & "', '', '', '" & intCommentSeq & "', '', 'comment' ")
						IF NOT(RS.EOF) THEN DBCON.EXECUTE("[ARTY30_SP_POINT_REMOVE] '" & RS("intSeq") & "', '" & bitUseTrash & "' ")
					NEXT
				END IF

				SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_READ] '', '" & intMemberSrl & "', '', '" & intBoardSeq & "', '', '', 'upload' ")
	
				IF NOT(RS.EOF) THEN
	
					WHILE NOT(RS.EOF)
	
						DBCON.EXECUTE("[ARTY30_SP_POINT_REMOVE] '" & RS("intSeq") & "', '" & bitUseTrash & "' ")
	
					RS.MOVENEXT
					WEND
	
				END IF

			END IF

		END IF

		IF bitUseTrash = "0" THEN

			SET RS = DBCON.EXECUTE("[ARTY30_SP_FILES_LIST] '', '" & intBoardSeq & "', '', 'A', '' ")

			WHILE NOT(RS.EOF)

				strPath = strDefaultPath

				IF RS("intCommentSeq") = "0" THEN
					strPath = strPath & "\board\" & RS("intSrl")
				ELSE
					strPath = strPath & "\comment\" & RS("intSrl")
				END IF

				IF RS("bitImage") = True THEN
					strPath = strPath & "\images\"
					CALL ActFileDelete(strPath & RS("strFilename"))
					CALL ActFileDelete(strPath & "temp\" & RS("strFilename"))
					CALL ActFileDelete(strPath & "thrum\" & RS("strFilename"))
				ELSE
					strPath = strPath & "\files\"
					CALL ActFileDelete(strPath & RS("strSid"))
				END IF

				DBCON.EXECUTE("[ARTY30_SP_FILES_REMOVE] '" & RS("intSeq") & "' ")

			RS.MOVENEXT
			WEND

		END IF

		SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_LIST] 'R', '" & intSrl & "', '" & intBoardSeq & "' ")

		WHILE NOT(RS.EOF)

			DBCON.EXECUTE("[ARTY30_SP_COMMENTS_REMOVE] '" & RS("intSeq") & "', '" & intBoardSeq & "', '" & bitUseTrash & "', '" & RS("intMemberSrl") & "' ")

		RS.MOVENEXT
		WEND

		DBCON.EXECUTE("[ARTY30_SP_BOARD_REMOVE] '" & intBoardSeq & "', '" & bitUseTrash & "', '" & intMemberSrl & "' ")

		ActBoardRemove = True

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : NULL 값을 NULL이 아닌 값으로 변환                                        *
	' * 변수설명 : strValue      : 체크값                                                   *
	' ***************************************************************************************
	FUNCTION GetNullTextChange(strValue)

		IF ISNULL(strValue) = True THEN GetNullTextChange = "" ELSE GetNullTextChange = strValue

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시판 링크 반환                                                         *
	' * 변수설명 : sub_act       : 서브 액션값                                              *
	' *            strParameters : 추가 전달값                                              *
	' ***************************************************************************************
	FUNCTION GetBoardUrl(sub_act, strParameters)

		DIM tmpUrl, strParameter

		SELECT CASE LCASE(sub_act)
		CASE "login", "logout"

			tmpUrl = "?act=" & sub_act

		CASE ELSE

			tmpUrl = "?act=bbs"

			IF sub_act <> "" THEN tmpUrl = tmpUrl & "&subAct=" & sub_act

		END SELECT

		IF REQ_strBid <> "" THEN tmpUrl = tmpUrl & "&bid=" & REQ_strBid

		IF INSTR(LCASE(strParameters), "search_keyword=") = 0 AND INSTR(LCASE(strParameters), "search_target=") = 0 THEN
			IF REQ_strSearchKeyword <> "" AND REQ_strSearchTarget <> "" THEN tmpUrl = tmpUrl & "&search_keyword=" & Server.URLEncode(REQ_strSearchKeyword) & "&search_target=" & REQ_strSearchTarget
		END IF

		IF INSTR(LCASE(strParameters), "page=")        = 0 AND REQ_intPage       <> "" THEN tmpUrl = tmpUrl & "&page=" & REQ_intPage
		IF INSTR(LCASE(strParameters), "category=")    = 0 AND REQ_intCategory   <> "" THEN tmpUrl = tmpUrl & "&category=" & REQ_intCategory
		IF INSTR(LCASE(strParameters), "order_index=") = 0 AND REQ_strOrderIndex <> "" THEN tmpUrl = tmpUrl & "&order_index=" & REQ_strOrderIndex
		IF INSTR(LCASE(strParameters), "order_type=")  = 0 AND REQ_strOrderType  <> "" THEN tmpUrl = tmpUrl & "&order_type=" & REQ_strOrderType
		IF INSTR(LCASE(strParameters), "list_style=")  = 0 AND REQ_strListType   <> "" THEN tmpUrl = tmpUrl & "&list_style=" & REQ_strListType

		FOR EACH strParameter IN SPLIT(strParameters, ",")
			IF SPLIT(strParameter, "=")(1) <> "" THEN tmpUrl = tmpUrl & "&" & SPLIT(strParameter, "=")(0) & "=" & SPLIT(strParameter, "=")(1)
		NEXT

		GetBoardUrl = tmpUrl

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시글 및 댓글 비밀번호 세션 체크                                        *
	' * 변수설명 : intCheckSeq : 체크 번호                                                  *
	' *            strCheckSeq : 저장된 세션 체크 번호                                      *
	' ***************************************************************************************
	FUNCTION GetPasswordSessionCheck(intCheckSeq, strCheckSeq)

		IF strCheckSeq = "" THEN

			GetPasswordSessionCheck = False

		ELSE

			DIM intTmpSeq
			GetPasswordSessionCheck = False

			FOR EACH intTmpSeq IN SPLIT(strCheckSeq, ",")
				IF intTmpSeq <> "" THEN
					IF CDbl(intTmpSeq) = CDbl(intCheckSeq) THEN
						GetPasswordSessionCheck = True
						EXIT FOR
					END IF
				END IF
			NEXT

		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 게시글 목록 정렬 변환                                                    *
	' * 변수설명 : strOrder : 현재 정렬상태                                                 *
	' ***************************************************************************************
	FUNCTION GetListSortChange(strOrder)

		SELECT CASE LCASE(strOrder)
		CASE "desc" : GetListSortChange = "asc"
		CASE "asc"  : GetListSortChange = "desc"
		CASE ELSE   : GetListSortChange = "desc"
		END SELECT

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 추가필드 형식에 따른 입력값 반환                                         *
	' * 변수설명 : strValue  : 등록된 정보                                                  *
	' *            fieldType : 입력형식                                                     *
	' ***************************************************************************************
	FUNCTION GetExtraVar(strValue, fieldType)

		IF fieldType = "" OR ISNULL(fieldType) = True THEN
			GetExtraVar = ""
		ELSE
			IF strValue = "" OR ISNULL(strValue) = True THEN
				GetExtraVar = ""
			ELSE
				SELECT CASE fieldType
				CASE "url" : GetExtraVar = "<a href=""" & strValue & """ target=""_blank"">" & strValue & "</a>"
				CASE "email" : GetExtraVar = "<a href=""mailto:" & strValue & """>" & strValue & "</a>"
				CASE "text", "textarea", "checkbox", "select", "radio", "tel" : GetExtraVar = strValue
				CASE "date" : GetExtraVar = LEFT(strValue, 4) & "-" & MID(strValue, 5, 2) & "-" & MID(strValue, 7, 2)
				CASE "addr" : GetExtraVar = REPLACE(strValue, "$$$", " ")
				CASE "datetime" :
					IF strValue = "" THEN
						GetExtraVar = ""
					ELSE
						GetExtraVar = SPLIT(strValue, "$$$")(0) & "-" & SPLIT(strValue, "$$$")(1) & "-" & SPLIT(strValue, "$$$")(2) & " " & SPLIT(strValue, "$$$")(3) & ":" & SPLIT(strValue, "$$$")(4)
					END IF
				END SELECT
			END IF
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 아이피 주소 마지막 값 숨김                                               *
	' * 변수설명 : strIpAddr  : 아이피주소                                                  *
	' ***************************************************************************************
	FUNCTION GetHiddenIpAddr(strIpAddr)

		IF strIpAddr <> "" AND ISNULL(strIpAddr) = False THEN GetHiddenIpAddr = SPLIT(strIpAddr, ".")(0) & "." & SPLIT(strIpAddr, ".")(1) & ".xxx." & SPLIT(strIpAddr, ".")(3)

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 닉네임 체크 (사용 불가능한 특수문자 제한)                                *
	' * 변수설명 : str    : 입력값                                                          *
	' *            strLen : 입력길이 제한값                                                 *
	' ***************************************************************************************
	FUNCTION GetNickNameCheck(str, strLen)

		IF LEN(str) < strLen THEN
			GetNickNameCheck = False
		ELSE
			DIM tmpFor
			FOR tmpFor = 1 TO LEN(str)
			
				IF ASC(MID(str, tmpFor, 1)) >= 33 AND ASC(MID(str, tmpFor, 1)) <= 47 THEN
					IF ASC(MID(str, tmpFor, 1)) = 45 OR ASC(MID(str, tmpFor, 1)) = 46 THEN
						GetNickNameCheck = True
					ELSE
						GetNickNameCheck = False
						EXIT FOR
					END IF
				ELSEIF ASC(MID(str, tmpFor, 1)) >= 58 AND ASC(MID(str, tmpFor, 1)) <= 64 THEN
					GetNickNameCheck = False
					EXIT FOR
				ELSEIF ASC(MID(str, tmpFor, 1)) >= 91 AND ASC(MID(str, tmpFor, 1)) <= 96 THEN
					IF ASC(MID(str, tmpFor, 1)) = 95 THEN
						GetNickNameCheck = True
					ELSE
						GetNickNameCheck = False
						EXIT FOR
					END IF
				ELSEIF ASC(MID(str, tmpFor, 1)) >= 123 OR ASC(MID(str, tmpFor, 1)) = 126 THEN
					GetNickNameCheck = False
					EXIT FOR
				ELSE
					GetNickNameCheck = True
				END IF
			NEXT
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 회원아이디 체크 (사용 불가능한 특수문자 제한)                            *
	' * 변수설명 : str    : 입력값                                                          *
	' *            strLen : 입력길이 제한값                                                 *
	' ***************************************************************************************
	FUNCTION GetUserIDCheck(str, strLen)

		IF LEN(str) < strLen THEN
			GetUserIDCheck = False
		ELSE
			IF ASC(MID(str, 1, 1)) = 46 THEN
				GetUserIDCheck = False
				EXIT FUNCTION
			END IF

			IF ASC(MID(str, LEN(str), 1)) = 46 THEN
				GetUserIDCheck = False
				EXIT FUNCTION
			END IF

			DIM tmpFor
			FOR tmpFor = 1 TO LEN(str)
				IF ASC(MID(str, tmpFor, 1)) >= 65 AND ASC(MID(str, tmpFor, 1)) <= 90 THEN
					GetUserIDCheck = True
				ELSEIF ASC(MID(str, tmpFor, 1)) >= 97 AND ASC(MID(str, tmpFor, 1)) <= 122 THEN
					GetUserIDCheck = True
				ELSEIF ASC(MID(str, tmpFor, 1)) >= 48 AND ASC(MID(str, tmpFor, 1)) <= 57 THEN
					GetUserIDCheck = True
				ELSEIF ASC(MID(str, tmpFor, 1)) = 45 OR ASC(MID(str, tmpFor, 1)) = 46 OR ASC(MID(str, tmpFor, 1)) = 95 THEN
					GetUserIDCheck = True
				ELSE
					GetUserIDCheck = False
					EXIT FOR
				END IF
			NEXT
		END IF

	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : INT 값 MONEY 변형 함수                                                   *
	' * 변수설명 : intValue = 변환할 값                                                     *
	' ***************************************************************************************
	FUNCTION GetMoneyComma(intValue)
		IF intValue <> "" AND ISNULL(intValue) = False THEN GetMoneyComma = MID(FORMATCURRENCY(intValue), 2, LEN(FORMATCURRENCY(intValue))) ELSE GetMoneyComma = 0
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 회원 그룹 및 레벨 이미지 반환                                            *
	' * 변수설명 : strGroupLevel      = 회원그룹코드,레벨                                   *
	' *            bitDispLevelIcon   = 레벨아이콘 출력유무 (True or False)                 *
	' *            strLevelIconFolder = 레벨아이콘 폴더                                     *
	' *            strFilePath        = 파일저장 경로                                       *
	' ***************************************************************************************
	FUNCTION GetMemberGroupLevelIcon(strGroupLevel, bitDispLevelIcon, strLevelIconFolder, strFilePath)

		DIM strGroupImg, strLevelImg, strReturn

		IF strGroupLevel <> "" AND ISNULL(strGroupLevel) = False THEN
			strGroupImg = GetFolderFileList(GetNowFolderPath("") & "\" & strFilePath & "\member\group\" & SPLIT(strGroupLevel, ",")(0) & "\")
			IF strGroupImg <> "" THEN strGroupImg = strFilePath & "/member/group/" & SPLIT(strGroupLevel, ",")(0) & "/" & strGroupImg
			IF bitDispLevelIcon = True THEN
				strLevelImg = strFilePath & "/member/level/" & strLevelIconFolder & "/" & SPLIT(strGroupLevel, ",")(1) & ".gif"
			END IF
		END IF

		strReturn = ""
		
		IF strGroupImg <> "" THEN strReturn = strReturn & "<img src=""" & strGroupImg & """ alt=""group_icon"" style=""vertical-align:middle; margin-right:3px;"">"
		
		IF strLevelImg <> "" THEN strReturn = strReturn & "<img src=""" & strLevelImg & """ alt=""Lv." & SPLIT(strGroupLevel, ",")(1) & """ style=""vertical-align:middle; margin-right:3px;"">"
		 
		GetMemberGroupLevelIcon = strReturn
		
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 회원 사진, 마크, 이름 이미지 반환                                        *
	' * 변수설명 : intMemberSrl = 회원고유번호                                              *
	' *            bitUse       = 사용유무 (True or False)                                  *
	' *            strImageType = 이미지 구분                                               *
	' *            strPdsPath   = 파일저장 경로                                             *
	' *            dispType     = 이미지 또는 파일명                                        *
	' *            intWidth     = 이미지 너비                                               *
	' *            intHeight    = 이미지 높이                                               *
	' ***************************************************************************************
	FUNCTION GetMemberImage(intMemberSrl, bitUse, strImageType, strPdsPath, dispType, intWidth, intHeight)

		DIM strFileName

		IF intMemberSrl > 0 THEN
			IF bitUse = True THEN
				strFileName = GetFolderFileList(GetNowFolderPath("") & "\" & strPdsPath & "\member\" & strImageType & "\" & intMemberSrl & "\")
				IF strFileName = "" THEN
					GetMemberImage = ""
				ELSE
					SELECT CASE dispType
					CASE "image"
						GetMemberImage = "<img src=""" & strPdsPath & "/member/" & strImageType & "/" & intMemberSrl & "/" & strFileName & """ alt=""" & strImageType & """ width=""" & intWidth & """ height=""" & intHeight & """ style=""vertical-align:middle;"
					IF strImageType <> "profile" THEN GetMemberImage = GetMemberImage & "margin-right:3px;"
					GetMemberImage = GetMemberImage & """ class=""member_" & strImageType & """>"
					CASE "file"  : GetMemberImage = strFileName
					END SELECT
				END IF
			ELSE
				GetMemberImage = ""
			END IF
		ELSE
			GetMemberImage = ""
		END IF
		
	END FUNCTION

	' ***************************************************************************************
	' * 함수설명 : 날짜 추가 반환                                                           *
	' * 변수설명 : strDate    = 기준날짜                                                    *
	' *            strAddType = 추가 구분 (년,월,일,시,분등)                                *
	' *            intAdd     = 추가수치                                                    *
	' ***************************************************************************************
	FUNCTION GetDateAdd(strDate, strAddType, intAdd)

		IF strDate = "" THEN GetDateAdd = "" ELSE GetDateAdd = DATEADD(strAddType, intAdd, strDate)

	END FUNCTION
%>