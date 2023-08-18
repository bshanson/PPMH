<!--------------------------------------------------------------
Description:
	get the Trigger Categories

History:
	1/11/2022 - created
--------------------------------------------------------------->

<!--- get the Trigger Categories --->
<CFQUERY NAME="getTriggerCategorys" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Trigger_Category_ID, Trigger_Category
	FROM #Request.WebSite#.dbo.Corporate_Affairs_Trigger_Category
	Where Active = 1
	ORDER BY Trigger_Category_ID
</CFQUERY>
