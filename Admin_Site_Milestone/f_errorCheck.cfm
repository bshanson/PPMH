<!-------------------------------------------
Description:
	error checking

History:
	1/27/2021 - created
-------------------------------------------->

<!--- Portfolio ID --->
<cfif len(form.PortfolioID) and form.PortfolioID EQ 0>
	<cfset ArrayAppend(arrErrors, "select the portfolio") />
</cfif>	

<!--- Site ID --->
<cfif not len(form.SiteID) or (len(form.SiteID) and form.SiteID EQ 0)>
	<cfset ArrayAppend(arrErrors, "select the site") />
</cfif>	

<!--- Milestone --->
<cfif len(form.MilestoneID) and form.MilestoneID EQ 0>
	<cfset ArrayAppend(arrErrors, "select the milestone") />
</cfif>	

<!--- Milestone Amount --->
<cfif not len(form.MilestoneAmount)>
	<cfset ArrayAppend(arrErrors, "enter a numeric Amount value") />
</cfif>	
<cfif len(form.MilestoneAmount) and not isnumeric(form.MilestoneAmount)>
	<cfset ArrayAppend(arrErrors, "enter a numeric Amount value") />
</cfif>	
<cfif len(form.MilestoneAmount) and isnumeric(form.MilestoneAmount) and form.MilestoneAmount EQ 0>
	<cfset ArrayAppend(arrErrors, "enter an Amount greater than 0") />
</cfif>	

<!--- Year --->
<cfif len(form.Year) and (form.Year EQ 0)>
	<cfset ArrayAppend(arrErrors, "select the year") />
</cfif>	

<!--- Plan Month --->
<cfif len(form.PlanMonth) and form.PlanMonth EQ 0>
	<cfset ArrayAppend(arrErrors, "select the plan month") />
</cfif>	

<!--- Plan Year --->
<cfif len(form.PlanYear) and form.PlanYear EQ 0>
	<cfset ArrayAppend(arrErrors, "select the plan year") />
</cfif>	

<!--- Baseline Month --->
<cfif len(form.BaselineMonth) and form.BaselineMonth EQ 0>
	<cfset ArrayAppend(arrErrors, "select the baseline month") />
</cfif>	

<!--- Baseline Year --->
<cfif len(form.BaselineYear) and form.BaselineYear EQ 0>
	<cfset ArrayAppend(arrErrors, "select the baseline year") />
</cfif>	

<cfif ArrayLen(arrErrors)>
	<cfset msgSuccess = "">
<cfelse>
	<cfset msgSuccess = "The information has been updated">
</cfif>
