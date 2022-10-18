<%
	'--------------------------------------------------------------------------------------------------------------------
	'# ��¥���� �Լ�
	'# FunYMDHMS(dflag)	����Ͻú��� �������� �Լ�
	'#    			4:yyyy    6:yyyymm    8:yyyymmdd    10:yyyymmddhh    12:yyyymmddhhmm    14:yyyymmddhhmmss
	'# DateFormatReplace	20090605123541 -->> 2009-06-05 12:35:41
	'#    			psDate:����Ÿ	psDateflag:��¥���а�	psDategubun:1=��¥��ü 2=�ð���
	'# SelectDateChoice	����� �޺��ڽ�
	'#    			yearDa:�⵵��    monthDa:����    dayDa:�ϰ�    yvalD:�⵵�̸�    mvalD:���̸�    dvalD:���̸�
	'# alertURL	 �̵��� �ּ�
	'--------------------------------------------------------------------------------------------------------------------
	Function DateFormatReplace(psDate,psDateflag,psDategubun)
		if psDateflag="" then
			psDateflag = "-"
		end if
		if psDategubun="" then
			psDategubun = "1"
		end if

		if psDategubun="1" then
	        	if IsNull(psDate) OR Len(psDate)=0 then 
        	        	DateFormatReplace="" 
        		elseif Len(psDate)=6 then 
      	          		DateFormatReplace = Left(psDate,4) & psDateflag & Right(psDate,2) 
        		elseif Len(psDate)=8 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & Right(psDate,2) 
  			elseif Len(psDate)=12 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & mid(psDate,7,2) & " " & mid(psDate,9,2) & ":" & right(psDate,2) 
  			elseif Len(psDate)=14 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & mid(psDate,7,2) & " " & mid(psDate,9,2) & ":" & mid(psDate,11,2)  & ":" & mid(psDate,13,2)
			else 
	                	DateFormatReplace = psDate 
        		end if 
		else
	        	if IsNull(psDate) OR Len(psDate)=0 then 
        	        	DateFormatReplace="" 
        		elseif Len(psDate)=4 then 
                		DateFormatReplace = mid(psDate,1,2) & ":" & mid(psDate,3,2)
        		elseif Len(psDate)=6 then 
                		DateFormatReplace = mid(psDate,1,2) & ":" & mid(psDate,3,2) & ":" & mid(psDate,5,2)
			else 
	                	DateFormatReplace = psDate 
        		end if 
		end if
	End Function 
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")

	if searchg="" then searchg = "0"
	if searchc="" then searchc = "0"
	if searchd="" then searchd = replace(left(now()-90,10),"-","")
	if searche="" then searche = replace(left(now(),10),"-","")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if searchh="" then searchh = "a.tcode asc, a.Aym desc"
	orderby = searchh
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select a.*, b.comname, b.dcode,c.dname, d.comname as jisaname, b.accountflag, d.tcode as jtcode, e.iflag "
	sql = sql & " from  "

	SQL = sql & " 	(select seq,Aym,hname,umoney,tcode,jtcode,wdate,idx,iflag from tAccountM where idate='' and flag='1') e "
	sql = sql & " 	left outer join  "

	sql = sql & " 	( select wdate,tcode,jtcode,Aym,Aymd, "
	sql = sql & " 		sum(kmoney) as kmoney,sum(smoney) as smoney,sum(hmoney) as hmoney,idate,imoney "
	sql = sql & " 	  from tAccountM group by wdate,tcode,Aym,Aymd,idate,imoney,jtcode) a "

	SQL = sql & " on a.tcode = e.tcode and a.wdate=e.wdate and a.jtcode=e.jtcode and a.Aym = e.Aym "

	sql = sql & " 	left outer join  "
	sql = sql & " 	( select idx,comname,virtual_acnt2,tcode,dcode,accountflag from tb_company where flag='1' ) b "
	sql = sql & " 	on a.tcode = b.tcode "
	sql = sql & " 	left outer join ( select dname,dcode from tb_dealer ) c on c.dcode = b.dcode "
	sql = sql & " 	left outer join  "
	sql = sql & " 	( select comname,tcode,bidxsub from tb_company where flag='2' ) d "
	sql = sql & " 	on a.jtcode = d.tcode and d.bidxsub = b.idx "

	SQL = sql & " where a.Aymd >= '"& searchd &"' and a.Aymd <= '"& searche &"' "
	if searchf="y" then SQL = sql & " and a.idate <> '' and a.imoney > 0 "
	if searchf="n" then SQL = sql & " and a.idate = '' and a.imoney = 0 "
	if searcha<>"" and searchb<>"" then SQL = sql & " and "& searcha &" like '%"& searchb &"%' "
	SQL = sql & " order by " & orderby

	rslist.Open sql, db, 1
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<script language="JavaScript">
<!--
function onlyNumber(){
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}
function posorderwin(){
	window.open ('posDatatorder.asp','dssdsd','width=300,height=180,left=100,top=100');
	return false ;
}

