<!-------------------------------------------
Description:
	Uncommitted Milestone edit page

History:
	7/15/2022 - created
-------------------------------------------->

<script src="scripts/divHider.js"></script>

<cfset msgSuccess = "">
<cfset arrErrors = ArrayNew(1) />

<!--- get Milestones --->
<cfinclude template="q_getMilestones.cfm">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- update Site --->
<cfif isDefined("form.btnUpdateWatchlistMilestone") and (form.edittype EQ "editWatchlistMilestoneRecord")>
	<cfinclude template="q_updWatchlistMilestoneInfo.cfm">
</cfif>

<!--- add Watchlist Milestone --->
<cfif isDefined("form.btnUpdateWatchlistMilestone") and (form.edittype EQ "addWatchlistMilestoneRecord")>
	<cfinclude template="q_addWatchlistMilestoneInfo.cfm">
	<cfif not ArrayLen(arrErrors)>
		<cfset form.edittype = "editWatchlistMilestoneRecord">
		<cfset form.edtWatchlistMilestoneID = getNewID.newID>
	</cfif>
</cfif>

<cfparam name="form.edittype" default="addWatchlistMilestoneRecord">

<!--- get the uncommitted Milestone info and set form variables --->
<cfif not ArrayLen(arrErrors)>
	<cfif isDefined("Form.edtWatchlistMilestoneID")>
		<cfinclude template="q_getWatchlistMilestoneInfo.cfm">
		<cfset form.AdminSiteID = getWatchlistMilestoneInfo.AdminSiteID>
		<cfset form.SiteID = getWatchlistMilestoneInfo.Site_ID>
		<cfset form.MilestoneID = getWatchlistMilestoneInfo.Milestone_ID>
		<cfset form.MilestoneAmount = getWatchlistMilestoneInfo.Milestone_Amount>
		<cfset form.AnticipatedClaimMonth = getWatchlistMilestoneInfo.Anticipated_Claim_Month>
		<cfset form.AnticipatedClaimYear = getWatchlistMilestoneInfo.Anticipated_Claim_Year>
		<cfset form.WatchlistProbability = getWatchlistMilestoneInfo.Watchlist_Probability>
		<cfset form.ACS = getWatchlistMilestoneInfo.ACS>
		<cfset form.Notes = getWatchlistMilestoneInfo.Notes>
	<cfelse>
		<cfset form.AdminSiteID = "">
		<cfset form.SiteID = "">
		<cfset form.MilestoneID = "0">
		<cfset form.MilestoneAmount = "0">
		<cfset form.AnticipatedClaimMonth = "0">
		<cfset form.AnticipatedClaimYear = "0">
		<cfset form.WatchlistProbability = "0">
		<cfset form.Notes = "">
		<cfset form.ACS = "0">
	</cfif>
<cfelse>
	<cfset form.AdminSiteID = form.AdminSiteID>
	<cfset form.SiteID = form.SiteID>
	<cfset form.MilestoneID = form.MilestoneID>
	<cfset form.MilestoneAmount = form.MilestoneAmount>
	<cfset form.AnticipatedClaimMonth = form.AnticipatedClaimMonth>
	<cfset form.AnticipatedClaimYear = form.AnticipatedClaimYear>
	<cfset form.WatchlistProbability = form.WatchlistProbability>
	<cfset form.Notes = form.Notes>
	<cfset form.ACS = form.ACS>
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
		<td class="largeText"><strong>Uncommitted Milestone Management</strong></TD>
		<td class="largeText" width="1%">
	</TR>
	<TR>
		<td class="largeText" width="1%">
		<td class="largeText">
			<li>Use this page to add/update uncommitted milestone information.</li>
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
		<FORM NAME="WatchlistMilestone" ACTION="" METHOD="POST">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
			<cfif isDefined("form.SiteToFind")><input type="hidden" name="SiteToFind" value="#form.SiteToFind#" /></cfif>
			<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
			<cfif isDefined("form.MilestonePortfolioToFind")><input type="hidden" name="MilestonePortfolioToFind" value="#form.MilestonePortfolioToFind#" /></cfif>
			<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
			<cfif isDefined("form.milestonetofind")><input type="hidden" name="milestonetofind" value="#form.milestonetofind#" /></cfif>
			<cfif isDefined("form.edtWatchlistMilestoneID")><input type="hidden" name="edtWatchlistMilestoneID" value="#form.edtWatchlistMilestoneID#" /></cfif>
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
					<cfif isDefined("form.edittype") and (form.edittype EQ "addWatchlistMilestoneRecord")>
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

			<!--- Anticipated Claim Date --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Anticipated Claim Date:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<select name="AnticipatedClaimMonth" class="largeText">
						<option value="0" <cfif (not isDefined("form.AnticipatedClaimMonth")) or (isDefined("form.AnticipatedClaimMonth") and form.AnticipatedClaimMonth EQ 0)>selected="selected"</cfif>>- select month -</option>
