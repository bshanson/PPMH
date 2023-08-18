<!----------------------------------------------------------------------------------------------------------
Description:
	get site's attorney letters

History:
	10/11/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getSiteAttorneyLetters" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT ID, Site_ID, Document_Name, File_Name
	FROM TurboScope.dbo.Admin_Site_Attorney_Letter
	WHERE Site_ID = <cfqueryparam value="#getAttorneyLetters.AdminID#" cfsqltype="cf_sql_integer" >
</cfquery>
