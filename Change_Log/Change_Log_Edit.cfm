<!--------------------------------------------
Description:
	Change Log edit page

History:
	4/3/2020 - created
--------------------------------------------->

<cfinvoke component="Components.getSiteUsersAttributes" method="ProjectControllers" returnvariable="ControllerList"></cfinvoke>
<cfinvoke component="Components.getSiteUsersAttributes" method="MilestoneManagers" returnvariable="MilestoneManagerList"></cfinvoke>
<cfset EditorList = ControllerList>
<cfset EditorList = listappend(EditorList,MilestoneManagerList)>

<!--- div hider script --->
<script src="scripts/divHider.js"></script>

<!--- calendar --->
<CFIF NOT IsDefined("Request.PopupInitialized")>
	<LINK REL="stylesheet" type="text/css" href="scripts/CalendarPopup/popcalendar.css">
	<SCRIPT LANGUAGE="javaScript" SRC="scripts/CalendarPopup/popcalendar.js"></SCRIPT>	
	<CFSET Request.PopupInitialized = "Yes">
</CFIF>

<CFSET row = 1>
<cfset errormsg = ArrayNew(1) />
<cfset successmsg = "">

<!--- get all Sites --->
<cfinclude template="../components/q_getAllSites.cfm">
<!--- linked portfolio select function --->
<SCRIPT>
	arr_to=new Array();
	arr_options=new Array();
	// Data table
	var optionData = new Array(
		new Array("0","- select the site -","0"),
		<cfloop query="getAllSites">
			<cfoutput>
				new Array("#getAllSites.Portfolio_ID#","#getAllSites.Site_ID#, #getAllSites.Site_Name#, #getAllSites.Address#, #getAllSites.City#, #getAllSites.State_Abbreviation#","#getAllSites.Admin_Site_ID#")<cfif getAllSites.currentRow NEQ getAllSites.RecordCount>,</cfif>
			</cfoutput>
		</cfloop>
	);
	
	// Linked select elements, data table
	function PortfolioSelect(from, to, options)
	{
		(from.style || from).visibility = "visible";
		arr_to.push(to);
		arr_options.push(options);
		from.onchange = function()
		{
			change_sites_all(from, arr_to, arr_options)
		}
		from.onchange();
	}
	
	// change portfolio and sites
	function change_sites_all(from, arr_to, arr_options)
	{
		for (j=0; j<arr_to.length; j++)
		{
			change_sites(from, arr_to[j], arr_options[j]) ;
		}
	}
	
	// change site elements
	function change_sites(from, to, options) 
	{
		var fromCode = from.options[from.selectedIndex].value;
		to.options.length = 0;
		for (i = 0; i < options.length; i++) 
		{
			if (options[i][0] == fromCode) 
			{
				to.options[to.options.length] =
				new Option(options[i][1],options[i][2]);
			}
		}
		to.options[0].selected = true;
	}
</SCRIPT>

<!--- get all members --->
<cfinclude template="q_getTeamMembersAll.cfm">
<!--- linked send to select function --->
<SCRIPT>
	SendArr_to=new Array();
	SendArr_options=new Array();
	// Data table
	var SendOptionData = new Array(
		new Array("0","- select the member -","0"),
		<cfloop query="getTeamMembersAll">
			<cfoutput>
				new Array("#getTeamMembersAll.Team_ID#","#getTeamMembersAll.First_Name# #getTeamMembersAll.Last_Name#","#getTeamMembersAll.User_ID#")<cfif getTeamMembersAll.currentRow NEQ getTeamMembersAll.RecordCount>,</cfif>
			</cfoutput>
		</cfloop>
	);
	
	// Linked select elements, data table
	function SendSelect(from, to, options)
	{
		(from.style || from).visibility = "visible";
		SendArr_to.push(to);
		SendArr_options.push(options);
		from.onchange = function()
		{
			change_team_all(from, SendArr_to, SendArr_options)
		}
		from.onchange();
	}
	
	// change send to and member
	function change_team_all(from, SendArr_to, SendArr_options)
	{
		for (j=0; j<SendArr_to.length; j++)
		{
			change_team(from, SendArr_to[j], SendArr_options[j]) ;
		}
	}
	
	// change member elements
	function change_team(from, to, options) 
	{
		var fromCode = from.options[from.selectedIndex].value;
		to.options.length = 0;
		for (i = 0; i < options.length; i++) 
		{
			if (options[i][0] == fromCode) 
			{
				to.options[to.options.length] =
				new Option(options[i][1],options[i][2]);
			}
		}
		to.options[0].selected = true;
	}
</SCRIPT>

<!--- get Portfolios --->
<cfinvoke component="Components.getPortfolios" method="FCOPortfolios" returnvariable="getPortfolios"></cfinvoke>
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- get sites --->
<cfinclude template="q_getSites.cfm">
<!--- get Team --->
<cfinclude template="q_getTeam.cfm">

<!--- update change info --->
<cfif isDefined("form.btnUpdateChangeLog")>
	<!--- edit record --->
	<cfif isDefined("form.edittype") AND form.edittype EQ "editChangeLog">
		<cfinclude template="q_updChangeLog.cfm">
	</cfif>

	<!--- add new record --->
	<cfif isDefined("form.edittype") AND form.edittype EQ "addChangeLog">
		<cfinclude template="q_addChangeLog.cfm">
		<!--- if no error --->
		<cfif not ArrayLen(errormsg)>
			<cfset form.edittype = "editChangeLog">
		</cfif>
	</cfif>
