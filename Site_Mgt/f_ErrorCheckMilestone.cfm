<!----------------------------------------------------------------------------
Description:
	provides error checking of the milestone

History:
	2/19/2020 - created
----------------------------------------------------------------------------->

<!--- check for delay reason --->
<cfif (isDefined("form.DelayReasonID")) and (form.DelayReasonID EQ 0)>
	<cfset ArrayAppend(errormsg, "select the delay reason") />
</cfif>

<!--- check for delay reason notes --->
<cfif (isDefined("form.DelayReasonID")) and ((form.DelayReasonID GT 1) and not len(form.Notes))>
	<cfset ArrayAppend(errormsg, "describe the reason for the delay in the notes field") />
</cfif>

<!--- check for file extension for all document names --->
<cfif (isDefined("form.MilestoneDoc")) and (len(evaluate("form.MilestoneDoc")))>
	<cfset ext = listlast(form.MilestoneDoc,".")>
	<cfif not len(ext)>
		<cfset ArrayAppend(errormsg, "enter a file extension for the document name") />
	</cfif>
</cfif>

<cfif ArrayLen(errormsg)>
	<cfset successmsg = "">
<cfelse>
	<cfset successmsg = "The information has been updated">
</cfif>
