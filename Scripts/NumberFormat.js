/*Parse number to currency format:
By JavaScript Kit (www.javascriptkit.com)
Over 200+ free scripts here!
*/

//Remove the $ sign if you wish the parse number to NOT include it
function parseelement(thisone) {
	var prefix=""
	var tempnum=thisone.value
	tempnum=(Math.round(tempnum*100)/100).toString()

	if (tempnum.indexOf(".") == -1)
		thisone.value=prefix+tempnum+".00"
	else if (tempnum.charAt(tempnum.length-2)==".")
		thisone.value=prefix+tempnum+"0"
	else if (tempnum.charAt(tempnum.length-1)==".")
		thisone.value=prefix+tempnum+"00"
	else
		thisone.value=prefix+tempnum
}