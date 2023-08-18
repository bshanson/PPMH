<!-------------------------------------------
Description:
	Uncommitted Milestone search page

History:
	7/15/2022 - created
-------------------------------------------->

<script src="scripts/divHider.js"></script>
<cfset msgSuccess = "&nbsp;">
<cfset arrErrors = ArrayNew(1) />

<!--- delete a Watchlist Milestone record --->
<cfif isDefined("form.edittype") and form.edittype EQ "deleteWatchlistMilestone">
 	<cfinclude template="q_delWatchlistMilestoneInfo.cfm">
</cfif>

<!--- get Milestones --->
<cfinclude template="q_getMilestones.cfm">
<!--- get states --->
<cfinclude template="../components/q_getStates.cfm">
<!--- get portfolios --->
<cfinclude template="q_getPortfolios.cfm">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- search for the sites --->
<cfif isDefined("form.SiteIDtofind")>
	<cfinclude template="q_getWatchlistMilestones.cfm">
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
		<td class="largeText"><strong>Uncommitted Milestone Information Management</strong></TD>
		<td class="largeText" width="1%">
	</TR>
	<TR>
		<td class="largeText" width="1%">
		<td class="largeText">
			<li>Use this page to manage uncommitted milestone information.</li>
			<li>Select the <strong>Portfolio</strong>, <strong>Region</strong>, enter the <strong>Site ID</strong>, <strong>Site Name</strong>, or select a <strong>State</strong> or <strong>Milestone</strong> for which to display the Site records.</li>
			<li>Once displayed, you may add, edit, or delete records.</li>
		</td>
		<td class="largeText" width="1%">
	</TR>
</TABLE>

<!--- search form --->
<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="#ffffff">
<cfoutput>
	<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
	<form name="frmClientReview" action="" method="post">
	<!--- scrub url input for XSS --->
	<cfinclude template="/Common/XSS_Scubber.cfm" >
		<!--- Site Portfolio, Region --->
		<TR>
			<td class="largeText"></td>
			<td class="largeText" align="right"><strong>Site Portfolio:</strong>&nbsp;</td>
			<td class="largeText" colspan="2" valign="top">
				<select name="SitePortfolioToFind" class="largeText">
					<option value="0" <cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind EQ "0">selected="selected"</cfif>>- select a portfolio -</option>
					<cfloop query="getPortfolios">
						<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
					</cfloop>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<strong>Region:</strong>&nbsp;
				<cfloop query="getRegions">
					<input type="checkbox" class="largeText" name="RegionToFind#getRegions.COP_Region_ID#" <cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>checked="checked"</cfif>>#getRegions.Region#&nbsp;
				</cfloop>
			</td>
		</tr>
		<tr><td colspan="3" height="5"></td></tr>
		<!--- site id, site name, address, city, state --->
		<TR>
			<td class="largeText"></td>
			<td class="largeText" align="right"><strong>Site ID:</strong>&nbsp;</td>
			<td class="largeText">
				<input type="Text" name="SiteIDToFind" size="10" class="largeText" <cfif isDefined("form.SiteIDToFind") and len(form.SiteIDToFind)>value="#form.SiteIDToFind#"</cfif>>
				&nbsp;
				<strong>Site Name:</strong>&nbsp;
				<input type="Text" name="SiteNameToFind" size="25" class="largeText" <cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)>value="#form.SiteNameToFind#"</cfif>>
				&nbsp;
				<strong>Address:</strong>&nbsp;
				<input type="Text" name="AddressToFind" size="25" class="largeText" <cfif isDefined("form.AddressToFind") and len(form.AddressToFind)>value="#form.AddressToFind#"</cfif>>
				&nbsp;
				<strong>City:</strong>&nbsp;
				<input type="Text" name="CityToFind" size="20" class="largeText" <cfif isDefined("form.CityToFind") and len(form.CityToFind)>value="#form.CityToFind#"</cfif>>
				&nbsp;
				<strong>State:</strong>&nbsp;
				<select name="StateToFind" class="largeText">
					<option value="0" <cfif isDefined("form.StateToFind") and form.StateToFind EQ "0">selected="selected"</cfif>>- select a state -</option>
					<cfloop query="getStates">
						<option value="#getStates.State_ID#" <cfif isDefined("form.StateToFind") and form.StateToFind EQ getStates.State_ID>selected="selected"</cfif>>#getStates.State#</option>
					</cfloop>
				</select>
			</td>
		</TR>
		<tr><td colspan="3" height="5"></td></tr>

		<!--- milestone --->
		<TR>
			<td class="largeText"></td>
			<td class="largeText" align="right"><strong>Milestone:</strong>&nbsp;</td>
			<td class="largeText">
				<select name="milestonetofind" class="largeText">
					<option value="0" <cfif isDefined("form.milestonetofind") and form.milestonetofind EQ getMilestones.ID>selected="selected"</cfif>>- select milestone -</option>
					<cfloop query="getMilestones">
						<option value="#getMilestones.ID#" <cfif isDefined("form.milestonetofind") and form.milestonetofind EQ getMilestones.ID>selected="selected"</cfif>>#getMilestones.Milestone#</option>
					</cfloop>
				</select>
			</td>
		</TR>
		<tr><td colspan="3" height="5"></td></tr>

		<!--- buttons --->
		<TR>
			<td class="largeText"></td>
			<td class="largeText"></td>
			<td class="largeText">
				<input type="Submit" name="Search" class="largeTextButton" value="Search" onClick="buttonDisable();">
				<input type="Reset" name="Reset" class="largeTextButton" value="Reset">
				<input type="Submit" name="btnAddWatchlistMilestoneRecord" class="largeTextButton" value="Add New Uncommitted Milestone" onClick="buttonDisable();">
				<cfif isDefined("getWatchlistMilestones") and getWatchlistMilestones.RecordCount GT 0>
					<CFSET FileName="Uncommitted_Milestone_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
					<input type="button" name="lblExcelButton" class="largeTextButton" value="Open Excel File" ONCLICK="window.open('#Request.ExcelPath#/#FileName#')">
				</cfif>
			</td>
		</TR>

		<!--- column widths --->
		<TR>
			<td class="largeText" width="1%">&nbsp;</td>
			<td class="largeText" width="8%">&nbsp;</td>
			<td class="largeText">&nbsp;</td>
		</TR>
	</form>
