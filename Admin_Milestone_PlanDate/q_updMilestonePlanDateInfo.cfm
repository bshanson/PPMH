<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to update site milestone information

History:
	9/8/2022 - created
--------------------------------------------------------------------------------------------------------------------------------->

<!--- errorcheck --->
<cfinclude template="f_errorCheck.cfm">

<cfif not ArrayLen(arrErrors)>
	<cfif len(form.planmonth) EQ 1><cfset form.planmonth = '0' & form.planmonth></cfif>
	<cfset MilestonePlanDate = form.planyear & form.planmonth>

	<!--- get current info --->
	<CFQUERY NAME="getCurrentInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select Site_ID, Milestone_ID, Portfolio_ID, Milestone_Amount, Year, Milestone_Plan_Date, FCO, SAP_Charge_Code
		from #Request.WebSite#.dbo.Site_Milestones
		where ID = #form.edtMilestonePlanDateID#
	</CFQUERY>

	<!--- update database --->
	<CFQUERY NAME="updMilestonePlanDate" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		update #Request.WebSite#.dbo.Site_Milestones
		set Milestone_Plan_Date = <cfqueryparam value="#MilestonePlanDate#" cfsqltype="cf_sql_integer" >
				,Delay_Reason_ID = #form.DelayReasonID#
				,Notes = <cfif len(form.Notes)>'#form.Notes#'<cfelse>NULL</cfif>
		where ID = #form.edtMilestonePlanDateID#
	</CFQUERY>

	<!--- add to history if any changes --->
	<cfif (getCurrentInfo.Milestone_Plan_Date NEQ MilestonePlanDate)>
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
