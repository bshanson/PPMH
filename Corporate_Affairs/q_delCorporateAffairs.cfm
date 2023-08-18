<!----------------------------------------------------------------------------------------------------------
Description:
	delete Corporate Affairs record

History:
	1/11/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- delete the triggers --->
<cfquery name="deleteCorporateAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	DELETE
	FROM #Request.WebSite#.dbo.Corporate_Affairs_Trigger_List
	WHERE Corporate_Affairs_ID = '#form.delCorporateAffairsID#'
</cfquery>

<!--- delete the record --->
<cfquery name="deleteCorporateAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	DELETE
	FROM #Request.WebSite#.dbo.Corporate_Affairs
	WHERE Corporate_Affairs_ID = '#form.delCorporateAffairsID#'
</cfquery>
