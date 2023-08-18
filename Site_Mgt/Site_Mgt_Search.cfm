<!----------------------------------------------------------------------------------------------------------
Description:
	Site Mgt search page

History:
	2/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<SCRIPT>
	function picked(){
		document.forms.frmSiteInfo.submit()
	}
</SCRIPT>

<cfset searchErrormsg = "" />

<!--- delete site record --->
<cfif isDefined("form.edittype") and form.edittype EQ "deleteSite">
	<cfinclude template="q_delSite.cfm">
</cfif>

<!--- delete monthly record --->
<cfif isDefined("form.delStatus") and form.delStatus EQ "delStatus">
	<cfinclude template="q_delStatus.cfm">
</cfif>

<!--- get all sites --->
<cfinclude template="q_getSites.cfm">
<!--- get Site Managers --->
<cfinclude template="../components/q_getSiteManagers.cfm">
<!--- get ERP Stages --->
<cfinclude template="../components/q_getERPStages.cfm">
<!--- get states --->
<cfinclude template="../components/q_getStates.cfm">
<!--- get portfolios --->
<cfinclude template="q_getPortfolios.cfm">
<!--- get regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- if filtering --->
<cfif isDefined("form.filter")><cfset form.AdminSiteID = ""></cfif>

<!--- search for the site --->
<cfif (isDefined("form.AdminSiteID")) and form.AdminSiteID NEQ "">
	<!--- get site info --->
	<cfinclude template="q_getSiteInfo.cfm">
</cfif>

<!--- help text --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText"></td>
		<td class="largeText" width="1%"></td>
	</TR>
	<TR>
		<td class="largeText"></td>
		<td class="largeText"><strong>Site Management</strong></TD></TR>
		<td class="largeText"></td>
	<TR>
		<td class="largeText"></td>
		<td class="largeText">
			<li>Use this page to manage site information and prepare monthly progress reports.</li>
			<li>Search by selecting and / or filling in the any fields below, and clicking the <strong>Search</strong>. Exact terms are not necessary, substrings of a search item may be used.</li>
			<li>Select the <strong>Site</strong> from the select list and click <strong>Retrieve Selected Site</strong> to display the site information.</li>
			<li>If there is monthly project information it will be displayed below the site information. The monthly project information may be edited by clicking on the pencil icon to the left of the year.</li>
		</td>
		<td class="largeText"></td>
	</TR>
	<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
</TABLE>

