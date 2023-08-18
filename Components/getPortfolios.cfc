<!-------------------------------------------
Description:
	cfc to return various portfolio lists

History:
	5/20/2022 - created
-------------------------------------------->

<cfcomponent>
	<!--- get COP portfolios --->
	<cffunction name="FCOPortfolios"
			  			hint="get the portfolios that have COP in the name" 
			  			returntype="Any" >
		<CFQUERY NAME="getPortfolios" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT Portfolio_ID, Portfolio
			FROM TurboScope.dbo.Admin_Portfolio
			Where Active = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
				and Portfolio like 'cop%'
			ORDER BY Portfolio
		</CFQUERY>
		<cfreturn getPortfolios>
	</cffunction>

	<!--- get portfolios used in the queries --->
	<cffunction name="QueryPortfolios"
			  			hint="get the portfolios used in queriesthat have COP in the name" 
			  			returntype="Any" >
		<CFQUERY NAME="getPortfolios" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT Portfolio_ID, Portfolio
			FROM TurboScope.dbo.Admin_Portfolio
			Where Active = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
				and For_Query = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
			ORDER BY Portfolio
		</CFQUERY>
		<cfreturn getPortfolios>
	</cffunction>

	<!--- get portfolios used in corporate affairs --->
	<cffunction name="CorpAffairsPortfolios"
			  			hint="get the portfolios that have the turboscope.admin_site.Corporate_Affairs_Advisor_ID set" 
			  			returntype="Any" >
		<CFQUERY NAME="getPortfolios" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT DISTINCT a.Portfolio_ID, b.Portfolio
			FROM TurboScope.dbo.Admin_Site AS a 
				INNER JOIN TurboScope.dbo.Admin_Portfolio AS b ON a.Portfolio_ID = b.Portfolio_ID
			WHERE  (a.Corporate_Affairs_Advisor_ID IS NOT NULL)
			ORDER BY a.Portfolio_ID
		</CFQUERY>
		<cfreturn getPortfolios>
	</cffunction>
</cfcomponent>
