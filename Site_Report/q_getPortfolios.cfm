<!--------------------------------------------------------------
Description:
	get the Portfolios

History:
	1/27/2021 - created
--------------------------------------------------------------->

<!--- get the client Portfolios --->
<CFQUERY NAME="getPortfolios" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.Portfolio_ID, a.Portfolio
	FROM TurboScope.dbo.Admin_Portfolio as a
	Where a.Active = <cfqueryparam cfsqltype="cf_sql_integer" value="1"> 
				AND (Portfolio_ID IN (24, 39, 40, 41, 42, 46, 51, 37, 20, 44, 21, 50, 43, 32, 29, 35))
	ORDER BY a.Portfolio
</CFQUERY>
