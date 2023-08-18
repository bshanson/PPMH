<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to add watchlist milestone information

History:
	7/15/2022 - created
--------------------------------------------------------------------------------------------------------------------------------->

<cfset form.MilestoneAmount = Replace(form.MilestoneAmount, "$", "")>
<cfset form.MilestoneAmount = Replace(form.MilestoneAmount, ",", "", "all" )>
<cfset form.WatchlistProbability = Replace(form.WatchlistProbability, "%", "" )>

<!--- errorcheck --->
<cfinclude template="f_errorCheck.cfm">

<cfif not ArrayLen(arrErrors)>
	<!--- update database --->
	<CFQUERY NAME="addWatchlistMilestone" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		insert into #Request.WebSite#.dbo.Site_Milestone_Watchlist
			(Site_ID, Milestone_ID, Milestone_Amount, Anticipated_Claim_Month, Anticipated_Claim_Year, Watchlist_Probability, ACS, Notes)
		values
			(<cfqueryparam value="#form.SiteID#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.MilestoneID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.MilestoneAmount#" cfsqltype="cf_sql_real" >
			,<cfqueryparam value="#form.AnticipatedClaimMonth#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.AnticipatedClaimYear#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.WatchlistProbability#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.ACS#" cfsqltype="CF_SQL_INTEGER" >
			,<cfqueryparam value="#form.Notes#" cfsqltype="cf_sql_longvarchar" >
			)
	</CFQUERY>

	<!--- get the id of the new record --->
	<CFQUERY NAME="getNewID" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select max(id) as newID from #Request.WebSite#.dbo.Site_Milestone_Watchlist
	</CFQUERY>
	<cfset msgSuccess = "The information has been updated">
</cfif>
