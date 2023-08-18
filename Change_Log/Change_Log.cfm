<!-------------------------------------------
Description:
	Change Log controller page - V2

History:
	4/3/2020 - created
-------------------------------------------->

<cfif isDefined("form.btnAddNewChangeLog") or isDefined("form.btnAddChangeLog")>
	<cfinclude template="Change_Log_Edit.cfm">
<cfelseif isDefined("form.btnEditChangeLog") or isDefined("form.btnUpdateChangeLog") or isDefined("form.btnRefreshChangeLog.x") or isDefined("form.btnReturnChangeLog")>
	<cfinclude template="Change_Log_Edit.cfm">
<cfelse>
	<cfinclude template="Change_Log_Search.cfm">
</cfif>
