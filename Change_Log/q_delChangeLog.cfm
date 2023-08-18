<!----------------------------------------------------------------------------------------------------------
Description:
	delete change log record

History:
	4/3/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- delete change log new milestones --->
<cfquery name="delNewMilestone" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	delete from #Request.WebSite#.dbo.Change_Log_Milestone_New
	WHERE Change_Log_ID = '#form.delChangeLogID#'
</cfquery>

<!--- delete change log milestones --->
<cfquery name="delMilestone" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	delete from #Request.WebSite#.dbo.Change_Log_Milestone
	WHERE Change_Log_ID = '#form.delChangeLogID#'
</cfquery>

<!--- delete Change Log History --->
<cfquery name="delMilestone" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	delete from #Request.WebSite#.dbo.Change_Log_History
	WHERE Change_Log_ID = '#form.delChangeLogID#'
</cfquery>

<!--- delete the Change_Log record --->
<cfquery name="deleteChangeLog" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	DELETE
	FROM #Request.WebSite#.dbo.Change_Log
	WHERE Change_Log_ID = '#form.delChangeLogID#'
</cfquery>
