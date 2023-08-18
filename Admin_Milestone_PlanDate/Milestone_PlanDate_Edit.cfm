<!-------------------------------------------
Description:
	Site Milestone edit page

History:
	9/8/2022 - created
-------------------------------------------->

<script src="scripts/divHider.js"></script>

<cfset msgSuccess = "">
<cfset arrErrors = ArrayNew(1) />

<!--- get Portfolios --->
<cfinclude template="q_getPortfolios.cfm">
<!--- get Milestones --->
<cfinclude template="q_getMilestones.cfm">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- get delay reason --->
<cfinclude template="../components/q_getDelayReason.cfm">

<!--- update Site --->
<cfif isDefined("form.btnUpdateMilestonePlanDate") and (form.edittype EQ "editMilestonePlanDateRecord")>
	<cfinclude template="q_updMilestonePlanDateInfo.cfm">
</cfif>

<!--- get the Site Milestone info and set form variables --->
<cfif not ArrayLen(arrErrors)>
	<cfif isDefined("Form.edtMilestonePlanDateID")>
		<cfinclude template="q_getMilestonePlanDateInfo.cfm">
		<cfset form.AdminSiteID = getMilestonePlanDateInfo.AdminSiteID>
		<cfset form.SiteID = getMilestonePlanDateInfo.Site_ID>
		<cfset form.PortfolioID = getMilestonePlanDateInfo.Portfolio_ID>
		<cfset form.Portfolio = getMilestonePlanDateInfo.Portfolio>
		<cfset form.MilestoneID = getMilestonePlanDateInfo.Milestone_ID>
		<cfset form.Milestone = getMilestonePlanDateInfo.Milestone>
		<cfset form.MilestoneAmount = getMilestonePlanDateInfo.Milestone_Amount>
		<cfset form.PlanMonth = right(getMilestonePlanDateInfo.Milestone_Plan_Date,2)>
		<cfset form.PlanYear = left(getMilestonePlanDateInfo.Milestone_Plan_Date,4)>
		<cfset form.BaselineMonth = right(getMilestonePlanDateInfo.Milestone_Baseline_Date,2)>
		<cfset form.BaselineYear = left(getMilestonePlanDateInfo.Milestone_Baseline_Date,4)>
		<cfset form.Year = getMilestonePlanDateInfo.Year>
		<cfset form.FCO = getMilestonePlanDateInfo.FCO>
		<cfset form.SAPChargeCode = getMilestonePlanDateInfo.SAP_Charge_Code>
		<cfset form.Notes = getMilestonePlanDateInfo.Notes>
		<cfset form.DelayReasonID = getMilestonePlanDateInfo.Delay_Reason_ID>
	<cfelse>
		<cfset form.AdminSiteID = "">
		<cfset form.SiteID = "">
		<cfset form.PortfolioID = "0">
		<cfset form.Portfolio = "">
		<cfset form.MilestoneID = "0">
		<cfset form.Milestone = "">
		<cfset form.MilestoneAmount = "0">
		<cfset form.PlanMonth = "0">
		<cfset form.PlanYear = "0">
		<cfset form.BaselineMonth = "0">
		<cfset form.BaselineYear = "0">
		<cfset form.Year = "0">
		<cfset form.FCO = "">
		<cfset form.SAPChargeCode = "">
		<cfset form.Notes = "">
		<cfset form.DelayReasonID = "0">
	</cfif>
<cfelse>
	<cfset form.AdminSiteID = form.AdminSiteID>
	<cfset form.SiteID = form.SiteID>
	<cfset form.PortfolioID = form.PortfolioID>
	<cfset form.Portfolio = form.Portfolio>
	<cfset form.MilestoneID = form.MilestoneID>
	<cfset form.Milestone = form.Milestone>
	<cfset form.MilestoneAmount = form.MilestoneAmount>
	<cfset form.PlanMonth = form.PlanMonth>
	<cfset form.PlanYear = form.PlanYear>
	<cfset form.BaselineMonth = form.BaselineMonth>
	<cfset form.BaselineYear = form.BaselineYear>
	<cfset form.Year = form.Year>
	<cfset form.FCO = form.FCO>
	<cfset form.SAPChargeCode = form.SAPChargeCode>
	<cfset form.Notes = form.Notes>
	<cfset form.DelayReasonID = form.DelayReasonID>
