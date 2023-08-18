<!-------------------------------------------
Description:
	get the Tab ID

History:
	03/06/2015 - created
-------------------------------------------->

<!--- get the Tab ID --->
<CFQUERY NAME="getTabID" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.ID, a.ParentID
	FROM #Attributes.Database#.dbo.Portal as a
	WHERE (a.Label = '#Attributes.Label#')
				AND a.Active=1
				<cfif isDefined("Attributes.AccessLevel")>AND a.AccessLevel=#Attributes.AccessLevel#</cfif>
</CFQUERY>

<cfif getTabID.ParentID NEQ 0>
	<CFSET "Caller.#Attributes.Return#"="#Request.Protocol#//#HTTP.Server_Name#/#Attributes.WebSite#/index.cfm?TabID=#getTabID.ParentID#&child=#getTabID.ID#">
<cfelse>
	<CFSET "Caller.#Attributes.Return#"="#Request.Protocol#//#HTTP.Server_Name#/#Attributes.WebSite#/index.cfm?TabID=#getTabID.ID#">
</cfif>
