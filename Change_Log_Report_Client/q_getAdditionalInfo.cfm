<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the addtional information

History:
	5/18/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the addtional information --->
<cfif Attributes.VType EQ "V1">
	<cfquery name="getAdditionalInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Additional_Information
		FROM #Request.WebSite#.dbo.Change_Log_V1
		WHERE (Change_Log_ID = #Attributes.CLID#)
	</cfquery>
</cfif>

<cfif Attributes.VType EQ "V2">
	<cfquery name="getAdditionalInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Site_Specific_Assumptions as Additional_Information
		FROM #Request.WebSite#.dbo.Change_Log
		WHERE (Change_Log_ID = #Attributes.CLID#)
	</cfquery>
</cfif>
<CFSET "Caller.#Attributes.Return#" = getAdditionalInfo.Additional_Information>
