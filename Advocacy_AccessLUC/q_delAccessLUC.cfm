<!----------------------------------------------------------------------------------------------------------
Description:
	delete AccessLUC record

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the LUC document name --->
<CFQUERY NAME="getLUCDoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select Final_Document
	from #Request.WebSite#.dbo.AccessLUC
	WHERE ID = '#form.delAccessLUCID#'
</CFQUERY>

<!--- delete the LUC document --->
<cfif len(getLUCDoc.Final_Document)>
	<cfif FileExists("#Request.LUCUploadPath#\#getLUCDoc.Final_Document#")>
		<CFFILE 
			action="DELETE" 
			file="#Request.LUCUploadPath#\#getLUCDoc.Final_Document#">
	</cfif>
</cfif>

<!--- delete the record --->
<cfquery name="deleteAccessLUC" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	DELETE
	FROM #Request.WebSite#.dbo.AccessLUC
	WHERE ID = '#form.delAccessLUCID#'
</cfquery>
