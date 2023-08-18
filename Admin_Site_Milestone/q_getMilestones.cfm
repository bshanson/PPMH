<!-------------------------------------------
Description:
	query to get the milestones

History:
	1/27/2021 - created
-------------------------------------------->

<CFQUERY NAME="getMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.ID, a.Milestone, a.ERP_Stage_ID, b.ERP_Stage
	from PPMH.dbo.Milestones as a
		left join PPMH.dbo.ERP_Stage as b on a.ERP_Stage_ID = b.ERP_Stage_ID and b.Active = 1
	where a.Active = 1
	order by a.Milestone
</CFQUERY>