</cfif>

<!--- set form info --->
<cfif form.edittype EQ "editChangeLog">
	<cfif not ArrayLen(errormsg)>
		<!--- get Change Info --->
		<cfif isDefined("form.editChangeLogID")>
			<cfinclude template="q_getChangeLogInfo.cfm">
		</cfif>
		<cfset form.ChangeLogID = getChangeLogInfo.Change_Log_ID>
		<cfset form.AdminSiteID = getChangeLogInfo.Admin_Site_ID>
		<cfset form.SitePortfolio = getChangeLogInfo.Site_Portfolio>
		<cfset form.SitePortfolioID = getChangeLogInfo.Site_Portfolio_ID>
		<cfset form.PortfolioManager = getChangeLogInfo.Portfolio_Manager>
		<cfset form.SiteID = getChangeLogInfo.Site_ID>
		<cfset form.SiteName = getChangeLogInfo.Site_Name>
		<cfset form.SiteManager = getChangeLogInfo.Site_Manager>
		<cfset form.Address = getChangeLogInfo.Address>
		<cfset form.City = getChangeLogInfo.City>
		<cfset form.StateAbbreviation = getChangeLogInfo.State_Abbreviation>
		<cfset form.CLPortfolioID = getChangeLogInfo.Portfolio_ID>
		<cfset form.SiteProjectID = getChangeLogInfo.Site_Project_ID>
		<cfset form.ActualChangeLogID = getChangeLogInfo.Actual_Change_Log_ID>
		<cfset form.DateLogged = dateformat(getChangeLogInfo.Date_Logged,"mm/dd/yyyy")>
		<cfset form.CurrentStatusID = getChangeLogInfo.Current_Status_ID>
		<cfset form.CurrentStatus = getChangeLogInfo.Status>
		<cfset form.UpdateStatusID = getChangeLogInfo.Update_Status_ID>
		<cfset form.AssignedToID = getChangeLogInfo.Assigned_To_ID>
		<cfset form.AssignedTo = getChangeLogInfo.Team>
		<cfset form.SendToID = getChangeLogInfo.Send_To_ID>
		<cfset form.AssignToUserID = getChangeLogInfo.Assign_To_User_ID>
		<cfset form.ServiceOrderNumber = getChangeLogInfo.Service_Order_Number>
		<cfset form.ChevOpsLead = getChangeLogInfo.Chev_Ops_Lead>
		<cfset form.DraftChangeValue = dollarformat(getChangeLogInfo.Draft_Change_Value)>
		<cfset form.DueDateForClient = dateformat(getChangeLogInfo.Due_Date_For_Client,"mm/dd/yyyy")>
		<cfset form.FCONotes = getChangeLogInfo.FCO_Notes>
		<cfset form.FCOName = getChangeLogInfo.FCO_Name>
		<cfset form.TimeLogged = getChangeLogInfo.Time_Logged>
		<cfset form.OracleStatus = getChangeLogInfo.Oracle_Status>
		<cfset form.MilestoneUpdateStatus = getChangeLogInfo.Milestone_Update_Status>
		<cfset form.ProjectControllerID = getChangeLogInfo.Project_Controller_ID>
		<cfset form.ChevronPMApprovalDate = dateformat(getChangeLogInfo.Chevron_PM_Approval_Date,"mm/dd/yyyy")>
		<cfset form.FCOProcessed = getChangeLogInfo.FCO_Processed>
		<cfset form.CompletedFCO = getChangeLogInfo.Compiled_FCO>
		<cfset form.FCOType = getChangeLogInfo.FCO_Type>
	<cfelse>
		<cfset form.ChangeLogID = form.ChangeLogID>
		<cfset form.AdminSiteID = form.AdminSiteID>
		<cfset form.SitePortfolio = form.SitePortfolio>
		<cfset form.SitePortfolioID = form.SitePortfolioID>
		<cfset form.PortfolioManager = form.PortfolioManager>
		<cfset form.SiteID = form.SiteID>
		<cfset form.SiteName = form.SiteName>
		<cfset form.SiteManager = form.SiteManager>
		<cfset form.Address = form.Address>
		<cfset form.City = form.City>
		<cfset form.StateAbbreviation = form.StateAbbreviation>
		<cfset form.CLPortfolioID = form.CLPortfolioID>
		<cfset form.SiteProjectID = form.SiteProjectID>
		<cfif isDefined("form.ActualChangeLogID")><cfset form.ActualChangeLogID = form.ActualChangeLogID><cfelse><cfset form.ActualChangeLogID = ""></cfif>
		<cfset form.DateLogged = form.DateLogged>
		<cfset form.CurrentStatusID = form.CurrentStatusID>
		<cfset form.CurrentStatus = form.CurrentStatus>
		<cfset form.UpdateStatusID = form.UpdateStatusID>
		<cfset form.SendToID = form.SendToID>
		<cfset form.AssignToUserID = form.AssignToUserID>
		<cfset form.AssignedToID = form.AssignedToID>
		<cfset form.AssignedTo = form.AssignedTo>
		<cfset form.ServiceOrderNumber = form.ServiceOrderNumber>
		<cfset form.ChevOpsLead = form.ChevOpsLead>
		<cfset form.DraftChangeValue = form.DraftChangeValue>
		<cfset form.DueDateForClient = form.DueDateForClient>
		<cfset form.FCONotes = form.FCONotes>
		<cfset form.FCOName = form.FCOName>
		<cfset form.TimeLogged = form.TimeLogged>
		<cfset form.OracleStatus = form.OracleStatus>
		<cfset form.MilestoneUpdateStatus = form.MilestoneUpdateStatus>
		<cfset form.ProjectControllerID = form.ProjectControllerID>
		<cfset form.ChevronPMApprovalDate = form.ChevronPMApprovalDate>
		<cfset form.FCOProcessed = form.FCOProcessed>
		<cfset form.CompletedFCO = form.CompletedFCO>
		<cfset form.FCOType = form.FCOType>
	</cfif>
