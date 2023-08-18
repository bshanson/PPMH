<!-------------------------------------------
Description:
	delete the Site Milestone info

History:
	1/27/2021 - created
-------------------------------------------->

<!--- see if any milestone docs were uploaded --->
<CFQUERY NAME="getSiteMilestoneDocs" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	select Milestone_Doc
	from PPMH.dbo.Site_Milestones
	WHERE ID = <cfqueryparam value="#form.delSiteMilestoneID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>
<cfif len(getSiteMilestoneDocs.Milestone_Doc)>
	<cfif FileExists("#Request.UploadPath#\#getSiteMilestoneDocs.Milestone_Doc#")>
		<CFFILE action="DELETE" file="#Request.UploadPath#\#getSiteMilestoneDocs.Milestone_Doc#">
	</cfif>
</cfif>

<!--- delete Site Milestone --->
<CFQUERY NAME="deleteSiteMilestoneInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	delete 
	from PPMH.dbo.Site_Milestones
	WHERE ID = <cfqueryparam value="#form.delSiteMilestoneID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>

<cfset msgSuccess = "*** The information has been updated ***">
