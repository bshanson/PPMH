<!-------------------------------------------
Description:
	Site search

History:
	3/26/2020 - created
-------------------------------------------->

<SCRIPT>
function buttonDisable() {
	if (document.frmClientReview.lblExcelButton) document.frmClientReview.lblExcelButton.style.visibility='hidden';
}
</SCRIPT>

<!--- get Site Managers --->
<cfinclude template="../components/q_getSiteManagers.cfm">
<!--- get states --->
<cfinclude template="../components/q_getStates.cfm">
<!--- get portfolios --->
<cfinclude template="q_getPortfolios.cfm">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- get Ops Lead --->
<cfinclude template="q_getChevronPortfolioManagers.cfm">

<!--- search for the sites --->
<cfif isDefined("form.Search")>
	<cfinclude template="q_getReviewSites.cfm">
</cfif>

<!--- help text --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText"></td>
		<td class="largeText" ></td>
	</TR>
	<TR>
		<td class="largeText"></td>
		<td class="largeText" ><strong>Site Report</strong></TD>
		<td class="largeText"></td>
	</TR>
	<TR>
		<td class="largeText"></td>
		<td class="largeText">
			<li>Use this page to generate a <strong>Site Report</strong>.</li> 
			<li>Search by selecting and / or filling in the any fields below, and clicking the <strong>Search</strong>. Exact terms are not necessary, substrings of a search item may be used.</li>
			<li>To generate a report for all sites, leave all fields blank and click <strong>Search</strong>.</li>
			<li>Once displayed, you will be able to open an Excel file of the search results.</li>
		</td>
		<td class="largeText"></td>
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
			<td class="largeText" ></td>
			<td class="largeText" align="right" ><strong>Site Portfolio:</strong>&nbsp;</td>
			<td class="largeText" colspan="2" valign="top">
				<select name="SitePortfolioToFind" class="largeText">
					<option value="0" <cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind EQ "0">selected="selected"</cfif>>- select a site portfolio -</option>
					<cfloop query="getPortfolios" >
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
			<td class="largeText" align="right" ></td>
			<td class="largeText" align="right"><strong>Site ID:</strong>&nbsp;</td>
			<td class="largeText">
				<input type="Text" name="SiteIDtofind" size="10" class="largeText" <cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)>value="#form.SiteIDtofind#"</cfif>>
				&nbsp;
				<strong>Site Name:</strong>&nbsp;
				<input type="Text" name="SiteNameToFind" size="20" class="largeText" <cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)>value="#form.SiteNameToFind#"</cfif>>
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

		<!--- ops lead, deputy, Site Manager --->
		<TR>
			<td class="largeText"></td>
			<td class="largeText" align="right"><strong>Chevron Ops:</strong>&nbsp;</td>
			<td class="largeText">
				<select name="ChevronOpsToFind" class="largeText">
					<option value="0">- select a chevron ops lead -</option>
					<cfloop query="getChevronPortfolioManagers">
						<option value="#getChevronPortfolioManagers.User_ID#" <cfif isDefined("form.ChevronOpsToFind") and form.ChevronOpsToFind EQ getChevronPortfolioManagers.User_ID>selected="selected"</cfif>>#getChevronPortfolioManagers.Last_Name#, #getChevronPortfolioManagers.First_Name#</option>
					</cfloop>
				</select>
				&nbsp;
				<strong>Deputy:</strong>&nbsp;
				<select name="DeputyToFind" class="largeText">
					<option value="0">- select a deputy -</option>
					<cfloop query="getSiteManagers">
						<option value="#getSiteManagers.User_ID#" <cfif isDefined("form.DeputyToFind") and form.DeputyToFind EQ getSiteManagers.User_ID>selected="selected"</cfif>>#getSiteManagers.Last_Name#, #getSiteManagers.First_Name#</option>
					</cfloop>
				</select>
