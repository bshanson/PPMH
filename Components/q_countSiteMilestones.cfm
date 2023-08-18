<!----------------------------------------------------------------------------------------------------------
Description:
	count the milestones for a site

History:
	3/20/2020 - created
----------------------------------------------------------------------------------------------------------->

<CFQUERY NAME="countSiteMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT SUM(Quantity) AS cntMilestone, SUM(Milestone_Amount) AS totalMilestoneFee
	FROM PPMH.dbo.Site_Milestones
	WHERE (Site_ID = #attributes.AdminSiteID#) 
		AND (Milestone_ID = #attributes.MID#) 
		and (Portfolio_ID = #attributes.PID#)
</CFQUERY>

<CFSET "Caller.#Attributes.countMilestones#" = countSiteMilestones>
