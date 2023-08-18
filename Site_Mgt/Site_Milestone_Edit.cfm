<!----------------------------------------------------------------------------------------------------------
Description:
	Site Milestone edit page

History:
	12/17/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- div hider script --->
<script src="scripts/divHider.js"></script>

<cfset errormsg = ArrayNew(1) />
<cfset successmsg = "">

<!--- get delay reason --->
<cfinclude template="../components/q_getDelayReason.cfm">

<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- get site info --->
<cfinclude template="q_getSiteInfo.cfm">

<!--- get site info --->
<cfinclude template="q_getSiteMilestoneInfo.cfm">

<!--- update site info --->
<cfif isDefined("form.submitinfo")>
	<!--- edit milestone record --->		
	<cfif isDefined("form.editMilestone") AND form.editMilestone EQ "editMilestone">
		<cfinclude template="q_updSiteMilestone.cfm">
		<cfinclude template="q_getSiteMilestoneInfo.cfm">
	</cfif>
	<cfset form.editMilestone = form.editMilestone>
</cfif>

<!--- set form variables --->
<cfif not ArrayLen(errormsg)>
	<cfset form.MilestoneID = getSiteMilestoneInfo.Milestone_ID>
	<cfset form.MilestonePlanDate = getSiteMilestoneInfo.Milestone_Plan_Date>
	<cfset form.MonthClaimed = right(getSiteMilestoneInfo.Period,2)>
	<cfset form.YearClaimed = left(getSiteMilestoneInfo.Period,4)>
	<cfset form.DelayReasonID = getSiteMilestoneInfo.Delay_Reason_ID>
	<!---<cfset form.Skip = getSiteMilestoneInfo.Skip>--->
	<cfset form.FCO = getSiteMilestoneInfo.FCO>
	<cfset form.Deliverable = getSiteMilestoneInfo.Deliverable>
	<cfset form.Notes = getSiteMilestoneInfo.Notes>
	<cfset form.MilestoneYear = getSiteMilestoneInfo.Year>
	<cfset form.Claim = getSiteMilestoneInfo.Claim>
<cfelse>
	<cfset form.MilestoneID = form.MilestoneID>
	<cfset form.MilestonePlanDate = form.MilestonePlanDate>
	<cfset form.MonthClaimed = form.MonthClaimed>
	<cfset form.YearClaimed = form.YearClaimed>
	<cfset form.DelayReasonID = form.DelayReasonID>
	<!---<cfif isDefined("form.Skip")><cfset form.Skip = 1></cfif>--->
	<cfset form.FCO = form.FCO>
	<cfset form.Deliverable = form.Deliverable>
	<cfset form.Notes = form.Notes>
	<cfset form.MilestoneYear = form.MilestoneYear>
	<cfset form.Claim = form.Claim>
</cfif>
<cfif isDefined("form.editMilestone") AND form.editMilestone EQ "addMilestone">
	<cfset form.Deliverable = getSiteMilestoneInfo.Primary_Backup>
</cfif>

<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR><td class="largeText"></td></TR>
	<TR><TD class="largeText"><strong>Milestone Status</strong></TD></TR>
	<TR>
		<td class="largeText">
			<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
				<tr>
					<td class="largeText" width="1%"><li></li></td>
					<td class="largeText">Use this page to administer the milestone status information. Enter/edit the information and click the <strong>submit information</strong> button at the bottom of the page.</td>
					<td class="largeText" width="2%"></td>
				</tr>
				<tr>
					<td class="largeText" width="1%"><li></li></td>
					<td class="largeText">If a <strong>Delay Reason</strong> other than <strong>On Track</strong> is selected, please enter <strong>Notes</strong> about the reason.</td>
					<td class="largeText" width="2%"></td>
				</tr>
				<tr>
					<td class="largeText" width="1%"><li></li></td>
					<td class="largeText">Be sure to add your initials and date when entering <strong>Notes</strong>.</td>
					<td class="largeText" width="2%"></td>
				</tr>
			</table>
		</td>
	</TR>
	<TR><td class="largeText"><hr color="##0083a9"></td></TR>
</TABLE>

