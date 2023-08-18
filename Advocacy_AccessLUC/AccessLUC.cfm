<!-------------------------------------------
Description:
	AccessLUC controller page

History:
	2/11/2020 - created
-------------------------------------------->

<cfif isDefined("form.btnAddAccessLUC") or isDefined("form.btnEditAccessLUC") or isDefined("form.btnUpdateAccessLUC")>
	<cfinclude template="AccessLUC_Edit.cfm">
<cfelse>
	<cfinclude template="AccessLUC_Search.cfm">
</cfif>
