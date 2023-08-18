<!----------------------------------------------------------------------------------------------------------
Description:
	get the distinct Corporate Affairs records

History:
	12/20/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfset RegionsToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionsToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionsToFind = listappend(RegionsToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<!--- get the Corporate Affairs records --->
<cfquery name="getDistinctCorporateAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT DISTINCT a.Corporate_Affairs_ID, d.Trigger_Date, d.Tracking_Date, 
		e.Site_ID, e.Site_Name, e.Address, e.City, f.State_Abbreviation, 
		g.Last_Name + ', ' + g.First_Name as Corporate_Affairs_Advisor,
		h.Last_Name + ', ' + h.First_Name as Ops_Lead,
		i.Portfolio, j.Region
	FROM #Request.WebSite#.dbo.Corporate_Affairs_Trigger_List as a
		inner join #Request.WebSite#.dbo.Corporate_Affairs_Trigger_Description as b on a.Trigger_Description_ID = b.Trigger_Description_ID and b.active=1
		inner join #Request.WebSite#.dbo.Corporate_Affairs_Trigger_Category as c on b.Trigger_Category_ID = c.Trigger_Category_ID and c.active=1
		inner join #Request.WebSite#.dbo.Corporate_Affairs as d on a.Corporate_Affairs_ID = d.Corporate_Affairs_ID
		inner join TurboScope.dbo.Admin_Site as e on d.site_ID = e.ID
		inner join TurboScope.dbo.Admin_State as f on e.State_id = f.State_id
		inner join WebSite_Admin.dbo.Web_Site_Users as g on e.Corporate_Affairs_Advisor_ID = g.User_ID
		inner join WebSite_Admin.dbo.Web_Site_Users as h on e.Chevron_PM_ID = h.User_ID
		inner join TurboScope.dbo.Admin_Portfolio as i on e.Portfolio_ID = i.Portfolio_ID
		inner join TurboScope.dbo.Admin_COP_Region as j on e.COP_Region_ID = j.COP_Region_ID
	WHERE a.Corporate_Affairs_ID is not null
		<cfif isDefined("URL.CAID")> and a.Corporate_Affairs_ID = #URL.CAID#</cfif>
		<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> and e.Portfolio_ID = #form.SitePortfolioToFind#</cfif>
		<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND e.Site_ID like ('%#form.SiteIDtofind#%')</cfif>
		<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND e.Site_Name like ('%#form.SiteNameToFind#%')</cfif>
		<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND e.Address like ('%#form.AddressToFind#%')</cfif>
		<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND e.City like ('%#form.CityToFind#%')</cfif>
		<cfif isDefined("form.StateToFind") and form.StateToFind NEQ 0> AND f.State_ID = (#form.StateToFind#)</cfif>
		<cfif isDefined("form.smtofind") and form.smtofind NEQ 0> and e.SM_ID = #form.smtofind#</cfif>
		<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0> and e.Portfolio_Deputy_ID = #form.DeputyToFind#</cfif>
		<cfif len(RegionsToFind)> and e.COP_Region_ID in (#RegionsToFind#)</cfif>
	ORDER BY d.Trigger_Date desc
</cfquery>