//���� �ܾ� �˻� ����
function nottxtfield(word) {
var NotWord = ",";
var SP = NotWord.split('|');
	for(var i=0; i<SP.length; i++)
	{
        	var NotStr = word.indexOf(SP[i], 0);
        	if( NotStr >= 0 )
        	{
                	alert(SP[i]+' �޸��� ���� ��� ���� ������.');
			//word = "";
                	return;
        	}
	}
}
//�����ܾ� �˻� ��

function allsavechb(){
	form1.action = "cyberNumSave.asp";
	form1.submit();
	return false ;
}

function allsavechb2(){
	form1.target = "ifrm";
	form1.method = "post";
	form1.action = "TcyberNumSaveIframe.asp";
	form1.submit();
	return false ;
}

function allsavechb3(){
	form1.target = "ifrm";
	form1.method = "post";
	form1.action = "TcyberNumSaveIframeCancle.asp";
	form1.submit();
	return false ;
}
function kindsearchok2(form) {
	form.submit() ;
}

function frmzerocheck(form,url) {
	location.href = url;
}
//-->
</script>




<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=form1>
<input type=hidden name=pagegubun value=3>

	<tr>
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>�Ա�����<BR> &nbsp;<B>�Ա����� �˻�</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="����" value="����" class="box_work"' onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);"> ��)20040928 ~ 20041004
			<BR>
			<select name="searchh" size="1" class="box_work">
	          		<option value=""                          <%if searchh="" then%>selected<%end if%>>����Ʈ����
	          		<option value="a.tcode asc, a.Aym desc"   <%if searchh="a.tcode asc, a.Aym desc" then%>selected<%end if%>>ȸ�����ڵ�
	          		<option value="b.comname asc, a.Aym desc" <%if searchh="b.comname asc, a.Aym desc" then%>selected<%end if%>>ȸ�����
	          		<option value="c.dname asc, a.Aym desc"   <%if searchh="c.dname asc, a.Aym desc" then%>selected<%end if%>>�����
	          		<option value="a.Aym asc, a.tcode asc"   <%if searchh="a.Aym asc, a.tcode asc" then%>selected<%end if%>>û�����
	          		<option value="a.idate asc, a.tcode asc, a.Aym desc" <%if searchh="a.idate asc, a.tcode asc, a.Aym desc" then%>selected<%end if%>>�Ա�����
        		</select>
			<select name="searchf" size="1" class="box_work">
	          		<option value=""  <%if searchf=""  then%>selected<%end if%>>�Ա���ü
	          		<option value="y" <%if searchf="y" then%>selected<%end if%>>�Ա�Ȯ��
	          		<option value="n" <%if searchf="n" then%>selected<%end if%>>�Աݹ�Ȯ��
	          		<!--<option value="i" <%if searchf="i" then%>selected<%end if%>>�Աݾ׿���-->
        		</select>
			<select name="searcha" size="1" class="box_work">
	          		<option value="" <%if searcha="" then%>selected<%end if%>>�˻�����
	          		<option value="a.tcode"   <%if searcha="a.tcode" then%>selected<%end if%>>ȸ�����ڵ�
	          		<option value="b.comname" <%if searcha="b.comname" then%>selected<%end if%>>ȸ�����
	          		<option value="c.dname"   <%if searcha="c.dname" then%>selected<%end if%>>�����
	          		<option value="a.Aym"     <%if searcha="a.Aym" then%>selected<%end if%>>û�����
	          		<option value="a.idate"   <%if searcha="a.idate" then%>selected<%end if%>>�Ա�����
        		</select>
			<input type="Text" name="searchb" size="20" maxlength="20" class="box_work" value="<%=searchb%>" onkeypress="if(event.keyCode==13){kindsearchok2(this.form);}">
	        	<input type="button" name="�� ��" value="�� �� "  class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work"' onclick="javascript:frmzerocheck(this.form,'list.asp?pagegubun=3');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form name=form1 method=post>
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type=hidden name=searchc value="<%=searchc%>">
<input type=hidden name=searchd value="<%=searchd%>">
<input type=hidden name=searche value="<%=searche%>">
<input type=hidden name=searchf value="<%=searchf%>">
<input type=hidden name=searchg value="<%=searchg%>">
<input type=hidden name=gotopage value="<%=gotopage%>">

	<tr height=30 valign=bottom>
		<td width=70%>* ��ü <B><%=rslist.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.</td>
		<td width=30% align=right>
			<!--<input type=button value="�Ա�Ȯ��" onclick="return allsavechb2()">
			<input type=button value="�Ա����" onclick="return allsavechb3()">-->
			<a href="Tcexcell.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchf=<%=searchf%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>"><img src="/images/admin/excel.gif" border=0></a>
		</td>
	</tr>
