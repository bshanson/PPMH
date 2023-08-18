<!-------------------------------------------
Description:
	Site Milestone controller page

History:
	1/27/2021 - created
-------------------------------------------->

<cfif isDefined("form.btnAddSiteMilestoneRecord") or isDefined("form.btnEditSiteMilestone.x") or isDefined("form.btnUpdateSiteMilestone") or isDefined("form.btnCopySiteMilestone.x")>
	<cfinclude template="Site_Milestone_Edit.cfm">
<cfelse>
	<cfinclude template="Site_Milestone_Search.cfm">
</cfif>
