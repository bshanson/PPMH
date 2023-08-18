<!-------------------------------------------
Description:
	Site Milestone edit page

History:
	1/27/2021 - created
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

<!--- update Site --->
<cfif isDefined("form.btnUpdateSiteMilestone") and (form.edittype EQ "editSiteMilestoneRecord")>
	<cfinclude template="q_updSiteMilestoneInfo.cfm">
</cfif>

<!--- add Site Milestone --->
<cfif isDefined("form.btnUpdateSiteMilestone") and (form.edittype EQ "addSiteMilestoneRecord" or form.edittype EQ "CopySiteMilestoneRecord")>
	<cfinclude template="q_addSiteMilestoneInfo.cfm">
	<cfif not ArrayLen(arrErrors)>
		<cfset form.edittype = "editSiteMilestoneRecord">
		<cfset form.edtSiteMilestoneID = getNewID.newID>
	</cfif>
</cfif>

<cfparam name="form.edittype" default="addSiteMilestoneRecord">
<cfparam name="form.ACSMilestone" default="0">

<!--- get the Site Milestone info and set form variables --->
<cfif not ArrayLen(arrErrors)>
	<cfif isDefined("Form.edtSiteMilestoneID")>
		<cfinclude template="q_getSiteMilestoneInfo.cfm">
		<cfset form.AdminSiteID = getSiteMilestoneInfo.AdminSiteID>
		<cfset form.SiteID = getSiteMilestoneInfo.Site_ID>
		<cfset form.PortfolioID = getSiteMilestoneInfo.Portfolio_ID>
		<cfset form.MilestoneID = getSiteMilestoneInfo.Milestone_ID>
		<cfset form.MilestoneAmount = getSiteMilestoneInfo.Milestone_Amount>
		<cfset form.PlanMonth = right(getSiteMilestoneInfo.Milestone_Plan_Date,2)>
		<cfset form.PlanYear = left(getSiteMilestoneInfo.Milestone_Plan_Date,4)>
		<cfset form.BaselineMonth = right(getSiteMilestoneInfo.Milestone_Baseline_Date,2)>
		<cfset form.BaselineYear = left(getSiteMilestoneInfo.Milestone_Baseline_Date,4)>
		<cfset form.Year = getSiteMilestoneInfo.Year>
		<cfset form.FCO = getSiteMilestoneInfo.FCO>
		<cfset form.Skip = getSiteMilestoneInfo.Skip>
		<cfset form.SAPChargeCode = getSiteMilestoneInfo.SAP_Charge_Code>
		<cfset form.ACSMilestone = getSiteMilestoneInfo.ACS_Milestone>
	<cfelse>
		<cfset form.AdminSiteID = "">
		<cfset form.SiteID = "">
		<cfset form.PortfolioID = "0">
		<cfset form.MilestoneID = "0">
		<cfset form.MilestoneAmount = "0">
		<cfset form.PlanMonth = "0">
		<cfset form.PlanYear = "0">
		<cfset form.BaselineMonth = "0">
		<cfset form.BaselineYear = "0">
		<cfset form.Year = "0">
		<cfset form.FCO = "">
		<cfset form.SAPChargeCode = "">
		<cfset form.ACSMilestone = "0">
	</cfif>
<cfelse>
	<cfset form.AdminSiteID = form.AdminSiteID>
	<cfset form.SiteID = form.SiteID>
	<cfset form.PortfolioID = form.PortfolioID>
	<cfset form.MilestoneID = form.MilestoneID>
	<cfset form.MilestoneAmount = form.MilestoneAmount>
	<cfset form.PlanMonth = form.PlanMonth>
	<cfset form.PlanYear = form.PlanYear>
	<cfset form.BaselineMonth = form.BaselineMonth>
	<cfset form.BaselineYear = form.BaselineYear>
	<cfset form.Year = form.Year>
	<cfset form.FCO = form.FCO>
	<cfif isDefined("form.Skip")><cfset form.Skip = 1></cfif>
	<cfset form.SAPChargeCode = form.SAPChargeCode>
	<cfif isDefined("form.ACSMilestone")><cfset form.ACSMilestone = form.ACSMilestone></cfif>
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
		<td class="largeText"><strong>Site Milestone Management</strong></TD>
		<td class="largeText" width="1%">
	</TR>
	<TR>
		<td class="largeText" width="1%">
		<td class="largeText">
			<li>Use this page to add/update site milestone information.</li>
			<li>All fields are required.</li>
			<li>Enter/update the information and click <strong>Save</strong> to save the changes to the database. Click <strong>Reset</strong> to reset all form values to the values when the form is first displayed or following a save.</li>
		</td>
		<td class="largeText" width="1%">
	</TR>
	<TR><td class="largeText" colspan="3"><hr></td></TR>
