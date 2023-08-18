<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the projects for the site

History:
	4/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getProjects" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT Site_ID, Start_Date, Project_Name, Project_Number, Project_Manager_Name, Status
	FROM TurboScope.dbo.Site_Project
	WHERE Site_ID = #attributes.AdminSiteID#
		and Related_Portfolio_ID = #attributes.pid#
	ORDER BY Project_Number
</cfquery>

<CFSET "Caller.#Attributes.Return#" = getProjects>
