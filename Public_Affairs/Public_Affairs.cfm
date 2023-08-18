<!-------------------------------------------
Description:
	Public_Affairs controller page

History:
	5/24/2021 - created
-------------------------------------------->

<cfif isDefined("form.btnAddPublicAffairs") or isDefined("form.btnEditPublicAffairs") or isDefined("form.btnUpdatePublicAffairs")>
	<cfinclude template="Public_Affairs_Edit.cfm">
<cfelse>
	<cfinclude template="Public_Affairs_Search.cfm">
</cfif>
