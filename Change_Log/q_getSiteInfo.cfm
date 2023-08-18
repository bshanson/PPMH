<!----------------------------------------------------------------------------------------------------------
Description:
	get site inbfo

History:
	3/30/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get site info --->
<CFQUERY NAME="getSiteInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT 	a.Site_ID, a.Site_Name, a.Address, a.City, b.Portfolio_Name, c.State_Abbreviation, d.Region
	FROM TurboScope.dbo.Admin_Site as a
		inner join TurboScope.dbo.Admin_Portfolio as b on a.Portfolio_ID = b.Portfolio_ID
		left join TurboScope.dbo.Admin_State as c on a.State_ID = c.State_ID
		left join TurboScope.dbo.Admin_COP_Region as d on a.COP_Region_ID = d.COP_Region_ID
	WHERE (ID = <cfqueryparam value="#form.AdminSiteID#" cfsqltype="cf_sql_varchar" >)
</CFQUERY>
