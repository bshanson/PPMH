<!----------------------------------------------------------------------------------------------------------
Description:
	delete change log record

History:
	4/3/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the FCO document name --->
<CFQUERY NAME="getFCODoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select FCO_File_Name
	from PPMH.dbo.Change_Log_V1
	WHERE Change_Log_ID = '#form.delChangeLogID#'
</CFQUERY>

<!--- delete the FCO document --->
<cfif len(getFCODoc.FCO_File_Name)>
	<cfif FileExists("#Request.FCOUploadPath#\#getFCODoc.FCO_File_Name#")>
		<CFFILE 
			action="DELETE" 
			file="#Request.FCOUploadPath#\#getFCODoc.FCO_File_Name#">
	</cfif>
</cfif>

<!--- delete the record --->
<cfquery name="deleteChangeLog" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	DELETE
	FROM PPMH.dbo.Change_Log_V1
	WHERE Change_Log_ID = '#form.delChangeLogID#'
</cfquery>
