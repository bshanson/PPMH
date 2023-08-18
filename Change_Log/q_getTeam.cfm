<!----------------------------------------------------------------------------------------------------------
Description:
	get Team

History:
	2/22/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get Team --->
<cfquery name="getTeam" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select Team_ID, Team
	from #Request.WebSite#.dbo.Change_Log_Team
	where active = 1
	order by Sort_Order
</cfquery>
