<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the change records

History:
	4/3/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getChangeLogs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Change_Log_ID, a.Site_ID as Admin_Site_ID, a.Date_Logged, a.Initiating_Entity_ID, a.Change_Type_ID, a.Change_Reason_ID, 
				 a.Reason_Detail_ID, a.Additional_Information, a.Milestone_List, a.Change_Value, a.Assumptions, 
				 a.Performance_Period_End_Date, a.Portfolio_Manager_Approval_Date, a.Portfolio_Manager_ID, a.Chevron_PM_Approval_Date, 
				 a.Chevron_PM_ID, a.Amendment, a.Arcadis_PM_ID, a.Email_Reference, a.Oracle_Update, a.Internal_Status, a.Change_Type_Other,
				 a.Approval_Description, a.Reason_Detail_Other, a.Chevron_Approval_Status, a.FCO_File_Name, a.Actual_Change_Log_ID, a.Milestone_Update_Status,
				 b.Portfolio_Deputy_ID,
				 b.Site_ID, b.Site_Name, b.Address, b.City, b.State_ID,
				 c.Portfolio as Log_Portfolio
	FROM PPMH.dbo.Change_Log_V1 as a 
			 inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.ID
			 left join TurboScope.dbo.Admin_Portfolio as c on a.Portfolio_ID = c.Portfolio_ID
	WHERE a.Site_ID = #attributes.AdminSiteID#
				and a.Portfolio_ID = #attributes.StatusPortfolioID#
	ORDER BY a.Actual_Change_Log_ID, a.Date_Logged
</cfquery>

<CFSET "Caller.#Attributes.Return#" = getChangeLogs>
