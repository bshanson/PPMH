<!----------------------------------------------------------------------------------------------------------
Description:
	get Status

History:
	2/22/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get Status --->
<cfquery name="getStatus" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select Status_ID, Status
	from #Request.WebSite#.dbo.Change_Log_Status
	where active = 1
	<cfif isDefined("getChangeLogInfo") and getChangeLogInfo.current_status_id NEQ 4>
		<cfif isDefined("EditorList") and (not listfind(EditorList,Session.Security.UserID))>and Status_ID <> 4</cfif>
	</cfif>
	order by Sort_Order
</cfquery>
