<!----------------------------------------------------------------------------------------------------------
Description:
	get projects

History:
	10/19/2021 - created
----------------------------------------------------------------------------------------------------------->

<!--- get Projects --->
<cfquery name="getTempProjects" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select ID as Site_Project_ID, Site_ID, Project_Name, Project_Number, Project_Manager_Name
	from TurboScope.dbo.Site_Project
	WHERE Project_Number = 99999999
	order by Project_Name
</cfquery>
