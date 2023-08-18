<!-------------------------------------------
Description:
	query to get the info from Change_Log and update Portfolio_ID
-------------------------------------------->

<!--- get Change_Log --->
<CFQUERY NAME="getChangeLogs" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT ID, Change_Log_ID, Milestone_ID, Change_Type_ID, Change_Reason_ID, Unique_Row
	FROM ppmh.dbo.Change_Log_Milestone
	WHERE (Unique_Row LIKE '%-%-%')
	ORDER BY ID
</CFQUERY>
<cfloop query="getChangeLogs">
	<CFQUERY NAME="getDups" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		SELECT ID, Change_Log_ID, Milestone_ID, Change_Type_ID, Change_Reason_ID, Unique_Row
		FROM ppmh.dbo.Change_Log_Milestone
		WHERE ID <> #getChangeLogs.ID#
			<cfif len(getChangeLogs.Change_Log_ID)>and Change_Log_ID = #getChangeLogs.Change_Log_ID#</cfif>
			<cfif len(getChangeLogs.Milestone_ID)>and Milestone_ID = #getChangeLogs.Milestone_ID#</cfif>
			<cfif len(getChangeLogs.Change_Type_ID)>and Change_Type_ID = #getChangeLogs.Change_Type_ID#</cfif>
			<cfif len(getChangeLogs.Change_Reason_ID)>and Change_Reason_ID = #getChangeLogs.Change_Reason_ID#</cfif>
			and Unique_Row = '#getChangeLogs.Unique_Row#'
	</CFQUERY>
	<cfif getDups.RecordCount NEQ 0><cfoutput>#getDups.Change_Log_ID#,</cfoutput><br></CFIF>
</cfloop>
done