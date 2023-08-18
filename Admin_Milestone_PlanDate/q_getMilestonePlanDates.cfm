<!-------------------------------------------
Description:
	query to get Milestones for a site

History:
	9/8/2022 - created
-------------------------------------------->

<cfset RegionsToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionsToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionsToFind = listappend(RegionsToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<!--- get the Site Milestones info --->
<CFQUERY NAME="getMilestonePlanDates" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.ID, a.Site_ID, a.Milestone_ID, a.Quantity, a.Year, a.Milestone_Plan_Date, a.Milestone_Amount, a.Milestone_Baseline_Date, a.skip,
				 a.Claim, a.FCO, a.Notes,
				 b.id as AdminID, b.Site_ID as Admin_Site_ID, b.Site_Name, b.Address, b.City,
				 c.Milestone,
				 d.State_Abbreviation,
				 f.Portfolio,
				 g.Last_Name + ', ' + g.First_Name as SM_Name,
				 h.Delay_Reason
	FROM #Request.WebSite#.dbo.Site_Milestones as a
		inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.id
		inner join #Request.WebSite#.dbo.Milestones as c on a.Milestone_ID = c.id
		inner join TurboScope.dbo.Admin_State as d on b.State_ID = d.state_id
		left join TurboScope.dbo.Admin_Portfolio as f on a.Portfolio_ID = f.Portfolio_ID
		left join WebSite_Admin.dbo.Web_Site_Users as g on b.SM_ID = g.User_id 
		left join #Request.WebSite#.dbo.Delay_Reason as h on a.Delay_Reason_ID = h.Delay_Reason_ID
	WHERE a.Site_ID is not null
				<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0>and b.Portfolio_id = #form.SitePortfolioToFind#</cfif>
				<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND b.Site_ID like ('%#form.SiteIDtofind#%')</cfif>
				<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND b.Site_Name like ('%#form.SiteNameToFind#%')</cfif>
				<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND b.Address like ('%#form.AddressToFind#%')</cfif>
				<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND b.City like ('%#form.CityToFind#%')</cfif>
				<cfif isDefined("form.StateToFind") and form.StateToFind NEQ 0> AND b.State_ID = ('#form.StateToFind#')</cfif>
				<cfif isDefined("form.milestonetofind") and form.milestonetofind NEQ 0>and a.Milestone_id = #form.milestonetofind#</cfif>
				<cfif isDefined("form.MilestonePortfolioToFind") and form.MilestonePortfolioToFind NEQ 0>and f.Portfolio_id = #form.MilestonePortfolioToFind#</cfif>
				<cfif len(RegionsToFind)> and b.COP_Region_ID in (#RegionsToFind#)</cfif>
	ORDER BY a.Site_ID, f.Portfolio, c.Milestone, a.Milestone_Plan_Date
</CFQUERY>
