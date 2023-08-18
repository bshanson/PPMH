<!-------------------------------------------
Description:
	Unclaimed Milestones Report search page

History:
	4/7/2021 - created
-------------------------------------------->

<SCRIPT>
function buttonDisable() {
	if (document.frmClientReview.lblExcelButton) document.frmClientReview.lblExcelButton.style.visibility='hidden';
}
</SCRIPT>

<cfparam name="form.startmonthtofind" default="#dateformat(now(),'m')#">
<cfparam name="form.startyeartofind" default="#dateformat(now(),'yyyy')#">
<cfparam name="form.endmonthtofind" default="#dateformat(now(),'m')#">
<cfparam name="form.endyeartofind" default="#dateformat(now(),'yyyy')#">

<!--- get months --->
<cfinclude template="../components/q_getMonths.cfm">
<!--- get years --->
<cfinclude template="../components/q_getYears.cfm">
<!--- get Milestones --->
<cfinclude template="../Client_Review/q_getMilestones.cfm">
<!--- get Site Managers --->
<cfinclude template="../components/q_getSiteManagers.cfm">
<!--- get states --->
<cfinclude template="../components/q_getStates.cfm">
<!--- get portfolios --->
<cfmodule template="../Client_Review/q_getPortfolios.cfm" UserCompanyID="#Session.Security.CompanyID#" getPortfolios="getPortfolios">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- search for the sites --->
<cfif isDefined("form.Search")>
	<cfinclude template="q_getUnclaimedMilestones.cfm">	
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
		<td class="largeText" ><strong>Unclaimed Milestone Report</strong></TD>
		<td class="largeText"></td>
	</TR>
	<TR>
		<td class="largeText"></td>
		<td class="largeText">
			<li>Use this page to generate an <strong>Unclaimed Milestone Report</strong>.</li> 
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

		<!--- Site Manager, deputy, ops lead --->
		<TR>
			<td class="largeText"></td>
			<td class="largeText" align="right"><strong>Site Manager:</strong>&nbsp;</td>
			<td class="largeText">
					<select name="smtofind" class="largeText">
						<option value="0">- select a site manager -</option>
						<cfloop query="getSiteManagers">
							<option value="#getSiteManagers.User_ID#" <cfif isDefined("form.smtofind") and form.smtofind EQ getSiteManagers.User_ID>selected="selected"</cfif>>#getSiteManagers.Last_Name#, #getSiteManagers.First_Name#</option>
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
			</td>
		</TR>
		<tr><td colspan="3" height="5"></td></tr>

 		<!--- portfolio, milestone --->
		<TR>
			<td class="largeText"></td>
			<td class="largeText" align="right"><strong>Milestone Portfolio:</strong>&nbsp;</td>
			<td class="largeText">
				<select name="MilestonePortfolioToFind" class="largeText">
					<option value="0" <cfif isDefined("form.MilestonePortfolioToFind") and form.MilestonePortfolioToFind EQ "0">selected="selected"</cfif>>- select a milestone portfolio -</option>
					<cfloop query="getPortfolios" >
						<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.MilestonePortfolioToFind") and form.MilestonePortfolioToFind EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
					</cfloop>
				</select>
				&nbsp;
				<strong>Milestone:</strong>&nbsp;
				<select name="milestonetofind" class="largeText">
					<option value="0" <cfif isDefined("form.milestonetofind") and form.milestonetofind EQ getMilestones.ID>selected="selected"</cfif>>- select milestone -</option>
					<cfloop query="getMilestones">
						<option value="#getMilestones.ID#" <cfif isDefined("form.milestonetofind") and form.milestonetofind EQ getMilestones.ID>selected="selected"</cfif>>#getMilestones.Milestone#</option>
					</cfloop>
				</select>
			</td>
		</TR>
		<tr><td colspan="3" height="5"></td></tr>

		<!--- date --->
		<TR>
			<td class="largeText"></td>
			<td class="largeText" align="right"><strong>Plan Date Start :</strong>&nbsp;</td>
			<td class="largeText">
				<select name="startmonthtofind" class="largeText">
					<cfloop query="getMonths">
						<option value="#getMonths.Month_ID#" <cfif isDefined("form.startmonthtofind") and form.startmonthtofind EQ getMonths.Month_ID>selected="selected"</cfif>>#getMonths.Month#</option>
					</cfloop>
				</select>&nbsp;
				<select name="startyeartofind" class="largeText">
					<cfloop query="getYears">
						<option value="#getYears.Year_ID#" <cfif isDefined("form.startyeartofind") and form.startyeartofind EQ getYears.Year_ID>selected="selected"</cfif>>#getYears.Year_ID#</option>
					</cfloop>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<strong>Plan Date End:</strong>&nbsp;
				<select name="endmonthtofind" class="largeText">
					<cfloop query="getMonths">
						<option value="#getMonths.Month_ID#" <cfif isDefined("form.endmonthtofind") and form.endmonthtofind EQ getMonths.Month_ID>selected="selected"</cfif>>#getMonths.Month#</option>
					</cfloop>
				</select>
				&nbsp;
				<select name="endyeartofind" class="largeText">
					<cfloop query="getYears">
						<option value="#getYears.Year_ID#" <cfif isDefined("form.endyeartofind") and form.endyeartofind EQ getYears.Year_ID>selected="selected"</cfif>>#getYears.Year_ID#</option>
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
				<cfif isDefined("getUnclaimedMilestones") and getUnclaimedMilestones.RecordCount GT 0>
					<CFSET FileName="Unclaimed_Milestones_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
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
<cfif isDefined("getUnclaimedMilestones")>
	<cfset r=0>
		<cfoutput><TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff"></cfoutput>
			<tr><td>
				<cfoutput><TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999"></cfoutput>
		<TR>
			<td class="ServiceListHeader" width="10%" align="center">Site ID</td>
			<td class="ServiceListHeader" width="11%" align="center">Site Name</td>
			<td class="ServiceListHeader" width="4%" align="center">State</td>
			<td class="ServiceListHeader" width="5%" align="center">Region</td>
			<td class="ServiceListHeader" width="6%" align="center">Site Portfolio</td>
			<td class="ServiceListHeader" width="9%" align="center">Site Manager</td>
			<td class="ServiceListHeader" width="9%" align="center">Deputy</td>
			<td class="ServiceListHeader" width="7%" align="center">Milestone</td>
			<td class="ServiceListHeader" width="7%" align="center">Milestone Portfolio</td>
			<td class="ServiceListHeader" width="7%" align="center">Milestone Baseline Date</td>
			<td class="ServiceListHeader" width="7%" align="center">Milestone Plan Date</td>
			<td class="ServiceListHeader" width="6%" align="center">Milestone Amt</td>
			<td class="ServiceListHeader" width="12%" align="center">Notes</td>
		</tr>
		<cfif getUnclaimedMilestones.RecordCount GT 0>
			<cfoutput query="getUnclaimedMilestones">
				<TR>
					<td valign="center" class="ReportBody#r#"><cfif len(getUnclaimedMilestones.Site_ID)><SPAN TITLE="#getUnclaimedMilestones.Site_ID#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getUnclaimedMilestones.Site_ID,15)#<cfif len(getUnclaimedMilestones.Site_ID) GT 15>...</cfif></SPAN><cfelse>&nbsp;</cfif></td>
					<td valign="center" class="ReportBody#r#">#getUnclaimedMilestones.site_Name#</td>
					<td valign="center" class="ReportBody#r#" align="center">#getUnclaimedMilestones.State_Abbreviation#</td>
					<td valign="center" class="ReportBody#r#" align="center">#getUnclaimedMilestones.Region#</td>
					<td valign="center" class="ReportBody#r#">#getUnclaimedMilestones.Site_Portfolio#</td>
					<td valign="center" class="ReportBody#r#">#getUnclaimedMilestones.SiteManager#</td>
					<td valign="center" class="ReportBody#r#">#getUnclaimedMilestones.Deputy#</td>
					<td valign="center" class="ReportBody#r#">#getUnclaimedMilestones.milestone#</td>
					<td valign="center" class="ReportBody#r#">#getUnclaimedMilestones.Milestone_Portfolio#</td>
					<td valign="center" class="ReportBody#r#" align="center">#right(getUnclaimedMilestones.Milestone_Baseline_Date,2)#/#left(getUnclaimedMilestones.Milestone_Baseline_Date,4)#</td>
					<td valign="center" class="ReportBody#r#" align="center">#right(getUnclaimedMilestones.Milestone_Plan_Date,2)#/#left(getUnclaimedMilestones.Milestone_Plan_Date,4)#</td>
					<td valign="center" class="ReportBody#r#" align="right">#dollarformat(getUnclaimedMilestones.Milestone_Amount)#</td>
					<td valign="center" class="ReportBody#r#"><cfif len(getUnclaimedMilestones.notes)><SPAN TITLE="#getUnclaimedMilestones.Notes#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getUnclaimedMilestones.notes,20)#<cfif len(getUnclaimedMilestones.notes) GT 20>...</cfif></SPAN><cfelse>&nbsp;</cfif></td>
				</tr>
				<cfset r = 1-r>
			</cfoutput>
			<cfinclude template="Unclaimed_Milestones_Report_Export.cfm">
		<cfelse>
			<cfoutput>
				<TR>
					<td ALIGN="center" valign="top" colspan="13" class="ReportBody#r#"><em>no records in the database matched your search criteria</em></td>
				</tr>
			</cfoutput>
		</cfif>
	</TABLE>
			</td></tr>
		</TABLE>
</cfif>
<script>document.frmClientReview.SiteIDtofind.focus();</script>
