<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the Change Log Types

History:
	9/20/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the Change Log Change Type --->
<cfif Attributes.VType EQ "V1">
	<cfquery name="getChangeTypeIDs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Change_Type_ID
		FROM #Request.WebSite#.dbo.Change_Log_V1
		WHERE (Change_Log_ID = #Attributes.CLID#)
	</cfquery>
	<cfquery name="getChangeLogChangeType" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Change_Type_ID, Change_Type
		FROM #Request.WebSite#.dbo.Change_Log_Change_Type_V1
		WHERE (Change_Type_ID IN (#getChangeTypeIDs.Change_Type_ID#))
		Order by Change_Type_ID
	</cfquery>
</cfif>

<cfif Attributes.VType EQ "V2">
	<cfquery name="getChangeLogChangeType" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT a.Change_Type_ID, b.Change_Type
		FROM #Request.WebSite#.dbo.Change_Log_Milestone as a
		inner join #Request.WebSite#.dbo.Change_Log_Change_Type as b on a.Change_Type_ID=b.Change_Type_ID
		WHERE (a.Change_Log_ID = #Attributes.CLID#)
		Order by a.Change_Type_ID
	</cfquery>
</cfif>

<cfset ChangeTypes = valuelist(getChangeLogChangeType.Change_Type)>
<CFSET "Caller.#Attributes.Return#" = ChangeTypes>
