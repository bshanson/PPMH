<!----------------------------------------------------------------------------------------------------------
Description:
	get site milestone info

History:
	1/27/2021 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getSiteMilestoneInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Site_ID, a.Milestone_ID, a.Milestone_Amount, a.Milestone_Plan_Date, a.Year, a.Portfolio_ID, a.FCO, a.SAP_Charge_Code, 
				 a.Milestone_Baseline_Date, a.Skip, a.ACS_Milestone,
				 b.id, b.Milestone,
				 c.Site_ID as AdminSiteID, c.Site_Name
	FROM PPMH.dbo.Site_Milestones AS a 
		INNER JOIN PPMH.dbo.Milestones AS b ON a.Milestone_ID = b.id
		INNER JOIN TurboScope.dbo.Admin_Site AS c ON a.Site_ID = c.id
	WHERE a.ID = #form.edtSiteMilestoneID#
</cfquery>
