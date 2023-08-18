<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the change records

History:
	4/3/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getChangeLogs_V2" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Change_Log_ID, a.Site_ID as Admin_Site_ID, a.Date_Logged, a.Draft_Change_Value, a.Sharepoint_File_Name,
				 a.Actual_Change_Log_ID, a.Current_Status_ID, a.Current_Action_ID, a.Assigned_To_ID, a.FCO_Folder, a.FCO_SubFolder,
				 a.Oracle_Status, a.Milestone_Update_Status,
				 b.Portfolio_Deputy_ID,
				 b.Site_ID, b.Site_Name, b.Address, b.City, b.State_ID,
				 c.Portfolio as Log_Portfolio,
				 d.Status,
				 e.Action,
				 f.Team
	FROM PPMH.dbo.Change_Log as a 
			 inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.ID
			 left join TurboScope.dbo.Admin_Portfolio as c on a.Portfolio_ID = c.Portfolio_ID
			 inner join PPMH.dbo.Change_Log_Status as d on a.Current_Status_ID = d.Status_ID
			 inner join PPMH.dbo.Change_Log_Action as e on a.Current_Action_ID = e.Action_ID
			 inner join PPMH.dbo.Change_Log_Team as f on a.Assigned_To_ID = f.Team_ID
	WHERE a.Site_ID = #attributes.AdminSiteID#
				and a.Portfolio_ID = #attributes.StatusPortfolioID#
	ORDER BY a.Actual_Change_Log_ID, a.Date_Logged
</cfquery>

<CFSET "Caller.#Attributes.Return#" = getChangeLogs_V2>
