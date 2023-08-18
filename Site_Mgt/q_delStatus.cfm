<!----------------------------------------------------------------------------------------------------------
Description:
	delete status and milestone status

History:
	2/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- delete the status --->
<cfquery name="delStatus" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	DELETE
	FROM PPMH.dbo.Site_Status
	WHERE Status_ID = '#form.delStatusID#'
</cfquery>