</cfif>
<cfif isDefined("form.editChangeLogID")><cfinclude template="q_getStatusHistory.cfm"></cfif>
<!--- get Status --->
<cfinclude template="q_getStatus.cfm">

<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText"></td>
		<td class="largeText" width="1%"></td>
	</TR>
  <TR>
		<td class="largeText" width="1%">
		<td class="largeText"><strong>Change Order Request Form</strong></TD>
		<td class="largeText" width="1%">
	</TR>
	<TR>
		<td class="largeText" width="1%">
		<td class="largeText">
			<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="#ffffff">
				<cfif isDefined("form.EditType") and form.EditType EQ "AddChangeLog">
					<tr>
						<td class="largeText" width="1%"><li></li></td>
						<td class="largeText" width="99%">Use this page to create a Change Order Request Form.</td>
					</tr>
					<tr>
						<td class="largeText"><li></li></td>
						<td class="largeText">Select the <strong>Portfolio</strong>, <strong>Site</strong>, enter the <strong>FCO Name</strong> and click the <strong>Save</strong> button.</td>
					</tr>
					<tr>
						<td class="largeText"><li></li></td>
						<td class="largeText">All fields are required.</td>
					</tr>
					<tr>
						<td class="largeText"><li></li></td>
						<td class="largeText"><strong>Hint:</strong> in the <strong>Site</strong> field, type the Site ID to quickly find the Site.</td>
					</tr>
					<tr>
						<td class="largeText"><li></li></td>
						<td class="largeText"><strong>Note:</strong> enter only alphanumeric characters or the underscore, '_', in the <strong>FCO Name</strong></td>
					</tr>
					<tr>
						<td class="largeText"></td>
						<td class="largeText">There is no need to enter all the project info (Region, COP, etc). A name like "Soil_Vapor_Event" is adequate.</li></td>
					</tr>
					<tr>
						<td class="largeText"></td>
						<td class="largeText">The system will append the date to the FCO name automatically, so there is no need to include it in the FCO name.</li></td>
					</tr>
				<cfelse>
					<tr>
						<td class="largeText" width="1%"><li></li></td>
						<td class="largeText" width="99%">Use this page to administer the Change Order Request Form.</td>
					</tr>
					<tr>
						<td class="largeText"><li></li></td>
						<td class="largeText">Enter / edit the information and click the <strong>Save</strong> button.</td>
					</tr>
					<tr>
						<td class="largeText"><li></li></td>
						<td class="largeText">The <strong>Log ID</strong> field will remain inactive until <strong>Send To</strong> = <strong>Project Controller</strong> and <strong>Update Status</strong> = <strong>Approved</strong>.</td>
					</tr>
					<tr>
						<td class="largeText"><li></li></td>
						<td class="largeText">Note:</strong> be sure to <strong>Save</strong> any changes you have made to the form before you click the <strong>Refresh</strong> icon.</td>
					</tr>
				</cfif>
				<tr>
					<td class="largeText"><li></li></td>
					<td class="largeText"><a href="help/FCO_Approval_Process_Flowchart.pdf" target="_blank">The FCO Approval Process Flowchart may be accessed here</a>.</td>
				</tr>
			</TABLE>
		</td>
		<td class="largeText" width="1%">
	</TR>
</TABLE>