</table>


<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=4%>��ȣ</td>
		<td width=6%>�ڵ�</td>
		<td width=26%>ȸ����</td>
		<td width=8%>�����</td>
		<td width=6%>���</td>
		<td width=9%>�ݾ�</td>
		<td width=8%>�ΰ���</td>
		<td width=9%>�հ�ݾ�</td>
		<td width=10%>�Ա�����</td>
		<td width=10%>�Աݾ�</td>
		<td width=4%>���</td>
	</tr>

<%
i=1
hkmoney  = 0
hsmoney  = 0
hhmoney  = 0
hdep_amt = 0
do until rslist.EOF
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'tcode,Aym,kmoney,smoney,hmoney,idate,imoney
	imsidt   = rslist("idate")
	dep_amt  = rslist("imoney")
	Aym      = rslist("Aym")
	jisaname = rslist("jisaname")
	kmoney   = rslist("kmoney")
	smoney   = rslist("smoney")
	hmoney   = rslist("hmoney")
	accountflag = rslist("accountflag")
	if accountflag <> "y" then smoney = 0
	if accountflag <> "y" then hmoney = kmoney
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	hkmoney  = hkmoney + kmoney
	hsmoney  = hsmoney + smoney
	hhmoney  = hhmoney + hmoney
	hdep_amt = hdep_amt + dep_amt
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	kmoney   = formatnumber(kmoney,0)
	smoney   = formatnumber(smoney,0)
	hmoney   = formatnumber(hmoney,0)
	if imsidt  <>""  then imsidt  = DateFormatReplace(imsidt,"/","1")
	if dep_amt <> "" then dep_amt = formatnumber(dep_amt,0)
	if isnull(jisaname) then jisaname=""
	Aym = mid(Aym,3,2) &"/"& mid(Aym,5,2)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td><%if rslist("jtcode")<>"" then%><%=rslist("jtcode")%><%else%><%=rslist("tcode")%><%end if%></td>
		<td align=left>&nbsp;<%=rslist("comname")%><%if jisaname<>"" then%><font color=red>(<%=jisaname%>)<%end if%></td>
		<td><%=rslist("dname")%></td>
		<td><%=Aym%></td>
		<td align=right><%=kmoney%>&nbsp;</td>
		<td align=right><%=smoney%>&nbsp;</td>
		<td align=right><%=hmoney%>&nbsp;</td>
		<%if imsidt<>"" then%>
			<%imsival2 = rslist("wdate") &"/"& rslist("tcode") &"/"& rslist("jtcode") &"/"& rslist("Aym") &"/"& rslist("Aymd") &"/"& rslist("hmoney")%>
			<td><%=imsidt%></td>
			<td align=right><%=dep_amt%>&nbsp;</td>
			<td><%if rslist("iflag")<>"y" then%><input type=checkbox name=cancleidx value="<%=imsival2%>"><%end if%></td>
		<%else%>
			<%imsival = rslist("wdate") &"/"& rslist("tcode") &"/"& rslist("jtcode") &"/"& rslist("Aym") &"/"& rslist("Aymd") &"/"& rslist("hmoney")%>
			<input type=hidden name=inkey value="<%=imsival%>">
			<td><input type=text name=inymd maxlength=8 size=8 onkeypress="onlyNumber()"></td>
			<td><input type=text name=inmoney style="width:100%" onkeypress="onlyNumber()"></td>
			<td></td>
		<%end if%>
	</tr>

<%
rslist.MoveNext 
i=i+1
loop
%>


	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td colspan=5>�� ��</td>
		<td align=right><%=formatnumber(hkmoney,0)%>&nbsp;</td>
		<td align=right><%=formatnumber(hsmoney,0)%>&nbsp;</td>
		<td align=right><%=formatnumber(hhmoney,0)%>&nbsp;</td>
		<td></td>
		<td align=right><%=formatnumber(hdep_amt,0)%>&nbsp;</td>
		<td></td>
	</tr>

</table>




<%
	rslist.close
	'db.close
	set rs=nothing
	set rslist=nothing
	'set db=nothing
%>