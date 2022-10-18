<HTML>
 <HEAD>
<script language="javascript">

function openerQQ()
{ 
    if (opener && !opener.closed)
    { 
            opener.document.f1.t1.value=10; 
            window.close(); 
    } 
} 
</script>

 </HEAD>
 <BODY>
  <input type="button" value="send" onClick="openerQQ();">
 </BODY>

</HTML>
