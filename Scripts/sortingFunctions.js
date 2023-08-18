function sortSelect(selectObj) {
	var o = new Array();
	for (var i=0; i<selectObj.options.length; i++)
		{o[i] = new Array(); o[i][0]=selectObj.options[i].text; o[i][1]=selectObj.options[i].value; o[i][2]=selectObj.options[i].defaultSelected; o[i][3]=selectObj.options[i].selected}
	o = o.sort( 
		function(a,b) { 
			if ((a[1].toLowerCase()+"") == '') return -1;
			if ((b[1].toLowerCase()+"") == '') return 1;
			if ((a[0].toLowerCase()+"") < (b[0].toLowerCase()+"")) { return -1; }
			if ((a[0].toLowerCase()+"") > (b[0].toLowerCase()+"")) { return 1; }
			return 0;
		} 
	);

	for (var i=0; i<o.length; i++) {
		selectObj.options[i] = new Option(o[i][0], o[i][1], o[i][2], o[i][3]);
		selectObj.options[i].selected = o[i][3]
	}
}

function updateTdBgColor(tableObj) {
	oddClassName='row1'
	evenClassName='row0';
	for (i=1; i<tableObj.rows.length;i++) {
		className = Math.round(i/2) != i/2?oddClassName:evenClassName
		for (j=0; j<tableObj.rows[i].cells.length; j++)
			if (tableObj.rows[i].cells[j].className != 'rowDelete')
				tableObj.rows[i].cells[j].className = className;
	}
}

function getTextForElement(obj) {
 var str=""
 for (var i=0;i < obj.childNodes.length;i++) {
  if (obj.childNodes[i].nodeType==1) 
   // Element node - walk children
   str+=getTextForElement(obj.childNodes[i])
  else if (obj.childNodes[i].nodeType==3)
   // Text Node - extract contents
   str = obj.childNodes[i].data
 }
 return str	
}

function sortTable(tableObj, sortBy, rowWithSelectLast, sortDesc) {
	var o = new Array();
	for (i=1; i<tableObj.rows.length;i++) o[o.length] = tableObj.rows[i]
	o = o.sort(
		function(a,b) {
			if (rowWithSelectLast && !a.cells[0].childNodes[0].tagName || a.cells[0].childNodes[0].tagName == 'SELECT') return 1;
			if (rowWithSelectLast && !b.cells[0].childNodes[0].tagName || b.cells[0].childNodes[0].tagName == 'SELECT') return -1;
			if (document.all) {
				if (!validFloat(a.cells[sortBy].innerText) && !validFloat(b.cells[sortBy].innerText)) {
					if (a.cells[sortBy].innerText.toLowerCase() < b.cells[sortBy].innerText.toLowerCase()) return !sortDesc? -1: 1;
					if (a.cells[sortBy].innerText.toLowerCase() > b.cells[sortBy].innerText.toLowerCase()) return !sortDesc? 1: -1;
				} else {
					if (parseFloat(a.cells[sortBy].innerText) < parseFloat(b.cells[sortBy].innerText.toLowerCase())) return !sortDesc? -1: 1;
					if (parseFloat(a.cells[sortBy].innerText) > parseFloat(b.cells[sortBy].innerText.toLowerCase())) return !sortDesc? 1: -1;
				}
			} else {
				if (!validFloat(a.cells[sortBy].innerHTML) && !validFloat(b.cells[sortBy].innerHTML)) {
					if (a.cells[sortBy].innerHTML.toLowerCase() < b.cells[sortBy].innerHTML.toLowerCase()) return !sortDesc? -1: 1;
					if (a.cells[sortBy].innerHTML.toLowerCase() > b.cells[sortBy].innerHTML.toLowerCase()) return !sortDesc? 1: -1;
				} else {
					if (parseFloat(a.cells[sortBy].innerHTML) < parseFloat(b.cells[sortBy].innerHTML.toLowerCase())) return !sortDesc? -1: 1;
					if (parseFloat(a.cells[sortBy].innerHTML) > parseFloat(b.cells[sortBy].innerHTML.toLowerCase())) return !sortDesc? 1: -1;
				}
			}
			return 0;
		}
	);
	
	for (var i=0; i<o.length; i++) {
		value=new Array(); checked = new Array(); selectedIndex = new Array();
		for (var j=0; j<o[i].cells.length; j++)
			if (o[i].cells[j].childNodes[0] && o[i].cells[j].childNodes[0].value) {
				value[j]=o[i].cells[j].childNodes[0].value;
				checked[j]=o[i].cells[j].childNodes[0].checked;
				selectedIndex[j]=o[i].cells[j].childNodes[0].selectedIndex;
			}
		tableObj.appendChild(o[i]);
		for (var j=0; j<tableObj.rows[i+1].cells.length; j++)
			if (tableObj.rows[tableObj.rows.length-1].cells[j] && tableObj.rows[tableObj.rows.length-1].cells[j].childNodes[0]) {
				if (value[j]) tableObj.rows[tableObj.rows.length-1].cells[j].childNodes[0].value = value[j];
				if (checked[j]) tableObj.rows[tableObj.rows.length-1].cells[j].childNodes[0].checked = checked[j];
				if (selectedIndex[j]) tableObj.rows[tableObj.rows.length-1].cells[j].childNodes[0].selectedIndex = selectedIndex[j];
			}
	}
}