<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to get site Watchlist Milestones

History:
	7/13/2022 - created
--------------------------------------------------------------------------------------------------------------------------------->

<!--- get the site Watchlist Milestones --->
<cfquery name="getWatchlistMilestones"  datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT b.id, b.Milestone,
				 a.ID as SiteMilestoneID, a.Anticipated_Claim_Year, a.Anticipated_Claim_Month, a.Milestone_Amount, a.Watchlist_Probability, a.ACS, a.Notes
	FROM PPMH.dbo.Site_Milestone_Watchlist AS a 
			 INNER JOIN PPMH.dbo.Milestones AS b ON a.Milestone_ID = b.id and b.Active = 1
			 INNER JOIN PPMH.dbo.ERP_Stage AS c ON b.ERP_Stage_ID = c.ERP_Stage_ID and c.Active = 1
	WHERE a.Site_ID = #form.AdminSiteID#
</cfquery>
