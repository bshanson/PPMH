<!----------------------------------------------------------------------------------------------------------
Description:
	get sites

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get sites --->
<cfquery name="getSites" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.ID as Admin_Site_ID, a.Site_ID, a.Site_Name, a.Address, a.City,
		b.State_Abbreviation
	from TurboScope.dbo.Admin_Site as a
		inner join TurboScope.dbo.Admin_State as b on a.State_id = b.State_id
		inner join TurboScope.dbo.Admin_Portfolio as c on a.Portfolio_ID = c.Portfolio_ID and (c.Active = 1) AND (c.Portfolio_ID NOT IN (20, 21, 24, 34, 38, 44))
	where Site_ID is not null
	order by a.Site_ID, a.Site_Name
</cfquery>
