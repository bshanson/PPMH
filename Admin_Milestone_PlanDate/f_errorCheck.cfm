<!-------------------------------------------
Description:
	error checking

History:
	9/8/2022 - created
-------------------------------------------->

<!--- Plan Month --->
<cfif len(form.PlanMonth) and form.PlanMonth EQ 0>
	<cfset ArrayAppend(arrErrors, "select the plan month") />
</cfif>	

<!--- Plan Year --->
<cfif len(form.PlanYear) and form.PlanYear EQ 0>
	<cfset ArrayAppend(arrErrors, "select the plan year") />
</cfif>	

<cfif ArrayLen(arrErrors)>
	<cfset msgSuccess = "">
<cfelse>
	<cfset msgSuccess = "The information has been updated">
</cfif>
