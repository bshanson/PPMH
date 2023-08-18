<!-------------------------------------------
Description:
	Change Log search page

History:
	4/3/2020 - created
-------------------------------------------->

<cfset FromError = "">
<cfset ToError = "">
<cfset ApprovalFromError = "">
<cfset ApprovalToError = "">
<cfset DaysError = "">
<cfparam name="form.DaysToFind" default="0">
<cfparam name="form.SortBy" default="2">
<cfif not isDefined("form.Search") and not isDefined("form.btnReturn") and not isDefined("url.CLID")><cfparam name="form.AssignedToMe" default="on"></cfif>

<SCRIPT>
function buttonDisable() {
	if (document.frmChangeLog.btnAddNewChangeLog) document.frmChangeLog.btnAddNewChangeLog.style.visibility='hidden';
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
<!--- get portfolio Managers --->
<cfinclude template="/turboscope/components/q_getPortfolioManagers.cfm">
<!--- get Deputies --->
<cfinclude template="../components/q_getDeputies.cfm">
<!--- get states --->
<cfinclude template="../components/q_getStates.cfm">
<!--- get portfolios --->
<cfinvoke component="Components.getPortfolios" method="FCOPortfolios" returnvariable="getPortfolios"></cfinvoke>
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- get Ops Lead --->
<cfinclude template="q_getChevronPortfolioManagers.cfm">
<!--- get Status --->
<cfinclude template="q_getStatus.cfm">
<!--- get Team --->
<cfinclude template="q_getTeam.cfm">
<!--- get all members --->
<cfinclude template="q_getTeamMembersAll.cfm">

<!--- query for sites --->
<cfif isDefined("form.Search") or isDefined("url.CLID") or isDefined("form.AssignedToMe") or isDefined("form.btnReturn")>
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
		<td class="largeText"><strong>Change Log - FCOs In Process</strong></TD>
		<td class="largeText" ></td>
	</TR>
	<TR>
		<td class="largeText" ></td>
		<td class="largeText">
			<li>Use this page to manage <strong>Change Log</strong> information.</li>
			<li>Search by selecting and / or filling in any fields below, and clicking the <strong>Search</strong> button. Exact terms are not necessary, substrings of a search item may be used.</li>
			<li>Check the <strong>Associated With Me</strong> box to display FCOs where you are the Site Manager or Deputy for the site on the FCO, or PM for the project on the FCO.</li>
			<li>To display all records, leave the fields blank and click the <strong>Search</strong> button.</li>
			<li>Once displayed, you will be able to enter or edit the resulting information.</li>
			<li>Once the FCO document has been uploaded, a view icon, <img src="images/icon_view.gif" border="0" alt="view FCO">, will be displayed in the rightmost column.</li>
			<li>When approved by Chevron, save a copy of the approval email in the FCO's SharePoint folder.</li>
			<cfoutput><li><a href="#Request.SharePointPath#" target="_blank">The root FCO SharePoint folder may be accessed here</a>.</li></cfoutput>
			<li><a href="help/FCO_Approval_Process_Flowchart.pdf" target="_blank">The FCO Approval Process Flowchart may be accessed here</a>.</li>
			<li><a href="https://arcadiso365.sharepoint.com/:p:/r/teams/Chevron/_layouts/15/Doc.aspx?sourcedoc=%7B192C5608-0EC1-424B-ADD4-26F79369A50F%7D&file=FCO%20Guide.pptx" target="_blank">The FCO Guide may be accessed here</a>.</li>
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
	
			<!--- error --->
			<TR>
				<td class="largeText" colspan="3" align="center">
					<cfif len(FromError)><span class="errortext"><i>*** #FromError# ***</i></span><br></cfif>
					<cfif len(ToError)><span class="errortext"><i>*** #ToError# ***</i></span><br></cfif>
					<cfif len(ApprovalFromError)><span class="errortext"><i>*** #ApprovalFromError# ***</i></span><br></cfif>
					<cfif len(ApprovalToError)><span class="errortext"><i>*** #ApprovalToError# ***</i></span></cfif>
					<cfif len(DaysError)><span class="errortext"><i>*** #DaysError# ***</i></span></cfif>
				</td>
			</tr>
			<!--- Site Portfolio, Region, fco portfolio --->
			<TR>
				<td class="largeText" ></td>
				<td class="largeText" align="right"><strong>Site Portfolio:</strong>&nbsp;</td>
				<td class="largeText" valign="top">
					<select name="SitePortfolioToFind" class="largeText">
						<option value="0" <cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind EQ "0">selected="selected"</cfif>>- select a portfolio -</option>
						<cfloop query="getPortfolios" >
							<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
						</cfloop>
					</select>
					&nbsp;
					<strong>Region:</strong>&nbsp;
					<cfloop query="getRegions">
						<input type="checkbox" class="largeText" name="RegionToFind#getRegions.COP_Region_ID#" <cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>checked="checked"</cfif>>#getRegions.Region#&nbsp;
					</cfloop>
					&nbsp;
					<strong>Change Log Portfolio:</strong>&nbsp;
					<select name="LogPortfolioToFind" class="largeText">
						<option value="0" <cfif isDefined("form.LogPortfolioToFind") and form.LogPortfolioToFind EQ "0">selected="selected"</cfif>>- select a portfolio -</option>
						<cfloop query="getPortfolios" >
							<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.LogPortfolioToFind") and form.LogPortfolioToFind EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
						</cfloop>
					</select>
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

			<!--- Site Manager, deputy, portfolio mgr --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Site Manager:</strong>&nbsp;</td>
				<td class="largeText">
					<select name="smtofind" class="largeText">
						<option value="0">- select the site manager -</option>
						<cfloop query="getSiteManagers">
							<option value="#getSiteManagers.User_ID#" <cfif isDefined("form.smtofind") and form.smtofind EQ getSiteManagers.User_ID>selected="selected"</cfif>>#getSiteManagers.Last_Name#, #getSiteManagers.First_Name#</option>
						</cfloop>
					</select>
					&nbsp;
					<strong>Deputy:</strong>&nbsp;
					<select name="DeputyToFind" class="largeText">
						<option value="0">- select the deputy -</option>
						<cfloop query="getDeputies">
							<option value="#getDeputies.User_ID#" <cfif isDefined("form.DeputyToFind") and form.DeputyToFind EQ getDeputies.User_ID>selected="selected"</cfif>>#getDeputies.Last_Name#, #getDeputies.First_Name#</option>
						</cfloop>
					</select>
					&nbsp;
					<strong>Port Mgr:</strong>&nbsp;
					<select name="PortMgrToFind" class="largeText">
						<option value="0">- select the portfolio manager -</option>
						<cfloop query="getPortfolioManagers">
							<option value="#getPortfolioManagers.User_ID#" <cfif isDefined("form.PortMgrToFind") and form.PortMgrToFind EQ getPortfolioManagers.User_ID>selected="selected"</cfif>>#getPortfolioManagers.Last_Name#, #getPortfolioManagers.First_Name#</option>
						</cfloop>
					</select>
					&nbsp;
					<strong>Chev Ops Lead:</strong>&nbsp;
					<select name="ChevronOpsToFind" class="largeText">
						<option value="0">- select the chevron ops lead -</option>
						<cfloop query="getChevronPortfolioManagers">
							<option value="#getChevronPortfolioManagers.User_ID#" <cfif isDefined("form.ChevronOpsToFind") and form.ChevronOpsToFind EQ getChevronPortfolioManagers.User_ID>selected="selected"</cfif>>#getChevronPortfolioManagers.Last_Name#, #getChevronPortfolioManagers.First_Name#</option>
						</cfloop>
					</select>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- created date, approval date, days since last action --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Created Date From:</strong>&nbsp;</td>
				<td class="largeText">
					<input type="text" name="FromDateToFind" class="largeText" size="10" maxlength="10" <cfif isDefined("form.FromDateToFind") and len(form.FromDateToFind)>value="#form.FromDateToFind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp1']:document.TaskPopUp1_Position), document.forms.frmChangeLog.FromDateToFind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp1_Position" ID="TaskPopUp1_Position" BORDER="0" ALT="Date"></A>
					&nbsp;
					<strong>To:</strong>&nbsp;
					<input type="text" name="ToDateToFind" class="largeText" size="10" maxlength="10" <cfif isDefined("form.ToDateToFind") and len(form.ToDateToFind)>value="#form.ToDateToFind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp2']:document.TaskPopUp2_Position), document.forms.frmChangeLog.ToDateToFind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp2_Position" ID="TaskPopUp2_Position" BORDER="0" ALT="Date"></A>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<strong>Approval Date From:</strong>&nbsp;
					<input type="text" name="ApprovalFromDateToFind" class="largeText" size="10" maxlength="10" <cfif isDefined("form.ApprovalFromDateToFind") and len(form.ApprovalFromDateToFind)>value="#form.ApprovalFromDateToFind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp3']:document.TaskPopUp3_Position), document.forms.frmChangeLog.ApprovalFromDateToFind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp3_Position" ID="TaskPopUp3_Position" BORDER="0" ALT="Date"></A>
					&nbsp;
					<strong>To:</strong>&nbsp;
					<input type="text" name="ApprovalToDateToFind" class="largeText" size="10" maxlength="10" <cfif isDefined("form.ApprovalToDateToFind") and len(form.ApprovalToDateToFind)>value="#form.ApprovalToDateToFind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp4']:document.TaskPopUp4_Position), document.forms.frmChangeLog.ApprovalToDateToFind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp4_Position" ID="TaskPopUp4_Position" BORDER="0" ALT="Date"></A>
					&nbsp;
					<strong>Days Since Last Action:</strong>&nbsp;
					<input type="text" name="DaysToFind" class="largeText" size="5"  <cfif isDefined("form.DaysToFind") and len(form.DaysToFind)>value="#form.DaysToFind#"</cfif>>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- fco review status, assigned to, assigned to team member --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Status:</strong>&nbsp;</td>
				<td class="largeText">
					<select name="StatusToFind" class="largeText">
						<option value="0">- select the status -</option>
						<cfloop query="getStatus">
							<option value="#getStatus.Status_ID#" <cfif isDefined("form.StatusToFind") and form.StatusToFind EQ getStatus.Status_ID>selected="selected"</cfif>>#getStatus.Status#</option>
						</cfloop>
					</select>
					&nbsp;
					<strong>Assigned To:</strong>&nbsp;
					<select name="AssignedToToFind" class="largeText">
						<option value="0">- select the assignee -</option>
						<cfloop query="getTeam">
							<option value="#getTeam.Team_ID#" <cfif isDefined("form.AssignedToToFind") and form.AssignedToToFind EQ getTeam.Team_ID>selected="selected"</cfif>>#getTeam.Team#</option>
						</cfloop>
					</select>
					&nbsp;
					<strong>Assigned To Team Member:</strong>&nbsp;
					<select name="TMtofind" class="largeText">
						<option value="0">- select the team member -</option>
						<cfloop query="getTeamMembersDistinct">
							<option value="#getTeamMembersDistinct.User_ID#" <cfif isDefined("form.TMtofind") and form.TMtofind EQ getTeamMembersDistinct.User_ID>selected="selected"</cfif>>#getTeamMembersDistinct.Last_Name#, #getTeamMembersDistinct.First_Name#</option>
						</cfloop>
					</select>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- assigned to me, Associated with me --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Assigned To Me:</strong>&nbsp;</td>
				<td class="largeText">
					<input type="checkbox" name="AssignedToMe" class="largeText" <cfif isDefined("form.AssignedToMe")>checked="checked"</cfif>>
					&nbsp;
					<strong>Associated With Me:</strong>&nbsp;
					<input type="checkbox" name="AssociatedWithMe" class="largeText" <cfif isDefined("form.AssociatedWithMe")>checked="checked"</cfif>>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- sort by --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Sort By:</strong>&nbsp;</td>
				<td class="largeText">
					<input type="Radio" name="SortBy" value="1" class="largeText" <cfif isDefined("form.SortBy") and form.SortBy EQ 1>checked</cfif>>Log ID
					&nbsp;
					<input type="Radio" name="SortBy" value="2" class="largeText" <cfif isDefined("form.SortBy") and form.SortBy EQ 2>checked</cfif>>Site ID
					&nbsp;
					<input type="Radio" name="SortBy" value="3" class="largeText" <cfif isDefined("form.SortBy") and form.SortBy EQ 3>checked</cfif>>Date Logged
					&nbsp;
					<input type="Radio" name="SortBy" value="4" class="largeText" <cfif isDefined("form.SortBy") and form.SortBy EQ 4>checked</cfif>>Due Date
					&nbsp;
					<input type="Radio" name="SortBy" value="5" class="largeText" <cfif isDefined("form.SortBy") and form.SortBy EQ 5>checked</cfif>>Days Since Last Action
					&nbsp;
					<input type="Radio" name="SortBy" value="6" class="largeText" <cfif isDefined("form.SortBy") and form.SortBy EQ 6>checked</cfif>>Status
					&nbsp;
					<input type="Radio" name="SortBy" value="8" class="largeText" <cfif isDefined("form.SortBy") and form.SortBy EQ 8>checked</cfif>>Assigned To
					&nbsp;
					<input type="Radio" name="SortBy" value="9" class="largeText" <cfif isDefined("form.SortBy") and form.SortBy EQ 9>checked</cfif>>Assigned To Team Member
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>

			<!--- buttons --->
			<TR>
				<td class="largeText"></td>
				<td class="largeText"></td>
				<td class="largeText">
					<input type="Submit" name="Search" class="largeTextButton" value="Search" onClick="buttonDisable();">
						<input type="hidden" name="edittype" value="addChangeLog" />
						<cfif Session.Security.CompanyID EQ 1>
							<input type="Submit" name="btnAddNewChangeLog" class="largeTextButton" onclick="submit()" value="Add New Change Log Record">
						</cfif>
						<cfif isDefined("getChangeLogs") and getChangeLogs.RecordCount NEQ 0>
							<CFSET FileName="Change_Log_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
							<input type="button" name="lblExcelButton" class="largeTextButton" value="Open Excel File" ONCLICK="window.open('#Request.ExcelPath#/#FileName#')">
						</cfif>
				</td>
			</TR>
			<TR>
				<td class="largeText" width="1%">&nbsp;</td>
				<td class="largeText" width="11%">&nbsp;</td>
				<td class="largeText">&nbsp;</td>
			</TR>
		</FORM>
	</TABLE>
</cfoutput>

<!--- display Change information --->
<cfif isDefined("getChangeLogs")>
	<cfset r=0>
	<cfset tempr=r>
	<cfset rowsDisplayed = 0>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="silver">
		<TR>
			<td class="ServiceListHeader" width="1%" align="center"></td>
			<td class="ServiceListHeader" width="4%" align="center">Log ID</td>
			<td class="ServiceListHeader" width="8%" align="center">Site ID</td>
			<td class="ServiceListHeader" width="17%" align="center">Address<br>Portfolio</td>
			<td class="ServiceListHeader" width="15%" align="center">Site Manager<br>Deputy<br>Portfolio Manager<br>Chevron Ops Lead</td>
			<td class="ServiceListHeader" width="4%" align="center">Date Logged</td>
			<td class="ServiceListHeader" width="4%" align="center">Due Date</td>
			<td class="ServiceListHeader" width="5%" align="center">Days Since Last Action</td>
			<td class="ServiceListHeader" width="5%" align="center">Days Since Approval</td>
			<td class="ServiceListHeader" width="7%" align="center">FCO Change Amount</td>
			<td class="ServiceListHeader" width="5%" align="center">Status</td>
			<td class="ServiceListHeader" width="6%" align="center">Assigned To</td>
			<td class="ServiceListHeader" width="6%" align="center">Assigned To Team Member</td>
			<td class="ServiceListHeader" width="6%" align="center">Oracle Process Status</td>
			<td class="ServiceListHeader" width="6%" align="center">Milestone Update Status</td>
			<td class="ServiceListHeader" width="1%" align="center"></td>
		</tr>

		<cfif getChangeLogs.RecordCount GT 0>
			<cfset totSites = getChangeLogs.RecordCount>
			<cfset expRowCount = getChangeLogs.RecordCount + 5>
	
			<!--- output data --->	
			<cfoutput query="getChangeLogs">
				<cfset DaysSinceApproval = 0>
				<cfif getChangeLogs.Current_Status_ID EQ 6>
					<cfinclude template="q_getDaysSinceApproval.cfm">
					<cfset DaysSinceApproval = datediff("d", ApprovalDate.StatusDate, now())>
				</cfif>
				<cfset vDaysSinceLastAction = getChangeLogs.DaysSinceLastAction>
				<cfif getChangeLogs.Current_Status_ID EQ 4><cfset vDaysSinceLastAction = "0"></cfif>
				<!--- set DaysActionColor --->
				<cfset DaysActionColor = "yellow">
				<cfif vDaysSinceLastAction LTE 5><cfset DaysActionColor = "green"></cfif>
				<cfif vDaysSinceLastAction GT 15><cfset DaysActionColor = "indigo"></cfif>
				<!--- set DaysApprovalColor --->
				<cfset DaysApprovalColor = "oj">
				<cfif DaysSinceApproval LTE 3><cfset DaysApprovalColor = "irish"></cfif>
				<cfif DaysSinceApproval GTE 7><cfset DaysApprovalColor = "red"></cfif>
				<cfif DaysSinceApproval EQ 0><cfset DaysApprovalColor = "white"></cfif>
				<!--- set ChangeLogs color --->	
				<cfif len(getChangeLogs.color)>
					<cfset ChangeLogColor = getChangeLogs.color>
					<cfif getChangeLogs.Current_Status_ID EQ 4 or getChangeLogs.Current_Status_ID EQ 13 or getChangeLogs.Current_Status_ID EQ 14>
						<cfset r = ChangeLogColor>
					</cfif>
				<cfelse>
					<cfset ChangeLogColor = r>
				</cfif>
				<cfif vDaysSinceLastAction GTE form.DaysToFind>
					<cfset rowsDisplayed = 1>
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
									<cfif isDefined("form.StatusToFind")><input type="Hidden" name="StatusToFind" value="#form.StatusToFind#"></cfif>
									<cfif isDefined("form.AssignedToToFind")><input type="Hidden" name="AssignedToToFind" value="#form.AssignedToToFind#"></cfif>
									<cfif isDefined("form.TMToFind")><input type="Hidden" name="TMToFind" value="#form.TMToFind#"></cfif>
									<cfif isDefined("form.FromDateToFind")><input type="Hidden" name="FromDateToFind" value="#form.FromDateToFind#"></cfif>
									<cfif isDefined("form.ToDateToFind")><input type="Hidden" name="ToDateToFind" value="#form.ToDateToFind#"></cfif>
									<cfif isDefined("form.MilestoneStatusToFind")><input type="Hidden" name="MilestoneStatusToFind" value="#form.MilestoneStatusToFind#"></cfif>
									<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
									<cfif isDefined("form.LogPortfolioToFind")><input type="Hidden" name="LogPortfolioToFind" value="#form.LogPortfolioToFind#"></cfif>
									<cfif isDefined("form.AssignedToMe")><input type="Hidden" name="AssignedToMe" value="#form.AssignedToMe#"></cfif>
									<cfif isDefined("form.AssociatedWithMe")><input type="Hidden" name="AssociatedWithMe" value="#form.AssociatedWithMe#"></cfif>
									<cfif isDefined("form.DaysToFind")><input type="Hidden" name="DaysToFind" value="#form.DaysToFind#"></cfif>
									<cfif isDefined("form.SortBy")><input type="Hidden" name="SortBy" value="#form.SortBy#"></cfif>
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
	
						<!--- change log id --->
						<td class="ReportBody#r#" valign="top" align="center">#getChangeLogs.Actual_Change_Log_ID#</td>
						<!--- site id --->
						<td class="ReportBody#r#" valign="top">#getChangeLogs.Site_ID#</td>
						<!--- Address --->
						<td class="ReportBody#r#" valign="top">#getChangeLogs.Site_Name#<br>#getChangeLogs.Address#<br>#getChangeLogs.City#, #getChangeLogs.State_Abbreviation#<cfif len(getChangeLogs.Zip_Code)>, #getChangeLogs.Zip_Code#</cfif><br>#getChangeLogs.Site_Portfolio#</td>
						<!--- Site Manager --->
						<td class="ReportBody#r#" valign="top">#getChangeLogs.SMName#<br>#getChangeLogs.DeputyName#<br>#getChangeLogs.PortMgrName#<br>#getChangeLogs.OpsLeadName#</td>
						<!--- Date logged --->
						<td class="ReportBody#r#" valign="top" align="center">#dateformat(getChangeLogs.Date_Logged,"m/d/yy")#</td>
						<!--- Due Date --->
						<td class="ReportBody#r#" valign="top" align="center">#dateformat(getChangeLogs.Due_Date_For_Client,"m/d/yy")#</td>
						<!--- Days Since Last Action --->
						<td class="ReportBody#DaysActionColor#" valign="top" align="center">#vDaysSinceLastAction#</td>
						<!--- Days Since Approval --->
						<cfif DaysSinceApproval EQ 0><cfset vDaysSinceApproval = ""><cfelse><cfset vDaysSinceApproval = DaysSinceApproval></cfif>
						<td class="ReportBody#DaysApprovalColor#" valign="top" align="center">#vDaysSinceApproval#</td>
						<!--- FCO Change Amount --->
						<cfset ChangeValue = getChangeLogs.Draft_Change_Value>
						<cfset supText = 1>
						<cfif getChangeLogs.FCO_Processed EQ 3>
							<CFModule template="q_getChangeValue.cfm" CLID="#getChangeLogs.Change_Log_ID#" Return="ChangeValue">
							<cfset supText = 2>
						</cfif>
						<cfif getChangeLogs.Current_Status_ID EQ 10>
							<cfset ChangeValue = 0>
							<cfset supText = "">
						</cfif>
						<td class="ReportBody#r#" valign="top">#dollarformat(ChangeValue)#<sup>#supText#</sup></td>
						<!--- FCO Status --->
						<td class="ReportBody#ChangeLogColor#" valign="top" align="center">#getChangeLogs.current_status#</td>
						<!--- Assigned To --->
						<td class="ReportBody#r#" valign="top" align="center">#getChangeLogs.team#</td>
						<!--- Assigned To Team Member--->
						<td class="ReportBody#r#" valign="top" align="center">#getChangeLogs.AssignedToName#</td>
						<!--- Oracle Process Status --->
						<cfif getChangeLogs.Oracle_Status EQ "R"><cfset ISClass = "ReportBodyOrange"><cfset OracleStatus = "Problem">
						<cfelseif getChangeLogs.Oracle_Status EQ "Y"><cfset ISClass = "ReportBodyYellow"><cfset OracleStatus = "Needs Follow Up">
						<cfelseif getChangeLogs.Oracle_Status EQ "G"><cfset ISClass = "ReportBodyGreen"><cfset OracleStatus = "Complete">
						<cfelseif getChangeLogs.Oracle_Status EQ "O"><cfset ISClass = "ReportBodyBlue"><cfset OracleStatus = "Pending Project Close">
						<cfelse><cfset ISClass = "ReportBody#r#"><cfset OracleStatus = "">
						</cfif>
						<td class="#ISClass#" valign="top" align="center">#OracleStatus#</td>
						<!--- Milestone Update Status --->
						<cfif getChangeLogs.Milestone_Update_Status EQ "R"><cfset MUSClass = "ReportBodyYellow"><cfset MilestoneUpdateStatus = "Needs Follow Up">
						<cfelseif getChangeLogs.Milestone_Update_Status EQ "Y"><cfset MUSClass = "ReportBodyOrange"><cfset MilestoneUpdateStatus = "Not Complete">
						<cfelseif getChangeLogs.Milestone_Update_Status EQ "G"><cfset MUSClass = "ReportBodyGreen"><cfset MilestoneUpdateStatus = "Complete">
						<cfelseif getChangeLogs.Milestone_Update_Status EQ "W"><cfset MUSClass = "ReportBodyBlue"><cfset MilestoneUpdateStatus = "Not Applicable">
						<cfelse><cfset MUSClass = "ReportBody#r#"><cfset MilestoneUpdateStatus = "">
						</cfif>
						<td class="#MUSClass#" valign="top" align="center">#MilestoneUpdateStatus#</td>
						<!--- file link --->
						<td class="ReportBody#r#" valign="top" align="center">
							<cfif isDefined("getChangeLogs.Sharepoint_File_Name") and len(getChangeLogs.Sharepoint_File_Name)>
								<a href="#Request.SharePointPath#/#getChangeLogs.FCO_Folder#/#getChangeLogs.FCO_SubFolder#/" target="_blank"><img src="images/icon_view.gif" border="0" alt="open the FCO workspace"></a>
							</cfif>
						</td>
					</tr>
				</cfif>
				<cfset r = tempr>
				<cfset r = 1-r>
			</cfoutput>
			<cfoutput>
			<tr>
				<td class="ReportBody#r#" colspan="1"></td>
				<td class="ReportBody#r#" colspan="14">
					1 - FCO Change Amount is set to the Draft Change Value<br>
					2 - FCO Change Amount is set to the Total Value of Change in the FCO
				</td>
				<td class="ReportBody#r#" colspan="1"></td>
			</tr>
			</cfoutput>
		</cfif>
				<cfif rowsDisplayed NEQ 0 and getChangeLogs.RecordCount NEQ 0>
					<cfinclude template="change_Log_export.cfm">
				<cfelse>
					<cfoutput>
						<tr>
							<td ALIGN="center" valign="top" colspan="16" class="ReportBody#r#"><em>no records in the database matched your search criteria</em></td>
						</tr>
					</cfoutput>
					<script>document.frmChangeLog.lblExcelButton.style.visibility='hidden';</script>
				</cfif>
			</TD>
		</TR>
	</TABLE>
</cfif>
<script>document.frmChangeLog.SiteIDtofind.focus();</script>
