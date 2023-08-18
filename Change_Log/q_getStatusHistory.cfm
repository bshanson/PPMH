<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the status history of the change log

History:
	3/15/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the record --->
<cfquery name="getStatusHistory" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Change_Log_ID, a.Status_ID, <!---a.Action_ID,---> a.Team_ID, a.Status_Date,
		b.Status, c.Action, d.Team, e.last_name, e.first_name
	FROM #Request.WebSite#.dbo.Change_Log_History as a
		left join #Request.WebSite#.dbo.Change_Log_Status as b on a.Status_ID = b.Status_ID 
		left join #Request.WebSite#.dbo.Change_Log_Action as c on a.Action_ID = c.Action_ID 
		left join #Request.WebSite#.dbo.Change_Log_Team as d on a.Team_ID = d.Team_ID 
		left join WebSite_Admin.dbo.Web_Site_Users as e on a.User_ID = e.User_ID 
	WHERE a.Change_Log_ID = #form.editChangeLogID#
</cfquery>
