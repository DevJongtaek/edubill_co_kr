<%
	set rsa = server.CreateObject("ADODB.Recordset") '--------대분류를 불러온다
	SQL = "select idx,comname from tb_company where flag='1' order by comname asc"
	rsa.Open sql, db, 1
	if not rsa.eof then
		barray = rsa.GetRows
		barrayint = ubound(barray,2)
	else
		barray = ""
		barrayint = ""
	end if
	rsa.close
	set rsa=nothing
%>

<script language="javascript">
<!--
txt_0  = new Array('지사(점)선택')
num_0 = new Array('0')

<%
for i=0 to barrayint
	set rsa = server.CreateObject("ADODB.Recordset") '--------중분류를 불러온다
	SQL = "select idx,comname from tb_company where flag='2' and bidxsub = "& barray(0,i) &" order by comname asc "
	rsa.Open sql, db, 1
	if not rsa.eof then
		sarray = rsa.GetRows
		sarrayint = ubound(sarray,2)
	else
		sarray = ""
		sarrayint = ""
	end if
	rsa.close
	set rsa=nothing
%>
 
txt_<%=barray(0,i)%> = new Array('지사(점)선택'<%if sarrayint<>"" then%><%for j=0 to sarrayint%>,'<%=sarray(1,j)%>'<%next%><%end if%>)
num_<%=barray(0,i)%> = new Array('0'<%if sarrayint<>"" then%><%for p=0 to sarrayint%>,'<%=sarray(0,p)%>'<%next%><%end if%>)

<%
next
%>

function Select_cate(form,v){
	var indx="0";
	var tmp = "";	
	form = document.form;	//폼이름
	sel  = form.secondsearch	//두번째조건
	val  = form.firstsearch.options[form.firstsearch.selectedIndex].value  ;

	title  = "txt_"+val
	title_val = "num_"+val

	list = eval(title);
	vallist = eval(title_val);

	for(i=sel.length-1;i>=0 ; i--)
	sel.options[i] = null;

	for(i=0; i< list.length ; i++){
	sel.options[i] = new Option(list[i],vallist[i]);

	if(sel.options[i].value==v){
	  indx = i ;
	}
		tmp  =tmp+" "+ v+"<<<<<< "+ sel.options[i].value;
	}

	sel.selectedIndex=indx ;
	//form2.jinaName.value=jinaName;
}


function Select_cateName(){
form = document.form;
servname = form.secondsearch.options[form.secondsearch.selectedIndex].text
form.Servername.value=servname
}

function submitform(form){
Select_cateName(form,'')
document.form.submit()
}

//선택된 값을 뿌려줌
function set_menu(){
	document.form.firstsearch.value='<%=imsibidxsub%>';
	Select_cate(document.form,'<%=imsiidxsub%>');
	}
//-->
</script>
