<!-------------------------------------------
Description:
	delete the Watchlist Milestone info

History:
	7/15/2022 - created
-------------------------------------------->

<!---<!--- see if any milestone docs were uploaded --->
<CFQUERY NAME="getWatchlistMilestoneDocs" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	select Milestone_Doc
	from #Request.WebSite#.dbo.Site_Milestone_Watchlist
	WHERE ID = <cfqueryparam value="#form.delWatchlistMilestoneID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>
<cfif len(getWatchlistMilestoneDocs.Milestone_Doc)>
	<cfif FileExists("#Request.UploadPath#\#getWatchlistMilestoneDocs.Milestone_Doc#")>
		<CFFILE action="DELETE" file="#Request.UploadPath#\#getWatchlistMilestoneDocs.Milestone_Doc#">
	</cfif>
</cfif>--->

<!--- delete Watchlist Milestone --->
<CFQUERY NAME="deleteWatchlistMilestoneInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	delete 
	from #Request.WebSite#.dbo.Site_Milestone_Watchlist
	WHERE ID = <cfqueryparam value="#form.delWatchlistMilestoneID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>

<cfset msgSuccess = "*** The information has been updated ***">
