<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to update Watchlist Milestone information

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
	<CFQUERY NAME="updWatchlistMilestone" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		update #Request.WebSite#.dbo.Site_Milestone_Watchlist
		set Milestone_ID = <cfqueryparam value="#form.MilestoneID#" cfsqltype="cf_sql_integer" >
			,Milestone_Amount = <cfqueryparam value="#form.MilestoneAmount#" cfsqltype="cf_sql_real" >
			,Anticipated_Claim_Month = <cfqueryparam value="#form.AnticipatedClaimMonth#" cfsqltype="cf_sql_integer" >
			,Anticipated_Claim_Year = <cfqueryparam value="#form.AnticipatedClaimYear#" cfsqltype="cf_sql_integer" >
			,Watchlist_Probability = <cfqueryparam value="#form.WatchlistProbability#" cfsqltype="cf_sql_integer" >
			,ACS = <cfqueryparam value="#form.ACS#" cfsqltype="CF_SQL_INTEGER" >
			,Notes = <cfqueryparam value="#form.Notes#" cfsqltype="cf_sql_longvarchar" >
		where ID = #form.edtWatchlistMilestoneID#
	</CFQUERY>

	<cfset msgSuccess = "The information has been updated">
</cfif>
