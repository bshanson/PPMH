<!----------------------------------------------------------------------------------------------------------
Description:
	delete public affairs record

History:
	5/24/2021 - created
----------------------------------------------------------------------------------------------------------->

<!--- delete the record --->
<cfquery name="delPublicAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	DELETE
	FROM PPMH.dbo.Public_Affairs
	WHERE Public_Affairs_ID = '#form.PublicAffairsID#'
</cfquery>
