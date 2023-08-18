<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the finalized date

History:
	1/3/2023 - created
----------------------------------------------------------------------------------------------------------->

<cfif attributes.VER EQ "v1">
	<cfquery name="getFinalizedDate" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Chevron_PM_Approval_Date as Finalized_Date 
		FROM PPMH.dbo.Change_Log_V1
		WHERE Change_Log_ID = #attributes.CLID#
	</cfquery>
<cfelse>
	<cfquery name="getFinalizedDate" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT MAX(Status_Date) AS Finalized_Date 
		FROM PPMH.dbo.Change_Log_History
		WHERE Change_Log_ID = #attributes.CLID#
				and Status_ID = 4
	</cfquery>
</cfif>

<CFSET "Caller.#Attributes.Return#" = getFinalizedDate>
