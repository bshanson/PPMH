<!-------------------------------------------
Description:
	query to find the portal pages that the user has access to

History:
	1/11/2019 - created
-------------------------------------------->

<!--- find the portal pages --->
<cfif len(Attributes.AccessLevel)><cfset AccessLevel = Attributes.AccessLevel><cfelse><cfset AccessLevel = 0></cfif>
<CFQUERY NAME="getAccessTo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT ID, Label
	FROM #Request.WebSiteID#.dbo.Portal
	WHERE (AccessLevel IN (#AccessLevel#))
				AND (ParentID =  <cfqueryparam value="0" cfsqltype="CF_SQL_INTEGER">)
				AND (Active =  <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">)
	ORDER BY SortOrder
</CFQUERY>
<cfset AccessTo = valuelist(getAccessTo.Label,", ")>
<cfset Pages = valuelist(getAccessTo.ID)>

<cfif isDefined("Attributes.Return")><CFSET "Caller.#Attributes.Return#" = "#AccessTo#"></cfif>
<cfif isDefined("Attributes.Pages")><CFSET "Caller.#Attributes.Pages#" = "#Pages#"></cfif>
