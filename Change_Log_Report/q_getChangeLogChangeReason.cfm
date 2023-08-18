<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the Change Log Change Reason

History:
	9/20/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the Change Log Change Reason --->
<cfif Attributes.VType EQ "V1">
	<cfquery name="getChangeReasonIDs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Change_Reason_ID
		FROM #Request.WebSite#.dbo.Change_Log_V1
		WHERE (Change_Log_ID = #Attributes.CLID#)
	</cfquery>
	<cfquery name="getChangeLogChangeReason" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Change_Reason_ID, Change_Reason
		FROM #Request.WebSite#.dbo.Change_Log_Change_Reason_V1
		WHERE (Change_Reason_ID IN (#getChangeReasonIDs.Change_Reason_ID#))
		Order by Change_Reason_ID
	</cfquery>
</cfif>

<cfset ChangeReasons = valuelist(getChangeLogChangeReason.Change_Reason, ", ")>
<CFSET "Caller.#Attributes.Return#" = ChangeReasons>
