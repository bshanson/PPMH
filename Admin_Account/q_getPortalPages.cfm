<!-------------------------------------------
Description:
	query to get the parent pages of the portal

History:
	1/11/2019 - created
-------------------------------------------->

<!--- get the parent pages of the portal --->
<CFQUERY NAME="getPortalPages" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT ID, Label, Name
	FROM #Request.WebSiteID#.dbo.Portal
	WHERE (Active =  <cfqueryparam value="#attributes.Active#" cfsqltype="CF_SQL_INTEGER">)
				AND (ParentID =  <cfqueryparam value="0" cfsqltype="CF_SQL_INTEGER">)
	ORDER BY SortOrder
</CFQUERY>
<CFSET "Caller.#Attributes.getPortalPages#" = "#getPortalPages#">