<cfoutput>
	<FORM NAME="ChangeLog" METHOD="POST" ACTION="" enctype="multipart/form-data">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
		<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
			<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
				<cfif isDefined("form.Site")><input type="Hidden" name="Site" value="#form.Site#"></cfif>
				<cfif isDefined("form.editChangeLogID")><input type="Hidden" name="editChangeLogID" value="#form.editChangeLogID#"></cfif>
				<cfif isDefined("form.addresstofind")><input type="Hidden" name="addresstofind" value="#form.addresstofind#"></cfif>
				<cfif isDefined("form.citytofind")><input type="Hidden" name="citytofind" value="#form.citytofind#"></cfif>
				<cfif isDefined("form.statetofind")><input type="Hidden" name="statetofind" value="#form.statetofind#"></cfif>
				<cfif isDefined("form.edittype")><input type="hidden" name="edittype" value="#form.edittype#" /></cfif>
				<cfif isDefined("form.LogPortfolioToFind")><input type="hidden" name="LogPortfolioToFind" value="#form.LogPortfolioToFind#" /></cfif>
				<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
				<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
				<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
				<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
				<cfif isDefined("form.ChevronOpsToFind")><input type="Hidden" name="ChevronOpsToFind" value="#form.ChevronOpsToFind#"></cfif>
				<cfif isDefined("form.StatusToFind")><input type="Hidden" name="StatusToFind" value="#form.StatusToFind#"></cfif>
				<cfif isDefined("form.AssignedToToFind")><input type="Hidden" name="AssignedToToFind" value="#form.AssignedToToFind#"></cfif>
				<cfif isDefined("form.TMToFind")><input type="Hidden" name="TMToFind" value="#form.TMToFind#"></cfif>
				<cfif isDefined("form.FromDateToFind")><input type="Hidden" name="FromDateToFind" value="#form.FromDateToFind#"></cfif>
				<cfif isDefined("form.ToDateToFind")><input type="Hidden" name="ToDateToFind" value="#form.ToDateToFind#"></cfif>
				<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
				<cfif isDefined("form.SitePortfolioID")><input type="Hidden" name="SitePortfolioID" value="#form.SitePortfolioID#"></cfif>
				<cfif isDefined("form.AssignedToMe")><input type="Hidden" name="AssignedToMe" value="#form.AssignedToMe#"></cfif>
				<cfif isDefined("form.AssociatedWithMe")><input type="Hidden" name="AssociatedWithMe" value="#form.AssociatedWithMe#"></cfif>
				<cfif isDefined("form.DaysToFind")><input type="Hidden" name="DaysToFind" value="#form.DaysToFind#"></cfif>
				<cfif isDefined("form.SortBy")><input type="Hidden" name="SortBy" value="#form.SortBy#"></cfif>
				<cfloop query="getRegions">
					<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
						<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
					</cfif>
				</cfloop>
				<cfif isDefined("form.CLPortfolioID")><input type="Hidden" name="CLPortfolioID" value="#form.CLPortfolioID#"></cfif>
				<cfif isDefined("form.TimeLogged")><input type="Hidden" name="TimeLogged" value="#form.TimeLogged#"></cfif>
				<cfif isDefined("form.FCOProcessed")><input type="Hidden" name="FCOProcessed" value="#form.FCOProcessed#"></cfif>
				<cfif isDefined("form.CompletedFCO")><input type="Hidden" name="CompletedFCO" value="#form.CompletedFCO#"></cfif>
	
				<!--- success / error message --->
				<cfif ArrayLen(errormsg)><TR><TD colspan="3" class="errorText" align="center">
				There were errors, please review the following:<br>
				<cfloop index="intError"from="1"to="#ArrayLen(errormsg)#"step="1">
					<li>#errormsg[intError]#</li>
				</cfloop>
			</TD></TR>
			<cfelseif len(successmsg)><TR><TD colspan="3" class="successText" align="center"><div id="msg">*** #successmsg# ***</div></TD></TR>
			<cfelse><TR><TD colspan="3" class="successText" align="center">&nbsp;</TD></TR>
			</cfif>
		</table>
	
		<!-------------------------------------------- add change log -------------------------------------------->
		<cfif isDefined("form.EditType") and form.EditType EQ "AddChangeLog">
		<!--- site table --->
		<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="##ffffff">
			<tr>
				<TD class="ListHeaderSilver" colspan="20" align="center"><strong>Site Information</strong></td>
			</tr>

			<!--- Portfolio --->
			<TR>
				<TD class="row0" colspan="2" align="right"><strong>Portfolio:</strong>&nbsp;</TD>
				<TD class="row0" colspan="18">
					<select name="PortfolioID" id="PortfolioID" class="row0" onchange="PortfolioSelect(PortfolioElement['PortfolioID'],PortfolioElement['AdminSiteID'],optionData)">
						<option value="0">- select a portfolio -</option>
						<cfloop query="getPortfolios">
							<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.PortfolioID") and form.PortfolioID EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- site --->
			<TR>
				<TD class="row0" colspan="2" align="right"><strong>Site:</strong>&nbsp;</TD>
				<TD class="row0" colspan="18">
					<select name="AdminSiteID" id="AdminSiteID" class="row0">
						<option value="0">- select a site -</option>
						<cfloop query="getSites">
							<option value="#getSites.Admin_Site_ID#" <cfif isDefined("form.AdminSiteID") and form.AdminSiteID EQ getSites.Admin_Site_ID>selected="selected"</cfif>>#getSites.Site_ID#, #getSites.Site_Name#, #getSites.Address#, #getSites.City#, #getSites.State_Abbreviation#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- FCO Name --->
			<TR>
				<TD class="row0" colspan="2" align="right" valign="top"><strong>FCO Name:</strong>&nbsp;</TD>
				<TD class="row0" colspan="18" valign="top">
					<input type="text" name="FCOName" size="40" maxlength="40" value="<cfif isDefined("form.FCOName") and len(form.FCOName)>#form.FCOName#</cfif>">
				</TD>
			</TR>

			<!--- column widths --->
			<tr><cfloop from="1" to="20" index="x"><TD width="5%"></td></cfloop></tr>
		</table>

		<!-------------------------------------------- edit change log -------------------------------------------->
		<cfelse>
		<!--- site table --->
		<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="##ffffff">
			<tr>
				<TD class="ListHeaderSilver" colspan="20" align="center"><strong>Site / Project Information</strong></td>
			</tr>

			<!--- Portfolio, Mgr --->
			<TR>
				<input type="hidden" name="SitePortfolio" value="#form.SitePortfolio#">
				<input type="hidden" name="PortfolioManager" value="#form.PortfolioManager#">
				<TD class="row0" colspan="2" align="right"><strong>Portfolio:</strong>&nbsp;</TD>
				<TD class="row0" colspan="10">#form.SitePortfolio#</TD>
				<TD class="row0" colspan="8"><strong>Portfolio Manager:</strong>&nbsp;#form.PortfolioManager#</TD>
			</TR>

			<!--- site, Mgr --->
			<TR>
				<input type="hidden" name="ChangeLogID" value="#form.ChangeLogID#">
				<input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#">
				<input type="hidden" name="SiteID" value="#form.SiteID#">
				<input type="hidden" name="SiteName" value="#form.SiteName#">
				<input type="hidden" name="Address" value="#form.Address#">
				<input type="hidden" name="City" value="#form.City#">
				<input type="hidden" name="SiteManager" value="#form.SiteManager#">
				<input type="hidden" name="StateAbbreviation" value="#form.StateAbbreviation#">
				<TD class="row0" colspan="2" align="right"><strong>Site:</strong>&nbsp;</TD>
				<TD class="row0" colspan="10">#form.SiteID#, #form.SiteName#, #form.Address#, #form.City#, #form.StateAbbreviation#</TD>
				<TD class="row0" colspan="8"><strong>Site Manager:</strong>&nbsp;#form.SiteManager#</TD>
			</TR>

			<!--- fco name --->
			<TR>
				<input type="hidden" name="FCOName" value="#form.FCOName#">
				<TD class="row0" colspan="2" align="right"><strong>FCO Name:</strong>&nbsp;</TD>
				<TD class="row0" colspan="18">#form.FCOName#</TD>
			</TR>

			<!--- Project, Change Log, SO, Chev OPs Lead, Date --->
			<tr>
				<TD class="row0" colspan="10">&nbsp;<strong>Project Name, Project Number, Arcadis PM</strong></td>
				<TD class="row0" colspan="2"><strong>Log ID</strong></td>
				<TD class="row0" colspan="2"><strong>SO Number</strong></td>
				<TD class="row0" colspan="3"><strong>Chevron Ops Lead</strong></td>
				<TD class="row0" colspan="3"><strong>Date Logged</strong></td>
			</tr>

			<!--- Project, Change Log, SO, Chev OPs Lead, Date --->
			<cfinclude template="q_getProjects.cfm">
			<cfinclude template="q_getTempProjects.cfm">
			<tr>
				<TD class="row0" colspan="10">
					&nbsp;<select name="SiteProjectID" class="row0">
						<cfif getProjects.RecordCount NEQ 0>
							<cfloop query="getProjects">
								<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="#getProjects.Site_Project_ID#" <cfif isDefined("form.SiteProjectID") and form.SiteProjectID EQ getProjects.Site_Project_ID>selected="selected"</cfif>>#getProjects.Project_Name#, #getProjects.Project_Number#, #getProjects.Project_Manager_Name#</option>
							</cfloop>
						<cfelse>
							<cfloop query="getTempProjects">
								<option value="#getTempProjects.Site_Project_ID#" <cfif isDefined("form.SiteProjectID") and form.SiteProjectID EQ 0>selected="selected"</cfif>>#getTempProjects.Project_Name#</option>
							</cfloop>
						</cfif>
					</select>
				</td>
				<TD class="row0" colspan="2">
					<INPUT TYPE="hidden" name="ProjectControllerID" value="#form.ProjectControllerID#">
					<!--- if Approved by Chevron and Project Controller or Milestone Manager --->
					<INPUT TYPE="text" name="ActualChangeLogID" size="10" maxlength="64" 
					<cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 6) and (listFind(EditorList,Session.Security.UserID) or listFind(MilestoneManagerList,Session.Security.UserID))>
