<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the Change Log Reason Detail

History:
	5/18/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the Change Log Reason Detail --->
<cfquery name="getChangeLogReasonDetail" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT Reason_Detail_ID, Reason_Detail
	FROM PPMH.dbo.Change_Log_Reason_Detail_V1
	WHERE Active = 1
	<cfif isDefined("getChangeLogs.Reason_Detail_ID")>
		and Reason_Detail_ID in (#getChangeLogs.Reason_Detail_ID#)
	</cfif>
	Order by Reason_Detail_ID
</cfquery>
<cfset vReasonDetails = valuelist(getChangeLogReasonDetail.Reason_Detail, ", ")>
