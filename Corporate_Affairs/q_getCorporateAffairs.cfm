<!----------------------------------------------------------------------------------------------------------
Description:
	get Corporate Affairs records

History:
	1/11/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the Corporate Affairs records --->
<cfquery name="getCorporateAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Corporate_Affairs_ID, a.Trigger_Description_ID,
		b.Trigger_Category_ID, b.Trigger_Description,
		c.Trigger_Category
	FROM #Request.WebSite#.dbo.Corporate_Affairs_Trigger_List as a
		inner join #Request.WebSite#.dbo.Corporate_Affairs_Trigger_Description as b on a.Trigger_Description_ID = b.Trigger_Description_ID and b.active=1
		inner join #Request.WebSite#.dbo.Corporate_Affairs_Trigger_Category as c on b.Trigger_Category_ID = c.Trigger_Category_ID and c.active=1
	WHERE a.Corporate_Affairs_ID = #Attributes.CAID#
</cfquery>
<CFSET "Caller.#Attributes.Return#" = "#getCorporateAffairs#">
