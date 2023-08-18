<!-------------------------------------------
Description:
	Site Milestone controller page

History:
	9/8/2022 - created
-------------------------------------------->

<cfif isDefined("form.btnEditMilestonePlanDate.x") or isDefined("form.btnUpdateMilestonePlanDate")>
	<cfinclude template="Milestone_PlanDate_Edit.cfm">
<cfelse>
	<cfinclude template="Milestone_PlanDate_Search.cfm">
</cfif>
