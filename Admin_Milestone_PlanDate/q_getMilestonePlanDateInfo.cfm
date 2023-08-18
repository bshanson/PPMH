<!----------------------------------------------------------------------------------------------------------
Description:
	get site milestone info

History:
	9/8/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getMilestonePlanDateInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Site_ID, a.Milestone_ID, a.Milestone_Amount, a.Milestone_Plan_Date, a.Year, a.Portfolio_ID, a.FCO,
				 a.SAP_Charge_Code, a.Milestone_Baseline_Date, a.Notes, a.Delay_Reason_ID,
				 b.id, b.Milestone,
				 c.Site_ID as AdminSiteID, c.Site_Name,
				 d.Portfolio
	FROM #Request.WebSite#.dbo.Site_Milestones AS a 
		INNER JOIN #Request.WebSite#.dbo.Milestones AS b ON a.Milestone_ID = b.id
		INNER JOIN TurboScope.dbo.Admin_Site AS c ON a.Site_ID = c.id
		INNER JOIN TurboScope.dbo.Admin_Portfolio AS d ON a.Portfolio_ID = d.Portfolio_ID
	WHERE a.ID = #form.edtMilestonePlanDateID#
</cfquery>
