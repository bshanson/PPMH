<!-------------------------------------------
Description:
	query to get the milestones

History:
	3/26/2020 - created
-------------------------------------------->

<CFQUERY NAME="getMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.ID, a.Milestone
	from PPMH.dbo.Milestones as a
	where a.Active = 1
	order by a.Milestone
</CFQUERY>
