<!----------------------------------------------------------------------------
Description:
	provides error checking of Corporate Affairs data

History:
	1/11/2022 - created
----------------------------------------------------------------------------->

<cfif form.AdminSiteID EQ 0><cfset ArrayAppend(errormsg, "select a site") /></cfif>
<cfif not len(form.TrackingDate)><cfset ArrayAppend(errormsg, "enter the notification date") /></cfif>
<cfif len(form.TrackingDate) and not isDate(form.TrackingDate)><cfset ArrayAppend(errormsg, "enter a valid notification date") /></cfif>
<cfif len(form.TrackingDate) and isDate(form.TrackingDate) and form.TrackingDate LT "1/1/1900"><cfset ArrayAppend(errormsg, "enter a valid notification date") /></cfif>
<cfif not len(form.TriggerDate)><cfset ArrayAppend(errormsg, "enter the trigger date") /></cfif>
<cfif len(form.TriggerDate) and not isDate(form.TriggerDate)><cfset ArrayAppend(errormsg, "enter a valid trigger date") /></cfif>
<cfif len(form.TriggerDate) and isDate(form.TriggerDate) and form.TriggerDate LT "1/1/1900"><cfset ArrayAppend(errormsg, "enter a valid trigger date") /></cfif>

<cfif (len(form.TrackingDate) and isDate(form.TrackingDate) and form.TrackingDate LT dateformat(now(),"mm/dd/yyyy")) and not len(form.Description)><cfset ArrayAppend(errormsg, "enter the description") /></cfif>

<cfset hit = 0>
<cfloop from="1" to="#form.noTriggerDescriptions#" index="i">
	<cfif isDefined("form.TD#i#")><cfset hit = hit + 1><cfbreak></cfif>
</cfloop>
<cfif hit EQ 0><cfset ArrayAppend(errormsg, "select a trigger description") /></cfif>

<cfif ArrayLen(errormsg)>
	<cfset successmsg = "">
<cfelse>
	<cfset successmsg = "The information has been updated">
</cfif>
