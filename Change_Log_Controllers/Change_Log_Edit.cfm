<!-------------------------------------------
Description:
	Change Log edit page

History:
	4/3/2020 - created
-------------------------------------------->

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

<!--- get Portfolios --->
<cfinclude template="../components/q_getPortfolios.cfm">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- get sites --->
<cfinclude template="q_getSites.cfm">
<!--- get the Change Log Entity --->
<cfinclude template="q_getChangeLogEntity.cfm">
<!--- get the Change Log Change Type --->
<cfinclude template="q_getChangeLogChangeType.cfm">
<!--- get the Change Log Change Reason --->
<cfinclude template="q_getChangeLogChangeReason.cfm">
<!--- get the Change Log Reason Detail --->
<cfinclude template="q_getChangeLogReasonDetail.cfm">
<!--- get Portfolio Managers --->
<cfinclude template="q_getPortfolioManagers.cfm">
<!--- get Portfolio Operations Project Leads --->
<cfinclude template="q_getChevronPortfolioManagers.cfm">
<!--- get Arcdadis PMs --->
<cfinclude template="../components/q_getSiteManagers.cfm">

<!--- replace double quote with single quote --->
<cfloop collection="#form#" item="name">
	<cfif name NEQ "IMGEDITCHANGELOG.X" and name NEQ "IMGEDITCHANGELOG.Y">
		<cfset "form.#name#" = #replace(evaluate("form.#name#"),chr(34),"'","all")#>
	</cfif>
</cfloop>

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

<cfparam name="form.PerformancePeriodEndDate" default="">
<cfparam name="form.listChangeType" default="">
<cfparam name="form.listChangeReason" default="">
<cfparam name="form.listReasonDetail" default="">
<cfparam name="form.PortfolioManagerID" default="493">
<cfparam name="form.ChevronPMID" default="0">

