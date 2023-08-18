<!----------------------------------------------------------------------------------------------------------
Description:
	get AccessLUC records

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the AccessLUC records --->
<cfquery name="getAccessLUC" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.ID as AccessLUC_ID, a.Complete_Date, a.SPL_ID, a.SPL_Notes
	FROM PPMH.dbo.AccessLUC as a
	WHERE a.Site_ID = #attributes.AdminSiteID#
	ORDER BY a.Current_CA_Status_Date desc
</cfquery>
<CFSET "Caller.#Attributes.Return#" = getAccessLUC>
