<!----------------------------------------------------------------------------------------------------------
Description:
	query to get a change record

History:
	9/20/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the record --->
<cfquery name="getChangeLogInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Change_Log_ID, a.Site_ID as Admin_Site_ID, a.Date_Logged, a.Initiating_Entity_ID, a.Change_Type_ID, a.Change_Reason_ID, 
				 a.Reason_Detail_ID, a.Additional_Information, a.Milestone_List, a.Change_Value, a.Assumptions, 
				 a.Performance_Period_End_Date, a.Portfolio_Manager_Approval_Date, a.Portfolio_Manager_ID, a.Chevron_PM_Approval_Date, 
				 a.Chevron_PM_ID, a.Amendment, a.Arcadis_PM_ID, a.Email_Reference, a.Oracle_Update, a.Internal_Status, a.Approval_Description,
				 a.Reason_Detail_Other, a.Change_Type_Other, a.Chevron_Approval_Status, a.FCO_File_Name, a.Actual_Change_Log_ID, a.Portfolio_ID,
				 a.Milestone_Update_Status,
				 b.Site_ID, b.Site_Name, b.Address, b.City,
				 c.State_Abbreviation
	FROM #Request.WebSite#.dbo.Change_Log_V1 as a
		inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.id  
		inner join TurboScope.dbo.Admin_State as c on b.State_id = c.State_id
	WHERE a.Change_Log_ID = #form.editChangeLogID#
</cfquery>
