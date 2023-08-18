<!----------------------------------------------------------------------------------------------------------
Description:
	get the forecast info for a site

History:
	5/13/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get forecast info --->
<cfquery name="getForecastInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT Site_ID, MAX(Forecast_Year) AS maxYear, MAX(Forecast_Quarter) AS maxQuarter
	FROM #Request.WebSite#.dbo.Site_Status
	WHERE Site_ID = #Attributes.SiteID#
	GROUP BY Site_ID
</cfquery>

<!--- if no forecast info, get closure info--->
<cfif getForecastInfo.RecordCount EQ 0>
	<cfquery name="getForecastInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Site_ID, ceiling(Closure_Month/3.0) AS maxQuarter, Closure_Year AS maxYear
		FROM TurboScope.dbo.Admin_Site
		WHERE ID = #Attributes.SiteID#
	</cfquery>
</cfif>
<CFSET "Caller.#Attributes.ForecastInfo#" = "#getForecastInfo#">
