<!----------------------------------------------------------------------------
Description:
	provides error checking of regulatory data

History:
	2/7/2020 - created
----------------------------------------------------------------------------->

<cfif not len(form.AdminSiteID)><cfset ArrayAppend(errormsg, "select a site") /></cfif>
<cfif not len(form.RegulatoryAction)><cfset ArrayAppend(errormsg, "enter a requirement / action") /></cfif>
<cfif not len(form.RegulatoryDate)><cfset ArrayAppend(errormsg, "enter a date") /></cfif>
<cfif len(form.RegulatoryDate) and not isDate(form.RegulatoryDate)><cfset ArrayAppend(errormsg, "enter a valid date") /></cfif>
<cfif len(form.RegulatoryDate) and isDate(form.RegulatoryDate) and form.RegulatoryDate LT "1/1/1900"><cfset ArrayAppend(errormsg, "enter a valid date") /></cfif>
<cfif len(form.CompleteDate) and not isDate(form.CompleteDate)><cfset ArrayAppend(errormsg, "enter a valid completion date") /></cfif>
<cfif len(form.CompleteDate) and isDate(form.CompleteDate) and form.CompleteDate LT "1/1/1900"><cfset ArrayAppend(errormsg, "enter a valid completion date") /></cfif>

<cfif ArrayLen(errormsg)>
	<cfset successmsg = "">
<cfelse>
	<cfset successmsg = "The information has been updated">
</cfif>