</cfoutput>
</TABLE>

<!--- display search results --->
<cfoutput>
	<cfset row = 1>
	<cfset totalMilestoneAmount = 0>
	<cfif isDefined("getWatchlistMilestones")>
		<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
			<tr><td>
				<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999">
					<tr>
						<td width="1%" class="ServiceListHeader" align="center"></td>
						<td width="8%" class="ServiceListHeader" align="center"><strong>Site ID</strong></td>
						<td width="20%" class="ServiceListHeader" align="center"><strong>Site Name</strong></td>
						<td width="21%" class="ServiceListHeader" align="center"><strong>Address</strong></td>
						<td width="14%" class="ServiceListHeader" align="center"><strong>Milestone</strong></td>
						<td width="7%" class="ServiceListHeader" align="center"><strong>Anticipated Claim Date</strong></td>
						<td width="9%" class="ServiceListHeader" align="center"><strong>Amount</strong></td>
						<td width="19%" class="ServiceListHeader" align="center"><strong>Notes</strong></td>
						<td width="1%" class="ServiceListHeader" align="center"></td>
					</tr>
					<cfif isDefined("getWatchlistMilestones") and getWatchlistMilestones.recordcount NEQ 0>
						<cfloop query="getWatchlistMilestones">
							<cfset row = 1-row>
							<TR>
								<!--- edit Watchlist Milestone --->
								<FORM NAME="EditWatchlistMilestone" ACTION="" METHOD="post">
									<!--- scrub url input for XSS --->
									<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<input type="Image" name="btnEditWatchlistMilestone" src="images/icon_pencil.gif" border="0" onclick="submit()" alt="edit this record">
										<input type="hidden" name="edittype" value="EditWatchlistMilestoneRecord" />
										<input type="hidden" name="edtWatchlistMilestoneID" value="#getWatchlistMilestones.ID#" />
										<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
										<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
										<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
										<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
										<cfif isDefined("form.milestonetofind")><input type="hidden" name="milestonetofind" value="#form.milestonetofind#" /></cfif>
										<cfif isDefined("form.MilestonePortfolioToFind")><input type="hidden" name="MilestonePortfolioToFind" value="#form.MilestonePortfolioToFind#" /></cfif>
										<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
										<cfloop query="getRegions">
											<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
												<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
											</cfif>
										</cfloop>
									</td>
								</FORM>
								<td class="row#row#"><cfif len(getWatchlistMilestones.Admin_Site_ID)><SPAN TITLE="#getWatchlistMilestones.Admin_Site_ID#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getWatchlistMilestones.Admin_Site_ID,10)#<cfif len(getWatchlistMilestones.Admin_Site_ID) GT 10>...</cfif></SPAN><cfelse>&nbsp;</cfif></td>
								<td class="row#row#">#getWatchlistMilestones.Site_Name#</td>
								<td class="row#row#">#getWatchlistMilestones.Address#, #getWatchlistMilestones.City#, #getWatchlistMilestones.State_Abbreviation#</td>
								<td class="row#row#">#getWatchlistMilestones.Milestone#</td>
								<td class="row#row#" align="center"><cfif getWatchlistMilestones.Anticipated_Claim_Month NEQ 999>#getWatchlistMilestones.Anticipated_Claim_Month#/</cfif>#getWatchlistMilestones.Anticipated_Claim_Year#</td>
								<cfif len(getWatchlistMilestones.Milestone_Amount)><cfset totalMilestoneAmount = totalMilestoneAmount + getWatchlistMilestones.Milestone_Amount></cfif>
								<td class="row#row#" align="right">#dollarformat(getWatchlistMilestones.Milestone_Amount)#</td>
								<td class="row#row#"><cfif len(getWatchlistMilestones.notes)><SPAN TITLE="#getWatchlistMilestones.Notes#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getWatchlistMilestones.notes,32)#<cfif len(getWatchlistMilestones.notes) GT 32>...</cfif></SPAN><cfelse>&nbsp;</cfif></td>
								<!--- delete Watchlist Milestone--->
								<FORM NAME="delWatchlistMilestone" ACTION="" METHOD="post">
									<!--- scrub url input for XSS --->
									<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<input type="Image" name="imgDeleteWatchlistMilestone" src="images/icon_trash.gif" border="0" onclick="if (confirm('Delete this record?')){submit()}; return false" alt="delete this record">
										<input type="hidden" name="btnDeleteWatchlistMilestone" value="btnDeleteWatchlistMilestone" />
										<input type="hidden" name="edittype" value="deleteWatchlistMilestone" />
										<input type="hidden" name="delWatchlistMilestoneID" value="#getWatchlistMilestones.ID#" />
										<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
										<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
										<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
										<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
										<cfif isDefined("form.milestonetofind")><input type="hidden" name="milestonetofind" value="#form.milestonetofind#" /></cfif>
										<cfif isDefined("form.MilestonePortfolioToFind")><input type="hidden" name="MilestonePortfolioToFind" value="#form.MilestonePortfolioToFind#" /></cfif>
										<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
										<cfloop query="getRegions">
											<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
												<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
											</cfif>
										</cfloop>
									</td>
								</FORM>
							</TR>
						</cfloop>
					<!--- milestone total --->
					<tr valign="top">
						<TD class="TotalRowOrange" colspan="1">&nbsp;</td>
						<TD class="TotalRowOrange" colspan="5">Milestone Total</td>
						<TD class="TotalRowOrange" colspan="1" align="right">#dollarformat(totalMilestoneAmount)#</td>
						<TD class="TotalRowOrange" colspan="2">&nbsp;</td>
					</tr>
					<cfinclude template="Milestone_Watchlist_Export.cfm">
					<cfelse>
						<cfset row = 1-row>
						<TR>
							<td class="row#row#" align="center" colspan="9"><em>There are no records that match your search parameters</em></td>
						</TR>
					</cfif>
				</TABLE>
			</td></tr>
		</TABLE>
	</cfif>
</cfoutput>
<script>document.frmClientReview.SiteIDToFind.focus();</script>
