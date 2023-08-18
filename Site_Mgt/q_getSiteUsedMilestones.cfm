<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	get used milestones for site

History:
	2/19/2020 - created
--------------------------------------------------------------------------------------------------------------------------------->

<CFQUERY NAME="getSiteUsedMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.Milestone_ID
	from PPMH.dbo.Site_Milestones as a
	inner join PPMH.dbo.Milestones as b on a.Milestone_ID = b.id
	where a.Site_ID = '#form.AdminSiteID#'
		and b.type_id = 1

	union

	select a.Milestone_ID
	from PPMH.dbo.Site_Milestones as a
	inner join PPMH.dbo.Milestones as b on a.Milestone_ID = b.id
	where a.Site_ID = '#form.AdminSiteID#' 
		and b.type_id = 2 
		and a.period like '#selectedYear#%'
	order by a.Milestone_ID
</CFQUERY>
