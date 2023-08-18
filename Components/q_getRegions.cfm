<!-------------------------------------------
Description:
	query to get a list of the COP regions

History:
	11/05/2020 - created
-------------------------------------------->

<!--- get the Regions --->
<CFQUERY NAME="getRegions" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT COP_Region_ID, Region
	FROM TurboScope.dbo.Admin_COP_Region
	where active = 1
	Order by Sort_Order
</CFQUERY>
