<!-------------------------------------------
Description:
	Uncommitted Milestone controller page

History:
	7/15/2022 - created
-------------------------------------------->

<cfif isDefined("form.btnAddWatchlistMilestoneRecord") or isDefined("form.btnEditWatchlistMilestone.x") or isDefined("form.btnUpdateWatchlistMilestone")>
	<cfinclude template="Milestone_Watchlist_Edit.cfm">
<cfelse>
	<cfinclude template="Milestone_Watchlist_Search.cfm">
</cfif>