<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##F0F0F0">
		<FORM NAME="MilestoneAdmin" METHOD="POST" ACTION=""  enctype="multipart/form-data">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.sorttype")><input type="hidden" name="sorttype" value="#form.sorttype#" /></cfif>
			<cfif isDefined("form.SiteMilestoneID")><input type="hidden" name="SiteMilestoneID" value="#form.SiteMilestoneID#" /></cfif>
			<cfif isDefined("form.AdminSiteID")><input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#" /></cfif>
			<cfif isDefined("form.yeartofind")><input type="hidden" name="yeartofind" value="#form.yeartofind#" /></cfif>
			<cfif isDefined("form.monthtofind")><input type="hidden" name="monthtofind" value="#form.monthtofind#" /></cfif>
			<cfif isDefined("form.periodtofind")><input type="hidden" name="periodtofind" value="#form.periodtofind#" /></cfif>
			<input type="hidden" name="edittype" value="#form.edittype#" />
			<input type="hidden" name="editMilestone" value="#form.editMilestone#" />
			<cfloop query="getRegions">
				<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
					<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
				</cfif>
			</cfloop>
			<cfif isDefined("form.siteidtofind")><input type="hidden" name="siteidtofind" value="#form.siteidtofind#" /></cfif>
			<cfif isDefined("form.sitenametofind")><input type="hidden" name="sitenametofind" value="#form.sitenametofind#" /></cfif>
			<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
			<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
			<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
			<cfif isDefined("form.smtofind")><input type="hidden" name="smtofind" value="#form.smtofind#" /></cfif>
			<cfif isDefined("form.DeputyToFind")><input type="hidden" name="DeputyToFind" value="#form.DeputyToFind#" /></cfif>
			<cfif isDefined("form.MilestonePlanDate")><input type="hidden" name="MilestonePlanDate" value="#form.MilestonePlanDate#" /></cfif>
			<cfif isDefined("form.MilestoneID")><input type="hidden" name="MilestoneID" value="#form.MilestoneID#" /></cfif>
			<cfif isDefined("form.MilestoneYear")><input type="hidden" name="MilestoneYear" value="#form.MilestoneYear#" /></cfif>
			<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
			<cfif isDefined("form.StatusPortfolioToFind")><input type="Hidden" name="StatusPortfolioToFind" value="#form.StatusPortfolioToFind#"></cfif>
			<cfif isDefined("form.editStatusID")><input type="Hidden" name="editStatusID" value="#form.editStatusID#"></cfif>
			<!--- site --->
			<TR>
				<TD class="largeText" width="15%"><strong>Site ID:</strong>&nbsp;#getSiteInfo.Site_ID#</TD>
				<TD class="largeText" width="25%"><strong>Site Name:</strong>&nbsp;#getSiteInfo.Site_Name#</TD>
				<TD class="largeText" width="30%"><strong>Address:</strong>&nbsp;#getSiteInfo.Address#, #getSiteInfo.City#, #getSiteInfo.State_Abbreviation#</TD>
				<TD class="largeText" width="30%"><strong>Site Manager:</strong>&nbsp;<cfif len(getSiteInfo.User_id)>#getSiteInfo.Last_Name#, #getSiteInfo.First_Name#</cfif></TD>
			</TR>
			<!--- Portfolio --->
			<TR>
				<TD class="largeText"><strong>Portfolio:</strong>&nbsp;#getSiteInfo.Portfolio#</TD>
				<TD class="largeText"><strong>COP Region:</strong>&nbsp;#getSiteInfo.Region#</TD>
				<cfset oerbFlag = "No">
				<cfif getSiteInfo.Inside_OERB EQ "1"><cfset oerbFlag = "Yes"></cfif>
				<TD class="largeText" colspan="2"><strong>Inside OERB:</strong>&nbsp;#oerbFlag#</TD>
			</TR>
	</TABLE>

	<!--- milestone info --->
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##BDD7EE">
		<tr valign="top">
			<!--- milestone --->
			<TD class="largeText" width="33.33%"><strong>Milestone:</strong>&nbsp;#getSiteMilestoneInfo.Milestone#</TD>
			<!--- amount --->
			<TD class="largeText" width="33.33%"><strong>Amount:</strong>&nbsp;#dollarformat(getSiteMilestoneInfo.Milestone_Amount)#</TD>
			<!--- plan date --->
			<cfset PlanMonth = right(form.MilestonePlanDate,2)>
			<cfset PlanYear = left(form.MilestonePlanDate,4)>
			<TD class="largeText" width="33.33%"><strong>Plan Date:</strong>&nbsp;#PlanMonth#/#PlanYear#</TD>
		</tr>
	</TABLE>

	<!--- database update message --->
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
		<cfif ArrayLen(errormsg)><TR><TD class="errorText" align="center">
		There were errors, please review the following:<br>
		<cfloop index="intError"from="1"to="#ArrayLen(errormsg)#"step="1">
			<li>#errormsg[intError]#</li>
		</cfloop>
		</TD></TR>
		<cfelseif successmsg NEQ ""><TR><TD class="successText" align="center"><div id="msg">*** #successmsg# ***</div></TD></TR>
		<cfelse><TR><TD class="successText" align="center">&nbsp;</TD></TR>
		</cfif>
	</TABLE>
	
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
		<tr valign="top">
			<!--- everyone --->
			<td width="49.5%">
				<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="##000000"><tr><td>
					<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
						<!--- delay reason --->
						<tr valign="top">
							<TD class="largeText" width="17%" align="right"><strong>Delay Reason:</strong>&nbsp;</TD>
							<TD class="largeText">
								<select name="DelayReasonID" class="largeText">
									<option value="0" <cfif (not isDefined("form.DelayReasonID")) or (isDefined("form.DelayReasonID") and form.DelayReasonID EQ 0)>selected="selected"</cfif>>- select delay reason -</option>
									<cfloop query="getDelayReasons" >
										<option value="#getDelayReasons.Delay_Reason_ID#" <cfif isDefined("form.DelayReasonID") and form.DelayReasonID EQ getDelayReasons.Delay_Reason_ID>selected="selected"</cfif>>#getDelayReasons.Delay_Reason#</option>
									</cfloop>
								</select>
							</TD>
						</tr>

