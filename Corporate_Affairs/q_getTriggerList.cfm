<!----------------------------------------------------------------------------------------------------------
Description:
	get list of triggers in selected record

History:
	1/11/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the Trigger List records --->
<cfquery name="getTriggerList" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT Trigger_Description_ID
	FROM #Request.WebSite#.dbo.Corporate_Affairs_Trigger_List
	WHERE Corporate_Affairs_ID = #Attributes.CAID#
</cfquery>

<cfset TriggerList = valuelist(getTriggerList.Trigger_Description_ID)>
<CFSET "Caller.#Attributes.Return#" = "#TriggerList#">
