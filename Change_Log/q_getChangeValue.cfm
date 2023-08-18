<!----------------------------------------------------------------------------------------------------------
Description:
	get the Change Value for an FCO that has been processed

History:
	7/21/2022 - created
----------------------------------------------------------------------------------------------------------->

<CFQUERY NAME="getUniqueRows" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT ID
	FROM PPMH.dbo.Change_Log_Milestone_New
	WHERE (Change_Log_ID = #attributes.CLID#)
	ORDER BY ID
</CFQUERY>

<cfset ChangeValue = 0>
<cfset TotalCurrent = 0>
<cfset TotalNew = 0>
<cfloop query="getUniqueRows" >
	<CFQUERY NAME="getValueTotal" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT  SUM(Quantity_Current * Milestone_Amount_Current) AS CurrentValueTotal, SUM(Quantity_New * Milestone_Amount_New) AS NewValueTotal
		FROM PPMH.dbo.Change_Log_Milestone_New
		WHERE (ID = #getUniqueRows.ID#)
	</CFQUERY>
	<cfset TotalCurrent = TotalCurrent+ getValueTotal.CurrentValueTotal>
	<cfset TotalNew = TotalNew+ getValueTotal.NewValueTotal>
</cfloop>
<cfset ChangeValue = TotalNew - TotalCurrent>

<CFSET "Caller.#Attributes.Return#" = ChangeValue>