<!---				&nbsp;
				<strong>Site Manager:</strong>&nbsp;
				<select name="smtofind" class="largeText">
					<option value="0">- select a site manager -</option>
					<cfloop query="getSiteManagers">
						<option value="#getSiteManagers.User_ID#" <cfif isDefined("form.smtofind") and form.smtofind EQ getSiteManagers.User_ID>selected="selected"</cfif>>#getSiteManagers.Last_Name#, #getSiteManagers.First_Name#</option>
					</cfloop>
				</select>--->
			</td>
		</TR>
		<tr><td colspan="3" height="5"></td></tr>

		<!--- buttons --->
		<TR>
			<td class="largeText"></td>
			<td class="largeText"></td>
			<td class="largeText">
				<input type="Submit" name="Search" class="largeTextButton" value="Search" onClick="buttonDisable();">
				<cfif isDefined("getReviewSites") and getReviewSites.RecordCount GT 0>
					<CFSET FileName="Site_Report_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
					<input type="button" name="lblExcelButton" class="largeTextButton" value="Open Excel File" ONCLICK="window.open('#Request.ExcelPath#/#FileName#')">
				</cfif>
			</td>
		</TR>
		<TR>
			<td class="largeText" width="1%">&nbsp;</td>
			<td class="largeText" width="11%">&nbsp;</td>
			<td class="largeText">&nbsp;</td>
		</TR>
	</form>
</cfoutput>
</TABLE>

<!--- display search results --->
<cfif isDefined("getReviewSites")>
	<cfset r=0>
		<cfoutput><TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff"></cfoutput>
			<tr><td>
				<cfoutput><TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999"></cfoutput>
		<TR>
			<td class="ServiceListHeader" width="9%" align="center">Site ID</td>
			<td class="ServiceListHeader" width="17%" align="center">Name</td>
			<td class="ServiceListHeader" width="17%" align="center">Address</td>
			<td class="ServiceListHeader" width="7%" align="center">Program</td>
			<td class="ServiceListHeader" width="7%" align="center">Portfolio</td>
			<td class="ServiceListHeader" width="13%" align="center">Deputy</td>
			<td class="ServiceListHeader" width="13%" align="center">Ops Lead</td>
			<td class="ServiceListHeader" width="9%" align="center">Facility Type</td>
			<td class="ServiceListHeader" width="8%" align="center">COP - Region</td>
		</tr>
		<cfif getReviewSites.RecordCount GT 0>
			<cfoutput query="getReviewSites">
				<cfset MonthQuantity = "">
				<cfset remainingSiteMilestones = "">
				<cfset InvoiceAmount = "">
				<cfset remainingSiteMilestoneFees = "">
				<cfset forecastQY = "">
				<TR>
					<td valign="center" class="ReportBody#r#">#getReviewSites.Site_ID#</td>
					<td valign="center" class="ReportBody#r#">#getReviewSites.Site_Name#</td>
					<td valign="center" class="ReportBody#r#">#getReviewSites.address#<br>#getReviewSites.city#, #getReviewSites.State_Abbreviation#</td>
					<td valign="center" class="ReportBody#r#">#getReviewSites.Program#</td>
					<td valign="center" class="ReportBody#r#">#getReviewSites.Portfolio#</td>
					<td valign="center" class="ReportBody#r#">#getReviewSites.Deputy_Name#</td>
					<td valign="center" class="ReportBody#r#">#getReviewSites.Ops_Lead#</td>
					<td valign="center" class="ReportBody#r#">#getReviewSites.Facility_Type#</td>
					<cfif len(getReviewSites.Portfolio) and findnocase("cop",getReviewSites.Portfolio)>
						<td valign="center" class="ReportBody#r#" align="center">#right(getReviewSites.Portfolio,3)# - #getReviewSites.Region#</td>
					<cfelse>
						<td valign="center" class="ReportBody#r#" align="center">&nbsp;</td>
					</cfif>
				</tr>
				<cfset r = 1-r>
			</cfoutput>
			<cfinclude template="Site_Report_export.cfm">
		<cfelse>
			<cfoutput>
				<TR>
					<td ALIGN="center" valign="top" colspan="9" class="ReportBody#r#"><em>no records in the database matched your search criteria</em></td>
				</tr>
			</cfoutput>
		</cfif>
	</TABLE>
			</td></tr>
		</TABLE>
</cfif>
<script>document.frmClientReview.SiteIDtofind.focus();</script>
