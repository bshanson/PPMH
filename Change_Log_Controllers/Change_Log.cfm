<!-------------------------------------------
Description:
	Change Log controller page - V1

History:
	4/3/2020 - created
-------------------------------------------->

<cfif isDefined("form.btnAddChangeLog") or isDefined("form.btnEditChangeLog") or isDefined("form.btnUpdateChangeLog")>
	<cfinclude template="Change_Log_Edit.cfm">
<cfelse>
	<cfinclude template="Change_Log_Search.cfm">
</cfif>
