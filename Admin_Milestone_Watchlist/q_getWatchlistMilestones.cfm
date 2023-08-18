<!-------------------------------------------
Description:
	query to get Watchlist Milestones for a site

History:
	7/15/2022 - created
-------------------------------------------->

<cfset RegionsToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionsToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionsToFind = listappend(RegionsToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<!--- get the Watchlist Milestones info --->
<CFQUERY NAME="getWatchlistMilestones" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.ID, a.Site_ID, a.Milestone_ID, a.Anticipated_Claim_Year, a.Anticipated_Claim_Month, a.Milestone_Amount, a.ACS, a.Notes, a.Watchlist_Probability,
				 b.id as AdminID, b.Site_ID as Admin_Site_ID, b.Site_Name, b.Address, b.City,
				 c.Milestone,
				 d.State_Abbreviation,
				 e.Portfolio,
				 g.Last_Name + ', ' + g.First_Name as SM_Name,
				 h.Last_Name + ', ' + h.First_Name as Deputy_Name
	FROM #Request.WebSite#.dbo.Site_Milestone_Watchlist as a
		inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.id
		inner join #Request.WebSite#.dbo.Milestones as c on a.Milestone_ID = c.id
		inner join TurboScope.dbo.Admin_State as d on b.State_ID = d.state_id
		inner join TurboScope.dbo.Admin_Portfolio as e on b.Portfolio_ID = e.Portfolio_ID
		left join WebSite_Admin.dbo.Web_Site_Users as g on b.SM_ID = g.User_id 
		left join WebSite_Admin.dbo.Web_Site_Users as h on b.Portfolio_Deputy_ID = h.User_id 
	WHERE a.Site_ID is not null
				<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0>and b.Portfolio_id = #form.SitePortfolioToFind#</cfif>
				<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND b.Site_ID like ('%#form.SiteIDtofind#%')</cfif>
				<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND b.Site_Name like ('%#form.SiteNameToFind#%')</cfif>
				<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND b.Address like ('%#form.AddressToFind#%')</cfif>
				<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND b.City like ('%#form.CityToFind#%')</cfif>
				<cfif isDefined("form.StateToFind") and form.StateToFind NEQ 0> AND b.State_ID = ('#form.StateToFind#')</cfif>
				<cfif isDefined("form.milestonetofind") and form.milestonetofind NEQ 0>and a.Milestone_id = #form.milestonetofind#</cfif>
				<cfif len(RegionsToFind)> and b.COP_Region_ID in (#RegionsToFind#)</cfif>
	ORDER BY a.Site_ID, c.Milestone, a.Anticipated_Claim_Year, a.Anticipated_Claim_Month
</CFQUERY>
