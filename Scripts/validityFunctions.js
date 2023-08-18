function validFloat(string) {
	return (string.search(/^([0-9]+(\.)?|(\.)+[0-9]+)[0-9]*$/) != -1 && string.search(/[A-Za-z]+/) == -1)
}

function validInt(string) {
	return (string.search(/^[0-9]+$/) != -1)
}

function validDate(date) {
	Month=parseInt(date.substring(0,date.indexOf('/')),10)-1;
	Day=parseInt(date.substring(date.indexOf('/')+1,date.lastIndexOf('/')),10);
	Year=parseInt(date.substring(date.lastIndexOf('/')+1,date.length),10);

	if (Month.toString() == 'NaN' || Day.toString() == 'NaN' || Year.toString() == 'NaN') return false;

	var myDate = new Date(Year,Month,Day);
	return !(myDate.getMonth().toString() != Month.toString())
}