<!---					<cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 6) and (isDefined("form.SendToID") and form.SendToID EQ 8)>--->
<!---						<cfif form.ProjectControllerID NEQ Session.Security.UserID>disabled="true"</cfif>--->
<!---					<cfelseif listFind(EditorList,Session.Security.UserID)>--->
					<cfelse>disabled="true"
					</cfif> 
					VALUE="<cfif isDefined('form.ActualChangeLogID')>#form.ActualChangeLogID#</cfif>">
				</td>
				<TD class="row0" colspan="2">
					#form.ServiceOrderNumber#
					<input type="hidden" name="ServiceOrderNumber" value="#form.ServiceOrderNumber#">
				</td>
				<TD class="row0" colspan="3">
					#form.ChevOpsLead#
					<input type="hidden" name="ChevOpsLead" value="#form.ChevOpsLead#">
				</td>
				<TD class="row0" colspan="3">
					<INPUT TYPE="text" name="DateCreated" size="10" maxlength="10" disabled="true" VALUE="<cfif isDefined('form.DateLogged')>#form.DateLogged#</cfif>">
					<input type="hidden" name="DateLogged" value="#form.DateLogged#">
				</td>
			</tr>
		
			<!--- space --->
			<tr><TD class="row0" colspan="20">&nbsp;</td></tr>
		
			<!--- FCO Status --->
			<TR><TD class="ListHeaderSilver" colspan="20" align="center"><strong>FCO Status</strong></td></tr>
	
			<!--- due date, Draft_Change_Value --->
			<TR>
				<TD class="row0" colspan="3" align="right" valign="top"><strong>Due Date For Client:</strong>&nbsp;</TD>
				<TD class="row0" colspan="4" valign="top">
					<INPUT TYPE="text" name="DueDateForClient" size="10" maxlength="10" <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> VALUE="<cfif isDefined('form.DueDateForClient')>#form.DueDateForClient#</cfif>">
				 	<cfif isDefined("form.UpdateStatusID") and form.UpdateStatusID NEQ 4>
						<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp2']:document.TaskPopUp2_Position), document.forms.ChangeLog.DueDateForClient, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp2_Position" ID="TaskPopUp2_Position" BORDER="0" ALT="Date"></A>
					</cfif>
				</TD>
				<cfif form.FCOProcessed NEQ 3> 
					<TD class="row0" colspan="3" align="right" valign="top"><strong>Draft Change Value:</strong>&nbsp;</TD>
					<TD class="row0" colspan="4" valign="top">
						<input type="text" name="DraftChangeValue" value="#form.DraftChangeValue#" <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif>>
					</TD>
				<cfelse>
					<TD class="row0" colspan="3" align="right" valign="top"><strong>Change Value:</strong>&nbsp;</TD>
					<TD class="row0" colspan="4" valign="top">
						<CFModule template="q_getChangeValue.cfm" CLID="#form.ChangeLogID#" Return="ChangeValue">
						<input type="text" name="DraftChangeValue" value="#dollarformat(ChangeValue)#" <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif>>
					</TD>
				</cfif>
				<TD class="row0" colspan="6"></TD>
			</TR>

			<!--- space --->
			<tr><TD class="row0" colspan="20">&nbsp;</td></tr>

			<!--- Assigned To, Current Status --->
			<input type="hidden" name="CurrentStatusID" value="#form.CurrentStatusID#">
			<input type="hidden" name="CurrentStatus" value="#form.CurrentStatus#">
			<input type="hidden" name="AssignedToID" value="#form.AssignedToID#">
			<input type="hidden" name="AssignedTo" value="#form.AssignedTo#">
			<TR>
				<TD class="row0" colspan="3" align="right" valign="top"><strong>Assigned To:</strong>&nbsp;</TD>
				<TD class="row0" colspan="3" valign="top">#form.AssignedTo#</TD>
				<!--- Current Status --->
				<TD class="row0" colspan="3" align="right" valign="top"><strong>Current Status:</strong>&nbsp;</TD>
				<TD class="row0" colspan="4" valign="top">#form.CurrentStatus#</TD>
	
				<TD class="row0" colspan="3" align="right" valign="top">&nbsp;</TD>
				<TD class="row0" colspan="4" valign="top">&nbsp;</TD>
			</TR>
		
			<!--- Send To, Update Status --->
			<TR>
				<TD class="row0" colspan="3" align="right" valign="top"><strong>Send To:</strong>&nbsp;</TD>
				<TD class="row0" colspan="3" valign="top">
				<select name="SendToID" id="SendToID" class="row0" onchange="SendSelect(SendElement['SendToID'],SendElement['AssignToUserID'],SendOptionData)">
						<cfif isDefined("form.UpdateStatusID") and form.UpdateStatusID NEQ 4>
							<option value="0">- select the team -</option>
						</cfif>
						<cfloop query="getTeam">
							<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="#getTeam.Team_ID#" <cfif isDefined("form.SendToID") and form.SendToID EQ getTeam.Team_ID>selected="selected"</cfif>>#getTeam.Team#</option>
						</cfloop>
					</select>
				</TD>
				<!--- Update Status --->
				<TD class="row0" colspan="3" align="right" valign="top"><strong>Update Status:</strong>&nbsp;</TD>
				<TD class="row0" colspan="4" valign="top">
					<select name="UpdateStatusID" class="row0">
						<cfif isDefined("form.UpdateStatusID") and form.UpdateStatusID NEQ 4>
							<option value="0">- select the update status -</option>
						</cfif>
						<cfloop query="getStatus">
							<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="#getStatus.Status_ID#" <cfif isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ getStatus.Status_ID>selected="selected"</cfif>>#getStatus.Status#</option>
						</cfloop>
					</select>
				</TD>
				<TD class="row0" colspan="3" align="right" valign="top">&nbsp;</TD>
				<TD class="row0" colspan="4" valign="top">&nbsp;</TD>
			</TR>
		
			<!--- get Team Members --->
			<cfinclude template="q_getTeamMembers.cfm">
			<!--- Assign To Team Member --->
			<TR>
				<TD class="row0" colspan="3" align="right" valign="top"><strong>Assign To Team Member:</strong>&nbsp;</TD>
				<TD class="row0" colspan="4" valign="top">
					<select name="AssignToUserID" id="AssignToUserID" class="row0">
						<cfif getTeamMembers.RecordCount NEQ 0>
							<cfif isDefined("form.UpdateStatusID") and form.UpdateStatusID NEQ 4>
								<option value="0">- select the member -</option>
							</cfif>
							<cfloop query="getTeamMembers">
								<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="#getTeamMembers.User_ID#" <cfif isDefined("form.AssignToUserID") and form.AssignToUserID EQ getTeamMembers.User_ID>selected="selected"</cfif>>#getTeamMembers.First_Name# #getTeamMembers.Last_Name#</option>
							</cfloop>
						<cfelse>
							<option value="0">- select the member -</option>
						</cfif>
					</select>
				</TD>
				<!--- Update Status --->
				<TD class="row0" colspan="3" >&nbsp;</TD>
				<TD class="row0" colspan="3" >&nbsp;</TD>
				<TD class="row0" colspan="3" >&nbsp;</TD>
				<TD class="row0" colspan="4" >&nbsp;</TD>
			</TR>

			<!--- space --->
			<tr><TD class="row0" colspan="20">&nbsp;</td></tr>

			<!--- FCO Documents --->
			<TR valign="bottom">
				<TD class="row0" colspan="3" align="right"><strong>FCO Workspace:</strong>&nbsp;</TD>
				<TD class="row0" colspan="17">
					<cfif isDefined("getChangeLogInfo.Sharepoint_File_Name") and len(getChangeLogInfo.Sharepoint_File_Name)>
						<a href="#Request.SharePointPath#/#getChangeLogInfo.FCO_Folder#/#getChangeLogInfo.FCO_SubFolder#/" target="_blank">open the FCO workspace</a>
					<cfelse>
						<cfif DateDiff("s",form.TimeLogged,CreateODBCDateTime(now())) LT 180>
							<span class="Errortext">The working FCO document has not yet been created on SharePoint. Please check back in a few minutes or click the Refresh icon.</span>
						<cfelse>
							<span class="Errortext">Sorry for the delay. Your FCO is being processed, but is taking longer than anticipated.</span>
						</cfif>
						<input type="Image" name="btnRefreshChangeLog" src="images/icon_refresh.gif" width="12" height="12" border="0" onclick="submit()" alt="refresh">
					</cfif>
				</TD>
			</TR>
			<TR valign="bottom">
				<TD class="row0" colspan="3" align="right"></TD>
				<TD class="row0" colspan="17">
					<i>Use this FCO Workspace to draft your FCO and save relevant supporting files (costs, etc.)</i>
				</TD>
			</TR>

			<!--- space --->
			<tr><TD class="row0" colspan="20">&nbsp;</td></tr>

			<!--- FCO Notes --->
			<TR>
				<TD class="row0" colspan="3" align="right" valign="top"><strong>Notes:</strong>&nbsp;</TD>
				<TD class="row0" colspan="17" valign="top">
					<textarea class="filetext" cols="120" rows="4" name="FCONotes" <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif>><cfif isDefined("form.FCONotes")>#form.FCONotes#</cfif></textarea>
				</TD>
			</TR>

			<!--- space --->
			<tr><TD class="row0" colspan="20">&nbsp;</td></tr>

			<!--- Oracle Process Status, Milestone Update Status --->
			<tr>
				<TD class="row0" colspan="20">
					<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="##ffffff"><TR><TD>
						<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="silver">
							<TR>
								<td class="largetext" align="center" colspan="9" bgcolor="yellow"><strong>*** For Project Controllers and Milestones Managers Only ***</strong></td>
							</tr>
							<TR>
								<TD class="row0" width="10%" align="right" valign="top"><strong>Oracle Process:</strong>&nbsp;</TD>
								<TD class="row0" width="14%" valign="top">
									<select name="OracleStatus" class="largeText">
										<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="">- select the status -</option>
										<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="G" class="ReportBodyGreen" <cfif isDefined("form.OracleStatus") and form.OracleStatus EQ "G">selected="selected"</cfif>>Complete</option>
										<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="O" class="ReportBodyBlue" <cfif isDefined("form.OracleStatus") and form.OracleStatus EQ "O">selected</cfif>>Pending Project Close</option>
										<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="Y" class="ReportBodyYellow" <cfif isDefined("form.OracleStatus") and form.OracleStatus EQ "Y">selected="selected"</cfif>>Needs Follow Up</option>
										<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="R" class="ReportBodyOrange" <cfif isDefined("form.OracleStatus") and form.OracleStatus EQ "R">selected="selected"</cfif>>Problem</option>
									</select>
								</TD>
								<TD class="row0" width="11%" align="right" valign="top"><strong>Milestone Update:</strong>&nbsp;</TD>
								<TD class="row0" width="14%" valign="top">
									<select name="MilestoneUpdateStatus" class="largeText">
										<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="W" class="ReportBodyBlue" <cfif isDefined("form.MilestoneUpdateStatus") and form.MilestoneUpdateStatus EQ "">selected="selected"</cfif>>Not Applicable</option>
										<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="Y" class="ReportBodyOrange" <cfif isDefined("form.MilestoneUpdateStatus") and form.MilestoneUpdateStatus EQ "Y">selected="selected"</cfif>>Not Complete</option>
										<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="R" class="ReportBodyYellow" <cfif isDefined("form.MilestoneUpdateStatus") and form.MilestoneUpdateStatus EQ "R">selected="selected"</cfif>>Needs Follow Up</option>
										<option <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> value="G" class="ReportBodyGreen" <cfif isDefined("form.MilestoneUpdateStatus") and form.MilestoneUpdateStatus EQ "G">selected="selected"</cfif>>Complete</option>
									</select>
								</TD>
								<TD class="row0" width="11%" align="right" valign="top"><strong>Chevron Approval:</strong>&nbsp;</TD>
								<TD class="row0" width="14%" valign="top">
									<INPUT <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> TYPE="text" name="ChevronPMApprovalDate" size="10" maxlength="10" <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif> VALUE="<cfif isDefined('form.ChevronPMApprovalDate')>#form.ChevronPMApprovalDate#</cfif>">
								 	<cfif isDefined("form.UpdateStatusID") and form.UpdateStatusID NEQ 4>
										<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp3']:document.TaskPopUp3_Position), document.forms.ChangeLog.ChevronPMApprovalDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp3_Position" ID="TaskPopUp3_Position" BORDER="0" ALT="Date"></A>
									</cfif>
								</TD>
								<TD class="row0" width="9%" align="right" valign="top"><strong>Compiled FCO:</strong>&nbsp;</TD>
								<TD class="row0" width="16%" valign="top"><input type="file" class="largeText" name="CompiledFCO" <cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID EQ 4) and not listFind(EditorList,Session.Security.UserID)>disabled="true"</cfif>></TD>
								<TD class="row0" width="1%" align="right" valign="top">
									<input type="hidden" name="FCOType" value="#form.FCOType#">
									<cfif len(form.CompletedFCO)>
										<A HREF="javascript: var n=window.open('components/GetDoc.cfm?editChangeLogID=#form.editChangeLogID#&DocType=ChangeLog#form.FCOType#', '', 'height=700,width=900,resizable')"><IMG SRC="/CommonImages/icon_view.gif" BORDER="0" ALT="View"></A>
									</cfif>
								</TD>
							</TR>
						</TABLE>
					</TD></TR></TABLE>
				</td>
			</tr>

			<!--- column widths --->
			<tr><cfloop from="1" to="20" index="x"><TD width="5%"></td></cfloop></tr>
		</TABLE>
		</cfif>

		<!--- buttons --->
		<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="##ffffff">
			<!--- space --->
			<tr><TD class="row0" colspan="2">&nbsp;</td></tr>
			<tr>
				<cfif isDefined("form.EditType") and form.EditType EQ "AddChangeLog">
					<TD class="row0" colspan="2"></td>
					<td class="row0" colspan="18">
				<cfelse>
					<td class="row0" colspan="20" align="center">
				</cfif>
			 	<cfif (isDefined("form.UpdateStatusID") and form.UpdateStatusID NEQ 4) or (isDefined("form.editType") and form.edittype EQ "addChangeLog") or (listFind(EditorList,Session.Security.UserID))>
					<input type="submit" name="btnUpdateChangeLog" value="Save" class="largeTextButton">
				</cfif>
					<input type="submit" name="btnReturn" value="Return" class="largeTextButton" />
				</td>
			</tr>
			<!--- column widths --->
			<tr><cfloop from="1" to="20" index="x"><TD width="5%"></td></cfloop></tr>
		</TABLE>
	</FORM>
