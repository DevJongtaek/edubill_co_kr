<script language="JavaScript">
<!--
    function checkval(val1,val2,val3){
        tmp = val2;
        if (tmp.length < 4) {
            alert("ȸ�����ڵ�� ���� 4���� �Դϴ�!!") ;
            return false ;
        }
        window.open ('/adminpage/jdregok2.asp?val='+val2+'&gubun='+val3,'CheckID','width=0,height=0,top=30000,left=30000')
        return false ;
    }

    function checkid(fm,fmvalue){
        tmp = fmvalue;
        window.open ('AjaxAllSave.asp?idx='+fm+'&virtual_acnt_bank='+tmp,'CheckID22','width=0,height=0,top=30000,left=30000')
        return false ;
    }

    function filechb(){
        tmp = form.fileflag.value;
        if (tmp=="a"){
            form.fileflagchb[0].disabled = false;
            form.fileflagchb[1].disabled = false;
        }else{
            form.fileflagchb[0].disabled = true;
            form.fileflagchb[1].disabled = true;
        }
    }

    function chbradio(){
        if (form.cyberNum[0].checked == true){	//������� ��� : ���Ѵ�-�Աݳ��� ��ȸ : �ٵ�� �Աݳ���
            form.ipConFlag[0].checked = true;
            form.ipConFlag[1].checked = false;
        }
        if (form.cyberNum[1].checked == true){	//������� ��� : �Ѵ�-�Աݳ��� ��ȸ : ������� �Աݳ���
            form.ipConFlag[0].checked = false;
            form.ipConFlag[1].checked = true;
        }
    }

    function smsflagChb(){
        if (form.smsflag[0].checked == true){
            form.smsflagType.disabled = true;
        }
        if (form.smsflag[1].checked == true){
            form.smsflagType.disabled = false;
        }
    }

    function selSeeChb(){
        if (form.proflag2[0].checked == true){
            form.proflag2Pgubun.disabled = false;
        }
        if (form.proflag2[1].checked == true){
            form.proflag2Pgubun.disabled = true;
        }
    }

    function ifrmOk(val){
        if (val=="") {
            alert("�˻��Ϸ��� ȸ�����ڵ� 4�ڸ� ������ �ּ���.") ;
            return false ;
        }
        var stxt = "inc/tCodeSearch.asp?tcode="+val;
        document.ifrm.location.href=stxt;
    }

    function ifrmSel(){
        if (form.ch_tcode2.value=="") {
            alert("ȸ�����ڵ带 �����Ŀ� Ŭ�����ּ���.") ;
            form.ch_tcode2.focus() ;
            return false ;
        }
        form.tcode.value=form.ch_tcode2.value;
    }

    //-->
