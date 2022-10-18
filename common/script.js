// 뒤가 비치는 투명버젼
function flashview (dirNswf,fwidth,fheight,params) {
 var flashobjec="";
 flashobjec+="  <object classid=\'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\' codebase=\'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\' width=\'"+fwidth+"\' height=\'"+fheight+"\'>";
 flashobjec+="      <param name=\'movie\' value=\'"+dirNswf+"\'>";
 flashobjec+="      <param name=\'wmode\' value=\'transparent\'>";
 flashobjec+="      <param name=\'quality\' value=\'high\'>";
 flashobjec+="      <param name=\'menu\' value=\'false\'>";
 flashobjec+="      <embed src=\'"+dirNswf+"\' width=\'"+fwidth+"\' height=\'"+fheight+"\' quality=\'high\' pluginspage=\'http://www.macromedia.com/go/getflashplayer\' type=\'application/x-shockwave-flash\' menu=\'false\'></embed>";
 flashobjec+="    </object>";

 document.write(flashobjec);
}


function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

// 메뉴 펼치기
var old_menu = '';
function menuclick( submenu) {
    if( old_menu != submenu ) {
    if( old_menu !='' ) {
        old_menu.style.display = 'none';
}
    submenu.style.display = 'block';
    old_menu = submenu;
    } else {
        submenu.style.display = 'none';
        old_menu = '';
    }
}




// 이미지오버
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}



//플래시 링크경로
function GoMenu(name) {
    if (eval(name) == "") {
        alert("서비스 준비중입니다.");
        return;    
    } else {
		document.location.href = eval(name);
	}
}

// 서브1 회사소개
	var sub01="../company/sub01.asp?Mnum=1&Snum=1";	//  
	var sub01_01="../company/sub01.asp?Mnum=1&Snum=1";	//  
	var sub01_02="../company/sub02.asp?Mnum=1&Snum=2";	//  
	var sub01_03="../company/sub03.asp?Mnum=1&Snum=3";	// 
	var sub01_04="../company/sub04.asp?Mnum=1&Snum=4";	// 	
	var sub01_05="../company/sub05.asp?Mnum=1&Snum=5";	// 	
	var sub01_06="../company/sub06.asp?Mnum=1&Snum=6";	//  
	var sub01_07="../company/sub07.asp?Mnum=1&Snum=7";	//  
	var sub01_08="../company/sub08.asp?Mnum=1&Snum=8";	// 
	var sub01_09="../company/sub09.asp?Mnum=1&Snum=9";	// 	
	var sub01_10="../company/sub010.asp?Mnum=1&Snum=10";	// 	

// 서브2 제품소개
	var sub02="../product/sub01.asp?Mnum=2&Snum=1";	// 
	var sub02_01="../product/sub01.asp?Mnum=2&Snum=1";	//  
	var sub02_02="../product/sub02.asp?Mnum=2&Snum=1";	// 
	var sub02_03="../product/sub03.asp?Mnum=2&Snum=1";	//  
	var sub02_04="../product/sub04.asp?Mnum=2&Snum=1";	//  
	var sub02_05="../product/sub05.asp?Mnum=2&Snum=5";	// 	
	var sub02_06="../product/sub06.asp?Mnum=2&Snum=6";	//  
	var sub02_07="../product/sub07.asp?Mnum=2&Snum=7";	// 
	var sub02_08="../product/sub08.asp?Mnum=2&Snum=8";	//  
	var sub02_09="../product/sub09.asp?Mnum=2&Snum=9";	//  
	var sub02_10="../product/sub10.asp?Mnum=2&Snum=10";	// 	 