</TABLE>
	
<!--- form --->
<cfoutput>
	<table width="100%" bgcolor="##ffffff" cellspacing="1">
		<FORM NAME="SiteMilestone" ACTION="" METHOD="POST">
			<!--- scrub url input for XSS --->
			<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
			<cfif isDefined("form.SiteToFind")><input type="hidden" name="SiteToFind" value="#form.SiteToFind#" /></cfif>
			<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
			<cfif isDefined("form.MilestonePortfolioToFind")><input type="hidden" name="MilestonePortfolioToFind" value="#form.MilestonePortfolioToFind#" /></cfif>
			<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
			<cfif isDefined("form.milestonetofind")><input type="hidden" name="milestonetofind" value="#form.milestonetofind#" /></cfif>
			<cfif isDefined("form.edtSiteMilestoneID")><input type="hidden" name="edtSiteMilestoneID" value="#form.edtSiteMilestoneID#" /></cfif>
			<cfif isDefined("form.ACSToFind1")><input type="hidden" name="ACSToFind1" value="#form.ACSToFind1#" /></cfif>
			<cfif isDefined("form.ACSToFind2")><input type="hidden" name="ACSToFind2" value="#form.ACSToFind2#" /></cfif>
			<cfif isDefined("form.ClaimToFind1")><input type="hidden" name="ClaimToFind1" value="#form.ClaimToFind1#" /></cfif>
			<cfif isDefined("form.ClaimToFind2")><input type="hidden" name="ClaimToFind2" value="#form.ClaimToFind2#" /></cfif>
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
					<cfif isDefined("form.edittype") and (form.edittype EQ "addSiteMilestoneRecord")>
						<input type="hidden" name="AdminSiteID" value="0">
						<cfinclude template="q_getSites.cfm">
						<select name="SiteID" class="largeText">
							<option value="0" <cfif isDefined("form.SiteID") and form.SiteID EQ 0>selected="selected"</cfif>>- select site -</option>
							<cfloop query="getSites">
								<option value="#getSites.ID#" <cfif isDefined("form.SiteID") and form.SiteID EQ getSites.ID>selected="selected"</cfif>>#getSites.AdminSiteID#, #getSites.Site_Name#</option>
							</cfloop>
						</select>
					<cfelse>
						#form.AdminSiteID#
						<input type="hidden" name="SiteID" value="#form.SiteID#">
						<input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#">
					</cfif>
				</TD>
			</TR>

			<!--- Milestone --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Milestone:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<select name="MilestoneID" class="largeText">
						<option value="0" <cfif isDefined("form.MilestoneID") and form.MilestoneID EQ getMilestones.ID>selected="selected"</cfif>>- select milestone -</option>
						<cfloop query="getMilestones">
							<option value="#getMilestones.ID#" <cfif isDefined("form.MilestoneID") and form.MilestoneID EQ getMilestones.ID>selected="selected"</cfif>>#getMilestones.Milestone#</option>
						</cfloop>
					</select>
				</td>
			</TR>

			<!--- Portfolio --->
			<TR valign="top">
				<TD CLASS="largeText" ALIGN="right"><strong>Milestone Portfolio:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<select name="PortfolioID" class="largeText">
						<option value="0" <cfif isDefined("form.PortfolioID") and form.PortfolioID EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>- select portfolio -</option>
						<cfloop query="getPortfolios">
							<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.PortfolioID") and form.PortfolioID EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.portfolio#</option>
						</cfloop>
					</select>
				</td>
			</TR>

			<!--- ACS Milestone --->
			<TR valign="top">
				<TD CLASS="largeText" ALIGN="right"><strong>ACS Milestone:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<input type="Radio" name="ACSMilestone" value="1" class="largeText" <cfif form.ACSMilestone EQ 1>checked</cfif>>Yes
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="Radio" name="ACSMilestone" value="0" class="largeText" <cfif form.ACSMilestone EQ 0>checked</cfif>>No
				</td>
			</TR>

			<!--- Milestone Amount --->
			<TR valign="top">
				<TD CLASS="largeText" ALIGN="right"><strong>Amount:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<input type="text" name="MilestoneAmount" id="MilestoneAmount" class="largeText" size="30" maxlength="25" <cfif isDefined("form.MilestoneAmount")>value="#form.MilestoneAmount#"</cfif>>
				</TD>
			</TR>

			<!--- Year --->
			<cfif editType EQ "CopySiteMilestoneRecord"><cfset form.Year = 0></cfif>
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Year:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<select name="Year" class="largeText">
						<option value="0" <cfif isDefined("form.Year") and form.Year EQ 0>selected="selected"</cfif>>- select year -</option>
						<cfloop from="2020" to="2024" index="yr">
							<option value="#yr#" <cfif isDefined("form.Year") and form.Year EQ yr>selected="selected"</cfif>>#yr#</option>
						</cfloop>
					</select>
				</td>
			</TR>

			<!--- Milestone Baseline Date --->
			<cfif editType EQ "CopySiteMilestoneRecord"><cfset form.BaselineMonth = 0></cfif>
			<cfif editType EQ "CopySiteMilestoneRecord"><cfset form.BaselineYear = 0></cfif>
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Baseline Date:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<cfif isDefined("form.edittype") and (form.edittype EQ "addSiteMilestoneRecord" or form.edittype EQ "CopySiteMilestoneRecord" )>
						<select name="BaselineMonth" class="largeText">
							<option value="0" <cfif (not isDefined("form.BaselineMonth")) or (isDefined("form.BaselineMonth") and form.BaselineMonth EQ 0)>selected="selected"</cfif>>- select month -</option>
							<cfloop from="1" to="12" index="month">
								<option value="#month#" <cfif isDefined("form.BaselineMonth") and form.BaselineMonth EQ #month#>selected="selected"</cfif>>#left(MonthAsString(month),3)#</option>
							</cfloop>
						</select>
						<select name="BaselineYear" class="largeText">
							<option value="0" <cfif (not isDefined("form.BaselineYear")) or (isDefined("form.BaselineYear") and form.BaselineYear EQ 0)>selected="selected"</cfif>>- select year -</option>
							<cfloop from="2019" to="2024" index="Year">
								<option value="#Year#" <cfif isDefined("form.BaselineYear") and form.BaselineYear EQ #Year#>selected="selected"</cfif>>#Year#</option>
							</cfloop>
						</select>
					<cfelse>
						<input type="hidden" name="BaselineMonth" value="#form.BaselineMonth#">
						<input type="hidden" name="BaselineYear" value="#form.BaselineYear#">
						#form.BaselineMonth#/#form.BaselineYear#
					</cfif>
				</td>
			</TR>

			<!--- Milestone Plan Date --->
			<cfif editType EQ "CopySiteMilestoneRecord"><cfset form.PlanMonth = 0></cfif>
			<cfif editType EQ "CopySiteMilestoneRecord"><cfset form.PlanYear = 0></cfif>
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

			<!--- FCO --->
			<cfif editType EQ "CopySiteMilestoneRecord"><cfset form.FCO = ""></cfif>
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>FCO:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<input type="text" name="FCO" id="FCO" class="largeText" size="30" maxlength="64" <cfif isDefined("form.FCO")>value="#form.FCO#"</cfif>>
				</td>
			</TR>

			<!--- skip --->
			<tr valign="top">
				<TD class="largeText" align="right"><strong>Skip:</strong>&nbsp;</TD>
				<TD class="largeText">
					<input type="checkbox" name="skip" class="largeText" <cfif isDefined("form.skip") and form.skip EQ 1>checked="checked"</cfif>> (check if Yes)
				</TD>
			</tr>

			<!--- SAP Charge Code --->
			<cfif editType EQ "CopySiteMilestoneRecord"><cfset form.SAPChargeCode = ""></cfif>
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>SAP Charge Code:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<input type="text" name="SAPChargeCode" id="SAPChargeCode" class="largeText" size="30" maxlength="64" <cfif isDefined("form.SAPChargeCode")>value="#form.SAPChargeCode#"</cfif>>
				</td>
			</TR>

			<!--- space --->
			<TR><TD CLASS="row0" colspan="2">&nbsp;</TD></TR>

			<!--- buttons --->
			<TR>
				<TD CLASS="largeText" ALIGN="center"></TD>
				<TD CLASS="largeText" ALIGN="left">
					<INPUT TYPE="Submit" name="btnUpdateSiteMilestone" CLASS="largeTextButton" VALUE="Save">
					<input type="Submit" name="btnReturnSiteMilestone" class="largeTextButton" value="Return">
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

<script>document.SiteMilestone.ProjectName.focus();</script>
