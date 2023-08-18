<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the FCO milestones

History:
	1/4/2023 - created
----------------------------------------------------------------------------------------------------------->

<cfset FCOMilestones = ''>
<cfif attributes.VER EQ "v1">
	<cfquery name="getFCOMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Change_Log_ID, Milestone_List
		FROM PPMH.dbo.Change_Log_V1
		WHERE Change_Log_ID = #attributes.CLID#
	</cfquery>
	<cfset FCOMilestones = getFCOMilestones.Milestone_List>
<cfelse>
	<cfquery name="getFCOMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT a.Milestone_ID, b.milestone
		FROM PPMH.dbo.Change_Log_Milestone as a
		inner join PPMH.dbo.Milestones as b on a.Milestone_ID = b.id
		WHERE Change_Log_ID = #attributes.CLID#
	</cfquery>
	<cfif getFCOMilestones.recordcount NEQ 0><cfset FCOMilestones = valuelist(getFCOMilestones.milestone)></cfif>
</cfif>

<CFSET "Caller.#Attributes.Return#" = FCOMilestones>
