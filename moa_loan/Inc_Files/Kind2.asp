<%
	set rsa = server.CreateObject("ADODB.Recordset") '--------지사를 불러온다
	SQL = "select idx,Name from tb_Area order by Seq asc"
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
    txt_0  = new Array('소속지사전체')
    num_0 = new Array('0')

    <%
    if barrayint<>"" then
    for i=0 to barrayint
        set rsa = server.CreateObject("ADODB.Recordset") '--------중분류를 불러온다
        SQL = "select idx,Name from tb_Branch where AreaIdx = "& barray(0,i) &" order by Seq asc "
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
 
    txt_<%=barray(0,i)%> = new Array('소속지사선택'<%if sarrayint<>"" then%><%for j=0 to sarrayint%>,'<%=replace(sarray(1,j),"'","")%>'<%next%><%end if%>)
    num_<%=barray(0,i)%> = new Array('0'<%if sarrayint<>"" then%><%for p=0 to sarrayint%>,'<%=sarray(0,p)%>'<%next%><%end if%>)

    <%
    next
    end if
    %>

    function Select_cate(form,v){
        var indx="0";
        var tmp = "";	
        form = document.form;	//폼이름
        sel  = form.searchf	//두번째조건
        val  = form.searchc.options[form.searchc.selectedIndex].value  ;

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

       

    }


    function Select_cateName(){
    form = document.form;
    servname = form.searchf.options[form.searchf.selectedIndex].text
    form.Servername.value=servname
    }

        function submitform(form){
            Select_cateName(form,'')
            document.form.submit()
        }

    //선택된 값을 뿌려줌
    function set_menu(){
        //  document.form.searchc.value='<%=searchc%>';
        document.form.searchc.value=<%=Area%>;
        Select_cate(document.form,'<%=searchf%>');
        document.form.searchf.value=<%=Branch%>;
    }
    //-->
</script>
