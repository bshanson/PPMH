<!-------------------------------------------
Description:
	Attorney Letter controller page

History:
	10/13/2022 - created
-------------------------------------------->

<cfif isDefined("form.BTNADDTYPE.X") or isDefined("form.BTNEDITTYPE.X") or isDefined("form.btnUpdateAttorneyLetter")>
	<cfinclude template="Attorney_Letter_Edit.cfm">
<cfelse>
	<cfinclude template="Attorney_Letter_Search.cfm">
</cfif>
