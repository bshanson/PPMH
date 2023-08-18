<!-------------------------------------------
Description:
	Regulatory controller page

History:
	2/7/2020 - created
-------------------------------------------->

<cfif isDefined("form.btnAddRegulatory") or isDefined("form.btnEditRegulatory") or isDefined("form.btnUpdateRegulatory")>
	<cfinclude template="Regulatory_Edit.cfm">
<cfelse>
	<cfinclude template="Regulatory_Search.cfm">
</cfif>
