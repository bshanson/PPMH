<!--------------------------------------------------------------
Description:
	get all sites

History:
	4/3/2020 - created
--------------------------------------------------------------->

<!--- get the Sites --->
<CFQUERY NAME="getAllSites" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	select a.ID as Admin_Site_ID, a.Site_ID, a.Site_Name, a.Address, a.City, a.Portfolio_ID,
		b.State_Abbreviation
	from TurboScope.dbo.Admin_Site as a
		inner join TurboScope.dbo.Admin_State as b on a.State_id = b.State_id
		inner join TurboScope.dbo.Admin_Portfolio as c on a.Portfolio_ID = c.Portfolio_ID
	where a.Attorney_Engagement = 1
	order by a.Site_ID, a.Site_Name
</CFQUERY>
