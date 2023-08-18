<!----------------------------------------------------------------------------------------------------------
Description:
	get Attorney Letter info

History:
	10/13/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getAttorneyLetterInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.ID, a.Site_ID, a.Document_Name, a.File_Name,
				 b.Site_ID as AdminSiteID, b.Site_Name, b.Attorney_Engagement
	FROM TurboScope.dbo.Admin_Site_Attorney_Letter as a
		INNER JOIN TurboScope.dbo.Admin_Site AS b ON a.Site_ID = b.id
	WHERE a.ID = #form.edtAttorneyLetterID#
</cfquery>
