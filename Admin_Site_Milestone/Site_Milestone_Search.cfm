<!-------------------------------------------
Description:
	Site Milestone search page

History:
	1/27/2021 - created
-------------------------------------------->

<script src="scripts/divHider.js"></script>
<cfset msgSuccess = "&nbsp;">
<cfset arrErrors = ArrayNew(1) />

<!--- delete a Site Milestone record --->
<cfif isDefined("form.edittype") and form.edittype EQ "deleteSiteMilestone">
 	<cfinclude template="q_delSiteMilestoneInfo.cfm">
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
	<cfinclude template="q_getSiteMilestones.cfm">
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
		<td class="largeText"><strong>Site Milestone Information Management</strong></TD>
		<td class="largeText" width="1%">
	</TR>
	<TR>
		<td class="largeText" width="1%">
		<td class="largeText">
			<li>Use this page to manage site milestone information.</li>
			<li>Select the <strong>Portfolio</strong>, <strong>Region</strong>, enter the <strong>Site ID</strong>, <strong>Site Name</strong>, or select a <strong>State</strong> or <strong>Milestone</strong> for which to display the Site records.</li>
			<li>Once displayed, you may add, edit, copy or delete records.</li>
			<li>If a milestone has been claimed, that milestone cannot be edited or deleted.</li>
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

		<!--- milestone, portfolio, ACS, Claimed --->
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
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<strong>Milestone Portfolio:</strong>&nbsp;
				<select name="MilestonePortfolioToFind" class="largeText">
					<option value="0" <cfif isDefined("form.MilestonePortfolioToFind") and form.MilestonePortfolioToFind EQ "0">selected="selected"</cfif>>- select a portfolio -</option>
					<cfloop query="getPortfolios">
						<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.MilestonePortfolioToFind") and form.MilestonePortfolioToFind EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
					</cfloop>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<strong>ACS Milestone:</strong>&nbsp;
				<input type="checkbox" class="largeText" name="ACSToFind1" <cfif isDefined("form.ACSToFind1")>checked="checked"</cfif>>Yes&nbsp;
				<input type="checkbox" class="largeText" name="ACSToFind2" <cfif isDefined("form.ACSToFind2")>checked="checked"</cfif>>No&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<strong>Claimed:</strong>&nbsp;
				<input type="checkbox" class="largeText" name="ClaimToFind1" <cfif isDefined("form.ClaimToFind1")>checked="checked"</cfif>>Yes&nbsp;
				<input type="checkbox" class="largeText" name="ClaimToFind2" <cfif isDefined("form.ClaimToFind2")>checked="checked"</cfif>>No&nbsp;
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
				<input type="Submit" name="btnAddSiteMilestoneRecord" class="largeTextButton" value="Add New Site Milestone" onClick="buttonDisable();">
				<cfif isDefined("getSiteMilestones") and getSiteMilestones.RecordCount GT 0>
					<CFSET FileName="Site_Milestone_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
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
	<cfif isDefined("getSiteMilestones")>
		<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
			<tr><td>
				<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999">
					<tr>
						<td width="1%" class="ServiceListHeader" align="center"></td>
						<td width="1%" class="ServiceListHeader" align="center"></td>
						<td width="9%" class="ServiceListHeader" align="center"><strong>Site ID</strong></td>
						<td width="10%" class="ServiceListHeader" align="center"><strong>Site Name</strong></td>
						<td width="14%" class="ServiceListHeader" align="center"><strong>Address</strong></td>
						<td width="14%" class="ServiceListHeader" align="center"><strong>Milestone</strong></td>
						<td width="7%" class="ServiceListHeader" align="center"><strong>Milestone Portfolio</strong></td>
						<td width="3%" class="ServiceListHeader" align="center"><strong>ACS</strong></td>
						<td width="3%" class="ServiceListHeader" align="center"><strong>Year</strong></td>
						<td width="5%" class="ServiceListHeader" align="center"><strong>Plan Date</strong></td>
						<td width="5%" class="ServiceListHeader" align="center"><strong>Baseline Date</strong></td>
						<td width="4%" class="ServiceListHeader" align="center"><strong>FCO</strong></td>
						<td width="3%" class="ServiceListHeader" align="center"><strong>Skip</strong></td>
						<td width="8%" class="ServiceListHeader" align="center"><strong>Amount</strong></td>
						<td width="3%" class="ServiceListHeader" align="center"><strong>Claim</strong></td>
						<td width="9%" class="ServiceListHeader" align="center"><strong>Notes</strong></td>
						<td width="1%" class="ServiceListHeader" align="center"></td>
					</tr>
					<cfif isDefined("getSiteMilestones") and getSiteMilestones.recordcount NEQ 0>
						<cfloop query="getSiteMilestones">
							<cfset row = 1-row>
							<TR>
								<!--- edit Site Milestone --->
								<FORM NAME="EditSiteMilestone" ACTION="" METHOD="post">
									<!--- scrub url input for XSS --->
									<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<cfif getSiteMilestones.Claim NEQ 1>
										<input type="Image" name="btnEditSiteMilestone" src="images/icon_pencil.gif" border="0" onclick="submit()" alt="edit this record">
										<input type="hidden" name="edittype" value="EditSiteMilestoneRecord" />
										<input type="hidden" name="edtSiteMilestoneID" value="#getSiteMilestones.ID#" />
										<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
										<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
										<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
										<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
										<cfif isDefined("form.milestonetofind")><input type="hidden" name="milestonetofind" value="#form.milestonetofind#" /></cfif>
										<cfif isDefined("form.MilestonePortfolioToFind")><input type="hidden" name="MilestonePortfolioToFind" value="#form.MilestonePortfolioToFind#" /></cfif>
										<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
										<cfif isDefined("form.ACSToFind1")><input type="hidden" name="ACSToFind1" value="#form.ACSToFind1#" /></cfif>
										<cfif isDefined("form.ACSToFind2")><input type="hidden" name="ACSToFind2" value="#form.ACSToFind2#" /></cfif>
										<cfif isDefined("form.ClaimToFind1")><input type="hidden" name="ClaimToFind1" value="#form.ClaimToFind1#" /></cfif>
										<cfif isDefined("form.ClaimToFind2")><input type="hidden" name="ClaimToFind2" value="#form.ClaimToFind2#" /></cfif>
										<cfloop query="getRegions">
											<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
												<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
											</cfif>
										</cfloop>
										</cfif>
									</td>
								</FORM>
								<!--- copy Site Milestone --->
								<FORM NAME="CopySiteMilestone" ACTION="" METHOD="post">
									<!--- scrub url input for XSS --->
									<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<input type="Image" name="btnCopySiteMilestone" src="images/icon_copy.gif" border="0" onclick="submit()" alt="copy this record">
										<input type="hidden" name="edittype" value="CopySiteMilestoneRecord" />
										<input type="hidden" name="edtSiteMilestoneID" value="#getSiteMilestones.ID#" />
										<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
										<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
										<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
										<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
										<cfif isDefined("form.milestonetofind")><input type="hidden" name="milestonetofind" value="#form.milestonetofind#" /></cfif>
										<cfif isDefined("form.MilestonePortfolioToFind")><input type="hidden" name="MilestonePortfolioToFind" value="#form.MilestonePortfolioToFind#" /></cfif>
										<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
										<cfif isDefined("form.ACSToFind1")><input type="hidden" name="ACSToFind1" value="#form.ACSToFind1#" /></cfif>
										<cfif isDefined("form.ACSToFind2")><input type="hidden" name="ACSToFind2" value="#form.ACSToFind2#" /></cfif>
										<cfif isDefined("form.ClaimToFind1")><input type="hidden" name="ClaimToFind1" value="#form.ClaimToFind1#" /></cfif>
										<cfif isDefined("form.ClaimToFind2")><input type="hidden" name="ClaimToFind2" value="#form.ClaimToFind2#" /></cfif>
										<cfloop query="getRegions">
											<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
												<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
											</cfif>
										</cfloop>
									</td>
								</FORM>
								<td class="row#row#"><cfif len(getSiteMilestones.Admin_Site_ID)><SPAN TITLE="#getSiteMilestones.Admin_Site_ID#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getSiteMilestones.Admin_Site_ID,11)#<cfif len(getSiteMilestones.Admin_Site_ID) GT 11>...</cfif></SPAN><cfelse>&nbsp;</cfif></td>
								<td class="row#row#">#getSiteMilestones.Site_Name#</td>
								<td class="row#row#">#getSiteMilestones.Address#<br>#getSiteMilestones.City#, #getSiteMilestones.State_Abbreviation#</td>
								<td class="row#row#">#getSiteMilestones.Milestone#</td>
								<td class="row#row#">#getSiteMilestones.Portfolio#</td>
								<td class="row#row#" align="center"><cfif getSiteMilestones.ACS_Milestone EQ 1><img src="images/icon_greencheck.gif" alt="Yes" border="0"><cfelse>&nbsp;</cfif></td>
								<td class="row#row#" align="center">#getSiteMilestones.Year#</td>
								<cfset Plan_Month = right(getSiteMilestones.Milestone_Plan_Date,2)>
								<cfset Plan_Year = left(getSiteMilestones.Milestone_Plan_Date,4)>
								<td class="row#row#" align="center">#Plan_Month#/#Plan_Year#</td>
								<cfif len(getSiteMilestones.Milestone_Baseline_Date)>
									<cfset Baseline_Month = right(getSiteMilestones.Milestone_Baseline_Date,2)>
									<cfset Baseline_Year = left(getSiteMilestones.Milestone_Baseline_Date,4)>
									<td class="row#row#" align="center">#Baseline_Month#/#Baseline_Year#</td>
								<cfelse>
									<td class="row#row#" align="center">&nbsp;</td>
								</cfif>
								<td class="row#row#"><cfif len(getSiteMilestones.FCO)><SPAN TITLE="#getSiteMilestones.FCO#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getSiteMilestones.FCO,12)#<cfif len(getSiteMilestones.FCO) GT 12>...</cfif></SPAN><cfelse>&nbsp;</cfif></td>
								<td class="row#row#" align="center"><cfif len(getSiteMilestones.Skip)><img src="images/icon_greencheck.gif" alt="Yes" border="0"><cfelse>&nbsp;</cfif></td>
								<cfset totalMilestoneAmount = totalMilestoneAmount + getSiteMilestones.Milestone_Amount>
								<td class="row#row#" align="right">#dollarformat(getSiteMilestones.Milestone_Amount)#</td>
								<td class="row#row#" align="center"><cfif getSiteMilestones.Claim EQ 1><img src="images/icon_greencheck.gif" alt="claimed" border="0"><cfelse>&nbsp;</cfif></td>
								<td class="row#row#"><cfif len(getSiteMilestones.notes)><SPAN TITLE="#getSiteMilestones.Notes#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getSiteMilestones.notes,12)#<cfif len(getSiteMilestones.notes) GT 12>...</cfif></SPAN><cfelse>&nbsp;</cfif></td>
								<!--- delete site milestone--->
								<FORM NAME="delSiteMilestone" ACTION="" METHOD="post">
									<!--- scrub url input for XSS --->
									<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<cfif getSiteMilestones.Claim NEQ 1>
										<input type="Image" name="imgDeleteSiteMilestone" src="images/icon_trash.gif" border="0" onclick="if (confirm('Delete this record?')){submit()}; return false" alt="delete this record">
										<input type="hidden" name="btnDeleteSiteMilestone" value="btnDeleteSiteMilestone" />
										<input type="hidden" name="edittype" value="deleteSiteMilestone" />
										<input type="hidden" name="delSiteMilestoneID" value="#getSiteMilestones.ID#" />
										<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
										<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
										<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
										<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
										<cfif isDefined("form.milestonetofind")><input type="hidden" name="milestonetofind" value="#form.milestonetofind#" /></cfif>
										<cfif isDefined("form.MilestonePortfolioToFind")><input type="hidden" name="MilestonePortfolioToFind" value="#form.MilestonePortfolioToFind#" /></cfif>
										<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
										<cfif isDefined("form.ACSToFind1")><input type="hidden" name="ACSToFind1" value="#form.ACSToFind1#" /></cfif>
										<cfif isDefined("form.ACSToFind2")><input type="hidden" name="ACSToFind2" value="#form.ACSToFind2#" /></cfif>
										<cfif isDefined("form.ClaimToFind1")><input type="hidden" name="ClaimToFind1" value="#form.ClaimToFind1#" /></cfif>
										<cfif isDefined("form.ClaimToFind2")><input type="hidden" name="ClaimToFind2" value="#form.ClaimToFind2#" /></cfif>
										<cfloop query="getRegions">
											<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
												<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
											</cfif>
										</cfloop>
										</cfif>
									</td>
								</FORM>
							</TR>
						</cfloop>
					<!--- milestone total --->
					<tr valign="top">
						<TD class="TotalRowOrange" colspan="2">&nbsp;</td>
						<TD class="TotalRowOrange" colspan="11">Milestone Total</td>
						<TD class="TotalRowOrange" colspan="1" align="right">#dollarformat(totalMilestoneAmount)#</td>
						<TD class="TotalRowOrange" colspan="3">&nbsp;</td>
					</tr>
					<cfinclude template="Site_Milestone_Export.cfm">
					<cfelse>
						<cfset row = 1-row>
						<TR>
							<td class="row#row#" align="center" colspan="17"><em>There are no records that match your search parameters</em></td>
						</TR>
					</cfif>
				</TABLE>
			</td></tr>
		</TABLE>
	</cfif>
</cfoutput>
<script>document.frmClientReview.SiteIDToFind.focus();</script>
