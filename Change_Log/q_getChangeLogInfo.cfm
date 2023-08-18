<!----------------------------------------------------------------------------------------------------------
Description:
	query to get a change record

History:
	4/3/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the record --->
<cfquery name="getChangeLogInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Change_Log_ID, a.Site_ID as Admin_Site_ID, a.Date_Logged
				 ,a.Actual_Change_Log_ID, a.Portfolio_ID
				 ,a.Site_Project_ID
				 ,a.Current_Status_ID, a.Assigned_To_ID, a.Update_Status_ID, a.Request_Action_ID, a.Send_To_ID
				 ,a.Sharepoint_File_Name, a.Draft_Change_Value, a.Due_Date_For_Client, a.FCO_Notes, a.FCO_Name, a.FCO_Folder, a.FCO_SubFolder
				 ,a.FCO_Processed
				 ,a.Time_Logged, a.Oracle_Status, a.Milestone_Update_Status, Assign_To_User_ID, a.Chevron_PM_Approval_Date
				 ,a.Compiled_FCO, 'V2' as FCO_Type
				 ,b.Site_ID, b.Site_Name, b.Address, b.City, c.State_Abbreviation
				 ,d.Portfolio_ID as Site_Portfolio_ID, d.Portfolio as Site_Portfolio, d.Project_Controller_ID
				 ,e.First_Name + ' ' + e.Last_Name as Chev_Ops_Lead
				 ,f.Service_Order_Number
				 ,g.Status
				 ,i.Team
				 ,j.First_Name + ' ' + j.Last_Name as Portfolio_Manager
				 ,k.First_Name + ' ' + k.Last_Name as Site_Manager
	FROM #Request.WebSite#.dbo.Change_Log as a
		left join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.id  
		left join TurboScope.dbo.Admin_State as c on b.State_id = c.State_id
		left join TurboScope.dbo.Admin_Portfolio as d on b.Portfolio_id = d.Portfolio_id
		left join WebSite_Admin.dbo.Web_Site_Users as e on b.Chevron_PM_ID = e.User_id
		left join TurboScope.dbo.Admin_Service_Order as f on b.Portfolio_ID = f.Portfolio_ID and b. COP_Region_ID = f.COP_Region_ID 
		left join #Request.WebSite#.dbo.Change_Log_Status as g on a.Current_Status_ID = g.Status_ID 
		left join #Request.WebSite#.dbo.Change_Log_Team as i on a.Assigned_To_ID = i.Team_ID 
		left join WebSite_Admin.dbo.Web_Site_Users as j on d.Portfolio_Manager_ID = j.User_id
		left join WebSite_Admin.dbo.Web_Site_Users as k on b.SM_ID = k.User_id
	WHERE a.Change_Log_ID = #form.editChangeLogID#
</cfquery>
