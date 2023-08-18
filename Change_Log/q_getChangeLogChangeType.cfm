<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the Change Log Entity

History:
	5/18/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the Change Log Change Type --->
<cfquery name="getChangeLogChangeType" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT Change_Type_ID, Change_Type
	FROM #Request.WebSite#.dbo.Change_Log_Change_Type
	WHERE Active = 1
	<cfif isDefined("getChangeLogs.Change_Type_ID")>
		and Change_Type_ID in (#getChangeLogs.Change_Type_id#)
	</cfif>
	Order by Change_Type_ID
</cfquery>
<cfset vChangeTypes = valuelist(getChangeLogChangeType.Change_Type, ", ")>
