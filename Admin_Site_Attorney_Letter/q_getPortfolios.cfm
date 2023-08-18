<!--------------------------------------------------------------
Description:
	get the Portfolios

History:
	10/13/2022 - created
--------------------------------------------------------------->

<!--- get the Portfolios --->
<CFQUERY NAME="getPortfolios" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT DISTINCT a.Portfolio_ID, a.Portfolio
	FROM TurboScope.dbo.Admin_Portfolio as a
		inner join TurboScope.dbo.Admin_Site as b on a.Portfolio_ID = b.Portfolio_ID and b.Attorney_Engagement = 1 
	ORDER BY a.Portfolio
</CFQUERY>