<!--- set form info --->
<cfif form.edittype EQ "editChangeLog">
	<cfif not ArrayLen(errormsg)>
		<!--- get Change Info --->
		<cfif isDefined("form.editChangeLogID")>
			<cfinclude template="q_getChangeLogInfo.cfm">
		</cfif>
		<cfset form.AdminSiteID = getChangeLogInfo.Admin_Site_ID>
		<cfset form.SiteID = getChangeLogInfo.Site_ID>
		<cfset form.PortfolioID = getChangeLogInfo.Portfolio_ID>
		<cfset form.SiteName = getChangeLogInfo.Site_Name>
		<cfset form.Address = getChangeLogInfo.Address>
		<cfset form.City = getChangeLogInfo.City>
		<cfset form.State_Abbreviation = getChangeLogInfo.State_Abbreviation>
		<cfset form.ActualChangeLogID = getChangeLogInfo.Actual_Change_Log_ID>
		<cfset form.DateLogged = dateformat(getChangeLogInfo.Date_Logged,"mm/dd/yyyy")>
		<cfset form.InitiatingEntityID = getChangeLogInfo.Initiating_Entity_ID>
		<cfset form.listChangeType = getChangeLogInfo.Change_Type_ID>
		<cfset form.ChangeTypeOther = getChangeLogInfo.Change_Type_Other>
		<cfset form.listChangeReason = getChangeLogInfo.Change_Reason_ID>
		<cfset form.listReasonDetail = getChangeLogInfo.Reason_Detail_ID>
		<cfset form.ReasonDetailOther = getChangeLogInfo.Reason_Detail_Other>
		<cfset form.ChangeValue = dollarformat(getChangeLogInfo.Change_Value)>
		<cfset form.AdditionalInformation = getChangeLogInfo.Additional_Information>
		<cfset form.MilestoneList = getChangeLogInfo.Milestone_List>
		<cfset form.Assumptions = getChangeLogInfo.Assumptions>
		<cfset form.PerformancePeriodEndDate = dateformat(getChangeLogInfo.Performance_Period_End_Date,"mm/dd/yyyy")>
		<cfset form.PortfolioManagerID = getChangeLogInfo.Portfolio_Manager_ID>
		<cfset form.PortfolioManagerApprovalDate = dateformat(getChangeLogInfo.Portfolio_Manager_Approval_Date,"mm/dd/yyyy")>
		<cfset form.ApprovalDescription = getChangeLogInfo.Approval_Description>
		<cfset form.ChevronPMID = getChangeLogInfo.Chevron_PM_ID>
		<cfset form.ChevronPMApprovalDate = dateformat(getChangeLogInfo.Chevron_PM_Approval_Date,"mm/dd/yyyy")>
		<cfset form.Amendment = getChangeLogInfo.Amendment>
		<cfset form.ArcadisPMID = getChangeLogInfo.Arcadis_PM_ID>
		<cfset form.EmailReference = getChangeLogInfo.Email_Reference>
		<cfset form.OracleUpdate = getChangeLogInfo.Oracle_Update>
		<cfset form.InternalStatus = getChangeLogInfo.Internal_Status>
		<cfset form.ChevronApprovalStatus = getChangeLogInfo.Chevron_Approval_Status>
		<cfset form.MilestoneUpdateStatus = getChangeLogInfo.Milestone_Update_Status>
	<cfelse>
		<cfset form.AdminSiteID = form.AdminSiteID>
		<cfset form.SiteID = form.SiteID>
		<cfset form.PortfolioID = form.PortfolioID>
		<cfset form.SiteName = form.SiteName>
		<cfset form.Address = form.Address>
		<cfset form.City = form.City>
		<cfset form.State_Abbreviation = form.State_Abbreviation>
		<cfset form.ActualChangeLogID = form.ActualChangeLogID>
		<cfset form.DateLogged = form.DateLogged>
		<cfset form.InitiatingEntityID = form.InitiatingEntityID>
		<cfset form.listChangeType = form.listChangeType>
		<cfset form.ChangeTypeOther = form.ChangeTypeOther>
		<cfset form.listChangeReason = form.listChangeReason>
		<cfset form.listReasonDetail = form.listReasonDetail>
		<cfset form.ReasonDetailOther = form.ReasonDetailOther>
		<cfset form.ChangeValue = form.ChangeValue>
		<cfset form.AdditionalInformation = form.AdditionalInformation>
		<cfset form.MilestoneList = form.MilestoneList>
		<cfset form.Assumptions = form.Assumptions>
		<cfset form.PerformancePeriodEndDate = form.PerformancePeriodEndDate>
		<cfset form.PortfolioManagerID = form.PortfolioManagerID>
		<cfset form.ChevronPMApprovalDate = form.ChevronPMApprovalDate>
		<cfset form.ApprovalDescription = form.ApprovalDescription>
		<cfset form.ChevronPMID = form.ChevronPMID>
		<cfset form.PortfolioManagerApprovalDate = form.PortfolioManagerApprovalDate>
		<cfset form.Amendment = form.Amendment>
		<cfset form.ArcadisPMID = form.ArcadisPMID>
		<cfset form.EmailReference = form.EmailReference>
		<cfset form.OracleUpdate = form.OracleUpdate>
		<cfset form.InternalStatus = form.InternalStatus>
		<cfset form.ChevronApprovalStatus = form.ChevronApprovalStatus>
		<cfset form.MilestoneUpdateStatus = form.MilestoneUpdateStatus>
	</cfif>
</cfif>
<cfif form.PerformancePeriodEndDate EQ "01/01/1900"><cfset form.PerformancePeriodEndDate = "NA"></cfif>

<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR>
		<td class="largeText" align="left" width="1%"></td>
		<td class="largeText" align="left">&nbsp;</td>
		<td class="largeText" align="left" width="1%"></td>
	</TR>
  <TR>
		<td class="largeText" align="left" width="1%">
		<td class="largeText" align="left"><strong>Change Log Management Version 1 - Project Controllers Only</strong></TD>
		<td class="largeText" align="left" width="1%">
	</TR>
	<TR>
		<td class="largeText" align="left" width="1%">
		<td class="largeText" align="left">
			<li>Use this page to administer change tracking information. Enter / edit the information and click the <strong>Save</strong> button.</li>
		</td>
		<td class="largeText" align="left" width="1%">
	</TR>
	<TR><td class="largeText" colspan="3"><hr></td></TR>
</TABLE>

