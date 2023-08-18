<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to add monthly site information

History:
	2/19/2020 - created
--------------------------------------------------------------------------------------------------------------------------------->

<cfset prjmn = form.monthtofind>
<cfif prjmn LTE 9><cfset prjmn = "0" & prjmn></cfif>
<cfset form.periodtofind = form.yeartofind & prjmn>

<!--- add monthly site info --->
<CFQUERY NAME="addSiteStatus" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	insert PPMH.dbo.Site_Status
	(Site_ID 
	,Period 
	,Status_Year 
	,Status_Month 
	,HS_Loss 
	,HS_Near_Loss 
	,Current_Quarter_Action_Items_v 
	,Milestone_Assumptions 
	,Projected_Change_In_Scope_Issues 
	,ERP_Stage_ID
	,Remedial_Technology_ID
	,Update_Date
	,Critical_Path
	,Overall_Project_Status
	,Forecast_Quarter
	,Forecast_Year
	,Portfolio_ID
	,Reg_Agency_ID
	,Agency_Person
	,Important_Site_Info
	,Important_GWM_Info
	,Important_Links
	,ERP_Notes
	)
	VALUES
	(<cfqueryparam value="#trim(form.AdminSiteID)#" cfsqltype="cf_sql_integer">
	,<cfqueryparam value="#trim(form.periodtofind)#" cfsqltype="cf_sql_integer">
	,<cfqueryparam value="#trim(form.yeartofind)#" cfsqltype="cf_sql_integer">
	,<cfqueryparam value="#trim(form.monthtofind)#" cfsqltype="cf_sql_integer">
	,<cfif len(form.HS_Loss)><cfqueryparam value="#trim(form.HS_Loss)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.HS_Near_Loss)><cfqueryparam value="#trim(form.HS_Near_Loss)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.CurrentQuarterActionItems)><cfqueryparam value="#trim(form.CurrentQuarterActionItems)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.Milestone_Assumptions)><cfqueryparam value="#trim(form.Milestone_Assumptions)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.Projected_Change_In_Scope_Issues)><cfqueryparam value="#trim(form.Projected_Change_In_Scope_Issues)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.ERP_Stage_ID)><cfqueryparam value="#form.ERP_Stage_ID#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>
	,<cfif len(form.Remedial_Technology_ID)><cfqueryparam value="#Remedial_Technology_ID#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>
	,getdate()
	,<cfif len(form.Critical_Path)><cfqueryparam value="#trim(form.Critical_Path)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.Overall_Project_Status)><cfqueryparam value="#trim(form.Overall_Project_Status)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.Forecast_Quarter)><cfqueryparam value="#form.Forecast_Quarter#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>
	,<cfif len(form.Forecast_Year)><cfqueryparam value="#form.Forecast_Year#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>
	,<cfif len(form.StatusPortfolioID)><cfqueryparam value="#form.StatusPortfolioID#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>
,<cfif len(form.RegAgencyID)><cfqueryparam value="#trim(form.RegAgencyID)#" cfsqltype="CF_SQL_integer"><cfelse>NULL</cfif>
	,<cfif len(form.AgencyPerson)><cfqueryparam value="#trim(form.AgencyPerson)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.ImportantSiteInfo)><cfqueryparam value="#trim(form.ImportantSiteInfo)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.ImportantGWMInfo)><cfqueryparam value="#trim(form.ImportantGWMInfo)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.ImportantLinks)><cfqueryparam value="#trim(form.ImportantLinks)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	,<cfif len(form.ERPNotes)><cfqueryparam value="#trim(form.ERPNotes)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	)
</CFQUERY>

<CFQUERY NAME="getmaxid" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select max(Status_ID) as maxid from PPMH.dbo.Site_Status
</CFQUERY>
<cfset form.editStatusID = getmaxid.maxid>
