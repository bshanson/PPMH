<!-------------------------------------------
Description:
	query to get the milestones

History:
	7/15/2022 - created
-------------------------------------------->

<CFQUERY NAME="getMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.ID, a.Milestone, a.ERP_Stage_ID, b.ERP_Stage
	from #Request.WebSite#.dbo.Milestones as a
		inner join #Request.WebSite#.dbo.ERP_Stage as b on a.ERP_Stage_ID = b.ERP_Stage_ID and b.Active = 1
	where a.Active = 1
	order by a.Milestone
</CFQUERY>