<!---						<option value="999" <cfif (not isDefined("form.AnticipatedClaimMonth")) or (isDefined("form.AnticipatedClaimMonth") and form.AnticipatedClaimMonth EQ 999)>selected="selected"</cfif>>- not applicable -</option>--->
						<cfloop from="1" to="12" index="month">
							<option value="#month#" <cfif isDefined("form.AnticipatedClaimMonth") and form.AnticipatedClaimMonth EQ #month#>selected="selected"</cfif>>#left(MonthAsString(month),3)#</option>
						</cfloop>
					</select>
					<select name="AnticipatedClaimYear" class="largeText">
						<option value="0" <cfif (not isDefined("form.AnticipatedClaimYear")) or (isDefined("form.AnticipatedClaimYear") and form.AnticipatedClaimYear EQ 0)>selected="selected"</cfif>>- select year -</option>
						<cfloop from="2019" to="2024" index="Year">
							<option value="#Year#" <cfif isDefined("form.AnticipatedClaimYear") and form.AnticipatedClaimYear EQ #Year#>selected="selected"</cfif>>#Year#</option>
						</cfloop>
					</select>
				</td>
			</TR>

			<!--- Milestone Amount --->
			<TR valign="top">
				<TD CLASS="largeText" ALIGN="right"><strong>Amount:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<input type="text" name="MilestoneAmount" id="MilestoneAmount" class="largeText" size="30" maxlength="25" <cfif isDefined("form.MilestoneAmount")>value="#dollarformat(form.MilestoneAmount)#"</cfif>>
				</TD>
			</TR>

			<!--- Watchlist Probability --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Uncommitted Probability:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<input type="text" name="WatchlistProbability" id="WatchlistProbability" class="largeText" size="30" maxlength="25" <cfif isDefined("form.WatchlistProbability")>value="#form.WatchlistProbability#%"</cfif>>
				</td>
			</TR>

			<!--- ACS --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>ACS:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<input type="radio" name="ACS" class="largeText" value="0" <cfif ((isDefined("form.ACS") and form.ACS EQ 0) or not isDefined("form.ACS"))>checked="checked"</cfif>>No
					<input type="radio" name="ACS" class="largeText" value="1" <cfif isDefined("form.ACS") and form.ACS EQ 1>checked="checked"</cfif>>Yes
				</td>
			</TR>

			<!--- Notes --->
			<TR>
				<TD CLASS="largeText" ALIGN="right" valign="top"><strong>Notes:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<textarea name="Notes" cols="130" rows="3" class="largeText"><cfif isDefined("form.Notes")>#form.Notes#</cfif></textarea>
				</td>
			</TR>

			<!--- space --->
			<TR><TD CLASS="row0" colspan="2">&nbsp;</TD></TR>

			<!--- buttons --->
			<TR>
				<TD CLASS="largeText" ALIGN="center"></TD>
				<TD CLASS="largeText" ALIGN="left">
					<INPUT TYPE="Submit" name="btnUpdateWatchlistMilestone" CLASS="largeTextButton" VALUE="Save">
					<input type="Submit" name="btnReturnWatchlistMilestone" class="largeTextButton" value="Return">
					<input type="reset" name="btnReset" class="largeTextButton" value="Reset">
				</TD>
			</TR>
		</FORM>

		<TR><TD CLASS="row0" colspan="2">&nbsp;</TD></TR>

		<!--- column widths --->
		<TR>
			<TD CLASS="largeText" width="14%"></TD>
			<TD CLASS="largeText" width="86%"></TD>
		</TR>
	</TABLE>
</cfoutput>

<script>document.WatchlistMilestone.SiteID.focus();</script>
