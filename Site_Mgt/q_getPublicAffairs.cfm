<!----------------------------------------------------------------------------------------------------------
Description:
	get PublicA ffairs records

History:
	5/25/2021 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the Public Affairs records --->
<cfquery name="getPublicAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Public_Affairs_ID, a.Q1, a.Q2, a.Q3, a.Q4, a.Q5, a.Q6, a.Q7, a.Q8, a.Assessment_Date, a.Comments_Date
	FROM PPMH.dbo.Public_Affairs as a
	WHERE a.Site_ID = #attributes.AdminSiteID#
	ORDER BY a.Assessment_Date desc
</cfquery>
<CFSET "Caller.#Attributes.Return#" = getPublicAffairs>
