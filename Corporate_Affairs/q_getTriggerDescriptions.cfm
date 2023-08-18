<!--------------------------------------------------------------
Description:
	get the Trigger Descriptions

History:
	1/11/2022 - created
--------------------------------------------------------------->

<!--- get the Trigger Descriptions --->
<CFQUERY NAME="getTriggerDescriptions" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Trigger_Description_ID, Trigger_Description
	FROM #Request.WebSite#.dbo.Corporate_Affairs_Trigger_Description
	Where Active = 1
		<cfif isDefined("getTriggerCategorys.Trigger_Category_ID")>and Trigger_Category_ID = #getTriggerCategorys.Trigger_Category_ID#</cfif>
	ORDER BY Trigger_Description_ID
</CFQUERY>
