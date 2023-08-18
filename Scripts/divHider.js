/*divHider.js
* by BSH
* 09/04/2012
* simple timer to hide a div after 5 seconds
*/

var div_timer=setTimeout("hide_div();",5000);
function hide_div(time_here){
    if(!time_here) {
    	document.getElementById('msg').style.visibility='hidden';
    }
}