// 서브3 자료다운
	var sub03="/data/sub01.asp?Mnum=3&Snum=1";	//  
	var sub03_01="/data/sub01.asp?Mnum=3&Snum=1";	//  
	var sub03_02="/data/sub02.asp?Mnum=3&Snum=1";	// 
	var sub03_03="/data/sub03.asp?Mnum=3&Snum=1";	// 	
	var sub03_04="../data/sub04.asp?Mnum=3&Snum=4";	// 
	var sub03_05="../data/sub05.asp?Mnum=3&Snum=5";	// 
	var sub03_06="../data/sub06.asp?Mnum=3&Snum=6";	//  
	var sub03_07="../data/sub07.asp?Mnum=3&Snum=7";	// 
	var sub03_08="../data/sub08.asp?Mnum=3&Snum=8";	// 	
	var sub03_09="../data/sub09.asp?Mnum=3&Snum=9";	//  
		
// 서브4 갤러리
	var sub04="../gallery/sub01.asp?Mnum=4&Snum=1";	//  
	var sub04_01="../gallery/sub01.asp?Mnum=4&Snum=1";	//  
	var sub04_02="../gallery/sub02.asp?Mnum=4&Snum=2";	//  
	var sub04_03="../gallery/sub03.asp?Mnum=4&Snum=3";	//  	
	var sub04_04="../gallery/sub04.asp?Mnum=4&Snum=4";	//  
	var sub04_05="../gallery/sub05.asp?Mnum=4&Snum=5";	//	
	var sub04_06="../gallery/sub06.asp?Mnum=4&Snum=6";	//  
	var sub04_07="../gallery/sub07.asp?Mnum=4&Snum=7";	//  	
	var sub04_08="../gallery/sub08.asp?Mnum=4&Snum=8";	//   	
	
// 서브5 고객센터
	var sub05="../customer/sub01.asp?Mnum=5&Snum=1";	//  
	var sub05_01="../customer/sub01.asp?Mnum=5&Snum=1";	//  
	var sub05_02="../customer/sub02.asp?Mnum=5&Snum=2";	//  
	var sub05_03="../customer/sub03.asp?Mnum=5&Snum=3";	//  
	var sub05_04="../customer/sub04.asp?Mnum=5&Snum=4";	// 
	var sub05_05="../customer/sub05.asp?Mnum=5&Snum=5";	//	
	var sub05_06="../customer/sub06.asp?Mnum=5&Snum=6";	//  
	var sub05_07="../customer/sub07.asp?Mnum=5&Snum=7";	//  
	var sub05_08="../customer/sub08.asp?Mnum=5&Snum=8";	//  
	
// 회원정보
	var sub06="../member/loagin.asp?Mnum=6&Snum=1";	//  
	var sub06_01="../member/login.asp?Mnum=6&Snum=1";	//  
	var sub06_02="../member/member01.asp?Mnum=6&Snum=2";	//  
	var sub06_03="../member/individual.asp?Mnum=6&Snum=3";	//  
	var sub06_04="../member/use.asp?Mnum=6&Snum=4";	// 
	var sub06_05="../member/sitemap.asp?Mnum=6&Snum=5";	//	
	var sub06_06="../member/sub06.asp?Mnum=6&Snum=6";	//  
	var sub06_07="../member/sub07.asp?Mnum=6&Snum=7";	//  
	var sub06_08="../member/sub08.asp?Mnum=6&Snum=8";	//  
	
// 마이페이지
	var sub07="../member/modify.asp?Mnum=7&Snum=1";	//  
	var sub07_01="../member/mypage.asp?Mnum=7&Snum=1";	//  
	var sub07_02="../member/cancel.asp?Mnum=7&Snum=2";	//  
	var sub07_03="../member/sub03.asp?Mnum=7&Snum=3";	//  
	var sub07_04="../member/sub04.asp?Mnum=7&Snum=4";	// 
	var sub07_05="../member/sub05.asp?Mnum=7&Snum=5";	//  
	var sub07_06="../member/sub06.asp?Mnum=7&Snum=6";	// 	
	
	
// 서브 탑메뉴
	var main="../main/main.asp?Mnum=1&Snum=1";	//  
	var contact="../company/sub03.asp?Mnum=1&Snum=3";	//  
	var admin="";	//  
	