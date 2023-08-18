<!-------------------------------------------
Description:
	Change Log report search page

History:
	9/20/2022 - created
-------------------------------------------->

<cfset FromError = "">
<cfset ToError = "">
<cfinvoke component="Components.getSiteUsersAttributes" method="ProjectControllers" returnvariable="ControllerList"></cfinvoke>
<cfset ControllerList = listappend(ControllerList,8489)>
<cfset ControllerList = listappend(ControllerList,11249)>

<SCRIPT>
function buttonDisable() {
	if (document.frmChangeLog.btnAddChangeLog) document.frmChangeLog.btnAddChangeLog.style.visibility='hidden';
	if (document.frmChangeLog.lblExcelButton) document.frmChangeLog.lblExcelButton.style.visibility='hidden';
}
</SCRIPT>

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
		<td class="largeText"><strong>Change Log Report</strong></TD>
		<td class="largeText" ></td>
	</TR>
	<TR>
		<td class="largeText" ></td>
		<td class="largeText">
			<li>Use this page to generate <strong>Change Log</strong> reports.</li>
			<li>Search by selecting and / or filling in the any fields below, and clicking the <strong>Search</strong>. Exact terms are not necessary, substrings of a search item may be used.</li>
			<li>To display all records, leave the fields blank and click the <strong>Search</strong> button.</li>
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
	
			<!--- portfolio, Date Chevron Approved --->
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
				<strong>Date Chevron Approved From:</strong>&nbsp;
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
	<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="silver">
		<TR>
			<td class="ServiceListHeader" width="17%" align="center" rowspan="2">Site</td>
			<td class="ServiceListHeader" width="8%" align="center" rowspan="2">Site Portfolio</td>
			<td class="ServiceListHeader" width="13%" align="center" rowspan="2">Site Manager</td>
			<td class="ServiceListHeader" width="8%" align="center" rowspan="2">Date Chevron Approved</td>
			<td class="ServiceListHeader" colspan="4" align="center">Milestone Information</td>
			<td class="ServiceListHeader" width="8%" align="center" rowspan="2">Total Value</td>
			<td class="ServiceListHeader" width="1%" align="center" rowspan="2"></td>
		</tr>
		<TR>
			<td class="ServiceListHeader" width="15%" align="center">Milestones</td>
			<td class="ServiceListHeader" width="10%" align="center">Change Type</td>
			<td class="ServiceListHeader" width="10%" align="center">Current Fee</td>
			<td class="ServiceListHeader" width="10%" align="center">New Fee</td>
		</tr>

		<cfif getChangeLogs.RecordCount GT 0>
			<cfset totSites = getChangeLogs.RecordCount>
			<cfset expRowCount = getChangeLogs.RecordCount + 5>
	
			<!--- output data --->	
			<cfoutput query="getChangeLogs">
				<cfmodule template="q_getMilestoneList.cfm" VType="#getChangeLogs.FCO_Type#" CLID="#getChangeLogs.Change_Log_ID#" Return="MilestoneList">
				<tr>
					<!--- change log info --->
					<td class="ReportBody#r#" valign="top">
						<table width="100%" cellpadding="2" cellspacing="0" border="0"><tr><td class="ReportBody#r#">
							#getChangeLogs.Site_ID#<br>#getChangeLogs.Site_Name#<br>#getChangeLogs.Address#<br>#getChangeLogs.City#, #getChangeLogs.State_Abbreviation#<cfif len(getChangeLogs.Zip_Code)>, #getChangeLogs.Zip_Code#</cfif>
						</td></tr></table>
					</td>
					<td class="ReportBody#r#" valign="top" align="center">#getChangeLogs.Site_Portfolio#</td>
					<td class="ReportBody#r#" valign="top">
						<table width="100%" cellpadding="2" cellspacing="0" border="0"><tr><td class="ReportBody#r#">
							#SMName#
						</td></tr></table>
					</td>
					<td class="ReportBody#r#" valign="top" align="center">#dateformat(getChangeLogs.Date_Logged,"mm/dd/yyyy")#</td>

					<!--- V1 FCOs --->
					<cfif getChangeLogs.FCO_Type EQ "V1">
						<td class="ReportBody#r#" valign="top">
							<table width="100%" cellpadding="2" cellspacing="0" border="0"><tr><td class="ReportBody#r#">
								<SPAN TITLE="#MilestoneList#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(MilestoneList,135)#<cfif len(MilestoneList) GT 135>...</cfif></SPAN>
							</td></tr></table>
						</td>
	
						<!--- Change Type --->
						<cfmodule template="q_getChangeLogChangeType.cfm" VType="#getChangeLogs.FCO_Type#" CLID="#getChangeLogs.Change_Log_ID#" Return="ChangeTypes">
						<cfset ChangeTypes = ReplaceNoCase(ChangeTypes, "Other Please Describe", getChangeLogs.Change_Type_Other, "all" )>
						<td class="ReportBody#r#" valign="top">
							<table width="100%" cellpadding="2" cellspacing="0" border="0"><tr><td class="ReportBody#r#">
								#ChangeTypes#
							</td></tr></table>
						</td>
						<!--- Fee --->
						<td class="ReportBody#r#" valign="top"></td>
						<td class="ReportBody#r#" valign="top"></td>

					<!--- V2 FCOs --->
					<cfelse>
						<cfset expRowCount = expRowCount + MilestoneList.RecordCount + 5>
						<td class="ReportBody#r#" valign="top" colspan="4">
							<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="silver">
								<cfloop query="MilestoneList">
									<CFModule template="q_getChangeValue.cfm" CLID="#getChangeLogs.Change_Log_ID#" VType="V2" UR="#MilestoneList.Unique_Row#" Return="getValueTotal">
									<tr>
										<td class="ReportBody#r#" width="33.0%" valign="top">
											<table width="100%" cellpadding="2" cellspacing="0" border="0"><tr><td class="ReportBody#r#">
												#MilestoneList.Milestone#
											</td></tr></table>
										</td>
										<td class="ReportBody#r#" width="21.9%" valign="top">
											<table width="100%" cellpadding="2" cellspacing="0" border="0"><tr><td class="ReportBody#r#">
												#MilestoneList.Change_Type#
											</td></tr></table>
										</td>
										<td class="ReportBody#r#" width="22.1%" valign="top">
											<table width="100%" cellpadding="2" cellspacing="0" border="0"><tr><td class="ReportBody#r#" align="right">
												#dollarformat(getValueTotal.CurrentValueTotal)#</td>
											</td></tr></table>
										<td class="ReportBody#r#" width="22%" align="right" valign="top">
											<table width="100%" cellpadding="2" cellspacing="0" border="0"><tr><td class="ReportBody#r#" align="right">
												#dollarformat(getValueTotal.NewValueTotal)#
											</td></tr></table>
										</td>
									</tr>
								</cfloop>
							</table>
						</td>
					</cfif>
						
					<!--- total value --->
					<cfmodule template="q_getChangeValue.cfm" VType="#getChangeLogs.FCO_Type#" CLID="#getChangeLogs.Change_Log_ID#" Return="getValueTotal">
					<cfif getChangeLogs.FCO_Type EQ "V2">
						<cfif (isDefined("getValueTotal.NewValueTotal") and len(getValueTotal.NewValueTotal)) and (isDefined("getValueTotal.CurrentValueTotal") and len(getValueTotal.CurrentValueTotal))>
							<cfset ChangeValue = getValueTotal.NewValueTotal - getValueTotal.CurrentValueTotal>
						<cfelse>
							<cfset ChangeValue = 0>
						</cfif>
					<cfelse><cfset ChangeValue = getValueTotal.Change_Value>
					</cfif>
					<cfif getChangeLogs.Current_Status_ID EQ 11><cfset ChangeValue = 0></cfif>
					<cfif getChangeLogs.Chevron_Approval_Status EQ "B"><cfset ChangeValue = 0></cfif>
					<td class="ReportBody#r#" valign="top">
						<table width="100%" cellpadding="2" cellspacing="0" border="0"><tr><td class="ReportBody#r#" align="right">
							#dollarformat(ChangeValue)#
						</td></tr></table>
					</td>

					<!--- file link --->
					<td class="ReportBody#r#" valign="top" align="center">
						<cfif len(getChangeLogs.CompiledFCO)>
							<A HREF="javascript: var n=window.open('components/GetDoc.cfm?editChangeLogID=#getChangeLogs.Change_Log_ID#&DocType=ChangeLog#getChangeLogs.FCO_Type#', '', 'height=700,width=900,resizable')"><img src="images/icon_view.gif" border="0" alt="view FCO"></A>
						</cfif>
					</td>
				</tr>
				<cfset r = 1-r>
			</cfoutput>
		<cfinclude template="change_Log_export.cfm">
		<cfelse>
			<cfoutput>
				<tr>
					<td ALIGN="center" valign="top" colspan="10" class="ReportBody#r#"><em>no records in the database matched your search criteria</em></td>
				</tr>
				<cfset r = 1-r>
			</cfoutput>
		</cfif>
		</TD>
	</TR>
	</TABLE>
</cfif>
<script>document.frmChangeLog.SiteIDtofind.focus();</script>
