<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to add site milestone information

History:
	1/27/2021 - created
--------------------------------------------------------------------------------------------------------------------------------->

<!--- errorcheck --->
<cfinclude template="f_errorCheck.cfm">

<cfif not ArrayLen(arrErrors)>
	<cfif len(form.planmonth) EQ 1><cfset form.planmonth = '0' & form.planmonth></cfif>
	<cfset MilestonePlanDate = form.planyear & form.planmonth>

	<cfif len(form.BaselineMonth) EQ 1><cfset form.BaselineMonth = '0' & form.BaselineMonth></cfif>
	<cfset MilestoneBaselineDate = form.BaselineYear & form.BaselineMonth>
	<!--- update database --->
	<CFQUERY NAME="addSiteMilestone" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		insert into PPMH.dbo.Site_Milestones
			(Site_ID, Milestone_ID, Portfolio_ID, Quantity, Milestone_Amount, Year, Milestone_Plan_Date, Milestone_Baseline_Date, FCO, Milestone_Update_Date, Claim, SAP_Charge_Code, Skip, ACS_Milestone)
		values
			(<cfqueryparam value="#form.SiteID#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.MilestoneID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.PortfolioID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="1" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.MilestoneAmount#" cfsqltype="cf_sql_real" >
			,<cfqueryparam value="#form.Year#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#MilestonePlanDate#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#MilestoneBaselineDate#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.FCO#" cfsqltype="cf_sql_varchar" >
			,'#dateformat(now(),"mm/dd/yyyy")#'
			,<cfqueryparam value="0" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.SAPChargeCode#" cfsqltype="cf_sql_varchar" >
			,<cfif isDefined("form.Skip")>1<cfelse>NULL</cfif>
			,<cfif isDefined("form.ACSMilestone")>#form.ACSMilestone#<cfelse>NULL</cfif>
			)
	</CFQUERY>

	<!--- get the id of the new record --->
	<CFQUERY NAME="getNewID" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select max(id) as newID from PPMH.dbo.Site_Milestones
	</CFQUERY>
	<cfset msgSuccess = "The information has been updated">
</cfif>
