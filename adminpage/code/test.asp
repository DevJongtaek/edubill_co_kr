<%

	Function FUNtelcheck(testimsi)

		imsitel1 = ""
		imsitel2 = ""
		imsitel3 = ""

		if mid(testimsi,3,1)="-" and mid(testimsi,8,1)="-" then		'02-2214-0833
			imsitel1 = left(testimsi,2)
			imsitel2 = mid(testimsi,4,4)
			imsitel3 = right(testimsi,4)
		elseif mid(testimsi,3,1)="-" and mid(testimsi,7,1)="-" then	'02-214-0833
			imsitel1 = left(testimsi,2)
			imsitel2 = mid(testimsi,4,3)
			imsitel3 = right(testimsi,4)
		elseif mid(testimsi,4,1)="-" and mid(testimsi,9,1)="-" then	'031-2214-0833
			imsitel1 = left(testimsi,3)
			imsitel2 = mid(testimsi,5,4)
			imsitel3 = right(testimsi,4)
		elseif mid(testimsi,4,1)="-" and mid(testimsi,8,1)="-" then	'031-214-0833
			imsitel1 = left(testimsi,3)
			imsitel2 = mid(testimsi,5,3)
			imsitel3 = right(testimsi,4)
		else
			imsitel1 = ""
			imsitel2 = ""
			imsitel3 = ""
		end if

	End Function

	testimsi2 = "031-2214-0833"
	tester1234 = FUNtelcheck("031-2214-0833")
	response.write FUNtelcheck("031-2214-0833")





%>