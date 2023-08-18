<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the Change Log Change Reason

History:
	5/18/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the Change Log Change Reason --->
<cfquery name="getChangeLogChangeReason" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT Change_Reason_ID, Change_Reason
	FROM PPMH.dbo.Change_Log_Change_Reason_V1
	WHERE Active = 1
	<cfif isDefined("getChangeLogs.Change_Reason_ID")>
		and Change_Reason_ID in (#getChangeLogs.Change_Reason_ID#)
	</cfif>
	Order by Change_Reason_ID
</cfquery>
<cfset vChangeReasons = valuelist(getChangeLogChangeReason.Change_Reason, ", ")>
