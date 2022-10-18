function isEmpty(s)
{
	return ((s == null) || (s.length == 0))
}

var whitespace = " \t\n\r";

function isWhitespace(s)
{
	var i;
	
	if (isEmpty(s)) return true;
	
	for (i = 0; i < s.length; i++)
	{
		var c = s.charAt(i);
		
		if (whitespace.indexOf(c) == -1) return false;
	}
	
	return true;
}

function isDigit(c)
{
	return ((c >= "0") && (c <= "9"))
}

function isInteger(s)
{
    var i;
    
    if (isWhitespace(s))
    	return false;
    	
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);

        if (!isDigit(c)) return false;
    }

    // All characters are numbers.
    return true;
}
