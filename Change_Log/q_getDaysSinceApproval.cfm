<!----------------------------------------------------------------------------------------------------------
Description:
	get the number of days since approval

History:
	5/2/2023 - created
----------------------------------------------------------------------------------------------------------->

<!--- get ApprovalDate --->
<cfquery name="ApprovalDate" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select max(Status_Date) as StatusDate
	from #Request.WebSite#.dbo.Change_Log_History
	where Change_Log_ID = #getChangeLogs.Change_Log_ID# and Status_ID = 6
</cfquery>
