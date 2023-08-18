<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the Change Log Entity

History:
	5/18/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the Change Log Entity --->
<cfquery name="getChangeLogEntity" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT Initiating_Entity_ID, Initiating_Entity
	FROM PPMH.dbo.Change_Log_Entity_V1
	WHERE Active = 1
	Order by Initiating_Entity
</cfquery>
