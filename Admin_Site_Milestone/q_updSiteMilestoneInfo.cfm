<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to update site milestone information

History:
	1/27/2021 - created
--------------------------------------------------------------------------------------------------------------------------------->

<!--- errorcheck --->
<cfinclude template="f_errorCheck.cfm">

<cfif not ArrayLen(arrErrors)>
	<cfif len(form.planmonth) EQ 1><cfset form.planmonth = '0' & form.planmonth></cfif>
	<cfset MilestonePlanDate = form.planyear & form.planmonth>

	<!--- get current info --->
	<CFQUERY NAME="getCurrentInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select Site_ID, Milestone_ID, Portfolio_ID, Milestone_Amount, Year, Milestone_Plan_Date, FCO, SAP_Charge_Code, ACS_Milestone
		from #Request.WebSite#.dbo.Site_Milestones
		where ID = #form.edtSiteMilestoneID#
	</CFQUERY>

	<!--- update database --->
	<CFQUERY NAME="updSiteMilestone" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		update PPMH.dbo.Site_Milestones
		set Milestone_ID = <cfqueryparam value="#form.MilestoneID#" cfsqltype="cf_sql_integer" >
			,Portfolio_ID = <cfqueryparam value="#form.PortfolioID#" cfsqltype="cf_sql_integer" >
			,Quantity = <cfqueryparam value="1" cfsqltype="cf_sql_integer" >
			,Milestone_Amount = <cfqueryparam value="#form.MilestoneAmount#" cfsqltype="cf_sql_real" >
			,Year = <cfqueryparam value="#form.Year#" cfsqltype="cf_sql_integer" >
			,Milestone_Plan_Date = <cfqueryparam value="#MilestonePlanDate#" cfsqltype="cf_sql_integer" >
			,FCO = <cfqueryparam value="#form.FCO#" cfsqltype="cf_sql_varchar" >
			,Milestone_Update_Date = '#dateformat(now(),"mm/dd/yyyy")#'
			,SAP_Charge_Code = <cfqueryparam value="#form.SAPChargeCode#" cfsqltype="cf_sql_varchar" >
			,Skip = <cfif isDefined("form.Skip")>1<cfelse>NULL</cfif>
			,ACS_Milestone = <cfif isDefined("form.ACSMilestone")>#form.ACSMilestone#<cfelse>NULL</cfif>
		where ID = #form.edtSiteMilestoneID#
	</CFQUERY>

	<!--- add to history if any changes --->
	<cfif (getCurrentInfo.Milestone_ID NEQ form.MilestoneID)
		or (getCurrentInfo.Portfolio_ID NEQ form.PortfolioID)
		or (getCurrentInfo.Milestone_Amount NEQ form.MilestoneAmount)
		or (getCurrentInfo.Year NEQ form.Year)
		or (getCurrentInfo.Milestone_Plan_Date NEQ MilestonePlanDate)
		or (getCurrentInfo.FCO NEQ form.FCO)
		or (getCurrentInfo.SAP_Charge_Code NEQ form.SAPChargeCode)>

		<CFQUERY NAME="insHistory" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			insert into #Request.WebSite#.dbo.Site_Milestones_History
			(Site_ID, Milestone_ID, Portfolio_ID, Milestone_Amount, Year, Milestone_Plan_Date, FCO, Milestone_Update_Date, SAP_Charge_Code, User_ID)
			values
				(<cfqueryparam value="#getCurrentInfo.Site_ID#" cfsqltype="cf_sql_integer" >
				,<cfqueryparam value="#getCurrentInfo.Milestone_ID#" cfsqltype="cf_sql_integer" >
				,<cfqueryparam value="#getCurrentInfo.Portfolio_ID#" cfsqltype="cf_sql_integer" >
				,<cfqueryparam value="#getCurrentInfo.Milestone_Amount#" cfsqltype="cf_sql_real" >
				,<cfqueryparam value="#getCurrentInfo.Year#" cfsqltype="cf_sql_integer" >
				,<cfqueryparam value="#getCurrentInfo.Milestone_Plan_Date#" cfsqltype="cf_sql_integer" >
				,<cfif len(getCurrentInfo.FCO)><cfqueryparam value="#getCurrentInfo.FCO#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
				,'#dateformat(now(),"mm/dd/yyyy")#'
				,<cfif len(getCurrentInfo.SAP_Charge_Code)><cfqueryparam value="#getCurrentInfo.SAP_Charge_Code#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
				,<cfqueryparam value="#Session.Security.UserID#" cfsqltype="cf_sql_integer" >
				)
		</CFQUERY>
	</cfif>

	<cfset msgSuccess = "The information has been updated">
</cfif>
