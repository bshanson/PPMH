<!--------------------------------------------------------------
Description:
	get the Priority

History:
	1/10/2022 - created
--------------------------------------------------------------->

<!--- get the Priority --->
<CFQUERY NAME="getPriority" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Priority_ID, Priority
	FROM #Request.WebSite#.dbo.AccessLUC_Priority
	where active = 1
	ORDER BY Priority_ID
</CFQUERY>
