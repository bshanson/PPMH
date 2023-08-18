<!-------------------------------------------
Description:
	Change Log search page V1

History:
	4/3/2020 - created
-------------------------------------------->

<cfset FromError = "">
<cfset ToError = "">
<cfparam name="form.LogIDSort" default="1">
<cfinvoke component="Components.getSiteUsersAttributes" method="ProjectControllers" returnvariable="ControllerList"></cfinvoke>
<cfset ControllerList = listappend(ControllerList,8489)>
<cfset ControllerList = listappend(ControllerList,11249)>

<SCRIPT>
function buttonDisable() {
	if (document.frmChangeLog.btnAddChangeLog) document.frmChangeLog.btnAddChangeLog.style.visibility='hidden';
	if (document.frmChangeLog.lblExcelButton) document.frmChangeLog.lblExcelButton.style.visibility='hidden';
}
</SCRIPT>

<!--- delete a change log --->
<cfif isDefined("form.edittype") and form.edittype EQ "deleteChangeLog">
	<cfinclude template="q_delChangeLog.cfm">
</cfif>

<!--- calendar scripts --->
<CFIF NOT IsDefined("Request.PopupInitialized")>
	<LINK REL="stylesheet" type="text/css" href="scripts/CalendarPopup/popcalendar.css">
	<SCRIPT LANGUAGE="javaScript" SRC="scripts/CalendarPopup/popcalendar.js"></SCRIPT>	
	<CFSET Request.PopupInitialized = "Yes">
</CFIF>

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

<!--- query for sites --->
<cfif isDefined("form.SiteIDtofind") or isDefined("url.CLID")>
	<cfinclude template="q_getChangeLogs.cfm">
</cfif>

<!--- help text --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText"></td>
		<td class="largeText" width="1%"></td>
	</TR>
	<TR>
		<td class="largeText" ></td>
		<td class="largeText"><strong>Change Log Version 1 - Project Controllers Only</strong></TD>
		<td class="largeText" ></td>
	</TR>
	<TR>
		<td class="largeText" ></td>
		<td class="largeText">
			<li>Use this page to manage <strong>Change Log</strong> information.</li>
			<li>Search by selecting and / or filling in the any fields below, and clicking the <strong>Search</strong>. Exact terms are not necessary, substrings of a search item may be used.</li>
			<li>To display all records, leave the fields blank and click the <strong>Search</strong> button.</li>
			<li>Once displayed, you will be able to enter, edit or delete the resulting information.</li>
			<li>If a FCO document has been uploaded, a view icon will be displayed in the column to the left of the delete column.</li>
		</td>
		<td class="largeText" ></td>
	</TR>
</TABLE>

