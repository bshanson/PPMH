<!-------------------------------------------
Description:
	Account controller page

History:
	1/11/2019 - created
-------------------------------------------->

<cfif isDefined("form.btnAddAccnt") or isDefined("form.btnEditAccnt.x") or isDefined("form.btnUpdateAccount")>
	<cfinclude template="Account_Edit.cfm">
<cfelse>
	<cfinclude template="Account_Search.cfm">
</cfif>
