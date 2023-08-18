<!----------------------------------------------------------------------------------------------------------
Description:
	delete regulatory record

History:
	2/7/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- delete the record --->
<cfquery name="deleteRegulatory" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	DELETE
	FROM PPMH.dbo.Regulatory
	WHERE ID = '#form.RegulatoryID#'
</cfquery>