<!--- search form --->
<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="##ffffff">
		<form name="frmSiteInfo" action="" method="post">
			<!--- scrub url input for XSS --->
			<cfinclude template="/Common/XSS_Scubber.cfm" >

			<!--- widths --->
			<TR>
				<td class="largeText" width="2%"></td>
				<td class="largeText" width="8%"></td>
				<td class="largeText" width="67%"></td>
				<td class="largeText" width="4%"></td>
				<td class="largeText" width="19%"></td>
			</tr>
			<!--- Site Portfolio, Region --->
			<TR>
				<td class="largeText">&nbsp;</td>
				<td class="largeText" align="right"><strong>Site Portfolio:</strong>&nbsp;</td>
				<td class="largeText" valign="top" colspan="3">
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
			<tr><td colspan="5" height="5"></td></tr>

			<!--- site id, site name, address, city, state --->
			<TR valign="top">
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Site ID:</strong>&nbsp;</td>
				<td class="largeText">
					<input type="Text" name="SiteIDtofind" size="10" class="largeText" <cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)>value="#form.SiteIDtofind#"</cfif>>
					&nbsp;
					<strong>Name:</strong>&nbsp;
					<input type="Text" name="SiteNameToFind" size="25" class="largeText" <cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)>value="#form.SiteNameToFind#"</cfif>>
					&nbsp;
					<strong>Address:</strong>&nbsp;
					<input type="Text" name="AddressToFind" size="25" class="largeText" <cfif isDefined("form.AddressToFind") and len(form.AddressToFind)>value="#form.AddressToFind#"</cfif>>
					&nbsp;
					<strong>City:</strong>&nbsp;
					<input type="Text" name="CityToFind" size="20" class="largeText" <cfif isDefined("form.CityToFind") and len(form.CityToFind)>value="#form.CityToFind#"</cfif>>
				</td>
				<td class="largeText" align="right">
					<strong>State:</strong>&nbsp;
				</td>
				<td class="largeText" rowspan="4">
					<select name="StateToFind" class="largeText" multiple="3">
						<option value="0" <cfif isDefined("form.StateToFind") and form.StateToFind EQ "0">selected="selected"</cfif>>- select a state -</option>
						<cfloop query="getStates">
							<option value="#getStates.State_ID#" <cfif isDefined("form.StateToFind") and listfind(form.StateToFind, getStates.State_ID)>selected="selected"</cfif>>#getStates.State#</option>
						</cfloop>
					</select>
				</td>
			</TR>
			<tr><td colspan="5" height="5"></td></tr>

			<!--- Site Manager, deputy, Status portfolio & Overall filter button --->
			<TR>
				<td class="largeText">&nbsp;</td>
				<td class="largeText" align="right"><strong>Site Manager:</strong>&nbsp;</td>
				<td class="largeText" valign="top">
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
					&nbsp;
					<strong>Status Portfolio:</strong>&nbsp;
					<select name="StatusPortfolioToFind" class="largeText">
						<option value="0" <cfif isDefined("form.StatusPortfolioToFind") and form.StatusPortfolioToFind EQ "0">selected="selected"</cfif>>- select a portfolio -</option>
						<cfloop query="getPortfolios">
							<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.StatusPortfolioToFind") and form.StatusPortfolioToFind EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
						</cfloop>
					</select>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="Submit" name="Filter" value="Apply Filter" class="largeTextButton">
				</TD>
				<td class="largeText"></td>
			</TR>
			<tr><td colspan="5" height="5"></td></tr>

			<!--- Active, Closed --->
			<TR valign="middle">
				<td class="largeText"></td>
				<td class="largeText" align="right"><strong>Closed:</strong>&nbsp;</td>
				<td class="largeText" colspan="3">
					<input type="checkbox" name="ClosedToFind" class="largeText" <cfif isDefined("form.ClosedToFind")>checked="checked"</cfif>>Yes
					&nbsp;
					<input type="checkbox" name="NotClosedToFind" class="largeText" <cfif isDefined("form.NotClosedToFind")>checked="checked"</cfif>>No
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<strong>Active:</strong>&nbsp;
					<input type="checkbox" name="ActiveToFind" class="largeText" <cfif isDefined("form.ActiveToFind")>checked="checked"</cfif>>Yes
					&nbsp;
					<input type="checkbox" name="NotActiveToFind" class="largeText" <cfif isDefined("form.NotActiveToFind")>checked="checked"</cfif>>No
				</td>
			</TR>
			<tr><td colspan="5" height="5"></td></tr>

			<!--- sites box --->
			<TR>
				<td class="largeText">&nbsp;</td>
				<td class="largeText" valign="top" colspan="4">
					<strong>Site ID - Site Name, City, State, Portfolio, Region</strong><br/>
					<SELECT NAME="AdminSiteID" MULTIPLE SIZE="10" class="largeText" STYLE="width:800px;" ondblclick="picked()">
						<CFLOOP QUERY="getSites">
							<OPTION VALUE="#getSites.Admin_Site_ID#" <cfif (isDefined("form.AdminSiteID")) and form.AdminSiteID EQ getSites.Admin_Site_ID>selected</cfif>>
								#getSites.Site_ID# - #getSites.Site_Name#, #getSites.City#, #getSites.State_Abbreviation#, #getSites.Portfolio#<cfif len(getSites.Region)>, #getSites.Region# Region</cfif>
							</OPTION>
						</CFLOOP>
					</SELECT>
				</td>
				<td class="largeText" valign="center">
					<cfif Len(searchErrormsg)><span class="errorText">#searchErrormsg#</span></cfif>
				</td>
			</TR>
			<tr><td colspan="5" height="5"></td></tr>

			<!--- Retrieve Selected Site button --->
			<TR>
				<td class="largeText">&nbsp;</td>
				<td class="largeText" colspan="4">
					<input type="Submit" name="Search" class="largeTextButton" value="Retrieve Selected Site">
				</td>
			</TR>
			<tr><td colspan="5" height="15"></td></tr>
		</form>
	</TABLE>
</cfoutput>

