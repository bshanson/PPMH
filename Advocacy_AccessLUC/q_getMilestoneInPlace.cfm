<!--------------------------------------------------------------
Description:
	get the Milestone In Place

History:
	1/10/2022 - created
--------------------------------------------------------------->

<!--- get the Milestone In Place --->
<CFQUERY NAME="getMilestoneInPlace" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Milestone_In_Place_ID, Milestone_In_Place
	FROM #Request.WebSite#.dbo.AccessLUC_Milestone_In_Place
	where active = 1
	ORDER BY Milestone_In_Place_ID
</CFQUERY>
