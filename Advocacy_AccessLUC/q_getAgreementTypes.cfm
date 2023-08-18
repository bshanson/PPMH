<!--------------------------------------------------------------
Description:
	get the Agreement Types

History:
	1/7/2022 - created
--------------------------------------------------------------->

<!--- get the Agreement Types --->
<CFQUERY NAME="getAgreementTypes" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Agreement_Type_ID, Agreement_Type
	FROM #Request.WebSite#.dbo.AccessLUC_Agreement_Type
	Where Active = 1
	ORDER BY Agreement_Type_ID
</CFQUERY>