<!--- display site information --->
<cfif isDefined("getSiteInfo") and getSiteInfo.RecordCount GT 0>
	<cfset r=0>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
		<TR>
			<td valign="bottom" class="ServiceListHeader" width="10%">Site ID</td>
			<td valign="bottom" class="ServiceListHeader" width="17%">Site Name</td>
			<td valign="bottom" class="ServiceListHeader" width="17%">Address</td>
			<td valign="bottom" class="ServiceListHeader" width="12%">City</td>
			<td valign="bottom" class="ServiceListHeader" width="12%">State</td>
			<td valign="bottom" class="ServiceListHeader" width="12%">Site Manager</td>
			<td valign="bottom" class="ServiceListHeader" width="10%">COP</td>
			<td valign="bottom" class="ServiceListHeader" width="10%">Region</td>
		</tr>
		<cfoutput query="getSiteInfo">
			<TR>
				<td valign="top" class="ReportBody#r#">#getSiteInfo.Site_ID#</td>
				<td valign="top" class="ReportBody#r#">#getSiteInfo.Site_Name#</td>
				<td valign="top" class="ReportBody#r#">#getSiteInfo.Address#</td>
				<td valign="top" class="ReportBody#r#">#getSiteInfo.City#</td>
				<td valign="top" class="ReportBody#r#">#getSiteInfo.State_Abbreviation#</td>
				<td valign="top" class="ReportBody#r#"><cfif len(getSiteInfo.User_ID)>#getSiteInfo.Last_Name#, #getSiteInfo.First_Name#</cfif></td>
				<td valign="top" class="ReportBody#r#">#getSiteInfo.Portfolio#</td>
				<td valign="top" class="ReportBody#r#">#getSiteInfo.Region#</td>
			</tr>
		</cfoutput>
	</TABLE>
</cfif>

<!--- add new record --->
<cfif isDefined("getSiteInfo") and getSiteInfo.RecordCount GT 0>
	<cfoutput>
		<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
			<TR>
				<FORM NAME="addStatus" ACTION="" METHOD="post">
					<!--- scrub url input for XSS --->
					<cfinclude template="/Common/XSS_Scubber.cfm" >
					<td valign="top" class="ReportBody#r#">
						<input type="hidden" name="edittype" value="addStatus" />
						<cfloop query="getRegions">
							<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
								<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
							</cfif>
						</cfloop>
						<cfif isDefined("form.AdminSiteID")><input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#" /></cfif>
						<cfif isDefined("form.SiteIDtofind")><input type="hidden" name="SiteIDtofind" value="#form.SiteIDtofind#" /></cfif>
						<cfif isDefined("form.sitenametofind")><input type="hidden" name="sitenametofind" value="#form.sitenametofind#" /></cfif>
						<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
						<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
						<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
						<cfif isDefined("form.smtofind")><input type="hidden" name="smtofind" value="#form.smtofind#" /></cfif>
						<cfif isDefined("form.DeputyToFind")><input type="hidden" name="DeputyToFind" value="#form.DeputyToFind#" /></cfif>
						<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
						<cfif isDefined("form.StatusPortfolioToFind")><input type="Hidden" name="StatusPortfolioToFind" value="#form.StatusPortfolioToFind#"></cfif>
						<cfif isDefined("form.ActiveToFind")><input type="hidden" name="ActiveToFind" value="#form.ActiveToFind#" /></cfif>
						<cfif isDefined("form.NotActiveToFind")><input type="hidden" name="NotActiveToFind" value="#form.NotActiveToFind#" /></cfif>
						<cfif isDefined("form.ClosedToFind")><input type="hidden" name="ClosedToFind" value="#form.ClosedToFind#" /></cfif>
						<cfif isDefined("form.NotClosedToFind")><input type="hidden" name="NotClosedToFind" value="#form.NotClosedToFind#" /></cfif>
						<input type="Button" name="btnAddStatus" class="largeTextButton" onclick="submit()" value="add new status record">
					</td>
				</FORM>
			</tr>
		</TABLE>
	</cfoutput>
</cfif>

