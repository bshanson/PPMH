<!----------------------------------------------------------------------------
Description:
	provides error checking of AccessLUC data

History:
	2/11/2020 - created
----------------------------------------------------------------------------->

<cfif form.PortfolioID EQ 0><cfset ArrayAppend(errormsg, "select a portfolio") /></cfif>
<cfif form.AdminSiteID EQ 0><cfset ArrayAppend(errormsg, "select a site") /></cfif>
<cfif not isDefined("form.onsite")><cfset ArrayAppend(errormsg, "is this On-site or Off-site") /></cfif>
<cfif form.AgreementTypeID EQ 0><cfset ArrayAppend(errormsg, "select the Type of Agreement") /></cfif>

<cfif form.AgreementTypeID EQ 1>
	<cfif form.ArcadisChevronFormID EQ 0><cfset ArrayAppend(errormsg, "select the Arcadis / Chevron Form") /></cfif>
	<cfif not isDefined("form.splid")><cfset ArrayAppend(errormsg, "select the SPL") /></cfif>
	<cfif not isDefined("form.Priorityid")><cfset ArrayAppend(errormsg, "select the Priority") /></cfif>
	<cfif not isDefined("form.OutsideCounselInvolved")><cfset ArrayAppend(errormsg, "is Outside Counsel Involved") /></cfif>
	<cfif not isDefined("form.MilestoneInPlaceID")><cfset ArrayAppend(errormsg, "is the Milestone in Place") /></cfif>
	<cfif form.StageID EQ 0><cfset ArrayAppend(errormsg, "select the Stage") /></cfif>
	<cfif not isDefined("form.FieldWorkNotification")><cfset ArrayAppend(errormsg, "is Field Work Notification Required") /></cfif>
	<cfif not isDefined("form.UntilCompletion")><cfset ArrayAppend(errormsg, "Until Completion Of Work?") /></cfif>
	<cfif not isDefined("form.TermLetterSentID")><cfset ArrayAppend(errormsg, "has the Term Letter been Sent") /></cfif>
</cfif>

<cfif len(form.ExpirationDate)>
	<cfif (len(form.ExpirationDate) GT 0 and len(form.ExpirationDate) LT 8)>
		<cfset ArrayAppend(errormsg, "enter a valid date logged in MM/DD/YYYY format") />
	<cfelseif not isDate(form.ExpirationDate)>
		<cfset ArrayAppend(errormsg, "enter a valid date logged in MM/DD/YYYY format") />
	<cfelseif isDate(form.ExpirationDate) and (form.ExpirationDate LT '1/1/1900' or form.ExpirationDate GT '12/31/2099')>
		<cfset ArrayAppend(errormsg, "enter a valid date logged in MM/DD/YYYY format") />
	</cfif>
</cfif>

<cfif len(form.CompleteDate) and not isDate(form.CompleteDate)><cfset ArrayAppend(errormsg, "enter a valid completion date") /></cfif>
<cfif len(form.CompleteDate) and isDate(form.CompleteDate) and form.CompleteDate LT "1/1/1900"><cfset ArrayAppend(errormsg, "enter a valid completion date") /></cfif>

<cfif ArrayLen(errormsg)>
	<cfset successmsg = "">
<cfelse>
	<cfset successmsg = "The information has been updated">
</cfif>