</script>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><b>[ ȸ���� ��� ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
<iframe name="ifrm" frameborder="0" style="width:0px;height:0px;" src=""></iframe>
<form action="writeok.asp" name=form method=post onsubmit="return comwrite1();">
<input type=hidden name=flag value="<%=flag%>">
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type="hidden" name="searcha" value="<%=searcha%>">
<input type="hidden" name="searchb" value="<%=searchb%>">
<input type="hidden" name="searchc" value="<%=searchc%>">
<input type="hidden" name="searchd" value="<%=searchd%>">
<input type="hidden" name="searche" value="<%=searche%>">
<input type="hidden" name="searchf" value="<%=searchf%>">
<input type="hidden" name="searchg" value="<%=searchg%>">
<input type="hidden" name="dflag">

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td colspan=2>&nbsp;<font color=red><B>[ �Ϲݻ��� ]</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>ȸ�����ڵ�&nbsp;</td>
		<td width=80% bgcolor=white>
			<input type="text" name="tcode" maxlength="4" size=4 OnKeypress="onlyNumber();" class="box_write" value="<%=imsitcode%>" <%if idx <> "" then%>readonly<%end if%>>
			<%if idx="" then%>
				<a href="#" onClick="return checkval(form,form.tcode.value,1)"><img src="/images/admin/member_01.gif" border=0></a>
				* ���� 4�ڸ�
				&nbsp;&nbsp;
				<input type="text" name="ch_tcode1" maxlength="4" size=4 OnKeypress="onlyNumber();">
				<input type="button" name="btn_tcode1" value="���İ˻�" onclick="ifrmOk(form.ch_tcode1.value);">
				<select name=ch_tcode2></select>
				<input type="button" name="btn_tcode2" value="����" onclick="ifrmSel();">
			<%end if%>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=right><font color=red>*</font><B>ȸ���&nbsp;</td>
		<td width=80% bgcolor=white><input type="text" name="comname" maxlength="30" size=20 class="box_write" value="<%=imsicomname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>��ǥ��&nbsp;</td>
		<td bgcolor=white><input type="text" name="name" maxlength="20" style="width:100;" class="box_write" value="<%=imsiname%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�ֹ�(����)��Ϲ�ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="juminno1" maxlength="6" size=6 class="box_write" value="<%=imsijuminno1%>">
-
<input type="text" name="juminno2" maxlength="7" size=6 class="box_write" value="<%=imsijuminno2%>">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>����ڵ�Ϲ�ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" class="box_write" name="companynum1" maxlength="3" size=3 value="<%=imsicompanynum1%>" OnKeypress="onlyNumber();">
-
<input type="text" class="box_write" name="companynum2" maxlength="2" size=2 value="<%=imsicompanynum2%>" OnKeypress="onlyNumber();">
-
<input type="text" class="box_write" name="companynum3" maxlength="5" size=5 value="<%=imsicompanynum3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>������ȣ&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:45;" name="m_post1" id="m_post1" maxlength=3 OnKeypress="onlyNumber();" value="<%=imsipost1%>">
			- 
			<input type="text" class="box_write" style="width:45;" name="m_post2" id="m_post2" maxlength=3 OnKeypress="onlyNumber();" value="<%=imsipost2%>"> 
			<a href="#" onclick="javascript:AutoAddr('1')"><img src="/images/member_02.gif" hspace="5" align="absmiddle" border=0></a>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�ּ�&nbsp;</td>
		<td bgcolor=white>
			<input type="text" class="box_write" style="width:300;" name="m_addr1" id="m_addr1" value="<%=imsiaddr%>"> 
                	<br> 
			<input type="text" class="box_write" style="width:300;" name="m_addr2" id="m_addr2" value="<%=imsiaddr2%>"> 
			������ �ּ� 
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>����&nbsp;</td>
		<td bgcolor=white><input type="text" name="uptae" maxlength="20" style="width:200;" class="box_write" value="<%=imsiuptae%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>����&nbsp;</td>
		<td bgcolor=white><input type="text" name="upjong" maxlength="20" style="width:200;" class="box_write" value="<%=imsiupjong%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B><font color="blue">ü�κ����ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="tel1" maxlength="3" size=3 class="box_write" value="<%=imsitel1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel2" maxlength="4" size=4 class="box_write" value="<%=imsitel2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="tel3" maxlength="4" size=4 class="box_write" value="<%=imsitel3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B><font color="blue">�������͹�ȣ&nbsp;</td>
		<td bgcolor=white>
<input type="text" name="fax1" maxlength="3" size=3 class="box_write" value="<%=imsifax1%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax2" maxlength="4" size=4 class="box_write" value="<%=imsifax2%>" OnKeypress="onlyNumber();">
-
<input type="text" name="fax3" maxlength="4" size=4 class="box_write" value="<%=imsifax3%>" OnKeypress="onlyNumber();">
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>e-�����ּ�&nbsp;</td>
		<td bgcolor=white><input type="text" name="homepage" maxlength="100" style="width:400;" class="box_write" value="<%=imsihomepage%>"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ֹ��ڵ�Ȯ��&nbsp;</td>
		<td bgcolor=white><input type="checkbox" name="orderreg" value="y" <%if imsiorderreg="y" then%>checked<%end if%> disabled>Yes</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�������&nbsp;</td>
		<td bgcolor=white>
			����� : <input type="text" name="virtual_acnt2_bank" value="<%=imsivirtual_acnt2_bank%>" size=10>����
			&nbsp;&nbsp;
			���¹�ȣ<input type="text" name="virtual_acnt2" value="<%=imsivirtual_acnt2%>" size=20>
		</td>
	</tr>
    <tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�Աݰ���&nbsp;</td>
		<td bgcolor=white>
			����� : <input type="text" name="virtual_acnt3_bank" value="<%=imsivirtual_acnt3_bank%>" size=10>����
			&nbsp;&nbsp;
			���¹�ȣ<input type="text" name="virtual_acnt3" value="<%=imsivirtual_acnt3%>" size=20>
            &nbsp;&nbsp;
            ������<input type="text" name="virtual_name3" value="<%=imsivirtual_name3%>" size=20>
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td colspan=2>&nbsp;<font color=red><B>[ ȯ�漳�� ]</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>���ݰ�꼭 ����&nbsp;</td>
		<td bgcolor=white>
<input type="radio" name="accountflag" value="n" <%if imsiaccountflag="n" then%>checked<%end if%>>���Ѵ�
<input type="radio" name="accountflag" value="y" <%if imsiaccountflag="y" or imsiaccountflag="" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�ΰ���&nbsp;</td>
		<td bgcolor=white>
<input type="radio" name="vatflag" value="y" <%if imsivatflag="y" or imsivatflag="" then%>checked<%end if%>>����
<input type="radio" name="vatflag" value="n" <%if imsivatflag="n" then%>checked<%end if%>>����
<input type="radio" name="vatflag" value="a" <%if imsivatflag="a" then%>checked<%end if%>>�����
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>���ݰ�꼭 �׸�&nbsp;</td>
		<td bgcolor=white><input type="text" name="taxtitle" class="box_write" value="<%=imsitaxtitle%>" size=20></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�̿�ᳳ����&nbsp;</td>
		<td bgcolor=white>
<input type="radio" name="usegubun" value="1" <%if imsiusegubun="1" or imsiusegubun="" then%>checked<%end if%>>ȸ����
<input type="radio" name="usegubun" value="2" <%if imsiusegubun="2" then%>checked<%end if%>>ü����
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><font color=red>*</font><B>�̿�� �ݾ�&nbsp;</td>
		<td bgcolor=white><input type="text" name="usemoney" class="box_write" value="<%=imsiusemoney%>" size=10 maxlength="8" OnKeypress="onlyNumber();"></td>
	</tr>

<!--
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>ȸ����� ����ȭ��&nbsp;</td>
		<td bgcolor=white><input type="text" name="soundfile" class="box_write" value="<%=imsisoundfile%>" size=15></td>
	</tr>
-->

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�����&nbsp;</td>
		<td bgcolor=white>
			<select name=dcode>
				<option value="">����
				<%do until rs2.eof%>
					<option value="<%=rs2("dcode")%>" <%if rs2("dcode")=imsidcode then%>selected<%end if%>><%=rs2("dname")%>
				<%rs2.movenext%>
				<%loop%>
				<%rs2.close%>
			</select>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>���� ���α׷�&nbsp;</td>
		<td bgcolor=white><input type="text" name="adminProgram" class="box_write" value="<%=imsiadminProgram%>" size=20></td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>ȭ�ϻ�������&nbsp;</td>
		<td bgcolor=white>
			<input type=radio name="fileflaglevel" value="1" <%if imsifileflaglevel="" or imsifileflaglevel ="1" then%>checked<%end if%>>����
			<input type=radio name="fileflaglevel" value="2" <%if imsifileflaglevel ="2" then%>checked<%end if%>>����
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>ȭ�ϻ�������&nbsp;</td>
		<td bgcolor=white>
			<select name=fileflag onchange="filechb()">
				<option value="0" <%if imsifileflag="0" then%>selected<%end if%>>������
				<option value="1" <%if imsifileflag="1" or imsifileflag="" then%>selected<%end if%>>Text 1 (����� ����)
				<option value="2" <%if imsifileflag="2" then%>selected<%end if%>>Text 2 (CJ ����, �ֹ�����)
				<option value="3" <%if imsifileflag="3" then%>selected<%end if%>>Text 3 (CJ ����, �������/Ȯ�ΰ�)
				<option value="7" <%if imsifileflag="7" then%>selected<%end if%>>Text 4 (����� ����, �ֹ�Ȯ�ΰǸ�)
				<option value="8" <%if imsifileflag="8" then%>selected<%end if%>>Text 5 (����� ����, ��޿�û����)
				<option value="9" <%if imsifileflag="9" then%>selected<%end if%>>Text 6 (CJ ����, ��޿�û����)
				<option value="a" <%if imsifileflag="a" then%>selected<%end if%>>Text 7 (����� ����, ȭ�ϻ����ڵ�)
				<option value="b" <%if imsifileflag="b" then%>selected<%end if%>>Text 8 (�ֹ��� �Աݾ� �񱳻��� )
				<option value="c" <%if imsifileflag="c" then%>selected<%end if%>>Text 9 (����� ����,��Ʈ�޴�����)
				<option value="4" <%if imsifileflag="4" then%>selected<%end if%>>Excel 1 (ȭ�ϻ����ڵ�, ȣ���߰�)
				<option value="5" <%if imsifileflag="5" then%>selected<%end if%>>Excel 2
				<option value="6" <%if imsifileflag="6" then%>selected<%end if%>>Excel 3
                <option value="d" <%if imsifileflag="d" then%>selected<%end if%>>Excel 4 (ȭ�ϻ����ڵ�, ȣ���߰�,�ֹ�Ȯ�ΰ�)
                <option value="e" <%if imsifileflag="e" then%>selected<%end if%>>Excel 5 (CJ ����, �������/Ȯ�ΰ�)
			</select>
			ȭ�ϻ����ڵ� �ߺ�üũ : 
			<input type=radio name=fileflagchb value="y" <%if imsifileflag<>"a" or idx="" then%>disabled<%end if%> <%if imsifileflagchb="y" or imsifileflagchb="" then%> checked<%end if%>>�Ѵ�
			<input type=radio name=fileflagchb value="n" <%if imsifileflag="a" then%><%else%>disabled<%end if%> <%if imsifileflagchb="n" then%> checked<%end if%>>���Ѵ�

		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>������ �����ֱ�&nbsp;</td>
		<td bgcolor=white>
			<select name=datadel>
				<option value="1" <%if imsidatadel="1" then%>selected<%end if%>>���ñ��� 1���� ���� �����ͻ���
				<option value="2" <%if imsidatadel="2" or imsidatadel="" then%>selected<%end if%>>���ñ��� 2���� ���� �����ͻ���
				<option value="3" <%if imsidatadel="3" then%>selected<%end if%>>���ñ��� 3���� ���� �����ͻ���
				<option value="4" <%if imsidatadel="4" then%>selected<%end if%>>���ñ��� 1���� ���� �����ͻ���
				<option value="5" <%if imsidatadel="5" then%>selected<%end if%>>���ñ��� 2���� ���� �����ͻ���
			</select>
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��뿩��&nbsp;</td>
		<td bgcolor=white><input type="radio" name="hclose" value="y" <%if imsihclose="y" or imsihclose="" then%>checked<%end if%>>����� <input type="radio" name="hclose" value="n" <%if imsihclose="n" then%>checked<%end if%>>�������</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ݾ�����&nbsp;</td>
		<td bgcolor=white><input type="radio" name="mregflag" value="n" <%if imsimregflag="n" or imsimregflag="" then%>checked<%end if%>>���Ѵ� <input type="radio" name="mregflag" value="y" <%if imsimregflag="y" then%>checked<%end if%>>�Ѵ�</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��޿�û����&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="d_requestday" value="n" <%if imsid_requestday="n" or imsid_requestday="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="d_requestday" value="y" <%if imsid_requestday="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��������ǥ���&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="maechulflag" value="n" <%if imsimaechulflag="n" or imsimaechulflag="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="maechulflag" value="y" <%if imsimaechulflag="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�̼���üũ&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="myflag" value="n" <%if imsimyflag="n" or imsimaechulflag="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="myflag" value="y" <%if imsimyflag="y" then%>checked<%end if%>>�Ѵ�
			<select name="myflag_select">
				<option value="1" <%if imsimyflag_select="1" then%>selected<%end if%>>�ܿ����Ÿ� üũ
				<option value="2" <%if imsimyflag_select="2" then%>selected<%end if%>>�ܿ����Ű� �ֹ��ݾ� üũ               
                <!--<option value="3" <%if imsimyflag_select="3" then%>selected<%end if%>>���� �ֹ����� ������ �߰� �ֹ�-->
                <option value="4" <%if imsimyflag_select="4" then%>selected<%end if%>>�ֹ� ��, �̼��ʰ� �ֹ����
			</select>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>ü�κ��� ����&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="myflagauth" value="n" <%if imsimyflagauth="n" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="myflagauth" value="y" <%if imsimyflagauth="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>ü��������2 üũ&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="agencycheck2" value="n" <%if imsiagencycheck2="n" or imsiagencycheck2="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="agencycheck2" value="y" <%if imsiagencycheck2="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ٿ�ε� ����ǥ&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="djflag" value="n" <%if imsidjflag="n" or imsidjflag="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="djflag" value="y" <%if imsidjflag="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>SMS ������&nbsp;</td>
		<td bgcolor=white>
			�ֹ�Ȯ�� : <input type="radio" name="smsflag" value="n" onclick="smsflagChb('1')" <%if imsismsflag="n" or imsismsflag="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="smsflag" value="y" onclick="smsflagChb('2')" <%if imsismsflag="y" then%>checked<%end if%>>�Ѵ�
			<select name=smsflagType <%if idx<>"" and imsismsflag="y" then%><%else%>disabled<%end if%>>
				<option value="A" <%if imsismsflagType="A" then response.write "selected"%>>A Type
				<option value="B" <%if imsismsflagType="B" then response.write "selected"%>>B Type
				<option value="C" <%if imsismsflagType="C" then response.write "selected"%>>C Type
                <option value="D" <%if imsismsflagType="D" then response.write "selected"%>>D Type
			</select>
			&nbsp;&nbsp;&nbsp;&nbsp;<span>ü���� ���� : </span><input type="radio" name="sms_send" value="n" <%if imsisms_send="n" or imsisms_send="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="sms_send" value="y" <%if imsisms_send="y" then%>checked<%end if%>>�Ѵ�		</td>
		
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�� �ֹ�����&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="miorderflag" value="n" <%if imsimiorderflag="n" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="miorderflag" value="y" <%if imsimiorderflag="y" or imsimiorderflag="" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>
    <tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�����̼��� �μ�&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="premisuprint" value="n" <%if imsipremisuprint="n" or imsipremisuprint="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="premisuprint" value="y" <%if imsipremisuprint="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>����̼��� �μ�&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="misuprint" value="n" <%if imsimisuprint="n" or imsimisuprint="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="misuprint" value="y" <%if imsimisuprint="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>���� ����������&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="jsusu" value="n" <%if imsijsusu="n" or imsijsusu="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="jsusu" value="y" <%if imsijsusu="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>������� �ڵ�Ȯ��&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="kbnumAreg" value="n" <%if imsikbnumAreg="n" or imsikbnumAreg="" then%>checked<%end if%>>���Ѵ� 
			<input type="radio" name="kbnumAreg" value="y" <%if imsikbnumAreg="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>



	<!--<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�̼��ݹ�ư���̱�&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="misubtn" value="n" <%if imsimisubtn="n" or imsimisubtn="" then%>checked<%end if%>>���Ѵ�
			<input type="radio" name="misubtn" value="y" <%if imsimisubtn="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>-->

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>������� ���&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="cyberNum" value="n" <%if imsicyberNum="n" or imsicyberNum="" then%>checked<%end if%> onclick="cporg_cd_no();chbradio();">���Ѵ�
			<input type="radio" name="cyberNum" value="y" <%if imsicyberNum="y" then%>checked<%end if%> onclick="cporg_cd_ok();chbradio();">�Ѵ�
			����ڵ� : <input type="text" size=14 name="cporg_cd" value="<%=imsicporg_cd%>" <%if imsicyberNum="n" or imsicyberNum="" then%>disabled<%end if%>>
			&nbsp;
			����� : <input type="text" size=8 name="virtual_acnt_bank" value="<%=imsivirtual_acnt_bank%>" <%if imsicyberNum="n" or imsicyberNum="" then%>disabled<%end if%>>����
			<input type=button name=vabtn value="�������" onclick="checkid(<%=idx%>,form.virtual_acnt_bank.value);" <%if imsicyberNum="n" or imsicyberNum="" then%>disabled<%end if%>>
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�Աݳ��� ��ȸ&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="ipConFlag" value="1" <%if imsiipConFlag="1" or imsiipConFlag="" then%>checked<%end if%>>�ٵ�� �Աݳ���
			<input type="radio" name="ipConFlag" value="2" <%if imsiipConFlag="2" then%>checked<%end if%>>������� �Աݳ���
            <input type="radio" name="ipConFlag" value="3" <%if imsiipConFlag="3" then%>checked<%end if%>>�ٵ�� ����ó����
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>����/�ѽ� ����&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="rec_fax" value="n" <%if imsirec_fax="n" or imsirec_fax="" then%>checked<%end if%>>���Ѵ�
			<input type="radio" name="rec_fax" value="y" <%if imsirec_fax="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>

	<input type="hidden" name="noteflag" value="y">
	<!--<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>����/���� ����&nbsp;</td>
		<td bgcolor=white>
		</td>
	</tr>-->

<%if idx<>"" then%>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�귣��&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="brandflag" value="n" <%if imsibrandflag="n" or imsibrandflag="" then%>checked<%end if%> onclick="brandcheck_no();">�ش� ����
			<input type="radio" name="brandflag" value="y" <%if imsibrandflag="y" then%>checked<%end if%> onclick="brandcheck_ok();">�ش� ����
			<input type=button name=btnbrand value="�귣�庸��" onclick="javascript:bwinopenXY('bwrite.asp?idx=<%=idx%>', 'domain', 500, 500)" <%if imsibrandflag="n" or imsibrandflag="" then%>disabled<%end if%>> 
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��������&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="dcenterflag" value="n" <%if imsidcenterflag="n" or imsidcenterflag="" then%>checked<%end if%> onclick="dcentercheck_no();">�ش� ����
			<input type="radio" name="dcenterflag" value="y" <%if imsidcenterflag="y" then%>checked<%end if%> onclick="dcentercheck_ok();">�ش� ����
			<input type=button name=btndcenter value="�������ͺ���" onclick="javascript:bwinopenXY('dwrite.asp?idx=<%=idx%>', 'domain', 500, 500)" <%if imsidcenterflag="n" or imsidcenterflag="" then%>disabled<%end if%>> 
		</td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�޴�ȭ�� ����&nbsp;</td>
		<td bgcolor=white>
			<select name="proflag1" onchange="proflag1chk();">
				<option value="1" <%if imsiproflag1="1" then%>selected<%end if%>>�޴�1(�ؽ�Ʈ 2��)
				<option value="2" <%if imsiproflag1="2" then%>selected<%end if%>>�޴�2(����޴� ����)
			</select>
			<input type=button name=btnpro value="����Ŵ�����" onclick="javascript:bwinopenXY('swrite.asp?idx=<%=idx%>', 'domain', 500, 500)" <%if imsiproflag1="1" then%>disabled<%end if%>> 
			&nbsp;&nbsp;
			��ǰ��������
			<input type="radio" name="proflag2" value="1" onclick="selSeeChb()" <%if imsiproflag2="1" then%>checked<%end if%>>�Ѵ�
			<input type="radio" name="proflag2" value="2" onclick="selSeeChb()" <%if imsiproflag2="2" or imsiproflag2="" then%>checked<%end if%>>���Ѵ�
			<select name=proflag2Pgubun <%if imsiproflag2="2" or imsiproflag2="" then%>disabled<%end if%>>
				<option value="1" <%if imsiproflag2Pgubun = "1" then response.write "selected"%>>������
				<option value="2" <%if imsiproflag2Pgubun = "2" then response.write "selected"%>>��������
			</select>
		</td>
	</tr>
<%end if%>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>���� ����&nbsp;</td>
		<td bgcolor=white>
			<select name="serviceflag">
				<option value="1" <%if imsiserviceflag="1" then%>selected<%end if%>>���
				<option value="2" <%if imsiserviceflag="2" then%>selected<%end if%>>����
				<option value="3" <%if imsiserviceflag="3" then%>selected<%end if%>>����
				<option value="4" <%if imsiserviceflag="4" then%>selected<%end if%>>����
				<option value="5" <%if imsiserviceflag="5" then%>selected<%end if%>>�̰�
			</select>
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>����� ���� ��&nbsp;</td>
		<td bgcolor=white>
			�ֹ� ������ : <input type="radio" name="conSeeflag" value="y" <%if imsiconSeeflag="y" or imsiconSeeflag="" then%>checked<%end if%>>���δ�
			<input type="radio" name="conSeeflag" value="n" <%if imsiconSeeflag="n" then%>checked<%end if%>>�Ⱥ��δ�
			&nbsp;&nbsp;&nbsp;&nbsp; 
			�����ʰ� : <input type="radio" name="yesin_memo" value="y" <%if imsiyesin_memo="y" or imsiyesin_memo="" then%>checked<%end if%>>���δ�
			<input type="radio" name="yesin_memo" value="n" <%if imsiyesin_memo="n" then%>checked<%end if%>>�Ⱥ��δ�
		</td>
	</tr>
	
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��ǰ ���� �ֹ�&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="productorderweek" value="n" <%if imsiproductorderweek="n" or imsiproductorderweek="" then%>checked<%end if%>>���Ѵ�		
			<input type="radio" name="productorderweek" value="y" <%if imsiproductorderweek="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ֹ� �ð� �˻�&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="searchordertime" value="n" <%if imsisearchordertime="n" or imsisearchordertime="" then%>checked<%end if%>>���Ѵ�	
			<input type="radio" name="searchordertime" value="y" <%if imsisearchordertime="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��Ʈ�޴�&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="usesetmenu" value="n" <%if imsiusesetmenu="n" or imsiusesetmenu="" then%>checked<%end if%>>���Ѵ�	
			<input type="radio" name="usesetmenu" value="y" <%if imsiusesetmenu="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>

	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�������� �հ� ����&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="UseDistributionTotal" value="n" <%if imsiUseDistributionTotal="n" or imsiUseDistributionTotal="" then%>checked<%end if%>>���Ѵ�	
			<input type="radio" name="UseDistributionTotal" value="y" <%if imsiUseDistributionTotal="y" then%>checked<%end if%>>�Ѵ�
		</td>
	</tr>
  
    <tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>��ǰ�ϱ�&nbsp;</td>
		<td bgcolor=white>
           
			<input type="radio" name="UseReturn" value="n" <%if imsiUseReturn="n" or imsiUseReturn="" then%>checked<%end if%> onclick="rcheck_no();">���Ѵ�	
			<input type="radio" name="UseReturn" value="y" <%if imsiUseReturn="y" then%>checked<%end if%> onclick="rcheck_ok();">�Ѵ�
           
						<input type=button name=btnReturn value="��ǰ����" onclick="javascript:bwinopenXY('rwrite.asp?idx=<%=idx%>', 'domain', 500, 500)" <%if imsibrandflag="n" or imsibrandflag="" then%>disabled<%end if%>></td>
	</tr>
   <tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ֹ����� ����ǥ��&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="UseTax" value="n" <%if imsiUseTax="n" or imsiUseTax="" then%>checked<%end if%>>���Ѵ�	
			<input type="radio" name="UseTax" value="y" <%if imsiUseTax="y" then%>checked<%end if%>>�Ѵ�
        </td>
	</tr>
     <tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�ֹ��ּұݾ�&nbsp;</td>
		<td bgcolor=white>
			<input type="radio" name="MinOrderCheck" value="n" <%if imsiMinOrderCheck="n" or imsiMinOrderCheck="" then%>checked<%end if%>>���Ѵ�	
			<input type="radio" name="MinOrderCheck" value="y" <%if imsiMinOrderCheck="y" then%>checked<%end if%>>�Ѵ�
            &nbsp;
            <input type="text" name="MinOrderAmt" class="box_write" value="<%=imsiMinOrderAmt%>" size=10 maxlength="8" OnKeypress="onlyNumber();">
        </td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td align=right><B>�������&nbsp;</td>
		<td bgcolor=white><input type="text" name="startday" maxlength="8" size=8 class="box_write" value="<%=replace(imsistartday,"/","")%>" OnKeypress="onlyNumber();"></td>
	</tr>
</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>
<%if session("Auserwrite")="y" then%>
		<%if idx="" then%>
			<input type="image" src="/images/admin/l_bu01.gif" border=0>
		<%else%>
			<input type="image" src="/images/admin/l_bu03.gif" border=0>
			<a href="#" onclick="javascript:comdel1();"><img src="/images/admin/l_bu04.gif" border=0></a>
		<%end if%>
<%end if%>
			<a href="#" onclick="javascript:history.back();"><img src="/images/admin/l_bu07.gif" border=0></a>
		</td>
	</tr>

</form>



</table>