<!--------------------------------------------------------------
Description:
	get the Stages

History:
	1/10/2022 - created
--------------------------------------------------------------->

<!--- get the Stages --->
<CFQUERY NAME="getStages" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Stage_ID, Stage
	FROM #Request.WebSite#.dbo.AccessLUC_Stage
	where active = 1
	ORDER BY Stage_ID
</CFQUERY>
