<!-------------------------------------------
Description:
	error checking

History:
	7/15/2022 - created
-------------------------------------------->

<!--- Site ID --->
<cfif not len(form.SiteID) or (len(form.SiteID) and form.SiteID EQ 0)>
	<cfset ArrayAppend(arrErrors, "select the site") />
</cfif>	

<!--- Milestone --->
<cfif len(form.MilestoneID) and form.MilestoneID EQ 0>
	<cfset ArrayAppend(arrErrors, "select the milestone") />
</cfif>	

<!--- Anticipated Month --->
<cfif len(form.AnticipatedClaimMonth) and form.AnticipatedClaimMonth EQ 0>
	<cfset ArrayAppend(arrErrors, "select the anticipated month") />
</cfif>	

<!--- Anticipated Year --->
<cfif len(form.AnticipatedClaimYear) and form.AnticipatedClaimYear EQ 0>
	<cfset ArrayAppend(arrErrors, "select the anticipated year") />
</cfif>	

<!--- Milestone Amount --->
<cfif len(form.MilestoneAmount) and not isnumeric(form.MilestoneAmount)>
	<cfset ArrayAppend(arrErrors, "enter a numeric Amount value") />
</cfif>	
<cfif len(form.MilestoneAmount) and isnumeric(form.MilestoneAmount) and form.MilestoneAmount EQ 0>
	<cfset ArrayAppend(arrErrors, "enter an amount greater than 0") />
</cfif>	

<!--- Probability --->
<cfif len(form.WatchlistProbability) and not isnumeric(form.WatchlistProbability)>
	<cfset ArrayAppend(arrErrors, "enter a numeric probability value") />
</cfif>	
<cfif len(form.WatchlistProbability) and isnumeric(form.WatchlistProbability) and (form.WatchlistProbability EQ 0 or form.WatchlistProbability GT 100)>
	<cfset ArrayAppend(arrErrors, "enter a probability greater than 0 and less than or equal to 100") />
</cfif>	

<cfif ArrayLen(arrErrors)>
	<cfset msgSuccess = "">
<cfelse>
	<cfset msgSuccess = "The information has been updated">
</cfif>