</cfoutput>

<!--- FCO Status History--->
<cfif isDefined("form.EditType") and form.EditType EQ "editChangeLog">
	<cfset r=0>
	<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
		<TR><TD class="ListHeaderSilver" colspan="20" align="center"><strong>Status History</strong></td></tr>
			<cfif isDefined("getStatusHistory")>
			<TR><TD>
				<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="##ffffff"><TR><TD>
					<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="silver">
						<TR>
							<td class="ListHeaderBlue" width="25%" align="center">Status</td>
							<td class="ListHeaderBlue" width="25%" align="center">Assigned To</td>
							<td class="ListHeaderBlue" width="25%" align="center">Date</td>
							<td class="ListHeaderBlue" width="25%" align="center">Updated By</td>
						</tr>
						<cfif getStatusHistory.RecordCount GT 0>			
							<cfloop query="getStatusHistory">
								<tr>
							<td class="row#r#" align="center">#getStatusHistory.Status#</td>
							<td class="row#r#" align="center">#getStatusHistory.Team#</td>
							<td class="row#r#" align="center">#dateformat(getStatusHistory.Status_Date,"mm/dd/yyyy" )#</td>
							<td class="row#r#" align="center"><cfif len(getStatusHistory.Last_Name)>#getStatusHistory.Last_Name#, #getStatusHistory.First_Name#</cfif></td>
								</tr>
								<cfset r = 1-r>
							</cfloop>
						<cfelse>
							<tr>
								<td ALIGN="center" valign="top" colspan="6" class="ReportBody#r#"><em>there is no status history for this fco</em></td>
							</tr>
						</cfif>
					</TABLE>
				</TD></TR></TABLE>
			</TD></TR>
			</cfif>
	</TABLE>
	</cfoutput>
</cfif>
	
<cfif isDefined("form.edittype") and form.edittype EQ "editChangeLog">
	<script>document.ChangeLog.SiteProjectID.focus();</script>
<cfelse>
	<script>document.ChangeLog.PortfolioID.focus();</script>
</cfif>
<SCRIPT>var PortfolioElement=document.forms['ChangeLog'].elements;</SCRIPT>
<SCRIPT>var SendElement=document.forms['ChangeLog'].elements;</SCRIPT>
