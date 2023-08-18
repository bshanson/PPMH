<!----------------------------------------------------------------------------------------------------------
Description:
	get the Change Value for an FCO that has been processed

History:
	7/21/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfif Attributes.VType EQ "V1">
	<cfquery name="getValueTotal" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Change_Value
		FROM #Request.WebSite#.dbo.Change_Log_V1
		WHERE (Change_Log_ID = #Attributes.CLID#)
	</cfquery>
	<CFSET "Caller.#Attributes.Return#" = getValueTotal>
</cfif>

<cfif Attributes.VType EQ "V2">
	<cfset ChangeValue = 0>
	<cfset TotalCurrent = 0>
	<cfset TotalNew = 0>
	<CFQUERY NAME="getValueTotal" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT SUM(Quantity_Current * Milestone_Amount_Current) AS CurrentValueTotal, SUM(Quantity_New * Milestone_Amount_New) AS NewValueTotal
		FROM #Request.WebSite#.dbo.Change_Log_Milestone_New
		WHERE (Change_Log_ID = #attributes.CLID#) 
			<cfif isDefined("attributes.UR")>AND (Unique_Row = '#attributes.UR#')</cfif>
	</CFQUERY>
	<CFSET "Caller.#Attributes.Return#" = getValueTotal>
</cfif>
