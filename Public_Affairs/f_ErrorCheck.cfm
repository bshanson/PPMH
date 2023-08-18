<!----------------------------------------------------------------------------
Description:
	provides error checking of Public Affairs

History:
	5/24/2021 - created
----------------------------------------------------------------------------->

<cfif isDefined("form.AdminSiteID") and form.AdminSiteID EQ 0>
	<cfset ArrayAppend(errormsg, "select a site") />
</cfif>

<cfif not isDefined("form.q1") or not isDefined("form.q2") or not isDefined("form.q3") or not isDefined("form.q4")
	or not isDefined("form.q5") or not isDefined("form.q6") or not isDefined("form.q7") or not isDefined("form.q8")>
	<cfset ArrayAppend(errormsg, "answer all questions") />
</cfif>

<cfif isDefined("form.q1") and form.q1 EQ 1 and not len(form.q1describe)>
	<cfset ArrayAppend(errormsg, "question 1, please describe") />
</cfif>

<cfif isDefined("form.q2") and form.q2 EQ 1 and not len(form.q2describe)>
	<cfset ArrayAppend(errormsg, "question 2, please describe") />
</cfif>

<cfif isDefined("form.q3") and form.q3 EQ 1 and not len(form.q3describe)>
	<cfset ArrayAppend(errormsg, "question 3, please describe") />
</cfif>

<cfif isDefined("form.q4") and form.q4 EQ 1 and not len(form.q4describe)>
	<cfset ArrayAppend(errormsg, "question 4, please describe") />
</cfif>

<cfif isDefined("form.q5") and form.q5 EQ 1 and not len(form.q5describe)>
	<cfset ArrayAppend(errormsg, "question 5, please describe") />
</cfif>
<cfif isDefined("form.q6") and form.q6 EQ 1 and not len(form.q6describe)>
	<cfset ArrayAppend(errormsg, "question 6, please describe") />
</cfif>
<cfif isDefined("form.q7") and form.q7 EQ 1 and not len(form.q7describe)>
	<cfset ArrayAppend(errormsg, "question 7, please describe") />
</cfif>
<cfif isDefined("form.q8") and form.q8 EQ 1 and not len(form.q8describe)>
	<cfset ArrayAppend(errormsg, "question 8, please describe") />
</cfif>

<cfif not len(form.AssessmentDate)>
	<cfset ArrayAppend(errormsg, "enter the assessment date") />
</cfif>
<cfif len(form.AssessmentDate) and not isDate(form.AssessmentDate)>
	<cfset ArrayAppend(errormsg, "enter a valid assessment date") />
</cfif>
<cfif len(form.AssessmentDate) and isDate(form.AssessmentDate) and form.AssessmentDate LT "1/1/1900">
	<cfset ArrayAppend(errormsg, "enter a valid assessment date") />
</cfif>

<cfif ArrayLen(errormsg)>
	<cfset successmsg = "">
<cfelse>
	<cfset successmsg = "The information has been updated">
</cfif>
