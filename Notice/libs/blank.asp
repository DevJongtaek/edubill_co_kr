<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<body>
<%
	Session.Timeout = 20000000
%>
<script language="JavaScript">
var refreshinterval = 1160
var displaycountdown = "no"
var starttime
var nowtime
var reloadseconds=0
var secondssinceloaded=0

function starttime() {
        starttime=new Date()
        starttime=starttime.getTime()
    countdown()
}

function countdown() {
        nowtime= new Date()
        nowtime=nowtime.getTime()
        secondssinceloaded=(nowtime-starttime)/1000
        reloadseconds=Math.round(refreshinterval-secondssinceloaded)
        if (refreshinterval>=secondssinceloaded) {
        var timer=setTimeout("countdown()",1000)
                if (displaycountdown=="yes") {
                        window.status="이 페이지는 "+reloadseconds+ "초 후에 리프레쉬됩니다"
                }
    }
    else {
        clearTimeout(timer)
				window.location.reload(true)
    } 
}
window.onload = starttime;
</script>
</body>
</html>