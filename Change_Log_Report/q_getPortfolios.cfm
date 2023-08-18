<!--------------------------------------------------------------
Description:
	get the Portfolios

History:
	9/20/2022 - created
--------------------------------------------------------------->

<!--- get the Portfolios --->
<CFQUERY NAME="getPortfolios" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.Portfolio_ID, a.Portfolio
	FROM TurboScope.dbo.Admin_Portfolio as a
	Where a.Active = <cfqueryparam cfsqltype="cf_sql_integer" value="1"> 
		and a.For_Query = 1
	ORDER BY a.Portfolio
</CFQUERY>
