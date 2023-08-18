<!-------------------------------------------
Description:
	Change Log controller page

History:
	4/3/2020 - created
-------------------------------------------->

<cfif isDefined("form.btnAddChangeLog")>
	<cfinclude template="Change_Log_Edit.cfm">
<cfelseif isDefined("form.btnEditChangeLog") and form.fcotype EQ "v1">
	<cfinclude template="Change_Log_Edit.cfm">
<cfelseif isDefined("form.btnUpdateChangeLog") and form.fcotype EQ "v1">
	<cfinclude template="Change_Log_Edit.cfm">
<cfelseif isDefined("form.btnEditChangeLog") and form.fcotype EQ "v2">
	<cfinclude template="../Change_Log/Change_Log_Edit.cfm">
<cfelseif isDefined("form.btnUpdateChangeLog") and form.fcotype EQ "v2">
	<cfinclude template="../Change_Log/Change_Log_Edit.cfm">
<cfelse>
	<cfinclude template="Change_Log_Search.cfm">
</cfif>