<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
		<FORM NAME="ChangeAdmin" METHOD="POST" ACTION="" enctype="multipart/form-data">
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
			<cfif isDefined("form.LogIDSort")><input type="Hidden" name="LogIDSort" value="#form.LogIDSort#"></cfif>
			<cfloop query="getRegions">
				<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
					<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
				</cfif>
			</cfloop>

			<cfif ArrayLen(errormsg)><TR><TD colspan="2" class="errorText" align="center">
			There were errors, please review the following:<br>
			<cfloop index="intError"from="1"to="#ArrayLen(errormsg)#"step="1">
				<li>#errormsg[intError]#</li>
			</cfloop>
			</TD></TR>
			<cfelseif len(successmsg)><TR><TD colspan="2" class="successText" align="center"><div id="msg">*** #successmsg# ***</div></TD></TR>
			<cfelse><TR><TD colspan="2" class="successText" align="center">&nbsp;</TD></TR>
			</cfif>

			<!--- Site --->
			<TR>
				<TD class="largeText" align="right"><strong>Site:</strong>&nbsp;</TD>
				<TD class="largeText">
						<select name="AdminSiteID" class="largeText">
							<option value="0">- select a site -</option>
							<cfloop query="getSites">
								<option value="#getSites.Admin_Site_ID#" <cfif isDefined("form.AdminSiteID") and form.AdminSiteID EQ getSites.Admin_Site_ID>selected="selected"</cfif>>#getSites.Site_ID#, #getSites.Site_Name#, #getSites.Address#, #getSites.City#, #getSites.State_Abbreviation#</option>
							</cfloop>
						</select>
				</TD>
			</TR>

			<!--- Portfolio --->
			<TR>
				<TD class="largeText" align="right"><strong>Change Log Portfolio:</strong>&nbsp;</TD>
				<TD class="largeText">
						<select name="PortfolioID" class="largeText">
							<option value="0">- select a portfolio -</option>
							<cfloop query="getPortfolios">
								<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.PortfolioID") and form.PortfolioID EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
							</cfloop>
						</select>
				</TD>
			</TR>

			<!--- Log ID, Date Logged --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Change Log ID:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<INPUT TYPE="text" name="ActualChangeLogID" size="20" maxlength="64" class="largeText" VALUE="<cfif isDefined('form.ActualChangeLogID')>#form.ActualChangeLogID#</cfif>">
					&nbsp;
					<strong>Date Logged:</strong>&nbsp;
					<INPUT TYPE="text" name="DateLogged" size="12" maxlength="10" class="largeText" VALUE="<cfif isDefined('form.DateLogged')>#form.DateLogged#</cfif>">
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp1']:document.TaskPopUp1_Position), document.forms.ChangeAdmin.DateLogged, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp1_Position" ID="TaskPopUp1_Position" BORDER="0" ALT="Date"></A>
				</TD>
			</TR>

			<!--- Entity Initiating Change --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Entity Initiating Change:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<select name="InitiatingEntityID" class="largeText">
						<option value="0">- select the entity -</option>
						<cfloop query="getChangeLogEntity">
							<option value="#getChangeLogEntity.Initiating_Entity_ID#" <cfif isDefined("form.InitiatingEntityID") and form.InitiatingEntityID EQ getChangeLogEntity.Initiating_Entity_ID>selected="selected"</cfif>>#getChangeLogEntity.Initiating_Entity#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- Type of Change --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Type of Change:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<cfloop query="getChangeLogChangeType">
							<cfif getChangeLogChangeType.CurrentRow EQ 1 or (getChangeLogChangeType.CurrentRow-1) mod 3 EQ 0 ><tr></cfif>
							<td class="largeText" width="33%">
								<input type="checkbox" name="ChangeTypeID#getChangeLogChangeType.Change_Type_ID#" class="largeText" <cfif listfind(form.listChangeType,getChangeLogChangeType.Change_Type_ID)>checked="checked"</cfif>>#getChangeLogChangeType.Change_Type#
							</td>
							<cfif getChangeLogChangeType.CurrentRow mod 3 EQ 0 or getChangeLogChangeType.CurrentRow EQ getChangeLogChangeType.RecordCount></TR></cfif>
						</cfloop>
						<tr><td class="largeText" colspan="3"><strong>
							If Other:</strong>&nbsp;
							<INPUT TYPE="text" name="ChangeTypeOther" size="67" maxlength="128" class="largeText" VALUE="<cfif isDefined('form.ChangeTypeOther')>#form.ChangeTypeOther#</cfif>">
						</td></tr>
					</table>
				</TD>
			</TR>

			<!--- Reason for Change --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Reason for Change:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<cfloop query="getChangeLogChangeReason">
							<cfif getChangeLogChangeReason.CurrentRow EQ 1 or (getChangeLogChangeReason.CurrentRow-1) mod 3 EQ 0 ><tr></cfif>
							<td class="largeText">
								<input type="checkbox" name="ChangeReasonID#getChangeLogChangeReason.Change_Reason_ID#" class="largeText" <cfif listfind(form.listChangeReason,getChangeLogChangeReason.Change_Reason_ID)>checked="checked"</cfif>>#getChangeLogChangeReason.Change_Reason#
							</td>
							<cfif getChangeLogChangeReason.CurrentRow mod 3 EQ 0 or getChangeLogChangeReason.CurrentRow EQ getChangeLogChangeReason.RecordCount></TR></cfif>
						</cfloop>
					</table>
				</TD>
			</TR>

			<!--- Reason Detail --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Reason Detail:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<cfloop query="getChangeLogReasonDetail">
							<cfif getChangeLogReasonDetail.CurrentRow EQ 1 or (getChangeLogReasonDetail.CurrentRow-1) mod 3 EQ 0 ><tr></cfif>
							<td class="largeText">
								<input type="checkbox" name="ReasonDetailID#getChangeLogReasonDetail.Reason_Detail_ID#" class="largeText" <cfif listfind(form.listReasonDetail,getChangeLogReasonDetail.Reason_Detail_ID)>checked="checked"</cfif>>#getChangeLogReasonDetail.Reason_Detail#
							</td>
							<cfif getChangeLogReasonDetail.CurrentRow mod 3 EQ 0 or getChangeLogReasonDetail.CurrentRow EQ getChangeLogReasonDetail.RecordCount></TR></cfif>
						</cfloop>
						<tr><td class="largeText" colspan="3"><strong>
							If Other:</strong>&nbsp;
							<INPUT TYPE="text" name="ReasonDetailOther" size="67" maxlength="128" class="largeText" VALUE="<cfif isDefined('form.ReasonDetailOther')>#form.ReasonDetailOther#</cfif>">
						</td></tr>
					</table>

				</TD>
			</TR>

			<!--- Additional Relevant Information --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Additional Relevant Information:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<textarea name="AdditionalInformation" cols="130" rows="3" class="largeText"><cfif isDefined("form.AdditionalInformation")>#form.AdditionalInformation#</cfif></textarea>
				</TD>
			</TR>

			<!--- New Milestones --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>New Milestones with Fees:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<textarea name="MilestoneList" cols="130" rows="3" class="largeText"><cfif isDefined("form.MilestoneList")>#form.MilestoneList#</cfif></textarea>
				</TD>
			</TR>

			<!--- Monetary Value of Change --->
			<TR>
				<TD class="largeText" align="right"><strong>Monetary Value of Change:</strong>&nbsp;</TD>
				<TD class="largeText">
					<INPUT type="text" name="ChangeValue" size="30" maxlength="14" class="largeText" value="<cfif isDefined('form.ChangeValue')>#form.ChangeValue#<cfelse>#dollarformat(0)#</cfif>">
				</TD>
			</TR>

			<!--- Assumptions --->
			<TR>
				<TD class="largeText" align="right"><strong>Assumptions:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<INPUT TYPE="text" name="Assumptions" size="67" maxlength="64" class="largeText" VALUE="<cfif isDefined('form.Assumptions')>#form.Assumptions#</cfif>">
				</TD>
			</TR>

			<!--- Period of Performance End Date --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Period of Performance End Date:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<INPUT TYPE="text" name="PerformancePeriodEndDate" size="12" maxlength="10" class="largeText" VALUE="<cfif isDefined('form.PerformancePeriodEndDate')>#form.PerformancePeriodEndDate#</cfif>">
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp2']:document.TaskPopUp2_Position), document.forms.ChangeAdmin.PerformancePeriodEndDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp2_Position" ID="TaskPopUp2_Position" BORDER="0" ALT="Date"></A>
				</TD>
			</TR>

			<!--- Arcadis Portfolio Manager, Date Approved --->
			<TR>
				<TD class="largeText" align="right"><strong>Arcadis Portfolio Manager:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<select name="PortfolioManagerID" class="largeText">
						<option value="0">- select the pm -</option>
						<cfloop query="getPortfolioManagers">
							<option value="#getPortfolioManagers.User_ID#" <cfif isDefined("form.PortfolioManagerID") and form.PortfolioManagerID EQ getPortfolioManagers.User_ID>selected="selected"</cfif>>#getPortfolioManagers.Last_Name#, #getPortfolioManagers.First_Name#</option>
						</cfloop>
					</select>
					&nbsp;
					<strong>Date Approved:</strong>&nbsp;
					<INPUT TYPE="text" name="PortfolioManagerApprovalDate" size="12" maxlength="10" class="largeText" VALUE="<cfif isDefined('form.PortfolioManagerApprovalDate')>#form.PortfolioManagerApprovalDate#</cfif>">
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp3']:document.TaskPopUp3_Position), document.forms.ChangeAdmin.PortfolioManagerApprovalDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp3_Position" ID="TaskPopUp3_Position" BORDER="0" ALT="Date"></A>
				</TD>
			</TR>

			<!--- Approval Description --->
			<TR>
				<TD class="largeText" align="right"><strong>Approval Description:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<INPUT TYPE="text" name="ApprovalDescription" size="129" maxlength="1024" class="largeText" VALUE="<cfif isDefined('form.ApprovalDescription')>#form.ApprovalDescription#</cfif>">
				</TD>
			</TR>

			<!--- Portfolio Operations Project Leads, Date Approved, Amendment --->
			<TR>
				<TD class="largeText" align="right"><strong>Portfolio Operations Project Leads:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<select name="ChevronPMID" class="largeText">
						<option value="0">- select the pm -</option>
						<cfloop query="getChevronPortfolioManagers">
							<option value="#getChevronPortfolioManagers.User_ID#" <cfif isDefined("form.ChevronPMID") and form.ChevronPMID EQ getChevronPortfolioManagers.User_ID>selected="selected"</cfif>>#getChevronPortfolioManagers.Last_Name#, #getChevronPortfolioManagers.First_Name#</option>
						</cfloop>
					</select>
					&nbsp;
					<strong>Date Approved:</strong>&nbsp;
					<INPUT TYPE="text" name="ChevronPMApprovalDate" size="12" maxlength="10" class="largeText" VALUE="<cfif isDefined('form.ChevronPMApprovalDate')>#form.ChevronPMApprovalDate#</cfif>">
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp4']:document.TaskPopUp4_Position), document.forms.ChangeAdmin.ChevronPMApprovalDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp4_Position" ID="TaskPopUp4_Position" BORDER="0" ALT="Date"></A>
					&nbsp;
					<strong>If Change, Which Amendment:</strong>&nbsp;
					<INPUT TYPE="text" name="Amendment" size="43" maxlength="64" class="largeText" VALUE="<cfif isDefined('form.Amendment')>#form.Amendment#</cfif>">
				</TD>
			</TR>

			<!--- Arcadis PM --->
			<TR>
				<TD class="largeText" align="right"><strong>Arcadis Site Manager:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<select name="ArcadisPMID" class="largeText">
						<option value="0">- select a site manager -</option>
						<cfloop query="getSiteManagers">
							<option value="#getSiteManagers.User_ID#" <cfif isDefined("form.ArcadisPMID") and form.ArcadisPMID EQ getSiteManagers.User_ID>selected="selected"</cfif>>#getSiteManagers.Last_Name#, #getSiteManagers.First_Name#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- Reference ID of Email Approval --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Reference ID of Email Approval:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<INPUT TYPE="text" name="EmailReference" size="125" maxlength="128" class="largeText" VALUE="<cfif isDefined('form.EmailReference')>#form.EmailReference#</cfif>">
				</TD>
			</TR>

			<!--- Chevron Approval Status --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Chevron Approval Status:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<select name="ChevronApprovalStatus" class="largeText">
						<option value="">- select the status -</option>
						<option value="S" class="StatSilver" <cfif isDefined("form.ChevronApprovalStatus") and form.ChevronApprovalStatus EQ "S">selected="selected"</cfif>>In Progress</option>
						<option value="Y" class="StatYellow" <cfif isDefined("form.ChevronApprovalStatus") and form.ChevronApprovalStatus EQ "Y">selected="selected"</cfif>>Pending Approval</option>
						<option value="G" class="StatGreen" <cfif isDefined("form.ChevronApprovalStatus") and form.ChevronApprovalStatus EQ "G">selected="selected"</cfif>>Approved by Chevron</option>
						<option value="B" class="StatBlack" <cfif isDefined("form.ChevronApprovalStatus") and form.ChevronApprovalStatus EQ "B">selected="selected"</cfif>>Rejected by Chevron</option>
					</select>
				</TD>
			</TR>

			<!--- Oracle Update --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Oracle Status Notes:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<textarea name="OracleUpdate" cols="130" rows="3" class="largeText"><cfif isDefined("form.OracleUpdate")>#form.OracleUpdate#</cfif></textarea>
				</TD>
			</TR>

			<!--- Oracle Process Status --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Oracle Process Status:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<select name="InternalStatus" class="largeText">
						<option value="">- select the status -</option>
						<option value="G" class="StatGreen" <cfif isDefined("form.InternalStatus") and form.InternalStatus EQ "G">selected="selected"</cfif>>Complete</option>
						<option value="O" class="StatOrange" <cfif isDefined("form.InternalStatus") and form.InternalStatus EQ "O">selected</cfif>>Pending Project Close</option>
						<option value="Y" class="StatYellow" <cfif isDefined("form.InternalStatus") and form.InternalStatus EQ "Y">selected="selected"</cfif>>Needs Follow Up</option>
						<option value="R" class="StatRed" <cfif isDefined("form.InternalStatus") and form.InternalStatus EQ "R">selected="selected"</cfif>>Problem</option>
					</select>
				</TD>
			</TR>

			<!--- Milestone Update Status --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Milestone Update Status:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<select name="MilestoneUpdateStatus" class="largeText">
						<option value="W" class="StatWhite" <cfif isDefined("form.MilestoneUpdateStatus") and form.MilestoneUpdateStatus EQ "">selected="selected"</cfif>>Not Applicable</option>
						<option value="Y" class="StatYellow" <cfif isDefined("form.MilestoneUpdateStatus") and form.MilestoneUpdateStatus EQ "Y">selected="selected"</cfif>>Not Complete</option>
						<option value="R" class="StatRed" <cfif isDefined("form.MilestoneUpdateStatus") and form.MilestoneUpdateStatus EQ "R">selected="selected"</cfif>>Needs Follow Up</option>
						<option value="G" class="StatGreen" <cfif isDefined("form.MilestoneUpdateStatus") and form.MilestoneUpdateStatus EQ "G">selected="selected"</cfif>>Complete</option>
					</select>
				</TD>
			</TR>

			<!--- FCO Document --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>FCO Document:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<input type="File" size="50" name="FCOFileName" maxlength="64" class="fileText">
					<cfif isDefined("getChangeLogInfo.FCO_File_Name") and len(getChangeLogInfo.FCO_File_Name)>
						&nbsp;
						<A HREF="javascript: var n=window.open('components/GetDoc.cfm?editChangeLogID=#form.editChangeLogID#&DocType=ChangeLogV1', '', 'height=700,width=900,resizable')">view the document</A>
						&nbsp;
						<input type="Checkbox" name="FCODocDelete">delete the document
					</cfif>
				</TD>
			</TR>

			<!--- buttons --->
			<tr>
				<td width="20%"></td>
				<td>
					<input type="submit" name="btnUpdateChangeLog" value="Save" class="largeTextButton">
					<input type="submit" name="btnReturn" value="Return" class="largeTextButton" />
				</td>
			</tr>
		</FORM>
	</TABLE>
</cfoutput>
<cfif isDefined("form.edittype") and form.edittype EQ "editChangeLog">
	<script>document.ChangeAdmin.DateLogged.focus();</script>
<cfelse>
	<script>document.ChangeAdmin.AdminSiteID.focus();</script>
</cfif>
