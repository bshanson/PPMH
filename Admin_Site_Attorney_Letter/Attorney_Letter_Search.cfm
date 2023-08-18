<!-------------------------------------------
Description:
	Attorney Letter search page

History:
	10/13/2022 - created
-------------------------------------------->

<script src="scripts/divHider.js"></script>
<cfset msgSuccess = "&nbsp;">
<cfset arrErrors = ArrayNew(1) />

<!--- delete a attorney letter record --->
<cfif isDefined("form.edittype") and form.edittype EQ "DeleteAttorneyLetterRecord">
 	<cfinclude template="q_delAttorneyLetterInfo.cfm">
</cfif>

<!--- get states --->
<cfinclude template="../components/q_getStates.cfm">
<!--- get portfolios --->
<cfinclude template="q_getPortfolios.cfm">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- search for the sites --->
<cfif isDefined("form.SiteIDtofind")>
	<cfinclude template="q_getAttorneyLetters.cfm">
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
		<td class="largeText"><strong>Attorney Letter Information Management</strong></TD>
		<td class="largeText" width="1%">
	</TR>
	<TR>
		<td class="largeText" width="1%">
		<td class="largeText">
			<li>Use this page to manage attorney letter information.</li>
			<li>Select the <strong>Portfolio</strong>, <strong>Region</strong>, enter the <strong>Site ID</strong>, <strong>Site Name</strong>, or select a <strong>State</strong> for which to display the Site records.</li>
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
			<td class="largeText" align="right"><strong>Portfolio:</strong>&nbsp;</td>
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

		<!--- buttons --->
		<TR>
			<td class="largeText"></td>
			<td class="largeText"></td>
			<td class="largeText">
				<input type="Submit" name="Search" class="largeTextButton" value="Search" onClick="buttonDisable();">
				<input type="Reset" name="Reset" class="largeTextButton" value="Reset">
				<cfif isDefined("getAttorneyLetters") and getAttorneyLetters.RecordCount GT 0>
					<CFSET FileName="Attorney_Letter_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
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
	<cfif isDefined("getAttorneyLetters")>
		<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
			<tr><td>
				<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999">
					<!--- add --->
					<FORM NAME="Add" ACTION="" METHOD="post">
						<input type="hidden" name="edittype" value="AddAttorneyLetterRecord" />
						<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
						<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
						<cfif isDefined("form.SiteNameToFind")><input type="hidden" name="SiteNameToFind" value="#form.SiteNameToFind#" /></cfif>
						<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
						<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
						<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
						<cfloop query="getRegions">
							<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
								<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
							</cfif>
						</cfloop>
						<tr>
							<td width="9%" class="ServiceListHeader" align="center"><strong>Site ID</strong></td>
							<td width="19%" class="ServiceListHeader" align="center"><strong>Site Name</strong></td>
							<td width="18%" class="ServiceListHeader" align="center"><strong>Address</strong></td>
							<td width="7%" class="ServiceListHeader" align="center"><strong>Portfolio</strong></td>
							<td width="18%" class="ServiceListHeader" align="center"><strong>Site Manager</strong></td>
							<td width="1%" class="ServiceListHeader" align="center"><input type="Image" name="btnAddType" src="images/icon_new.gif" border="0" onclick="submit()" alt="add new record"></td>
							<td width="27%" class="ServiceListHeader" align="center"><strong>Letters</strong></td>
							<td width="1%" class="ServiceListHeader" align="center"></td>
						</tr>
					</form>
					<cfif isDefined("getAttorneyLetters") and getAttorneyLetters.recordcount NEQ 0>
						<cfloop query="getAttorneyLetters">
							<cfset row = 1-row>
							<TR>
								<td class="row#row#"><cfif len(getAttorneyLetters.Admin_Site_ID)><SPAN TITLE="#getAttorneyLetters.Admin_Site_ID#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getAttorneyLetters.Admin_Site_ID,11)#<cfif len(getAttorneyLetters.Admin_Site_ID) GT 11>...</cfif></SPAN><cfelse>&nbsp;</cfif></td>
								<td class="row#row#">#getAttorneyLetters.Site_Name#</td>
								<td class="row#row#">#getAttorneyLetters.Address#<br>#getAttorneyLetters.City#, #getAttorneyLetters.State_Abbreviation#</td>
								<td class="row#row#">#getAttorneyLetters.Portfolio#</td>
								<td class="row#row#">#getAttorneyLetters.SM_Name#</td>

								<!--- edit --->
								<cfinclude template="q_getSiteAttorneyLetters.cfm">
								<cfif isDefined("getSiteAttorneyLetters") and getSiteAttorneyLetters.RecordCount NEQ 0>
									<td colspan="3">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="##ffffff">
										<cfloop query="getSiteAttorneyLetters" >
											<tr>
											<FORM NAME="Edit" ACTION="" METHOD="post">
												<input type="hidden" name="edittype" value="EditAttorneyLetterRecord" />
												<input type="hidden" name="edtAttorneyLetterID" value="#getSiteAttorneyLetters.ID#" />
												<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
												<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
												<cfif isDefined("form.SiteNameToFind")><input type="hidden" name="SiteNameToFind" value="#form.SiteNameToFind#" /></cfif>
												<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
												<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
												<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
												<cfloop query="getRegions">
													<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
														<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
													</cfif>
												</cfloop>
												<td class="row#row#" width="6%"><input type="Image" name="btnEditType" src="images/icon_pencil.gif" border="0" onclick="submit()" alt="edit this letter"></td>
											</form>
			
											<td class="row#row#" width="88%"><a href="#Request.AttorneyPath#/#getSiteAttorneyLetters.File_Name#" target="_blank">#getSiteAttorneyLetters.Document_Name#</a></td>
			
											<!--- delete --->
											<FORM NAME="Delete" ACTION="" METHOD="post">
												<input type="hidden" name="edittype" value="DeleteAttorneyLetterRecord" />
												<input type="hidden" name="delAttorneyLetterID" value="#getSiteAttorneyLetters.ID#" />
												<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
												<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
												<cfif isDefined("form.SiteNameToFind")><input type="hidden" name="SiteNameToFind" value="#form.SiteNameToFind#" /></cfif>
												<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
												<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
												<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
												<cfloop query="getRegions">
													<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
														<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
													</cfif>
												</cfloop>
												<td class="row#row#" width="6%" align="right"><input type="Image" name="btnDeleteType" src="images/icon_trash.gif" border="0" onclick="if (confirm('Delete this letter?')){submit()}; return false" alt="delete this letter"></td>
											</form>
											</tr>
										</cfloop>
										<cfif getSiteAttorneyLetters.RecordCount EQ 1><tr><td colspan="3">&nbsp;</td></tr></cfif>
										</table>
									</td>
								<cfelse>
									<td class="row#row#" colspan="3"></td>
								</cfif>
							</TR>
						</cfloop>
					<cfinclude template="Attorney_Letter_Export.cfm">
					<cfelse>
						<cfset row = 1-row>
						<TR>
							<td class="row#row#" align="center" colspan="8"><em>There are no records that match your search parameters</em></td>
						</TR>
					</cfif>
				</TABLE>
			</td></tr>
		</TABLE>
	</cfif>
</cfoutput>
<script>document.frmClientReview.SiteIDToFind.focus();</script>
