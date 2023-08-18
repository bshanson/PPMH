<!-------------------------------------------
Description:
	query to delete site Attorney Letter information

History:
	10/13/2022 - created
-------------------------------------------->

<!--- see if any letters were uploaded --->
<CFQUERY NAME="getAttorneyLetters" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	select File_Name
	from TurboScope.dbo.Admin_Site_Attorney_Letter
	WHERE ID = <cfqueryparam value="#form.delAttorneyLetterID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>
<cfif len(getAttorneyLetters.File_Name)>
	<cfif FileExists("#Request.AttorneyUploadPath#\#getAttorneyLetters.File_Name#")>
		<CFFILE action="DELETE" file="#Request.AttorneyUploadPath#\#getAttorneyLetters.File_Name#">
	</cfif>
</cfif>

<!--- delete the record --->
<CFQUERY NAME="deleteWatchlistMilestoneInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	delete 
	from TurboScope.dbo.Admin_Site_Attorney_Letter
	WHERE ID = <cfqueryparam value="#form.delAttorneyLetterID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>

<cfset msgSuccess = "*** The information has been updated ***">