<!--- search form --->
<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="##ffffff">
		<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
		<form name="frmChangeLog" action="" method="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
		<!--- Site Portfolio, Region --->
			<TR>
				<td class="largeText" ></td>
				<td class="largeText" align="right"><strong>Site Portfolio:</strong>&nbsp;</td>
				<td class="largeText" colspan="2" valign="top">
					<select name="SitePortfolioToFind" class="largeText">
						<option value="0" <cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind EQ "0">selected="selected"</cfif>>- select a portfolio -</option>
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
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Site ID:</strong>&nbsp;</td>
				<td class="largeText">
					<input type="Text" name="SiteIDtofind" size="10" class="largeText" <cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)>value="#form.SiteIDtofind#"</cfif>>
					&nbsp;
					<strong>Name:</strong>&nbsp;
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
				<td class="largeText" align="right"></td>
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
					&nbsp;
					<strong>Chevron Ops:</strong>&nbsp;
					<select name="ChevronOpsToFind" class="largeText">
						<option value="0">- select a chevron ops lead -</option>
						<cfloop query="getChevronPortfolioManagers">
							<option value="#getChevronPortfolioManagers.User_ID#" <cfif isDefined("form.ChevronOpsToFind") and form.ChevronOpsToFind EQ getChevronPortfolioManagers.User_ID>selected="selected"</cfif>>#getChevronPortfolioManagers.Last_Name#, #getChevronPortfolioManagers.First_Name#</option>
						</cfloop>
					</select>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- status --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Chev Approv Stat:</strong>&nbsp;</td>
				<td class="largeText">
					<select name="ChevApvlStatusToFind" class="largeText">
					<cfif Session.Security.CompanyID EQ 1>
						<option value="" <cfif isDefined("form.ChevApvlStatusToFind") and form.ChevApvlStatusToFind EQ "">selected</cfif>>- select -</option>
						<option value="S" class="StatSilver" <cfif isDefined("form.ChevApvlStatusToFind") and form.ChevApvlStatusToFind EQ "S">selected</cfif>>In Progress</option>
						<option value="Y" class="StatYellow" <cfif isDefined("form.ChevApvlStatusToFind") and form.ChevApvlStatusToFind EQ "Y">selected</cfif>>Pending Approval</option>
						<option value="G" class="StatGreen" <cfif isDefined("form.ChevApvlStatusToFind") and form.ChevApvlStatusToFind EQ "G">selected</cfif>>Approved by Chevron</option>
						<option value="B" class="StatBlack" <cfif isDefined("form.ChevApvlStatusToFind") and form.ChevApvlStatusToFind EQ "B">selected</cfif>>Rejected by Chevron</option>
					<cfelse>
						<option value="G" class="StatGreen" <cfif isDefined("form.ChevApvlStatusToFind") and form.ChevApvlStatusToFind EQ "G">selected</cfif>>Approved by Chevron</option>
					</cfif>
					</select>
					&nbsp;
					<strong>Oracle Process Status:</strong>&nbsp;
					<select name="IntStatusToFind" class="largeText">
						<option value="" <cfif isDefined("form.IntStatusToFind") and form.IntStatusToFind EQ "">selected</cfif>>- select -</option>
						<option value="G" class="StatGreen" <cfif isDefined("form.IntStatusToFind") and form.IntStatusToFind EQ "G">selected</cfif>>Complete</option>
						<option value="O" class="StatOrange" <cfif isDefined("form.IntStatusToFind") and form.IntStatusToFind EQ "O">selected</cfif>>Pending Project Close</option>
						<option value="Y" class="StatYellow" <cfif isDefined("form.IntStatusToFind") and form.IntStatusToFind EQ "Y">selected</cfif>>Needs Follow Up</option>
						<option value="R" class="StatRed" <cfif isDefined("form.IntStatusToFind") and form.IntStatusToFind EQ "R">selected</cfif>>Problem</option>
					</select>
					&nbsp;
					<strong>Milestone Update Status:</strong>&nbsp;
					<select name="MilestoneStatusToFind" class="largeText">
						<option value="" <cfif isDefined("form.MilestoneStatusToFind") and form.MilestoneStatusToFind EQ "">selected</cfif>>- select -</option>
						<option value="W" class="StatWhite" <cfif isDefined("form.MilestoneStatusToFind") and form.MilestoneStatusToFind EQ "W">selected</cfif>>Not Applicable</option>
						<option value="Y" class="StatYellow" <cfif isDefined("form.MilestoneStatusToFind") and form.MilestoneStatusToFind EQ "Y">selected</cfif>>Not Complete</option>
						<option value="R" class="StatRed" <cfif isDefined("form.MilestoneStatusToFind") and form.MilestoneStatusToFind EQ "R">selected</cfif>>Needs Follow Up</option>
						<option value="G" class="StatGreen" <cfif isDefined("form.MilestoneStatusToFind") and form.MilestoneStatusToFind EQ "G">selected</cfif>>Complete</option>
					</select>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- portfolio, date logged--->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Change Log Portfolio:</strong>&nbsp;</td>
				<td class="largeText">
				<select name="LogPortfolioToFind" class="largeText">
					<option value="0" <cfif isDefined("form.LogPortfolioToFind") and form.LogPortfolioToFind EQ "0">selected="selected"</cfif>>- select a portfolio -</option>
					<cfloop query="getPortfolios" >
						<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.LogPortfolioToFind") and form.LogPortfolioToFind EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
					</cfloop>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<strong>Date Logged From:</strong>&nbsp;
					<input type="text" name="FromDateToFind" class="largeText" size="15" maxlength="10" <cfif isDefined("form.FromDateToFind") and len(form.FromDateToFind)>value="#form.FromDateToFind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp1']:document.TaskPopUp1_Position), document.forms.frmChangeLog.FromDateToFind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp1_Position" ID="TaskPopUp1_Position" BORDER="0" ALT="Date"></A>
					<cfif len(FromError)><span class="errortext"><i>#FromError#</i></span></cfif>
					&nbsp;
					<strong>To:</strong>&nbsp;
					<input type="text" name="ToDateToFind" class="largeText" size="15" maxlength="10" <cfif isDefined("form.ToDateToFind") and len(form.ToDateToFind)>value="#form.ToDateToFind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp2']:document.TaskPopUp2_Position), document.forms.frmChangeLog.ToDateToFind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp2_Position" ID="TaskPopUp2_Position" BORDER="0" ALT="Date"></A>
					<cfif len(ToError)><span class="errortext"><i>#ToError#</i></span></cfif>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- buttons --->
			<TR>
				<td class="largeText"></td>
				<td class="largeText"></td>
				<td class="largeText">
					<input type="Submit" name="Search" class="largeTextButton" value="Search" onClick="buttonDisable();">
					<cfif isDefined("getChangeLogs")>
						<input type="hidden" name="edittype" value="addChangeLog" />
						<cfif Session.Security.CompanyID EQ 1 and (listfind(ControllerList, Session.Security.UserID))>
							<input type="Submit" name="btnAddChangeLog" class="largeTextButton" onclick="submit()" value="Add New Change Log Record">
						</cfif>
						<cfif getChangeLogs.RecordCount GT 0>
							<CFSET FileName="Change_Log_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
							<input type="button" name="lblExcelButton" class="largeTextButton" value="Open Excel File" ONCLICK="window.open('#Request.ExcelPath#/#FileName#')">
						</cfif>
					</cfif>
				</td>
			</TR>
			<TR>
				<td class="largeText" width="1%">&nbsp;</td>
				<td class="largeText" width="12.5%">&nbsp;</td>
				<td class="largeText">&nbsp;</td>
			</TR>
		</FORM>
	</TABLE>
