<!----------------------------------------------------------------------------------------------------------
Description:
	query to get milestones for the status record of the site

History:
	2/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- query for Site Status Milestones --->
<cfquery name="getSiteStatusMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.id, a.Milestone, b.period, b.site_id, b.Milestone_Doc, b.On_Track, b.Skip, b.FCO, b.Deliverable, b.Notes, b.Claim
	from PPMH.dbo.Milestones as a 
	 left join PPMH.dbo.Site_Status_Milestones as b on a.ID = b.Milestone_ID 
	 		and b.site_id = '#attributes.AdminSiteID#' 
			and b.Milestone_Plan_Date = '#attributes.MilestonePlanDate#'
	where a.ID = #attributes.MID#
	order by a.ID
</cfquery>

<CFSET "Caller.#Attributes.Return#" = getSiteStatusMilestones>
