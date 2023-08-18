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
	where active = <cfqueryparam cfsqltype="cf_sql_integer" value="1"> 
				<cfif attributes.UserCompanyID EQ 1>and (Portfolio_ID IN (28, 29, 32, 35, 37, 39, 40, 41, 42, 43, 46, 50, 64))</cfif>
				<cfif attributes.UserCompanyID NEQ 1>AND (Portfolio_ID IN (24, 39, 40, 41, 42, 46, 51, 37, 20, 44, 21, 50, 43, 32, 29, 35))</cfif>
	ORDER BY a.Portfolio
</CFQUERY>

<CFSET "Caller.#Attributes.getPortfolios#" = getPortfolios>
