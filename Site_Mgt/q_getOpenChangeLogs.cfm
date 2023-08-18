<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the open change records

History:
	2/14/2023 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getOpenChangeLogs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT 'v1' as fco_type, a.Change_Log_ID, a.Site_ID as Admin_Site_ID, a.Date_Logged, a.Change_Type_ID, a.Change_Reason_ID, 
				 a.Reason_Detail_ID, a.Change_Value as Draft_Change_Value, a.Assumptions, 
				 a.Performance_Period_End_Date, a.Portfolio_Manager_Approval_Date, a.Portfolio_Manager_ID, a.Chevron_PM_Approval_Date, 
				 a.Chevron_PM_ID, a.Amendment, a.Arcadis_PM_ID, a.Email_Reference, a.Oracle_Update, a.Internal_Status, a.Change_Type_Other,
				 a.Reason_Detail_Other, a.Chevron_Approval_Status, a.FCO_File_Name as CompiledFCO, a.Actual_Change_Log_ID, a.Milestone_Update_Status,
				 a.Change_Type_ID as FCO_Name,
				 b.Portfolio_Deputy_ID,
				 b.Site_ID, b.Site_Name, b.Address, b.City, b.State_ID, b.Zip_Code,
				 c.Portfolio as Log_Portfolio, 
				 d.First_Name + ' ' + d.Last_Name as SMName,
				 e.First_Name + ' ' + e.Last_Name as PortfolioManagerName,
				 f.First_Name + ' ' + f.Last_Name as ChevronPMName,
				 g.State_Abbreviation,
				 k.Initiating_Entity,
				 l.Portfolio as Site_Portfolio
	FROM PPMH.dbo.Change_Log_V1 as a 
			 inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.ID
			 left join TurboScope.dbo.Admin_Portfolio as c on a.Portfolio_ID = c.Portfolio_ID
			 left join WebSite_Admin.dbo.Web_Site_Users as d on a.Arcadis_PM_ID = d.User_ID
			 inner join WebSite_Admin.dbo.Web_Site_Users as e on a.Portfolio_Manager_ID = e.User_ID
			 left join WebSite_Admin.dbo.Web_Site_Users as f on a.Chevron_PM_ID = f.User_ID
			 inner join TurboScope.dbo.Admin_State as g on b.State_ID = g.State_ID
			 inner join PPMH.dbo.Change_Log_Entity_V1 as k on a.Initiating_Entity_ID = k.Initiating_Entity_ID
			 left join TurboScope.dbo.Admin_Portfolio as l on b.Portfolio_ID = l.Portfolio_ID
	WHERE a.Change_Log_ID is not null
			and Internal_Status <> 'G'
			and a.Site_ID = <cfqueryparam value="#attributes.AdminSiteID#" cfsqltype="cf_sql_integer" >
			and a.Portfolio_ID = #attributes.StatusPortfolioID#

	UNION

	SELECT 'v2' as fco_type, a.Change_Log_ID, a.Site_ID as Admin_Site_ID, a.Date_Logged, '0' as Change_Type_ID, '0' as Change_Reason_ID, 
				 '0' as Reason_Detail_ID, a.Draft_Change_Value, '' as Assumptions, 
				 '1/1/1900' as Performance_Period_End_Date, '1/1/1900' as Portfolio_Manager_Approval_Date, c.Portfolio_Manager_ID, a.Chevron_PM_Approval_Date, 
				 b.Chevron_PM_ID, '' as Amendment, b.SM_ID, '' as Email_Reference, '' as Oracle_Update, a.Oracle_Status as Internal_Status, '' as Change_Type_Other,
				 '' as Reason_Detail_Other, m.Status as Chevron_Approval_Status, a.Compiled_FCO as CompiledFCO, a.Actual_Change_Log_ID, a.Milestone_Update_Status,
				 a.FCO_Name,
				 b.Portfolio_Deputy_ID,
				 b.Site_ID, b.Site_Name, b.Address, b.City, b.State_ID, b.Zip_Code,
				 c.Portfolio as Log_Portfolio, 
				 d.First_Name + ' ' + d.Last_Name as SMName,
				 e.First_Name + ' ' + e.Last_Name as PortfolioManagerName,
				 f.First_Name + ' ' + f.Last_Name as ChevronPMName,
				 g.State_Abbreviation,
				 '' as Initiating_Entity,
				 l.Portfolio as Site_Portfolio
	FROM PPMH.dbo.Change_Log as a 
			 inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.ID
			 left join TurboScope.dbo.Admin_Portfolio as c on a.Portfolio_ID = c.Portfolio_ID
			 left join WebSite_Admin.dbo.Web_Site_Users as d on b.SM_ID = d.User_ID
			 inner join WebSite_Admin.dbo.Web_Site_Users as e on c.Portfolio_Manager_ID = e.User_ID
			 left join WebSite_Admin.dbo.Web_Site_Users as f on b.Chevron_PM_ID = f.User_ID
			 inner join TurboScope.dbo.Admin_State as g on b.State_ID = g.State_ID
			 left join TurboScope.dbo.Admin_Portfolio as l on b.Portfolio_ID = l.Portfolio_ID
			 left join PPMH.dbo.Change_Log_Status as m on a.Current_Status_ID = m.Status_ID
	WHERE a.Change_Log_ID is not null
			AND (a.Current_Status_ID <> 4 or ((FCO_Processed = 2) AND (Current_Status_ID = 4)))
			and a.Site_ID = <cfqueryparam value="#attributes.AdminSiteID#" cfsqltype="cf_sql_integer" >
			and a.Portfolio_ID = #attributes.StatusPortfolioID#
	ORDER BY a.Actual_Change_Log_ID, a.Date_Logged
</cfquery>

<CFSET "Caller.#Attributes.Return#" = getOpenChangeLogs>
