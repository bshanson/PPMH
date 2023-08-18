<!-------------------------------------------
Description:
	get the regulatory agencies

History:
	7/18/2023 - created
-------------------------------------------->

<!--- get the regulatory agencies info --->
<CFQUERY NAME="getRegulatoryAgencies" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Reg_Agency_ID, Reg_Agency
	FROM #Request.WebSite#.dbo.Site_Reg_Agency
	WHERE Active = 1
	Order by Reg_Agency
</CFQUERY>