</cfif>

<!--- help text --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR>
		<td class="largeText" width="1%">
		<td class="largeText"></td>
		<td class="largeText" width="1%">
	</TR>
  <TR>
		<td class="largeText" width="1%">
		<td class="largeText"><strong>Milestone Plan Date Management</strong></TD>
		<td class="largeText" width="1%">
	</TR>
	<TR>
		<td class="largeText" width="1%">
		<td class="largeText">
			<li>Use this page to add/update site milestone information.</li>
			<li>Enter/update the information and click <strong>Save</strong> to save the changes to the database. Click <strong>Reset</strong> to reset all form values to the values when the form is first displayed or following a save.</li>
		</td>
		<td class="largeText" width="1%">
	</TR>
	<TR><td class="largeText" colspan="3"><hr></td></TR>
</TABLE>
	
<!--- form --->
<cfoutput>
	<table width="100%" bgcolor="##ffffff" cellspacing="1">
		<FORM NAME="MilestonePlanDate" ACTION="" METHOD="POST">
			<!--- scrub url input for XSS --->
			<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
			<cfif isDefined("form.SiteToFind")><input type="hidden" name="SiteToFind" value="#form.SiteToFind#" /></cfif>
			<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
			<cfif isDefined("form.MilestonePortfolioToFind")><input type="hidden" name="MilestonePortfolioToFind" value="#form.MilestonePortfolioToFind#" /></cfif>
			<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
			<cfif isDefined("form.milestonetofind")><input type="hidden" name="milestonetofind" value="#form.milestonetofind#" /></cfif>
			<cfif isDefined("form.edtMilestonePlanDateID")><input type="hidden" name="edtMilestonePlanDateID" value="#form.edtMilestonePlanDateID#" /></cfif>
			<cfloop query="getRegions">
				<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
					<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
				</cfif>
			</cfloop>
			<input type="hidden" name="edittype" value="#form.edittype#" />

			<!--- message --->
			<cfif len(msgSuccess)><tr><td class="successText" align="center" colspan="2"><div id="msg">*** #msgSuccess# ***</div></td></tr></cfif>
			<cfif ArrayLen(arrErrors)>
				<tr><td colspan="2" class="errorText" align="center">
					There were errors, please review and correct the following:<br>
					<!--- Loop over form errors to output --->
					<cfloop index="intError" from="1" to="#ArrayLen(arrErrors)#" step="1">
						&bull; #arrErrors[intError]#<br>
					</cfloop>
				</td></tr>
			</cfif>
			<cfif not len(msgSuccess) and not ArrayLen(arrErrors)><tr><td class="successText" align="center" colspan="2"><div id="msg">&nbsp;</div></td></tr></cfif>

			<!--- Site ID --->
			<TR valign="top">
				<TD CLASS="largeText" ALIGN="right"><strong>Site ID:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
						#form.AdminSiteID#
						<input type="hidden" name="SiteID" value="#form.SiteID#">
						<input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#">
				</TD>
			</TR>

			<!--- Milestone --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Milestone:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					#form.Milestone#
					<input type="hidden" name="MilestoneID" value="#form.MilestoneID#">
					<input type="hidden" name="Milestone" value="#form.Milestone#">
				</td>
			</TR>

			<!--- Portfolio --->
			<TR valign="top">
				<TD CLASS="largeText" ALIGN="right"><strong>Milestone Portfolio:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					#form.Portfolio#
					<input type="hidden" name="PortfolioID" value="#form.PortfolioID#">
					<input type="hidden" name="Portfolio" value="#form.Portfolio#">
				</td>
			</TR>

			<!--- Milestone Amount --->
			<TR valign="top">
				<TD CLASS="largeText" ALIGN="right"><strong>Amount:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					#dollarformat(form.MilestoneAmount)#
					<input type="hidden" name="MilestoneAmount" value="#form.MilestoneAmount#">
				</TD>
			</TR>

			<!--- Year --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Year:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					#form.Year#
					<input type="hidden" name="Year" value="#form.Year#">
				</td>
			</TR>

			<!--- Milestone Baseline Date --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Baseline Date:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
						<input type="hidden" name="BaselineMonth" value="#form.BaselineMonth#">
						<input type="hidden" name="BaselineYear" value="#form.BaselineYear#">
						#form.BaselineMonth#/#form.BaselineYear#
				</td>
			</TR>

			<!--- Milestone Plan Date --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Plan Date:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<select name="PlanMonth" class="largeText">
						<option value="0" <cfif (not isDefined("form.PlanMonth")) or (isDefined("form.PlanMonth") and form.PlanMonth EQ 0)>selected="selected"</cfif>>- select month -</option>
						<cfloop from="1" to="12" index="month">
							<option value="#month#" <cfif isDefined("form.PlanMonth") and form.PlanMonth EQ #month#>selected="selected"</cfif>>#left(MonthAsString(month),3)#</option>
						</cfloop>
					</select>
					<select name="PlanYear" class="largeText">
						<option value="0" <cfif (not isDefined("form.PlanYear")) or (isDefined("form.PlanYear") and form.PlanYear EQ 0)>selected="selected"</cfif>>- select year -</option>
						<cfloop from="2020" to="2024" index="Year">
							<option value="#Year#" <cfif isDefined("form.PlanYear") and form.PlanYear EQ #Year#>selected="selected"</cfif>>#Year#</option>
						</cfloop>
					</select>
				</td>
			</TR>

			<!--- Delay Reason --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Delay Reason:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<select name="DelayReasonID" class="largeText">
						<option value="0" <cfif (not isDefined("form.DelayReasonID")) or (isDefined("form.DelayReasonID") and form.DelayReasonID EQ 0)>selected="selected"</cfif>>- select delay reason -</option>
						<cfloop query="getDelayReasons" >
							<option value="#getDelayReasons.Delay_Reason_ID#" <cfif isDefined("form.DelayReasonID") and form.DelayReasonID EQ getDelayReasons.Delay_Reason_ID>selected="selected"</cfif>>#getDelayReasons.Delay_Reason#</option>
						</cfloop>
					</select>
				</td>
			</TR>

			<!--- Notes --->
			<tr valign="top">
				<TD class="largeText" align="right" height="50">
					<strong>Notes:</strong>&nbsp;</br>
					<i>(add your initials and date with each note)</i>
				</TD>
				<TD class="largeText">
					<textarea name="Notes" cols="64" rows="5" class="largeText">#form.Notes#</textarea>
				</TD>
			</tr>

			<!--- FCO --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>FCO:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					#form.FCO#
					<input type="hidden" name="FCO" value="#form.FCO#">
				</td>
			</TR>

			<!--- SAP Charge Code --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>SAP Charge Code:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					#form.SAPChargeCode#
					<input type="hidden" name="SAPChargeCode" value="#form.SAPChargeCode#">
				</td>
			</TR>

			<!--- space --->
			<TR><TD CLASS="row0" colspan="2">&nbsp;</TD></TR>

			<!--- buttons --->
			<TR>
				<TD CLASS="largeText" ALIGN="center"></TD>
				<TD CLASS="largeText" ALIGN="left">
					<INPUT TYPE="Submit" name="btnUpdateMilestonePlanDate" CLASS="largeTextButton" VALUE="Save">
					<input type="Submit" name="btnReturnMilestonePlanDate" class="largeTextButton" value="Return">
					<input type="reset" name="btnReset" class="largeTextButton" value="Reset">
				</TD>
			</TR>
		</FORM>

		<TR><TD CLASS="row0" colspan="2">&nbsp;</TD></TR>

		<!--- column widths --->
		<TR>
			<TD CLASS="largeText" width="12%"></TD>
			<TD CLASS="largeText" width="88%"></TD>
		</TR>
	</TABLE>
</cfoutput>

<script>document.MilestonePlanDate.ProjectName.focus();</script>
