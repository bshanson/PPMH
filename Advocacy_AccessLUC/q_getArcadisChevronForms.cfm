<!--------------------------------------------------------------
Description:
	get the Arcadis Chevron Forms

History:
	1/7/2022 - created
--------------------------------------------------------------->

<!--- get the getArcadis Chevron Forms --->
<CFQUERY NAME="getArcadisChevronForms" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Arcadis_Chevron_Form_ID, Arcadis_Chevron_Form
	FROM #Request.WebSite#.dbo.AccessLUC_Arcadis_Chevron_Form
	Where Active = 1
	ORDER BY Sort_Order
</CFQUERY>
