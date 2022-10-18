// JavaScript Document

/* show - hide */
function MM_showHideLayers() { //v9.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) 
  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}


/* 포커스(인풋) */
function focusEvent(tBox, color) {
	tBox.style.backgroundImage = "";
	if(color == null) color = "";
	tBox.style.background = color;
}


/* openBrWindow */
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

/* swapImg */
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


/* FAQ */
function ifHeight()
{
	parent.document.all.faq_contents.style.height = document.all.ifr.offsetHeight;
    
    //onLoad();
}


    var previd = null;

    function displaySub(subID)
	{
        if (previd != null)
		{
			if (previd != subID)
			{
			    previd.style.display = "none";
			}
		}

		if (subID.style.display == "none") 
		{
			subID.style.display = "";
		}
		else
		{
			subID.style.display = "none";
		}

		previd = subID;
        //titleID.style.bold = true;

		//ifHeight();
	}

/* 레이어서브메뉴 */

function div_layer(name,num){ 
if(num==1) document.getElementById(name).style.display=''; 
else document.getElementById(name).style.display='none'; 
} 

/* faq  */

var onoff=0;
var re_num=5;
function faq_list(num){
	 var target = document.getElementById("opinion").getElementsByTagName('ul');

	var Maxnum = target.length;

	if(re_num==num && onoff==0){

		target[num-1].getElementsByTagName('li')[1].style.display = 'none';
		onoff=1;

	}else{
		for(i=0; i<Maxnum; i++){
		target[i].getElementsByTagName('li')[1].style.display = 'none';
		}
		target[num-1].getElementsByTagName('li')[1].style.display = '';
		onoff=0;
		re_num=num;
	}
}



function addLoadEvent(func){
	var oldonload = window.onload;
	if(typeof window.onload != 'function'){
		window.onload = func;

	}else{
		window.onload = function(){
			oldonload();
			func();
		}
	}
}

/*   main  tab      */
function only_tab(){
	if(!document.getElementById("main_notice")) return false;
	var source = document.getElementById("main_notice").getElementsByTagName("img");
	for(i=0; i<source.length; i++){
		source[i].count = i+1;
		source[i].onmouseover = function(){

				for(j=0; j<source.length; j++){
					source[j].src = source[j].src.replace("_on", "_off");
					document.getElementById("tab_text_" + [j+1]).style.display = "none"  ;
				}
				this.src = this.src.replace("_off", "_on");
				document.getElementById("tab_text_" + [this.count]).style.display = ""  ;


			return false;
		} // end of onclick
	}
}
addLoadEvent(only_tab)