</cfoutput>

<!--- display Change information --->
<cfif isDefined("getChangeLogs")>
	<cfset r=0>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="silver">
		<TR>
			<td class="ServiceListHeader" width="1%" align="center"></td>
			<!--- sort --->
			<cfoutput>
				<FORM NAME="SortLogID" id="SortLogID" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
					<cfif isDefined("form.Site")><input type="Hidden" name="Site" value="#form.Site#"></cfif>
					<cfif isDefined("form.editChangeLogID")><input type="Hidden" name="editChangeLogID" value="#form.editChangeLogID#"></cfif>
					<cfif isDefined("form.addresstofind")><input type="Hidden" name="addresstofind" value="#form.addresstofind#"></cfif>
					<cfif isDefined("form.citytofind")><input type="Hidden" name="citytofind" value="#form.citytofind#"></cfif>
					<cfif isDefined("form.statetofind")><input type="Hidden" name="statetofind" value="#form.statetofind#"></cfif>
					<cfif isDefined("form.edittype")><input type="hidden" name="edittype" value="#form.edittype#" /></cfif>
					<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
					<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
					<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
					<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
					<cfif isDefined("form.ChevronOpsToFind")><input type="Hidden" name="ChevronOpsToFind" value="#form.ChevronOpsToFind#"></cfif>
					<cfif isDefined("form.ChevApvlStatusToFind")><input type="Hidden" name="ChevApvlStatusToFind" value="#form.ChevApvlStatusToFind#"></cfif>
					<cfif isDefined("form.IntStatusToFind")><input type="Hidden" name="IntStatusToFind" value="#form.IntStatusToFind#"></cfif>
					<cfif isDefined("form.MilestoneStatusToFind")><input type="Hidden" name="MilestoneStatusToFind" value="#form.MilestoneStatusToFind#"></cfif>
					<cfif isDefined("form.FromDateToFind")><input type="Hidden" name="FromDateToFind" value="#form.FromDateToFind#"></cfif>
					<cfif isDefined("form.ToDateToFind")><input type="Hidden" name="ToDateToFind" value="#form.ToDateToFind#"></cfif>
					<cfif isDefined("form.SiteID")><input type="Hidden" name="SiteID" value="#form.SiteID#"></cfif>
					<cfif isDefined("form.SiteName")><input type="Hidden" name="SiteName" value="#form.SiteName#"></cfif>
					<cfif isDefined("form.Address")><input type="Hidden" name="Address" value="#form.Address#"></cfif>
					<cfif isDefined("form.City")><input type="Hidden" name="City" value="#form.City#"></cfif>
					<cfif isDefined("form.State_Abbreviation")><input type="Hidden" name="State_Abbreviation" value="#form.State_Abbreviation#"></cfif>
					<cfif isDefined("form.LogPortfolioToFind")><input type="Hidden" name="LogPortfolioToFind" value="#form.LogPortfolioToFind#"></cfif>
					<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
					<cfif isDefined("form.LogIDSort") and form.LogIDSort EQ 1><input type="Hidden" name="LogIDSort" value="2"><cfelse><input type="Hidden" name="LogIDSort" value="1"></cfif>
					<input type="Hidden" name="LogIDClick" value="1">
					<td class="ServiceListHeader" width="8%" align="center">
					<cfif form.LogIDSort EQ 1>
							<SPAN TITLE="click to sort by descending log id" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">
						<cfelse>
							<SPAN TITLE="click to sort by ascending log id" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">
						</cfif>
							<a href="javascript:{}" onclick="document.getElementById('SortLogID').submit(); return false;">Log ID</a>
						</span>
					</td>
				</FORM>
			</cfoutput>

			<td class="ServiceListHeader" width="14%" align="center">Facility</td>
			<td class="ServiceListHeader" width="7%" align="center">Site Manager</td>
			<td class="ServiceListHeader" width="7%" align="center">Date Logged</td>
			<td class="ServiceListHeader" width="9%" align="center">Change Type</td>
			<td class="ServiceListHeader" width="13%" align="center">Additional Relevant Information</td>
			<td class="ServiceListHeader" width="13%" align="center">New Milestones With Fees</td>
			<td class="ServiceListHeader" width="8%" align="center">Value</td>
			<td class="ServiceListHeader" width="6%" align="center">Chevron Approval Status</td>
			<td class="ServiceListHeader" width="6%" align="center">Oracle Process Status</td>
			<td class="ServiceListHeader" width="6%" align="center">Milestone Update Status</td>
			<td class="ServiceListHeader" width="1%" align="center"></td>
			<td class="ServiceListHeader" width="1%" align="center"></td>
		</tr>

		<cfif getChangeLogs.RecordCount GT 0>
			<cfset totSites = getChangeLogs.RecordCount>
			<cfset expRowCount = getChangeLogs.RecordCount + 5>
	
			<!--- output data --->	
			<cfset rowno = 1>
			<cfoutput query="getChangeLogs">
				<tr>
					<!--- edit --->
					<cfif Session.Security.CompanyID EQ 1>
					<FORM NAME="editSite" ACTION="" METHOD="post">
						<!--- scrub url input for XSS --->
						<cfinclude template="/Common/XSS_Scubber.cfm" >
						<td class="ReportBody#r#" valign="top">
							<input type="Image" name="imgEditChangeLog" src="images/icon_pencil.gif" border="0" onclick="submit()" alt="edit change log information">
							<input type="hidden" name="btnEditChangeLog" value="btnEditChangeLog" />
							<input type="hidden" name="edittype" value="EditChangeLog" />
							<input type="hidden" name="editChangeLogID" value="#getChangeLogs.Change_Log_ID#" />
							<cfif isDefined("form.SiteIDtofind")><input type="hidden" name="SiteIDtofind" value="#form.SiteIDtofind#" /></cfif>
							<cfif isDefined("form.SiteNameToFind")><input type="hidden" name="SiteNameToFind" value="#form.SiteNameToFind#" /></cfif>
							<cfif isDefined("form.addresstofind")><input type="Hidden" name="addresstofind" value="#form.addresstofind#"></cfif>
							<cfif isDefined("form.citytofind")><input type="Hidden" name="citytofind" value="#form.citytofind#"></cfif>
							<cfif isDefined("form.statetofind")><input type="Hidden" name="statetofind" value="#form.statetofind#"></cfif>
							<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
							<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
							<cfif isDefined("form.ChevronOpsToFind")><input type="Hidden" name="ChevronOpsToFind" value="#form.ChevronOpsToFind#"></cfif>
							<cfif isDefined("form.FromDateToFind")><input type="Hidden" name="FromDateToFind" value="#form.FromDateToFind#"></cfif>
							<cfif isDefined("form.ToDateToFind")><input type="Hidden" name="ToDateToFind" value="#form.ToDateToFind#"></cfif>
							<cfif isDefined("form.ChevApvlStatusToFind")><input type="Hidden" name="ChevApvlStatusToFind" value="#form.ChevApvlStatusToFind#"></cfif>
							<cfif isDefined("form.IntStatusToFind")><input type="Hidden" name="IntStatusToFind" value="#form.IntStatusToFind#"></cfif>
							<cfif isDefined("form.MilestoneStatusToFind")><input type="Hidden" name="MilestoneStatusToFind" value="#form.MilestoneStatusToFind#"></cfif>
							<cfif isDefined("form.LogPortfolioToFind")><input type="Hidden" name="LogPortfolioToFind" value="#form.LogPortfolioToFind#"></cfif>
							<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
							<cfif isDefined("form.LogIDSort")><input type="Hidden" name="LogIDSort" value="#form.LogIDSort#"></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
						</td>
					</FORM>
					<cfelse>
						<td class="ReportBody#r#" valign="top">&nbsp;</td>
					</cfif>

					<!--- change log info --->
					<td class="ReportBody#r#" valign="top" align="center">#getChangeLogs.Actual_Change_Log_ID#</td>
					<td class="ReportBody#r#" valign="top">#getChangeLogs.Site_ID#<br>#getChangeLogs.Site_Name#<br>#getChangeLogs.Address#<br>#getChangeLogs.City#, #getChangeLogs.State_Abbreviation#<cfif len(getChangeLogs.Zip_Code)>, #getChangeLogs.Zip_Code#</cfif></td>
					<td class="ReportBody#r#" valign="top">#SMName#</td>
					<td class="ReportBody#r#" valign="top" align="center">#dateformat(getChangeLogs.Date_Logged,"mm/dd/yyyy")#</td>

					<!--- Change Type --->
					<cfinclude template="q_getChangeLogChangeType.cfm">
					<cfset vChangeTypes = ReplaceNoCase(vChangeTypes, "Other Please Describe", getChangeLogs.Change_Type_Other, "all" )>
					<td class="ReportBody#r#" valign="top">#vChangeTypes#</td>

					<!--- Additional Information --->
					<td class="ReportBody#r#" valign="top">
						<SPAN TITLE="#getChangeLogs.Additional_Information#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getChangeLogs.Additional_Information,135)#<cfif len(getChangeLogs.Additional_Information) GT 135>...</cfif></SPAN>
					</td>

					<!--- milestones with fees --->
					<td class="ReportBody#r#" valign="top">
						<SPAN TITLE="#getChangeLogs.Milestone_List#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getChangeLogs.Milestone_List,135)#<cfif len(getChangeLogs.Milestone_List) GT 135>...</cfif></SPAN>
					</td>

					<!--- value --->
					<td class="ReportBody#r#" valign="top" align="right">#dollarformat(getChangeLogs.Change_Value)#&nbsp;</td>

					<!--- Chevron Approval Status --->
					<cfif getChangeLogs.Chevron_Approval_Status EQ "S"><cfset CASClass = "StatSilver"><cfset ChevronApprovalStatus = "In Progress">
					<cfelseif getChangeLogs.Chevron_Approval_Status EQ "Y"><cfset CASClass = "StatYellow"><cfset ChevronApprovalStatus = "Pending Approval">
					<cfelseif getChangeLogs.Chevron_Approval_Status EQ "G"><cfset CASClass = "StatGreen"><cfset ChevronApprovalStatus = "Approved by Chevron">
					<cfelseif getChangeLogs.Chevron_Approval_Status EQ "B"><cfset CASClass = "StatBlack"><cfset ChevronApprovalStatus = "Rejected by Chevron">
					<cfelse><cfset CASClass = "ReportBody#r#"><cfset ChevronApprovalStatus = "">
					</cfif>
					<td class="#CASClass#" valign="top" align="center">#ChevronApprovalStatus#</td>

					<!--- Oracle Process Status --->
					<cfif getChangeLogs.Internal_Status EQ "R"><cfset ISClass = "StatRed"><cfset InternalStatus = "Problem">
					<cfelseif getChangeLogs.Internal_Status EQ "Y"><cfset ISClass = "StatYellow"><cfset InternalStatus = "Needs Follow Up">
					<cfelseif getChangeLogs.Internal_Status EQ "G"><cfset ISClass = "StatGreen"><cfset InternalStatus = "Complete">
					<cfelseif getChangeLogs.Internal_Status EQ "O"><cfset ISClass = "StatOrange"><cfset InternalStatus = "Pending Project Close">
					<cfelse><cfset ISClass = "ReportBody#r#"><cfset InternalStatus = "">
					</cfif>
					<td class="#ISClass#" valign="top" align="center">#InternalStatus#</td>

					<!--- Milestone Update Status --->
					<cfif getChangeLogs.Milestone_Update_Status EQ "R"><cfset MUSClass = "StatRed"><cfset MilestoneUpdateStatus = "Needs Follow Up">
					<cfelseif getChangeLogs.Milestone_Update_Status EQ "Y"><cfset MUSClass = "StatYellow"><cfset MilestoneUpdateStatus = "Not Complete">
					<cfelseif getChangeLogs.Milestone_Update_Status EQ "G"><cfset MUSClass = "StatGreen"><cfset MilestoneUpdateStatus = "Complete">
					<cfelseif getChangeLogs.Milestone_Update_Status EQ "W"><cfset MUSClass = "StatWhite"><cfset MilestoneUpdateStatus = "Not Applicable">
					<cfelse><cfset MUSClass = "ReportBody#r#"><cfset MilestoneUpdateStatus = "">
					</cfif>
					<td class="#MUSClass#" valign="top" align="center">#MilestoneUpdateStatus#</td>

					<!--- file link --->
					<td class="ReportBody#r#" valign="top" align="center">
						<cfif len(getChangeLogs.FCO_File_Name)>
							<A HREF="javascript: var n=window.open('components/GetDoc.cfm?editChangeLogID=#getChangeLogs.Change_Log_ID#&DocType=ChangeLogV1', '', 'height=700,width=900,resizable')"><img src="images/icon_view.gif" border="0" alt="view FCO"></A>
						</cfif>
					</td>

					<!--- delete --->
					<cfif Session.Security.CompanyID EQ 1>
					<FORM NAME="deleteSite" ACTION="" METHOD="post">
						<!--- scrub url input for XSS --->
						<cfinclude template="/Common/XSS_Scubber.cfm" >
						<td class="ReportBody#r#" valign="top">
							<input type="Image" name="imgDeleteChangeLog" src="images/icon_trash.gif" border="0" onclick="if (confirm('Are you sure you want to delete this record?')){submit()}; return false" alt="delete change log information">
							<input type="hidden" name="btnDeleteChangeLog" value="btnDeleteChangeLog" />
							<input type="hidden" name="edittype" value="deleteChangeLog" />
							<input type="hidden" name="delChangeLogID" value="#getChangeLogs.Change_Log_ID#" />
							<cfif isDefined("form.SiteIDtofind")><input type="hidden" name="SiteIDtofind" value="#form.SiteIDtofind#" /></cfif>
							<cfif isDefined("form.SiteNameToFind")><input type="hidden" name="SiteNameToFind" value="#form.SiteNameToFind#" /></cfif>
							<cfif isDefined("form.addresstofind")><input type="Hidden" name="addresstofind" value="#form.addresstofind#"></cfif>
							<cfif isDefined("form.citytofind")><input type="Hidden" name="citytofind" value="#form.citytofind#"></cfif>
							<cfif isDefined("form.statetofind")><input type="Hidden" name="statetofind" value="#form.statetofind#"></cfif>
							<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
							<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
							<cfif isDefined("form.ChevronOpsToFind")><input type="Hidden" name="ChevronOpsToFind" value="#form.ChevronOpsToFind#"></cfif>
							<cfif isDefined("form.FromDateToFind")><input type="Hidden" name="FromDateToFind" value="#form.FromDateToFind#"></cfif>
							<cfif isDefined("form.ToDateToFind")><input type="Hidden" name="ToDateToFind" value="#form.ToDateToFind#"></cfif>
							<cfif isDefined("form.ChevApvlStatusToFind")><input type="Hidden" name="ChevApvlStatusToFind" value="#form.ChevApvlStatusToFind#"></cfif>
							<cfif isDefined("form.IntStatusToFind")><input type="Hidden" name="IntStatusToFind" value="#form.IntStatusToFind#"></cfif>
							<cfif isDefined("form.MilestoneStatusToFind")><input type="Hidden" name="MilestoneStatusToFind" value="#form.MilestoneStatusToFind#"></cfif>
							<cfif isDefined("form.LogPortfolioToFind")><input type="Hidden" name="LogPortfolioToFind" value="#form.LogPortfolioToFind#"></cfif>
							<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
							<cfif isDefined("form.LogIDSort")><input type="Hidden" name="LogIDSort" value="#form.LogIDSort#"></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
						</td>
					</FORM>
					<cfelse>
						<td class="ReportBody#r#" valign="top">&nbsp;</td>
					</cfif>
				</tr>
				<cfset r = 1-r>
			</cfoutput>
			<cfinclude template="change_Log_export.cfm">
		<cfelse>
			<cfoutput>
				<tr>
					<td ALIGN="center" valign="top" colspan="14" class="ReportBody#r#"><em>no records in the database matched your search criteria</em></td>
				</tr>
				<cfset r = 1-r>
			</cfoutput>
		</cfif>
		</TD>
	</TR>
	</TABLE>
</cfif>
<script>document.frmChangeLog.SiteIDtofind.focus();</script>
