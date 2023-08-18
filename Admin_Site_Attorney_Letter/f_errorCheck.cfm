<!-------------------------------------------
Description:
	error checking

History:
	10/13/2022 - created
-------------------------------------------->

<cfif form.edittype EQ "AddAttorneyLetterRecord" and (not len(form.SiteID) or form.SiteID EQ 0)>
	<cfset ArrayAppend(arrErrors, "select the site") />
</cfif>

<cfif not len(form.DocumentName)>
	<cfset ArrayAppend(arrErrors, "enter the document name") />
</cfif>

<cfif form.edittype EQ "AddAttorneyLetterRecord" and not len(form.FileName)>
	<cfset ArrayAppend(arrErrors, "select the file to upload") />
</cfif>

<cfif ArrayLen(arrErrors)>
	<cfset msgSuccess = "">
<cfelse>
	<cfset msgSuccess = "The information has been updated">
</cfif>
