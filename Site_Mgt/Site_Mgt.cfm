<!-------------------------------------------
Description:
	Site Mgt controller page

History:
	2/19/2020 - created
-------------------------------------------->

<cfif isDefined("form.btnReturn")>
	<cfinclude template="Site_Mgt_Search.cfm">
<cfelseif isDefined("form.btnSiteReturn")>
	<cfinclude template="Site_Mgt_Edit.cfm">
<cfelse>
	<cfif (isDefined("form.editMilestone") or isDefined("form.btnEditMilestone.x")) and not isDefined("form.sort")>
		<cfinclude template="Site_Milestone_Edit.cfm">
	<cfelseif isDefined("form.edittype") or isDefined("form.btnEditStatus.x") or isDefined("form.btnUpdateStatus") or isDefined("form.sort")>
		<cfinclude template="Site_Mgt_Edit.cfm">
	<cfelse>
		<cfinclude template="Site_Mgt_Search.cfm">
	</cfif>
</cfif>
