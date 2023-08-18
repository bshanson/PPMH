<!----------------------------------------------------------------------------------------------------------
Description:
	count the used milestones for a site

History:
	3/20/2020 - created
----------------------------------------------------------------------------------------------------------->

<CFQUERY NAME="countSiteUsedMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT COUNT(Milestone_ID) AS cntUsedMilestone, SUM(Milestone_Amount) AS usedMilestoneFee
	FROM PPMH.dbo.Site_Milestones 
	WHERE (Site_ID = #attributes.AdminSiteID#) 
		AND (Milestone_ID = #attributes.MID#) 
		and (Portfolio_ID = #attributes.PID#)
		and claim = 1
</CFQUERY>

<CFSET "Caller.#Attributes.countUsedMilestones#" = countSiteUsedMilestones>
