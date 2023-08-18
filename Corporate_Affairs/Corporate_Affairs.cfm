<!-------------------------------------------
Description:
	Corporate Affairs controller page

History:
	1/11/2022 - created
-------------------------------------------->

<cfif isDefined("form.btnAddCorpAffairs") or isDefined("form.btnEditCorpAffairs") or isDefined("form.btnUpdateCorpAffairs")>
	<cfinclude template="Corporate_Affairs_Edit.cfm">
<cfelse>
	<cfinclude template="Corporate_Affairs_Search.cfm">
</cfif>