<!--- display monthly information --->
<cfif isDefined("getSiteInfo") and getSiteInfo.RecordCount GT 0>
	<cfinclude template="q_getSiteStatus.cfm">
	<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="#ffffff">
		<cfoutput query="getSiteStatus">
			<!--- month row --->
			<TR>
				<!--- edit icon --->
				<FORM NAME="editStatus" ACTION="" METHOD="post">
					<!--- scrub url input for XSS --->
					<cfinclude template="/Common/XSS_Scubber.cfm" >
					<td valign="top" class="ReportBody0" width="1%">
						<input type="submit" name="btnEditStatus" value="" style="background: url(images/icon_pencil.gif) no-repeat; height: 25px; width: 23px; border: none; cursor: pointer;">
						<input type="hidden" name="edittype" value="editStatus" />
						<input type="hidden" name="editStatusID" value="#getSiteStatus.Status_ID#" />
						<cfif isDefined("form.AdminSiteID")><input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#" /></cfif>
						<input type="hidden" name="yeartofind" value="#Status_Year#" />
						<input type="hidden" name="monthtofind" value="#Status_Month#" />
						<input type="hidden" name="periodtofind" value="#Period#" />
						<cfloop query="getRegions">
							<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
								<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
							</cfif>
						</cfloop>
						<cfif isDefined("form.SiteIDtofind")><input type="hidden" name="SiteIDtofind" value="#form.SiteIDtofind#" /></cfif>
						<cfif isDefined("form.sitenametofind")><input type="hidden" name="sitenametofind" value="#form.sitenametofind#" /></cfif>
						<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
						<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
						<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
						<cfif isDefined("form.smtofind")><input type="hidden" name="smtofind" value="#form.smtofind#" /></cfif>
						<cfif isDefined("form.DeputyToFind")><input type="hidden" name="DeputyToFind" value="#form.DeputyToFind#" /></cfif>
						<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
						<cfif isDefined("form.StatusPortfolioToFind")><input type="Hidden" name="StatusPortfolioToFind" value="#form.StatusPortfolioToFind#"></cfif>
						<cfif isDefined("form.ActiveToFind")><input type="hidden" name="ActiveToFind" value="#form.ActiveToFind#" /></cfif>
						<cfif isDefined("form.NotActiveToFind")><input type="hidden" name="NotActiveToFind" value="#form.NotActiveToFind#" /></cfif>
						<cfif isDefined("form.ClosedToFind")><input type="hidden" name="ClosedToFind" value="#form.ClosedToFind#" /></cfif>
						<cfif isDefined("form.NotClosedToFind")><input type="hidden" name="NotClosedToFind" value="#form.NotClosedToFind#" /></cfif>
					</td>
				</FORM>
				<!--- year, month, closure --->
				<td valign="top" class="ReportBody1" width="98%">
					<strong>Year:</strong> #getSiteStatus.Status_Year#&nbsp;&nbsp;
					<strong>Month:</strong> #MonthAsString(getSiteStatus.Status_Month)#&nbsp;&nbsp;
					<strong>Status Portfolio: </strong><cfif len(getSiteStatus.Portfolio_ID) and getSiteStatus.Portfolio_ID NEQ 0>#getSiteStatus.Portfolio# </cfif>&nbsp;&nbsp;
					<strong>Planned Closure Date: </strong><cfif len(getSiteStatus.Closure_Month) and getSiteStatus.Closure_Month NEQ 0 and getSiteStatus.Closure_Month NEQ 999999>#MonthAsString(getSiteStatus.Closure_Month)# </cfif><cfif len(getSiteStatus.Closure_Year) and getSiteStatus.Closure_Year NEQ 0 and getSiteStatus.Closure_Year NEQ 999999>#getSiteStatus.Closure_Year#</cfif>
				</td>
				<!--- delete icon --->
				<FORM NAME="delStatus" ACTION="" METHOD="post">
					<!--- scrub url input for XSS --->
					<cfinclude template="/Common/XSS_Scubber.cfm" >
						<td valign="top" class="ReportBody0" width="1%">
						<input type="Image" name="btnDelStatus" src="images/icon_trash.gif" border="0" onclick="if (confirm('Delete this record?')){submit()}; return false" alt="delete this record">
						<cfif isDefined("form.AdminSiteID")><input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#" /></cfif>
						<input type="hidden" name="yeartofind" value="#getSiteStatus.Status_Year#" />
						<input type="hidden" name="monthtofind" value="#getSiteStatus.Status_Month#" />
						<input type="hidden" name="delStatus" value="delStatus" />
						<input type="hidden" name="delStatusID" value="#getSiteStatus.Status_ID#" />
						<input type="hidden" name="periodtofind" value="#getSiteStatus.Period#" />
						<cfloop query="getRegions">
							<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
								<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
							</cfif>
						</cfloop>
						<cfif isDefined("form.SiteIDtofind")><input type="hidden" name="SiteIDtofind" value="#form.SiteIDtofind#" /></cfif>
						<cfif isDefined("form.sitenametofind")><input type="hidden" name="sitenametofind" value="#form.sitenametofind#" /></cfif>
						<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
						<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
						<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
						<cfif isDefined("form.smtofind")><input type="hidden" name="smtofind" value="#form.smtofind#" /></cfif>
						<cfif isDefined("form.DeputyToFind")><input type="hidden" name="DeputyToFind" value="#form.DeputyToFind#" /></cfif>
						<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
						<cfif isDefined("form.StatusPortfolioToFind")><input type="Hidden" name="StatusPortfolioToFind" value="#form.StatusPortfolioToFind#"></cfif>
						<cfif isDefined("form.ActiveToFind")><input type="hidden" name="ActiveToFind" value="#form.ActiveToFind#" /></cfif>
						<cfif isDefined("form.NotActiveToFind")><input type="hidden" name="NotActiveToFind" value="#form.NotActiveToFind#" /></cfif>
						<cfif isDefined("form.ClosedToFind")><input type="hidden" name="ClosedToFind" value="#form.ClosedToFind#" /></cfif>
						<cfif isDefined("form.NotClosedToFind")><input type="hidden" name="NotClosedToFind" value="#form.NotClosedToFind#" /></cfif>
					</td>
				</FORM>
			</tr>
			<!--- health and safety --->
			<TR>
				<!--- space --->
				<td valign="bottom" class="ReportBody0"></td>
				<!--- data --->
				<td valign="top" class="ReportBody1" colspan="2">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<!--- forecast --->
						<tr>
							<td align="right" width="25%" class="HStext"><strong>Forecast Closure Quarter:&nbsp;</strong></td>
							<td class="HStext" colspan="2">
								<cfif len(getSiteStatus.Forecast_Quarter)>Q#getSiteStatus.Forecast_Quarter#</cfif>
								&nbsp;<strong>Forecast Closure Year:&nbsp;</strong>#getSiteStatus.Forecast_Year#
							</td>
						</tr>

						<!--- H&S --->
						<tr>
							<td align="right" class="HStext"><strong>Health &amp; Safety Loss:&nbsp;</strong></td>
							<td class="HStext" colspan="2">
								<SPAN TITLE="#getSiteStatus.HS_Loss#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getSiteStatus.HS_Loss,135)#<cfif len(getSiteStatus.HS_Loss) GT 135>...</cfif></SPAN>								
							</td>
						</tr>
						<tr>
							<td align="right" class="HStext"><strong>Health &amp; Safety Near Loss:&nbsp;</strong></td>
							<td class="HStext" colspan="2">
								<SPAN TITLE="#getSiteStatus.HS_Near_Loss#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getSiteStatus.HS_Near_Loss,135)#<cfif len(getSiteStatus.HS_Near_Loss) GT 135>...</cfif></SPAN>								
							</td>
						</tr>
	
						<!--- action item Information --->
						<tr>
							<td align="right" class="HStext"><strong>Current Action Items:&nbsp;</strong></td>
							<td class="HStext" colspan="2">
								<SPAN TITLE="#getSiteStatus.Current_Quarter_Action_Items_v#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getSiteStatus.Current_Quarter_Action_Items_v,135)#<cfif len(getSiteStatus.Current_Quarter_Action_Items_v) GT 135>...</cfif></SPAN>								
							</td>
						</tr>

						<!--- Milestone Assumptions --->
						<tr>
							<td align="right" class="HStext"><strong>Milestone Assumptions:&nbsp;</strong></td>
							<td class="HStext" colspan="2">
								<SPAN TITLE="#getSiteStatus.Milestone_Assumptions#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getSiteStatus.Milestone_Assumptions,135)#<cfif len(getSiteStatus.Milestone_Assumptions) GT 135>...</cfif></SPAN>								
							</td>
						</tr>

						<!--- projected change --->
						<tr>
							<td align="right" class="HStext"><strong>Projected Change In Scope / Issues:&nbsp;</strong></td>
							<td class="HStext" colspan="2">
								<SPAN TITLE="#getSiteStatus.Projected_Change_In_Scope_Issues#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getSiteStatus.Projected_Change_In_Scope_Issues,135)#<cfif len(getSiteStatus.Projected_Change_In_Scope_Issues) GT 135>...</cfif></SPAN>								
							</td>
						</tr>
		
						<!--- Critical Path --->
						<tr>
							<cfset vCriticalPath = "Endpoint">
							<cfif getSiteStatus.COP_ID EQ 39><cfset vCriticalPath = "Closure"></cfif>
							<td align="right" class="HStext"><strong>Critical Path to #vCriticalPath#:&nbsp;</strong></td>
							<td class="HStext" colspan="2">
								<SPAN TITLE="#getSiteStatus.Critical_Path#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getSiteStatus.Critical_Path,135)#<cfif len(getSiteStatus.Critical_Path) GT 135>...</cfif></SPAN>								
							</td>
						</tr>

						<!--- Current ERP --->
						<tr>
							<td align="right" class="HStext"><strong>Current ERP Stage:&nbsp;</strong></td>
							<td class="HStext" colspan="2"><span class="#getSiteStatus.ERP_Class#">&nbsp;#getSiteStatus.ERP_Stage#&nbsp;</span></td>
						</tr>

						<!--- Remedial Technology --->
						<tr>
							<td align="right" class="HStext"><strong>Remedial Technology:&nbsp;</strong></td>
							<td class="HStext" colspan="2">&nbsp;#getSiteStatus.Remedial_Technology#&nbsp;</td>
						</tr>

						<!--- Overall Project Status --->
						<cfif getSiteStatus.Overall_Project_Status EQ "R"><cfset statusClass = "ProjStatRed"><cfset OverallProjectStatus = "Late">
						<cfelseif getSiteStatus.Overall_Project_Status EQ "Y"><cfset statusClass = "ProjStatYellow"><cfset OverallProjectStatus = "At Risk">
						<cfelseif getSiteStatus.Overall_Project_Status EQ "G"><cfset statusClass = "ProjStatGreen"><cfset OverallProjectStatus = "On Track">
						<cfelse><cfset statusClass = "HStext"><cfset OverallProjectStatus = "">
						</cfif>
						<tr>
							<td align="right" class="HStext"><strong>Overall Project Status:&nbsp;</strong></td>
							<td class="HStext" colspan="2"><span class="#statusClass#">&nbsp;&nbsp;&nbsp;#OverallProjectStatus#&nbsp;&nbsp;&nbsp;</span></td>
						</tr>

						<!--- Milestone Information --->
						<cfloop query="getERPStages">
							<cfset lstMilestone = "">
							<cfmodule template="q_getMilestoneDocs.cfm" AdminSiteID="#getSiteStatus.Site_ID#" Period="#getSiteStatus.Period#" Type="#getERPStages.ERP_Stage_ID#" Return="getMilestoneDocs">
							<cfloop query="getMilestoneDocs">
								<cfif len(getMilestoneDocs.period)>
									<cfif len(getMilestoneDocs.Milestone_Doc)>
										<cfset displayMilestone = getMilestoneDocs.Milestone & " (#getMilestoneDocs.Year#)">
										<cfset lstMilestone = lstMilestone & "<a href='..#Request.MileStonePath#/#Milestone_Doc#' target='_blank'>" & displayMilestone & "</a>">
									<cfelse>
										<cfset displayMilestone = getMilestoneDocs.Milestone & " (#getMilestoneDocs.Year#)">
										<cfset lstMilestone = lstMilestone & displayMilestone>
									</cfif>
									<cfif getMilestoneDocs.currentrow NEQ getMilestoneDocs.recordcount><cfset lstMilestone = lstMilestone & ", "></cfif>
								</cfif>
							</cfloop>
							<tr valign="top">
								<td align="right" class="MStext" nowrap>
									<strong>#getERPStages.ERP_Stage# Milestones:&nbsp;</strong><br />
								</td>
								<td class="MStext" colspan="2">#lstMilestone#</td>
							</tr>
						</cfloop>
					</table>
				</td>
				<!--- space --->
				<td valign="top" class="ReportBody0" width="1%"></td>
			</tr>
			<!--- hr --->
			<tr>
				<td class="ReportBody0" colspan="4"><hr color="##000000"></td>
			</tr>
		</cfoutput>
	</TABLE>
</cfif>
<script>document.frmSiteInfo.SiteIDtofind.focus();</script>
