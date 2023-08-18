<!----------------------------------------------------------------------------------------------------------
Description:
	get Action

History:
	2/22/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get Action --->
<cfquery name="getAction" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select Action_ID, Action
	from #Request.WebSite#.dbo.Change_Log_Action
	where active = 1
	order by Sort_Order
</cfquery>
