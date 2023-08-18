<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the SIMS info

History:
	4/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getSIMS" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT Site_ID as Admin_Site_ID
	FROM TurboScope.dbo.Admin_Site
	WHERE ID = #attributes.AdminSiteID#
</cfquery>

<CFSET "Caller.#Attributes.Return#" = getSIMS>
