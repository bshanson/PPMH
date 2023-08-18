<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to update monthly site information

History:
	2/19/2020 - created
--------------------------------------------------------------------------------------------------------------------------------->

<!--- update monthly site info --->
<CFQUERY NAME="q_updSiteStatus" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	update PPMH.dbo.Site_Status
	set 
			HS_Loss = <cfif len(form.HS_Loss)><cfqueryparam value="#trim(form.HS_Loss)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,HS_Near_Loss = <cfif len(form.HS_Near_Loss)><cfqueryparam value="#trim(form.HS_Near_Loss)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,Current_Quarter_Action_Items_v = <cfif len(form.CurrentQuarterActionItems)><cfqueryparam value="#form.CurrentQuarterActionItems#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,Milestone_Assumptions = <cfif len(form.Milestone_Assumptions)><cfqueryparam value="#trim(form.Milestone_Assumptions)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,Projected_Change_In_Scope_Issues = <cfif len(form.Projected_Change_In_Scope_Issues)><cfqueryparam value="#trim(form.Projected_Change_In_Scope_Issues)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,ERP_Stage_ID = <cfif len(form.ERP_Stage_ID)><cfqueryparam value="#form.ERP_Stage_ID#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>
			,Remedial_Technology_ID = <cfif len(form.Remedial_Technology_ID)><cfqueryparam value="#Remedial_Technology_ID#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>
			,Update_Date = getdate()
			,Critical_Path = <cfif len(form.Critical_Path)><cfqueryparam value="#trim(form.Critical_Path)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,Overall_Project_Status = <cfif len(form.Overall_Project_Status)><cfqueryparam value="#trim(form.Overall_Project_Status)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,Forecast_Quarter = <cfif len(form.Forecast_Quarter)><cfqueryparam value="#form.Forecast_Quarter#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>
			,Forecast_Year = <cfif len(form.Forecast_Year)><cfqueryparam value="#form.Forecast_Year#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>
			,Portfolio_ID = <cfif len(form.StatusPortfolioID)><cfqueryparam value="#form.StatusPortfolioID#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>
			,Reg_Agency_ID = <cfif len(form.RegAgencyID)><cfqueryparam value="#trim(form.RegAgencyID)#" cfsqltype="CF_SQL_integer"><cfelse>NULL</cfif>
			,Agency_Person = <cfif len(form.AgencyPerson)><cfqueryparam value="#trim(form.AgencyPerson)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,Important_Site_Info = <cfif len(form.ImportantSiteInfo)><cfqueryparam value="#trim(form.ImportantSiteInfo)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,Important_GWM_Info = <cfif len(form.ImportantGWMInfo)><cfqueryparam value="#trim(form.ImportantGWMInfo)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,Important_Links = <cfif len(form.ImportantLinks)><cfqueryparam value="#trim(form.ImportantLinks)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
			,ERP_Notes = <cfif len(form.ERPNotes)><cfqueryparam value="#trim(form.ERPNotes)#" cfsqltype="CF_SQL_VARCHAR"><cfelse>NULL</cfif>
	WHERE Status_ID = #form.editStatusID#
</CFQUERY>
