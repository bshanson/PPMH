<!----------------------------------------------------------------------------------------------------------
Description:
	get max id from milestones

History:
	2/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<CFQUERY NAME="getMilestoneMaxID" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select max(ID) as maxID
	from PPMH.dbo.Milestones
	where Active = 1
</CFQUERY>
