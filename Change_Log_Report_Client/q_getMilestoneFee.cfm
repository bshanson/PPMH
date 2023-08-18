<!----------------------------------------------------------------------------------------------------------
Description:
	get the milestone fee

History:
	9/20/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfif Attributes.VType EQ "V1">
	<cfset MilestoneFee = "0">
<cfelse>
	<cfset MilestoneFee = "">
</cfif>

<cfif Attributes.VType EQ "V2">
	<CFQUERY NAME="getUniqueRows" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Change_Type_ID, Unique_Row
		FROM #Request.WebSite#.dbo.Change_Log_Milestone
		WHERE (Change_Log_ID = #attributes.CLID#)
		ORDER BY Unique_Row
	</CFQUERY>
	
	<cfloop query="getUniqueRows" >
		<CFQUERY NAME="getValueTotal" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			SELECT SUM(Quantity_Current * Milestone_Amount_Current) AS CurrentValueTotal, SUM(Quantity_New * Milestone_Amount_New) AS NewValueTotal
			FROM #Request.WebSite#.dbo.Change_Log_Milestone_New
			WHERE (Change_Log_ID = #attributes.CLID#) AND (Unique_Row = '#getUniqueRows.Unique_Row#')
		</CFQUERY>
		<cfset MilestoneFee = listappend(MilestoneFee,getValueTotal.CurrentValueTotal)>
	</cfloop>
</cfif>

<CFSET "Caller.#Attributes.Return#" = MilestoneFee>
