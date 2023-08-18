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
	order by Sort_Order
</cfquery>
