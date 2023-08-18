<!----------------------------------------------------------------------------
Description:
	provides error checking of the monthly data

History:
	2/19/2020 - created
----------------------------------------------------------------------------->

<!--- check to see if period is in the table --->
<cfif isDefined("form.edittype") AND form.edittype EQ "addStatus">
	<CFQUERY NAME="getSitePeriod" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select Site_ID, period
		from PPMH.dbo.Site_Status
		WHERE Site_ID = '#form.AdminSiteID#'
					and Status_Month = #form.monthtofind#
					and Status_Year = #form.yeartofind#
	</CFQUERY>
	<cfif getSitePeriod.RecordCount NEQ 0>
		<cfset ArrayAppend(errormsg, "the year and month is already in the database") />
	</cfif>
</cfif>

<!--- check to see action items, scope and stage --->
<cfif form.StatusPortfolioID EQ 0><cfset ArrayAppend(errormsg, "select the status portfolio") /></cfif>
<cfif form.Forecast_Quarter EQ 0><cfset ArrayAppend(errormsg, "select the forecast closure quarter") /></cfif>
<cfif form.Forecast_Year EQ 0><cfset ArrayAppend(errormsg, "select the forecast closure year") /></cfif>
<cfif not len(form.CurrentQuarterActionItems)><cfset ArrayAppend(errormsg, "enter the current quarter action items") /></cfif>
<cfif not len(form.Milestone_Assumptions)><cfset ArrayAppend(errormsg, "enter the milestone assumptions") /></cfif>
<cfif not len(form.Projected_Change_In_Scope_Issues)><cfset ArrayAppend(errormsg, "enter any projected change in scope issues") /></cfif>
<cfif not len(form.Critical_Path)><cfset ArrayAppend(errormsg, "enter the critical path") /></cfif>
<cfif form.ERP_Stage_ID EQ 0><cfset ArrayAppend(errormsg, "select the current erp stage") /></cfif>
<cfif not len(form.Overall_Project_Status)><cfset ArrayAppend(errormsg, "select the overall project status") /></cfif>

<cfif ArrayLen(errormsg)>
	<cfset successmsg = "">
<cfelse>
	<cfset successmsg = "The information has been updated">
</cfif>