<!---						<!--- skip --->
						<tr valign="top">
							<TD class="largeText" align="right"><strong>Skip:</strong>&nbsp;</TD>
							<TD class="largeText">
								<input type="checkbox" name="skip" class="largeText" <cfif isDefined("form.skip") and form.skip EQ 1>checked="checked"</cfif>> (check if Yes)
							</TD>
						</tr>--->

						<!--- fco --->
						<tr valign="top">
							<TD class="largeText" align="right"><strong>FCO:</strong>&nbsp;</TD>
							<TD class="largeText">
								<input type="text" size="63"	name="FCO" maxlength="64"	class="largeText" value="#form.fco#">
							</TD>
						</tr>

						<!--- deliverable --->
						<tr valign="top">
							<TD class="largeText" align="right"><strong>Deliverable:</strong>&nbsp;</TD>
							<TD class="largeText">
								<input type="text" size="63" name="Deliverable" maxlength="64" class="largeText" value="#form.Deliverable#">
							</TD>
						</tr>

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
					</TABLE>
				</td></tr></table>
			</td>

			<!--- blank --->
			<td width="1%"></td>

			<!--- managers --->
			<td width="49.5%">
				<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="##000000"><tr><td>
					<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
						<tr valign="top">
							<TD class="largeText" align="center" colspan="2" bgcolor="yellow"><strong>* For Milestone Managers Only * </strong></TD>
						</tr>
						<!--- Claim --->
						<tr valign="top">
							<TD class="largeText" width="18%" align="right"><strong>Claim:</strong>&nbsp;</TD>
							<TD class="largeText">
								<input type="radio" name="Claim" class="largeText" value="1" <cfif isDefined("form.Claim") and form.Claim EQ 1>checked="checked"</cfif>>Yes
								&nbsp;
								<input type="radio" name="Claim" class="largeText" value="0" <cfif (isDefined("form.Claim") and form.Claim EQ 0) or not len(form.Claim)>checked="checked"</cfif>>No
							</TD>
						</tr>

						<!--- Period claimed --->
						<tr valign="top">
							<TD class="largeText" align="right"><strong>Claim:</strong>&nbsp;</TD>
							<TD class="largeText">
								<select name="MonthClaimed" class="largeText">
									<option value="1" <cfif (not isDefined("form.MonthClaimed")) or (isDefined("form.MonthClaimed") and evaluate("form.MonthClaimed") EQ 1)>selected="selected"</cfif>>1</option>
									<cfloop from="2" to="12" index="month">
										<option value="#month#" <cfif isDefined("form.MonthClaimed") and evaluate("form.MonthClaimed") EQ #month#>selected="selected"</cfif>>#month#</option>
									</cfloop>
								</select>
								<select name="YearClaimed" class="largeText">
									<option value="2020" <cfif (not isDefined("form.YearClaimed")) or (isDefined("form.YearClaimed") and evaluate("form.YearClaimed") EQ 2020)>selected="selected"</cfif>>2020</option>
									<cfloop from="2021" to="2023" index="Year">
										<option value="#Year#" <cfif isDefined("form.YearClaimed") and evaluate("form.YearClaimed") EQ #Year#>selected="selected"</cfif>>#Year#</option>
									</cfloop>
								</select>
							</TD>
						</tr>

						<!--- file upload --->
						<tr valign="top">
							<TD class="largeText" align="right"><strong>Upload File:</strong>&nbsp;</TD>
							<TD class="largeText">
								<input type="File" name="MilestoneDoc" size="60" class="largeText">
							</TD>
						</tr>

						<!--- uploaded file --->
						<tr valign="top">
							<TD class="largeText" align="right" height="60"><strong>Uploaded File:</strong>&nbsp;</TD>
							<TD class="largeText">
								<cfif len(getSiteMilestoneInfo.Milestone_Doc)>
									<A HREF="javascript: var n=window.open('components/GetDoc.cfm?SiteMilestoneID=#form.SiteMilestoneID#&DocType=SiteMileStone', '', 'height=700,width=900,resizable')">view file</A>
									&nbsp;&nbsp;
									<strong>delete file:</strong><input type="Checkbox" name="DeleteDoc" class="largeText">
								</cfif>
							</TD>
						</tr>
					</TABLE>
				</td></tr></table>
			</td>
		</tr>
	</TABLE>

	<!--- buttons --->
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
		<TR align="center">
			<TD>
				<input type="submit" value="submit information" class="FormBodyButton" name="submitinfo">
					<input type="submit" value="return to monthly status page" class="FormBodyButton" name="btnSiteReturn">
			</TD>
		</TR>
		</FORM>
	</TABLE>
</cfoutput>
