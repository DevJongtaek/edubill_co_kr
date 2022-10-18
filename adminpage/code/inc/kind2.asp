<%
	set rskind = server.CreateObject("ADODB.Recordset") '대분류
	SQL = "select idx,comname from tb_company where flag = '1' order by comname asc "
	rskind.Open sql, db, 1
	if not rskind.eof then
		bimsiarray = rskind.GetRows
		bimsiarrayint = ubound(bimsiarray,2)
	else
		bimsiarray = ""
		bimsiarrayint = ""
	end if
	rskind.close
	set rskind=nothing

	set rskind = server.CreateObject("ADODB.Recordset") '중분류
	SQL = "select bidxsub,idx,comname from tb_company where flag = '2' order by comname asc "
	rskind.Open sql, db, 1
	if not rskind.eof then
		cimsiarray = rskind.GetRows
		cimsiarrayint = ubound(cimsiarray,2)
	else
		cimsiarray = ""
		cimsiarrayint = ""
	end if
	rskind.close
	set rskind=nothing

	set rskind = server.CreateObject("ADODB.Recordset") '소분류
	SQL = "select bidxsub,idxsub,idx,comname from tb_company where flag = '3' order by comname asc "
	rskind.Open sql, db, 1
	if not rskind.eof then
		simsiarray = rskind.GetRows
		simsiarrayint = ubound(simsiarray,2)
	else
		simsiarray = ""
		simsiarrayint = ""
	end if
	rskind.close
	set rskind=nothing

	totjanacount = bimsiarrayint+cimsiarrayint+simsiarrayint

%>

<script language=JavaScript>
// [x][0] =>classNo;
// [x][1] =>className;
// [x][3] =>Up classNo;
var rs_class = new Array();
var rs_cnt =0;

//대+중+소카운트
rs_cnt = '<%=totjanacount+3%>';


<%
	for j=0 to bimsiarrayint
%>
		rs_class[<%=j%>] = new Array();
		rs_class[<%=j%>][0] ="0-<%=bimsiarray(0,j)%>";
		rs_class[<%=j%>][1] ="<%=bimsiarray(1,j)%>";
		rs_class[<%=j%>][2] ="0";
<%
	next

	for j=0 to cimsiarrayint
%>
		rs_class[<%=j+(bimsiarrayint+1)%>] = new Array();
		rs_class[<%=j+(bimsiarrayint+1)%>][0] ="1-<%=cimsiarray(0,j)%><%=cimsiarray(1,j)%>";
		rs_class[<%=j+(bimsiarrayint+1)%>][1] ="<%=cimsiarray(2,j)%>";
		rs_class[<%=j+(bimsiarrayint+1)%>][2] ="0-<%=cimsiarray(0,j)%>";
<%
	next

	for j=0 to simsiarrayint
%>
		rs_class[<%=j+(bimsiarrayint+cimsiarrayint+2)%>] = new Array();
		rs_class[<%=j+(bimsiarrayint+cimsiarrayint+2)%>][0] ="2-<%=simsiarray(2,j)%>";
		rs_class[<%=j+(bimsiarrayint+cimsiarrayint+2)%>][1] ="<%=simsiarray(3,j)%>";
		rs_class[<%=j+(bimsiarrayint+cimsiarrayint+2)%>][2] ="1-<%=simsiarray(0,j)%><%=simsiarray(1,j)%>";
<%
	next
%>

function funcSetClass(strClass,lngLevel){
	if(lngLevel==1){
		var arrayClass = eval("document.kindform.sclass2");
	}else{
		var arrayClass = eval("document.kindform.tclass3");
	}
	arrayClass.options.length=1;
		
	if(lngLevel==1){
		arrayClass.options[0] = new Option("--지사(점)--","");
		document.kindform.tclass3.options.length=0;
		document.kindform.tclass3.options[0] = new Option("--체인점--","");
	}
	else arrayClass.options[0] = new Option("--체인점--","");
	
	var recall, tempClass;
	for(cnt =0,scnt=1 ; cnt < rs_cnt ; cnt++){
		if(rs_class[cnt][2]==strClass){
			arrayClass.options[scnt] = new Option(rs_class[cnt][1],rs_class[cnt][0]);			
			scnt++;
			if(scnt==1&&lngLevel==1){
				recall=true;
				tmpClass=rs_class[cnt][0];
			}
		}
	}

	if(recall) funcSetClass(tmpClass,2);

}

function funcSetfclass1(){
	var arrayClass = eval("document.kindform.fclass1");
	var arrayfclass1 = eval("document.kindform.sclass2");
	var arraysclass2 = eval("document.kindform.tclass3");

	arrayClass.options[0] = new Option("--본사--","");
	arrayfclass1.options[0] = new Option("--지사(점)--","");
	arraysclass2.options[0] = new Option("--체인점--","");

	for(cnt =0,scnt=1 ; cnt < rs_cnt ; cnt++){
		if(rs_class[cnt][2]=='0'){
			arrayClass.options[scnt] = new Option(rs_class[cnt][1],rs_class[cnt][0]);
			scnt++;
		}
	}
}

function funcSetClassSetting(fclass1,sclass2,tclass3){
	var arrayClass = document.kindform.fclass1;
	var arrayfclass1 = document.kindform.sclass2;
	var arraysclass2 = document.kindform.tclass3;
		
	arrayClass.value = fclass1;
	funcSetClass(fclass1,1);
	arrayfclass1.value = sclass2;
	funcSetClass(sclass2,2);
	arraysclass2.value = tclass3;
}
</script>

<select name=fclass1 onChange="funcSetClass(this.value,1)"></select>
<select name=sclass2 onChange="funcSetClass(this.value,2)"></select>
<select name=tclass3></select>

<%if idx = "" then%>
	<script language="JavaScript">funcSetfclass1();funcSetClassSetting('<%=fclass1%>','<%=sclass2%>','<%=tclass3%>')</script>
<%else%>
	<script language="JavaScript">funcSetfclass1();funcSetClassSetting('<%="0-"&left(imsiusercode,5)%>','<%="1-"&left(imsiusercode,10)%>','<%="2-"&right(imsiusercode,5)%>')</script>
<%end if%>
