<!----------------------------------------------------------------------------------------------------------
Description:
	get sites

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get sites --->
<cfquery name="getSites" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.ID as Admin_Site_ID, a.Site_ID, a.Site_Name, a.Address, a.City, a.COP_ID,
		c.State_Abbreviation, 
		d.Last_Name, d.First_Name,
		e.Region
	from TurboScope.dbo.Admin_Site as a
		inner join TurboScope.dbo.Admin_Portfolio as b on a.Portfolio_ID = b.Portfolio_ID
		inner join TurboScope.dbo.Admin_State as c on a.State_id = c.State_id
		left join WebSite_Admin.dbo.Web_Site_Users as d on a.SM_ID = d.User_id 
		left join TurboScope.dbo.Admin_COP_Region as e on a.COP_Region_ID = e.COP_Region_ID 
	where a.ID is not NULL
		and a.Status = 'A'
		and a.Portfolio_ID in 
		(
			SELECT DISTINCT a.Portfolio_ID
			FROM TurboScope.dbo.Admin_Site AS a 
				INNER JOIN TurboScope.dbo.Admin_Portfolio AS b ON a.Portfolio_ID = b.Portfolio_ID
			WHERE  (a.Corporate_Affairs_Advisor_ID IS NOT NULL)
		)
	order by a.Site_ID, a.Site_Name
</cfquery>
