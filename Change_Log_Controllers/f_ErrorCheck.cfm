<!----------------------------------------------------------------------------
Description:
	provides error checking of regulatory data

History:
	4/3/2020 - created
----------------------------------------------------------------------------->

<!--- site --->
<cfif form.AdminSiteID EQ 0>
	<cfset ArrayAppend(errormsg, "select a site") />
</cfif>

<!--- Portfolio --->
<cfif form.PortfolioID EQ 0>
	<cfset ArrayAppend(errormsg, "select the portfolio") />
</cfif>

<!--- Actual Change Log ID --->
<cfif not len(form.ActualChangeLogID)>
	<cfset ArrayAppend(errormsg, "enter the change log id") />
</cfif>

<!--- Date Logged --->
<cfif not isDate(form.DateLogged)>
	<cfset ArrayAppend(errormsg, "enter a valid date logged") />
</cfif>
<cfif isDate(Form.DateLogged) and form.DateLogged LT "1/1/1900">
	<cfset ArrayAppend(errormsg, "enter a valid date logged") />
</cfif>
<cfif isDate(Form.DateLogged) and isNumeric(left(form.DateLogged,2)) and left(form.DateLogged,2) GT 12>
	<cfset ArrayAppend(errormsg, "enter a valid date logged") />
</cfif>

<!--- Initiating Entity --->
<cfif form.InitiatingEntityID EQ 0>
	<cfset ArrayAppend(errormsg, "select the initiating entity") />
</cfif>

<!--- Change Type --->
<cfif not findnocase("ChangeTypeID",form.fieldnames) >
	<cfset ArrayAppend(errormsg, "select the change type") />
<cfelse>
	<cfif isDefined("form.ChangeTypeID9") and not len(form.ChangeTypeOther)>
		<cfset ArrayAppend(errormsg, "if other, enter the other change type") />
	</cfif>
</cfif>

<!--- Change Reason --->
<cfif not findnocase("ChangeReasonID",form.fieldnames) >
	<cfset ArrayAppend(errormsg, "select the reason for change") />
</cfif>

<!--- Reason Detail --->
<cfif not findnocase("ReasonDetailID",form.fieldnames) >
	<cfset ArrayAppend(errormsg, "select the reason detail") />
<cfelse>
	<cfif isDefined("form.ReasonDetailID21") and not len(form.ReasonDetailOther)>
		<cfset ArrayAppend(errormsg, "if other, enter the other reason detail") />
	</cfif>
</cfif>

<!--- Additional Information --->
<cfif not len(form.AdditionalInformation)>
	<cfset ArrayAppend(errormsg, "enter any additional information") />
</cfif>

<!--- Milestone List --->
<cfif not len(form.MilestoneList)>
	<cfset ArrayAppend(errormsg, "list any new milestones with fees, or enter NA") />
</cfif>

<!--- Monetary Value of Change --->
<cfif not len(form.ChangeValue)><cfset ArrayAppend(errormsg, "enter a value of change") /></cfif>
<cfif len(form.ChangeValue)>
	<cfset vChangeValue = form.ChangeValue>
	<cfset vChangeValue = replace(vChangeValue, "$", "", "all" )>
	<cfset vChangeValue = replace(vChangeValue, ",", "", "all" )>
	<cfset vChangeValue = replace(vChangeValue, ")", "", "all" )>
	<cfset vChangeValue = replace(vChangeValue, "(", "-", "all" )>
	<cfif not isNumeric(vChangeValue)><cfset ArrayAppend(errormsg, "enter a valid value of change") /></cfif>
</cfif>

<!--- Assumptions --->
<cfif not len(form.Assumptions)>
	<cfset ArrayAppend(errormsg, "enter any assumptions, or enter NA") />
</cfif>

<!--- Period of Performance End Date --->
<cfif not len(form.PerformancePeriodEndDate)>
	<cfset ArrayAppend(errormsg, "enter the period of performance end date, or enter NA") />
</cfif>
<cfif len(form.PerformancePeriodEndDate) and form.PerformancePeriodEndDate NEQ "NA">
	<cfif not isDate(form.PerformancePeriodEndDate) or (isDate(Form.PerformancePeriodEndDate) and form.PerformancePeriodEndDate LT "1/1/1900")>
		<cfset ArrayAppend(errormsg, "enter a valid period of performance end date, or enter NA") />
	</cfif>
	<cfif isDate(Form.PerformancePeriodEndDate) and isNumeric(left(form.PerformancePeriodEndDate,2)) and left(form.PerformancePeriodEndDate,2) GT 12>
		<cfset ArrayAppend(errormsg, "enter a valid period of performance end date, or enter NA") />
	</cfif>
</cfif>

<!--- Portfolio Manager --->
<cfif form.PortfolioManagerID EQ 0>
	<cfset ArrayAppend(errormsg, "select the portfolio manager") />
</cfif>

<!--- Portfolio Manager Approval Date --->
<cfif not isDate(form.PortfolioManagerApprovalDate)>
	<cfset ArrayAppend(errormsg, "enter a valid portfolio manager approval date") />
</cfif>
<cfif isDate(Form.PortfolioManagerApprovalDate) and form.PortfolioManagerApprovalDate LT "1/1/1900">
	<cfset ArrayAppend(errormsg, "enter a valid portfolio manager approval date") />
</cfif>
<cfif isDate(Form.PortfolioManagerApprovalDate) and isNumeric(left(Form.PortfolioManagerApprovalDate,2)) and left(Form.PortfolioManagerApprovalDate,2) GT 12>
	<cfset ArrayAppend(errormsg, "enter a valid portfolio manager approval date") />
</cfif>

<!--- Chevron PM Approval Date --->
<cfif len(form.ChevronPMApprovalDate) and not isDate(form.ChevronPMApprovalDate)>
	<cfset ArrayAppend(errormsg, "enter a valid chevron pm approval date") />
</cfif>
<cfif isDate(Form.ChevronPMApprovalDate) and form.ChevronPMApprovalDate LT "1/1/1900">
	<cfset ArrayAppend(errormsg, "enter a valid chevron pm approval date") />
</cfif>
<cfif isDate(ChevronPMApprovalDate) and isNumeric(left(ChevronPMApprovalDate,2)) and left(ChevronPMApprovalDate,2) GT 12>
	<cfset ArrayAppend(errormsg, "enter a valid chevron pm approval date") />
</cfif>

<!--- Arcadis PM --->
<cfif form.ArcadisPMID EQ 0>
	<cfset ArrayAppend(errormsg, "select the arcadis site manager") />
</cfif>

<!--- Chevron Approval Status --->
<cfif not len(form.ChevronApprovalStatus)>
	<cfset ArrayAppend(errormsg, "select the chevron approval status") />
</cfif>

<!--- Oracle Update Flag (Oracle Process Status) --->
<cfif not len(form.InternalStatus)>
	<cfset ArrayAppend(errormsg, "select the oracle process status") />
</cfif>

<cfif ArrayLen(errormsg)>
	<cfset successmsg = "">
<cfelse>
	<cfset successmsg = "The information has been updated">
</cfif>
