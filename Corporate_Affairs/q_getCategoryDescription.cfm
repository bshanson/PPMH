<!--------------------------------------------------------------
Description:
	get the Category Description pairs

History:
	1/11/2022 - created
--------------------------------------------------------------->

<!--- get the Category Description pairs --->
<CFQUERY NAME="getCategoryDescription" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT b.Trigger_Category_ID, b.Trigger_Category, a.Trigger_Description
	FROM #Request.WebSite#.dbo.Corporate_Affairs_Trigger_Description as a
		inner join #Request.WebSite#.dbo.Corporate_Affairs_Trigger_Category as b on a.Trigger_Category_ID = b.Trigger_Category_ID 
	Where Trigger_Description_ID in (#Attributes.TD#)
	ORDER BY b.Trigger_Category_ID, a.Trigger_Description_ID
</CFQUERY>
<CFSET "Caller.#Attributes.Return#" = "#getCategoryDescription#">
