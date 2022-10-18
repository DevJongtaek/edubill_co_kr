<%
	'*****************************************************
	'그해의 윤달 여부 
	'*****************************************************
	FUNCTION fn_leapmonth(pYear)

		IF (pYear MOD 100 <> 0 AND pYear MOD 4 = 0) OR pYear MOD 400 = 0 THEN fn_leapmonth = True ELSE fn_leapmonth = False

	END FUNCTION

	'*****************************************************
	'해당월의 마지막 월을 반환한다
	'*****************************************************
	FUNCTION fn_monthcount(pYear, pMonth)
 
		DIM aMonthNum
		aMonthNum = SPLIT("31-0-31-30-31-30-31-31-30-31-30-31-", "-")
 
		IF fn_leapmonth(pYear) THEN aMonthNum(1) = 29 ELSE aMonthNum(1) = 28
    
		fn_monthcount = CINT(aMonthNum(CINT(pMonth) -1))
 
	END FUNCTION

	'*****************************************************
	'해당년/월의 첫번째일의 위치를 반환
	'*****************************************************
	FUNCTION fn_firstweek(pYear, pMonth)

		fn_firstweek = WEEKDAY(pYear & "-" & pMonth)

	END FUNCTION

	'*****************************************************
	'해당년/월/일의 위치를 반환
	'*****************************************************
	FUNCTION fn_nowweek(pYear, pMonth, pDay)

		fn_nowweek = WEEKDAY(pYear & "-" & pMonth & "-" & pDay)

	END FUNCTION

	'*****************************************************
	'해당년/월의 마지막일의 위치를 반환
	'*****************************************************
	FUNCTION fn_lastweek(pYear, pMonth)

		fn_lastweek = WEEKDAY(pYear & "-" & pMonth & "-" & fn_monthcount(pYear,pMonth))
	
	END FUNCTION

	'*****************************************************
	'첫번째주 의 빈값을 구한다.
	'해당 년/월의 일수시작이 수요일 이라면 일/월/화 는 빈값이다.
	'*****************************************************
	FUNCTION fn_blankweekfirst(pYear, pMonth)

		fn_blankweekfirst = fn_firstweek(pYear,pMonth) -1

	END FUNCTION

	'*****************************************************
	'마지막주 의 빈값을 구한다.
	'해당 년/월의 일수끝이 목요일 이라면 금/토 는 빈값이다.
	'*****************************************************
	FUNCTION fn_blankweeklast(pYear,pMonth)
	
		fn_blankweeklast = 7-fn_lastweek(pYear,pMonth)

	END FUNCTION

	'*****************************************************
	'주어진 년/월의 달력을 만든다.
	'2차원배열을 사용하여 틀을 만든다.
	'가로(1주)는 무조건 7이 되므로 세로값만 알면 된다.
	'빈칸은 null 값으로한다
	'*****************************************************
	FUNCTION fn_CalMain(pYear,pMonth)

		DIM aCal(), intVertical, intWeekcnt, i, j, k, intDay

		k = 1
		intDay = 1
		intVertical = (fn_monthcount(pYear,pMonth)+fn_blankweekfirst(pYear,pMonth)+fn_blankweeklast(pYear,pMonth)) / 7
		intWeekcnt = 7

		REDIM aCal(intVertical,intWeekcnt)

		FOR i = 1 TO intVertical 
			FOR j=1 TO intWeekcnt
				IF k <= fn_blankweekfirst(pYear,pMonth) THEN
					aCal(i,j) = null
				ELSEIF k <= fn_blankweekfirst(pYear,pMonth)+intDay and intDay<=fn_monthcount(pYear,pMonth) THEN
					aCal(i,j) = intDay
					intDay = intDay+1
				ELSE
					aCal(i,j) = null
				END IF
				k = k + 1
			NEXT
		NEXT

		fn_CalMain = aCal

	END FUNCTION

	'*****************************************************
	'return type : string(yyyy-mm-dd)
	'음력을 양력으로 변환하는 함수
	'*****************************************************
	FUNCTION getSolar(pYear,pMonth,pDay)

    DIM sLunarTableString
    DIM sLunarTable, nDay
    
		sLunarTableString = "1212122322121-1212121221220-1121121222120-2112132122122-2112112121220-2121211212120-2212321121212-2122121121210-2122121212120-1232122121212-1212121221220-1121123221222-1121121212220-1212112121220-2121231212121-2221211212120-1221212121210-2123221212121-2121212212120-1211212232212-1211212122210-2121121212220-1212132112212-2212112112210-2212211212120-1221412121212-1212122121210-2112212122120-1231212122212-1211212122210-2121123122122-2121121122120-2212112112120-2212231212112-2122121212120-1212122121210-2132122122121-2112121222120-1211212322122-1211211221220-2121121121220-2122132112122-1221212121120-2121221212110-2122321221212-1121212212210-2112121221220-1231211221222-1211211212220-1221123121221-2221121121210-2221212112120-1221241212112-1212212212120-1121212212210-2114121212221-2112112122210-2211211412212-2211211212120-2212121121210-2212214112121-2122122121120-1212122122120-1121412122122-1121121222120-2112112122120-2231211212122-2121211212120-2212121321212-2122121121210-2122121212120-1212142121212-1211221221220-1121121221220-2114112121222-1212112121220-2121211232122-1221211212120-1221212121210-2121223212121-2121212212120-1211212212210-2121321212221-2121121212220-1212112112210-2223211211221-2212211212120-1221212321212-1212122121210-2112212122120-1211232122212-1211212122210-2121121122210-2212312112212-2212112112120-2212121232112-2122121212110-2212122121210-2112124122121-2112121221220-1211211221220-2121321122122-2121121121220-2122112112322-1221212112120-1221221212110-2122123221212-1121212212210-2112121221220-1211231212222-1211211212220-1221121121220-1223212112121-2221212112120-1221221232112-1212212122120-1121212212210-2112132212221-2112112122210-2211211212210-2221321121212-2212121121210-2212212112120-1232212122112-1212122122120-1121212322122-1121121222120-2112112122120-2211231212122-2121211212120-2122121121210-2124212112121-2122121212120-1212121223212-1211212221220-1121121221220-2112132121222-1212112121220-2121211212120-2122321121212-1221212121210-2121221212120-1232121221212-1211212212210-2121123212221-2121121212220-1212112112220-1221231211221-2212211211220-1212212121210-2123212212121-2112122122120-1211212322212-1211212122210-2121121122120-2212114112122-2212112112120-2212121211210-2212232121211-2122122121210-2112122122120-1231212122212-1211211221220-2121121321222-2121121121220-2122112112120-2122141211212-1221221212110-2121221221210-2114121221221" '2050
		sLunarTable = SPLIT(sLunarTableString, "-")
		nDay = SPLIT("31-0-31-30-31-30-31-31-30-31-30-31", "-")
 
		DIM nRetYear, nRetMonth, nRetDay
		DIM nDays, nLunarMonth
		DIM i, j

		nDays = 0

		FOR i = 0 TO pYear - 1882
			FOR j = 1 TO 13
				nLunarMonth = CINT(MID(sLunarTable(i), j, 1))
				IF nLunarMonth > 2 THEN
					nDays = nDays + (26 +  nLunarMonth)
				ELSE
					IF nLunarMonth > 0 THEN nDays = nDays + (28 +  nLunarMonth)
				END IF
			NEXT
		NEXT

		DIM nLeapMonthCount, nRealMonthCount

		nLeapMonthCount = pMonth
		nRealMonthCount = 0

		DO
			nRealMonthCount = nRealMonthCount + 1
			IF CINT(MID(sLunarTable(pYear - 1881), nRealMonthCount, 1)) > 2 THEN
				nDays = nDays + 26 + CInt(Mid(sLunarTable(pYear - 1881), nRealMonthCount, 1))
				nLeapMonthCount = nLeapMonthCount + 1
			ELSE
				IF nRealMonthCount = nLeapMonthCount THEN
					IF bIsLeapMonth THEN nDays = nDays + 28 + CINT(MID(sLunarTable(pYear - 1881), nRealMonthCount, 1))
					EXIT DO
				END IF
				nDays = nDays + 28 + CInt(Mid(sLunarTable(pYear - 1881), nRealMonthCount, 1))
			END IF
		LOOP

		nDays = nDays + pDay + 29
		nRetYear = 1880

		DO
			nRetYear = nRetYear + 1
			nDayPerYear = 365
			IF nRetYear MOD 400 = 0 OR nRetYear MOD 100 <> 0 AND nRetYear MOD 4 = 0 THEN nDayPerYear = 366
			IF nDays < nDayPerYear THEN EXIT DO
			nDays = nDays - nDayPerYear
		LOOP

		nDay(1) = nDayPerYear - 337

		nRetMonth = 0

		DO
			nRetMonth = nRetMonth + 1
			IF nDays <= CINT(nDay(nRetMonth - 1)) THEN EXIT DO
			nDays = nDays - CINT(nDay(nRetMonth - 1))
		LOOP

		nRetDay = nDays

		getSolar = CStr(nRetYear) & "-" & Right("0" & nRetMonth, 2) & "-" & Right("0" & nRetDay, 2)

	END FUNCTION

	'*****************************************************
	'양력을 음력으로 변환하는 함수
	'*****************************************************
	FUNCTION getLunar(pYear,pMonth,pDay)

    DIM sLunarTableString
    DIM sLunarTable, nDay
    
    sLunarTableString = "1212122322121-1212121221220-1121121222120-2112132122122-2112112121220-2121211212120-2212321121212-2122121121210-2122121212120-1232122121212-1212121221220-1121123221222-1121121212220-1212112121220-2121231212121-2221211212120-1221212121210-2123221212121-2121212212120-1211212232212-1211212122210-2121121212220-1212132112212-2212112112210-2212211212120-1221412121212-1212122121210-2112212122120-1231212122212-1211212122210-2121123122122-2121121122120-2212112112120-2212231212112-2122121212120-1212122121210-2132122122121-2112121222120-1211212322122-1211211221220-2121121121220-2122132112122-1221212121120-2121221212110-2122321221212-1121212212210-2112121221220-1231211221222-1211211212220-1221123121221-2221121121210-2221212112120-1221241212112-1212212212120-1121212212210-2114121212221-2112112122210-2211211412212-2211211212120-2212121121210-2212214112121-2122122121120-1212122122120-1121412122122-1121121222120-2112112122120-2231211212122-2121211212120-2212121321212-2122121121210-2122121212120-1212142121212-1211221221220-1121121221220-2114112121222-1212112121220-2121211232122-1221211212120-1221212121210-2121223212121-2121212212120-1211212212210-2121321212221-2121121212220-1212112112210-2223211211221-2212211212120-1221212321212-1212122121210-2112212122120-1211232122212-1211212122210-2121121122210-2212312112212-2212112112120-2212121232112-2122121212110-2212122121210-2112124122121-2112121221220-1211211221220-2121321122122-2121121121220-2122112112322-1221212112120-1221221212110-2122123221212-1121212212210-2112121221220-1211231212222-1211211212220-1221121121220-1223212112121-2221212112120-1221221232112-1212212122120-1121212212210-2112132212221-2112112122210-2211211212210-2221321121212-2212121121210-2212212112120-1232212122112-1212122122120-1121212322122-1121121222120-2112112122120-2211231212122-2121211212120-2122121121210-2124212112121-2122121212120-1212121223212-1211212221220-1121121221220-2112132121222-1212112121220-2121211212120-2122321121212-1221212121210-2121221212120-1232121221212-1211212212210-2121123212221-2121121212220-1212112112220-1221231211221-2212211211220-1212212121210-2123212212121-2112122122120-1211212322212-1211212122210-2121121122120-2212114112122-2212112112120-2212121211210-2212232121211-2122122121210-2112122122120-1231212122212-1211211221220-2121121321222-2121121121220-2122112112120-2122141211212-1221221212110-2121221221210-2114121221221-" '2050
		sLunarTable = SPLIT(sLunarTableString, "-")
		nDay = SPLIT("31-0-31-30-31-30-31-31-30-31-30-31", "-")

		DIM i, j, nDayTable(170), nLunarMonth

		FOR i = 0 TO 169
			nDayTable(i) = 0
			FOR j = 1 TO 13
				nLunarMonth = CINT(MID(sLunarTable(i), j, 1))
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

		IF fn_leapmonth(pYear) THEN nDay(1) = 29 ELSE nDay(1) = 28

		FOR i = 0 TO pMonth - 2
			nDays2 = nDays2 + nDay(i)
		NEXT

		nDays2 = nDays2 + pDay
		nRetDay = nDays2 - nDays1 + 1
		nDays3 = nDayTable(0)

		DIM nRetDay, nRetMonth, nRetYear

		FOR i = 0 TO 169
			IF nRetDay <= nDays3 THEN EXIT FOR
			nDays3 = nDays3 + nDayTable(i + 1)
		NEXT

		nRetYear = i + 1881
		nDays3 = nDays3 - nDayTable(i)
		nRetDay = nRetDay - nDays3

		DIM nMonthCount, nDayPerMonth

		nMonthCount = 11 : IF MID(sLunarTable(i), 13, 1) > 0 THEN nMonthCount = 12
		nRetMonth = 0

		FOR j = 0 TO nMonthCount
			nLunarMonth = CINT(MID(sLunarTable(i), j + 1, 1))
			IF nLunarMonth > 2 THEN
				nDayPerMonth = nLunarMonth + 26
			ELSE
				nRetMonth = nRetMonth + 1
				nDayPerMonth = nLunarMonth + 28
			END IF
			IF nRetDay <= nDayPerMonth THEN EXIT FOR
			nRetDay = nRetDay - nDayPerMonth
		NEXT

		getLunar = CSTR(nRetYear) & "-" & RIGHT("0" & nRetMonth, 2) & "-" & RIGHT("0" & nRetDay, 2)

	END FUNCTION

	'*****************************************************
	'휴일 여부
	'휴일은 음력에서 1.1(설)/8.15(추석)/4.8(석가탄신일) 이 있으며
	'양력으로 1.1(신정)/3.1(삼일절)/4.5(식목일)/5.5(어린이날)/6.6(현충일)/7.17(제헌절)/8.15(광복절)/10.3(개천절)/12.25(크리스마스) 이다.
	'설과 추석은 앞뒤로 하루씩 휴일이 더해진다.
	'*****************************************************

	FUNCTION fn_Holiday( pYear,pMonth, pDay  )

		DIM aHoli(13,31), i, j
		
		FOR	i = 0 TO 12
			FOR j = 0 TO 30
				aHoli(i, j) = False
			NEXT
		NEXT
	
		aHoli(1,1)   = True
		aHoli(3,1)   = True
		aHoli(4,5)   = True
		aHoli(5,5)   = True
		aHoli(6,6)   = True
		aHoli(7,17)  = True
		aHoli(8,15)  = True
		aHoli(10,3)  = True
		aHoli(12,25) = True
	
		DIM iLunYear,iLunMonth,iLunDay,iLunYmd,iLunYmdpre,iLunYmdNEXT
	
		'(설)
		iLunYmd = getSolar(pYear,1,1)
		iLunYmdpre = dateadd("d",-1,iLunYmd)
		
		iLunYmdNEXT = dateadd("d",1,iLunYmd)
	
		aHoli(month(iLunYmd),day(iLunYmd)) = True
		aHoli(month(iLunYmdpre),day(iLunYmdpre)) = True
		aHoli(month(iLunYmdNEXT),day(iLunYmdNEXT)) = True
	
		'(추석)
		iLunYmd = getSolar(pYear,8,15)
		iLunYmdpre = dateadd("d",-1,iLunYmd)
		iLunYmdNEXT = dateadd("d",1,iLunYmd)
	
		aHoli(month(iLunYmd),day(iLunYmd)) = True
		aHoli(month(iLunYmdpre),day(iLunYmdpre)) = True
		aHoli(month(iLunYmdNEXT),day(iLunYmdNEXT)) = True
	
		'(석가탄신일)
		iLunYmd = getSolar(pYear,4,8)
	
		aHoli(month(iLunYmd),day(iLunYmd)) = True
	
		fn_Holiday = aHoli( pMonth , pDay )

	END FUNCTION

	FUNCTION fn_HolidayPrint( pYear,pMonth, pDay  )

		DIM aHoli(13,31), i, j
		
		FOR	i = 0 TO 12
			FOR j = 0 TO 30
				aHoli(i, j) = False
			NEXT
		NEXT
		
		'양력 휴일
		aHoli(1,1)   = "신정"
		aHoli(3,1)   = "삼일절"
		aHoli(4,5)   = "식목일"
		aHoli(5,5)   = "어린이날"
		aHoli(5,27)  = "개관기념일"		
		aHoli(6,6)   = "현충일"
		aHoli(7,17)  = "제헌절"
		aHoli(8,15)  = "광복절"
		aHoli(10,3)  = "개천절"
		aHoli(12,25) = "성탄절"
		
		'음력휴일
		DIM iLunYear,iLunMonth,iLunDay,iLunYmd,iLunYmdpre,iLunYmdNEXT
		
		'(설)
		iLunYmd = getSolar(pYear,1,1)
		iLunYmdpre = dateadd("d",-1,iLunYmd)
		
		iLunYmdNEXT = dateadd("d",1,iLunYmd)
		
		aHoli(month(iLunYmd),day(iLunYmd)) = "설연휴"
		aHoli(month(iLunYmdpre),day(iLunYmdpre)) = "설연휴"
		aHoli(month(iLunYmdNEXT),day(iLunYmdNEXT)) = "설연휴"
		
		'(추석)
		iLunYmd = getSolar(pYear,8,15)
		iLunYmdpre = dateadd("d",-1,iLunYmd)
		iLunYmdNEXT = dateadd("d",1,iLunYmd)
		
		aHoli(month(iLunYmd),day(iLunYmd)) = "추석"
		aHoli(month(iLunYmdpre),day(iLunYmdpre)) = "추석"
		aHoli(month(iLunYmdNEXT),day(iLunYmdNEXT)) = "추석"
		
		'(석가탄신일)
		iLunYmd = getSolar(pYear,4,8)
		
		aHoli(month(iLunYmd),day(iLunYmd)) = "석가탄신일"
		
		fn_HolidayPrint = aHoli( pMonth , pDay )

	END FUNCTION
%>