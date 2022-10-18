
	function chkEngNumber(obj){
		for(var i = 0; i < obj.length; i++){
			var chr = obj.substr(i,1);
			if((chr < '0' || chr > '9') && (chr < 'a' || chr > 'z') && (chr < 'A' || chr > 'Z')){
				if (chr != "_"){
					return false;
				}
			}
		}
		return true; 
	}

	function openWindows(filename,p_name,s_width,s_height,s_scrol){

		var x = screen.width;
		var y = screen.height;
		var wid = (x / 2) - (s_width / 2);
		var hei = (y / 2) - (s_height / 2);
	
		window.open(filename, p_name, "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0,scrollbars=" + s_scrol + ",width=" + s_width + ",height=" + s_height + ",top=" + hei + ",left=" + wid + ",scrolbar=no"); 
	}
	
	function checkStringLength(queryText, maxLength) {
		var strCnt = 0;
		for(i=0; i<queryText.length; i++){
			tempStr = queryText.charAt(i);
			if(escape(tempStr).length > 4) strCnt += 2;
      	else strCnt += 1 ;
    }
    return (maxLength <= strCnt) ? true : false;
	}

	function procEngine(form){$.procAction(form);return false;}
	
	;(function($) {

		$.email_check = function(email){
			var pattern = /^(\w+)@(\w+)[.](\w+)$/;
			var pattern2 = /^(\w+)@(\w+)[.](\w+)[.](\w+)$/;
		
			if (email.match(pattern) == null && email.match(pattern2) == null){
				return false;
			}else{
				return true;
			}
		};
	
	})(jQuery);