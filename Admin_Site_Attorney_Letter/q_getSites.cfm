<!----------------------------------------------------------------------------------------------------------
Description:
	get sites

History:
	10/13/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get sites --->
<cfquery name="getSites" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.ID as Admin_Site_ID, a.Site_ID, a.Site_Name, a.Address, a.City,
		c.State_Abbreviation
	from TurboScope.dbo.Admin_Site as a
		inner join TurboScope.dbo.Admin_Portfolio as b on a.Portfolio_ID = b.Portfolio_ID and b.Active = 1
		inner join TurboScope.dbo.Admin_State as c on a.State_id = c.State_id
	where a.Attorney_Engagement = 1
	order by a.Site_ID, a.Site_Name
</cfquery>
