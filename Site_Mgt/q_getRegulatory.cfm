<!----------------------------------------------------------------------------------------------------------
Description:
	get regulatory records

History:
	2/7/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the regulatory records --->
<cfquery name="getRegulatory" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.ID as Regulatory_ID, a.Regulatory_Action, a.Regulatory_Date, a.Complete, a.Complete_Date
	FROM PPMH.dbo.Regulatory as a
	WHERE a.Site_ID = #attributes.AdminSiteID#
	ORDER BY a.Regulatory_Date desc
</cfquery>
<CFSET "Caller.#Attributes.Return#" = getRegulatory>
