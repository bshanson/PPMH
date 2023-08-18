<!----------------------------------------------------------------------------------------------------------
Description:
	get sites

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfset RegionsToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionsToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionsToFind = listappend(RegionsToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<!--- get sites --->
<cfquery name="getSites" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select distinct a.ID as Admin_Site_ID, a.Site_ID, a.Site_Name, a.Address, a.City, a.Portfolio_ID, a.Status,
		c.State_Abbreviation, 
		d.Last_Name, d.First_Name,
		e.Region,
		f.Portfolio
	from TurboScope.dbo.Admin_Site as a
		inner join TurboScope.dbo.Admin_Portfolio as b on a.Portfolio_ID = b.Portfolio_ID
		inner join TurboScope.dbo.Admin_State as c on a.State_id = c.State_id
		left join WebSite_Admin.dbo.Web_Site_Users as d on a.SM_ID = d.User_id 
		left join TurboScope.dbo.Admin_COP_Region as e on a.COP_Region_ID = e.COP_Region_ID 
		left join TurboScope.dbo.Admin_Portfolio as f on a.Portfolio_ID = f.Portfolio_ID
		left join PPMH.dbo.Site_Status as g on a.ID = g.Site_ID
	where a.ID is not NULL
		and a.company_id = 253
		<cfif isDefined("form.siteidtofind")>and (a.site_id like (<cfqueryparam value="%#form.siteidtofind#%" cfsqltype="cf_sql_varchar">))</cfif>
		<cfif isDefined("form.sitenametofind")>and (a.site_Name like (<cfqueryparam value="%#form.sitenametofind#%" cfsqltype="cf_sql_varchar">))</cfif>
		<cfif isDefined("form.AddressToFind") and form.AddressToFind NEQ 0>and a.Address like (<cfqueryparam value="%#form.AddressToFind#%" cfsqltype="cf_sql_varchar" >)</cfif>
		<cfif isDefined("form.CityToFind") and form.CityToFind NEQ 0>and a.City like (<cfqueryparam value="%#form.CityToFind#%" cfsqltype="cf_sql_varchar" >)</cfif>
		<cfif isDefined("form.StateToFind") and form.StateToFind NEQ 0>and a.State_ID IN (#form.StateToFind#)</cfif>
		<cfif isDefined("form.smtofind") and form.smtofind NEQ 0>and a.SM_ID = <cfqueryparam value="#form.smtofind#" cfsqltype="cf_sql_integer" ></cfif>
		<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0>and a.Portfolio_Deputy_ID = <cfqueryparam value="#form.DeputyToFind#" cfsqltype="cf_sql_integer" ></cfif>
		<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0>and a.Portfolio_ID = <cfqueryparam value="#form.SitePortfolioToFind#" cfsqltype="cf_sql_integer" ></cfif>
		<cfif isDefined("form.StatusPortfolioToFind") and form.StatusPortfolioToFind NEQ 0> AND g.Portfolio_ID = '#form.StatusPortfolioToFind#'</cfif>
		<cfif len(RegionsToFind)> and a.COP_Region_ID in (#RegionsToFind#)</cfif>
		<cfif isDefined("form.ActiveToFind") and not isDefined("form.NotActiveToFind")> and a.Status = 'A'</cfif>
		<cfif isDefined("form.NotActiveToFind") and not isDefined("form.ActiveToFind")> and (a.Status = 'I' or a.Status is NULL)</cfif>
		<cfif isDefined("form.ClosedToFind") and not isDefined("form.NotClosedToFind")> and a.Closed = 1</cfif>
		<cfif isDefined("form.NotClosedToFind") and not isDefined("form.ClosedToFind")> and (a.Closed = 0 or a.Closed is NULL)</cfif>
	order by a.Site_ID, a.Site_Name
</cfquery>
