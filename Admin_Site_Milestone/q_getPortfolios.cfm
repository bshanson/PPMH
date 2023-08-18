<!--------------------------------------------------------------
Description:
	get the Portfolios

History:
	1/27/2021 - created
--------------------------------------------------------------->

<!--- get the Portfolios --->
<CFQUERY NAME="getPortfolios" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.Portfolio_ID, a.Portfolio
	FROM TurboScope.dbo.Admin_Portfolio as a
	Where a.Portfolio_ID in (28, 29, 32, 35, 37, 39, 40, 41, 42, 43, 46, 50, 64)
	ORDER BY a.Portfolio
</CFQUERY>
