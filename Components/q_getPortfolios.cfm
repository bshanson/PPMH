<!-------------------------------------------
Description:
	query to get a list of the portfolios

History:
	11/05/2020 - created
-------------------------------------------->

<!--- get the Portfolios --->
<CFQUERY NAME="getPortfolios" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Portfolio_ID, Portfolio
	FROM TurboScope.dbo.Admin_Portfolio
	where active = <cfqueryparam cfsqltype="cf_sql_integer" value="1"> 
		and For_Query = 1
	Order by Portfolio
</CFQUERY>
