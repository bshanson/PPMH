<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the Milestone List

History:
	9/20/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the Milestone List --->
<cfif Attributes.VType EQ "V1">
	<cfquery name="getMilestoneList" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Milestone_List
		FROM #Request.WebSite#.dbo.Change_Log_V1
		WHERE (Change_Log_ID = #Attributes.CLID#)
	</cfquery>
	<cfset MilestoneList = getMilestoneList.Milestone_List>
</cfif>

<cfif Attributes.VType EQ "V2">
	<cfquery name="getMilestoneList" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT DISTINCT a.Milestone_ID, a.Change_Type_ID, a.Unique_Row, 
			b.Milestone,
			c.Change_Type,
			d.Change_Reason
		FROM #Request.WebSite#.dbo.Change_Log_Milestone as a
			INNER JOIN #Request.WebSite#.dbo.Milestones AS b ON a.Milestone_ID = b.id
			left JOIN #Request.WebSite#.dbo.Change_Log_Change_Type AS c ON a.Change_Type_ID = c.Change_Type_ID
			left JOIN #Request.WebSite#.dbo.Change_Log_Change_Reason AS d ON a.Change_Reason_ID = d.Change_Reason_ID
		WHERE (a.Change_Log_ID = #Attributes.CLID#)
	</cfquery>
	<cfset MilestoneList = getMilestoneList>
</cfif>

<CFSET "Caller.#Attributes.Return#" = MilestoneList>
