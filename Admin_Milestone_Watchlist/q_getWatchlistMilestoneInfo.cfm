<!----------------------------------------------------------------------------------------------------------
Description:
	get Watchlist Milestone info

History:
	7/15/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getWatchlistMilestoneInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Site_ID, a.Milestone_ID, a.Milestone_Amount, a.Anticipated_Claim_Month, a.Anticipated_Claim_Year, a.Watchlist_Probability, a.Notes, a.ACS,
				 b.id, b.Milestone,
				 c.Site_ID as AdminSiteID, c.Site_Name
	FROM #Request.WebSite#.dbo.Site_Milestone_Watchlist AS a 
		INNER JOIN #Request.WebSite#.dbo.Milestones AS b ON a.Milestone_ID = b.id
		INNER JOIN TurboScope.dbo.Admin_Site AS c ON a.Site_ID = c.id
	WHERE a.ID = #form.edtWatchlistMilestoneID#
</cfquery>
