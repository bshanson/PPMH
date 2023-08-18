<!----------------------------------------------------------------------------
Description:
	provides error checking of change log data

History:
	4/3/2020 - created
----------------------------------------------------------------------------->

<!--- bad character list --->
<cfset listCharacters = "32-47,58-64,91-94,96-96,123-255">

<cfif isDefined("form.edittype") AND form.edittype EQ "addChangeLog">
	<!--- site --->
	<cfif form.AdminSiteID EQ 0>
		<cfset ArrayAppend(errormsg, "select the site") />
	</cfif>
	<!--- FCO Name --->
	<cfif not len(form.FCOName)>
		<cfset ArrayAppend(errormsg, "enter the fco name") />
	<cfelse>
		<!--- check for bad characters --->
		<cfloop list="#listCharacters#" index="x">
			<cfset pos = find("-",x)>
			<cfset start = left(x,pos-1)>
			<cfset end = right(x,len(x)-pos)>
			<cfloop from="#start#" to="#end#" index="v">
				<cfif find(chr(#v#), form.FCOName)>
					<cfset ArrayAppend(errormsg, "enter only alphanumeric characters or the underscore, '_', in the fco name") />
					<cfset hit = "true">
					<cfbreak>
				</cfif>
			</cfloop>
				<cfif isDefined("hit")><cfbreak></cfif>
		</cfloop>
	</cfif>
	<!--- template name --->
	<CFQUERY NAME="getTemplateName" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Change_Log_ID
		FROM  #Request.WebSite#.dbo.Change_Log
		WHERE (Template_Name = '#TemplateName#')
	</CFQUERY>
	<cfif getTemplateName.RecordCount NEQ 0>
		<cfset ArrayAppend(errormsg, "an fco with the same fco name already exists, enter a new fco name") />
	</cfif>
</cfif>

<cfif isDefined("form.edittype") AND form.edittype EQ "editChangeLog">
	<!--- Project --->
	<cfif form.SiteProjectID EQ 0>
		<cfset ArrayAppend(errormsg, "select the project") />
	</cfif>
	
	<!--- Due Date For Client --->
	<cfif len(form.DueDateForClient)>
		<cfif (len(form.DueDateForClient) GT 0 and len(form.DueDateForClient) LT 8)>
			<cfset ArrayAppend(errormsg, "enter a valid due date in MM/DD/YYYY format") />
		<cfelseif not isDate(form.DueDateForClient)>
			<cfset ArrayAppend(errormsg, "enter a valid due date in MM/DD/YYYY format") />
		<cfelseif isDate(form.DueDateForClient) and (form.DueDateForClient LT '1/1/1900' or form.DueDateForClient GT '12/31/2099')>
			<cfset ArrayAppend(errormsg, "enter a valid due date in MM/DD/YYYY format") />
		</cfif>
	</cfif>

	<!--- Draft Change Value --->
	<cfif len(form.DraftChangeValue)>
		<cfset vA = replace(form.DraftChangeValue, "$", "", "all" )>
		<cfset vA = replace(vA, ",", "", "all" )>
		<cfset vA = replace(vA, ")", "", "all" )>
		<cfset vA = replace(vA, "(", "", "all" )>
		<cfif not isNumeric(vA)><cfset ArrayAppend(errormsg, "enter a valid draft change amount") /></cfif>
	</cfif>

	<!--- Update Status --->
	<cfif form.UpdateStatusID EQ 0>
		<cfset ArrayAppend(errormsg, "select the update status") />
	</cfif>

	<!--- Send To --->
	<cfif form.SendToID EQ 0>
		<cfset ArrayAppend(errormsg, "select a send to option") />
	</cfif>

	<!--- Chevron Approval Date --->
	<cfif len(form.ChevronPMApprovalDate)>
		<cfif (len(form.ChevronPMApprovalDate) GT 0 and len(form.ChevronPMApprovalDate) LT 8)>
			<cfset ArrayAppend(errormsg, "enter a valid approval date in MM/DD/YYYY format") />
		<cfelseif not isDate(form.ChevronPMApprovalDate)>
			<cfset ArrayAppend(errormsg, "enter a valid approval date in MM/DD/YYYY format") />
		<cfelseif isDate(form.ChevronPMApprovalDate) and (form.ChevronPMApprovalDate LT '1/1/1900' or form.ChevronPMApprovalDate GT '12/31/2099')>
			<cfset ArrayAppend(errormsg, "enter a valid approval date in MM/DD/YYYY format") />
		</cfif>
	</cfif>

	<cfif ArrayLen(errormsg)>
		<cfset successmsg = "">
	<cfelse>
		<cfset successmsg = "The information has been updated">
	</cfif>
</cfif>
