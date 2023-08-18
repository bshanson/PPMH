<!----------------------------------------------------------------------------------------------------------
Description:
	Site Mgt edit page

History:
	2/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<CFModule template="../Components/q_getPage.cfm" WebSite="PPMH" Database="PPMH" Label="FCOs in Process" AccessLevel="4" RETURN="ChangeLogLinkV1">
<CFModule template="../Components/q_getPage.cfm" WebSite="PPMH" Database="PPMH" Label="Closed FCOs" AccessLevel="4" RETURN="ChangeLogLinkV2">
<CFModule template="../Components/q_getPage.cfm" WebSite="PPMH" Database="PPMH" Label="Regulatory" AccessLevel="3" RETURN="RegulatoryLink">
<CFModule template="../Components/q_getPage.cfm" WebSite="PPMH" Database="PPMH" Label="Access / LUC" AccessLevel="3" RETURN="AccessLUCLink">
<CFModule template="../Components/q_getPage.cfm" WebSite="SIMS" Database="SIMS" Label="Site Information" AccessLevel="1" RETURN="SIMSLink">
<CFModule template="../Components/q_getPage.cfm" WebSite="PPMH" Database="PPMH" Label="Public Affairs" AccessLevel="3" RETURN="PublicAffairsLink">

<!--- div hider script --->
<script src="scripts/divHider.js"></script>

<CFSET row = 1>
<cfset errormsg = ArrayNew(1) />
<cfset successmsg = "">
<cfif not isDefined("selectedYear")><cfset selectedYear = dateformat(now(),"yyyy")></cfif>

<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- get months --->
<cfinclude template="../components/q_getMonths.cfm">
<!--- get portfolios --->
<cfinclude template="q_getPortfolios.cfm">
<!--- get max id from milestones --->
<cfinclude template="q_getMilestoneMaxID.cfm">
<!--- get milestones for the site --->
<cfparam name="form.sortType" default="plandate">
<!--- get site info --->
<cfinclude template="q_getSiteInfo.cfm">
<!--- get ERP Stages --->
<cfinclude template="../components/q_getERPStages.cfm">
<!--- get Remedial Technologies --->
<cfinclude template="../components/q_getRemedialTechnologies.cfm">
<!--- get regulatory agencies --->
<cfinclude template="q_getRegulatoryAgencies.cfm">

<!--- replace double quote with single quote, replace < > signs --->
<cfloop collection="#form#" item="name">
	<cfif name NEQ "btnEditStatus.X" and name NEQ "btnEditStatus.Y">
		<cfset "form.#name#" = #replace(evaluate("form.#name#"),chr(34),"'","all")#>
		<cfset "form.#name#" = #replace(evaluate("form.#name#"),"<","&lt;","all")#>
		<cfset "form.#name#" = #replace(evaluate("form.#name#"),">","&gt;","all")#>
	</cfif>
</cfloop>

<!--- update site info --->
<cfif isDefined("form.submitinfo")>
	<cfinclude template="f_errorCheck.cfm">
	<cfif not ArrayLen(errormsg)>
			<!--- edit monthly record --->		
			<cfif isDefined("form.edittype") AND form.edittype EQ "editStatus">
				<cfinclude template="q_updSiteStatus.cfm">
			</cfif>
	
			<!--- add new monthly record --->
			<cfif isDefined("form.edittype") AND form.edittype EQ "addStatus">
				<cfinclude template="q_addSiteStatus.cfm">
			</cfif>
	</cfif>

	<!--- if no error --->
	<cfif not ArrayLen(errormsg)>
		<cfset form.edittype = "editStatus">
		<cfset successmsg = "The information has been updated">
	<cfelse>
		<cfset form.edittype = form.edittype>
		<cfset prjMonth = form.monthtofind>
		<cfif form.edittype EQ "addStatus">
	 		<cfset form.yeartofind = "">
			<cfset form.monthtofind = "">
			<cfset form.periodtofind = "">
		</cfif>
	</cfif>
</cfif>

<cfif not ArrayLen(errormsg)>
	<!--- add a new month status --->
	<cfif form.edittype EQ "addStatus">
		<!--- set prior month info --->
		<cfinclude template="q_getPriorSiteStatusInfo.cfm">
		<cfif isDefined("getPriorSiteStatusInfo.Status_Month") and isNumeric(getPriorSiteStatusInfo.Status_Month)><cfset prjMonth = getPriorSiteStatusInfo.Status_Month+1><cfelse><cfset prjMonth = dateformat(now(),"m")></cfif>
		<cfif isDefined("getPriorSiteStatusInfo.Status_Year") and isNumeric(getPriorSiteStatusInfo.Status_Year)><cfset lastYear = getPriorSiteStatusInfo.Status_Year><cfelse><cfset Status_Year = dateformat(now(),"yyyy")></cfif>
		<cfif not isDefined("lastYear")><cfset lastYear = dateformat(now(),"yyyy")></cfif>
		<cfset selectedYear = lastYear>
		<cfif prjMonth EQ 13>
			<cfset prjMonth = 1>
			<cfset selectedYear = lastYear + 1>
		</cfif>
		<cfif isDefined("form.StatusPortfolioToFind") and form.StatusPortfolioToFind NEQ 0>
			<cfset form.StatusPortfolioID = getPriorSiteStatusInfo.Portfolio_ID>
		<cfelse>
			<cfset form.StatusPortfolioID = getSiteInfo.Portfolio_ID>
		</cfif>
		<cfset form.HS_Loss = getPriorSiteStatusInfo.HS_Loss>
		<cfset form.HS_Near_Loss = getPriorSiteStatusInfo.HS_Near_Loss>
		<cfset form.CurrentQuarterActionItems = getPriorSiteStatusInfo.Current_Quarter_Action_Items_v>
		<cfset form.Milestone_Assumptions = getPriorSiteStatusInfo.Milestone_Assumptions>
		<cfset form.Projected_Change_In_Scope_Issues = getPriorSiteStatusInfo.Projected_Change_In_Scope_Issues>
		<cfset form.Critical_Path = getPriorSiteStatusInfo.Critical_Path>
		<cfset form.ERP_Stage_ID = getPriorSiteStatusInfo.ERP_Stage_ID>
		<cfset form.Remedial_Technology_ID = getPriorSiteStatusInfo.Remedial_Technology_ID>
		<cfset form.Overall_Project_Status = getPriorSiteStatusInfo.Overall_Project_Status>
		<cfset form.Forecast_Quarter = getPriorSiteStatusInfo.Forecast_Quarter>
		<cfset form.Forecast_Year = getPriorSiteStatusInfo.Forecast_Year>
		<cfset form.RegAgencyID = getPriorSiteStatusInfo.Reg_Agency_ID>
<!---		<cfset form.RegulatoryAgency = getPriorSiteStatusInfo.Regulatory_Agency>--->
		<cfset form.AgencyPerson = getPriorSiteStatusInfo.Agency_Person>
		<cfset form.ImportantSiteInfo = getPriorSiteStatusInfo.Important_Site_Info>
		<cfset form.ImportantGWMInfo = getPriorSiteStatusInfo.Important_GWM_Info>
		<cfset form.ImportantLinks = getPriorSiteStatusInfo.Important_Links>
		<cfset form.ERPNotes = getPriorSiteStatusInfo.ERP_Notes>
	</cfif>

	<!--- edit month status --->
	<cfif form.edittype EQ "editStatus">
		<!--- get the monthly info --->
		<cfinclude template="q_getStatusInfo.cfm">
		<cfif isDefined("getStatusInfo.Status_Month") and isNumeric(getStatusInfo.Status_Month)><cfset prjMonth = getStatusInfo.Status_Month+1><cfelse><cfset prjMonth = dateformat(now(),"m")></cfif>
		<cfif isDefined("getStatusInfo.Status_Year") and isNumeric(getStatusInfo.Status_Year)><cfset lastYear = getStatusInfo.Status_Year><cfelse><cfset Status_Year = dateformat(now(),"yyyy")></cfif>
		<cfset selectedYear = lastYear>
		<cfset form.StatusPortfolioID = getStatusInfo.Portfolio_ID>
		<cfset form.HS_Loss = getStatusInfo.HS_Loss>
		<cfset form.HS_Near_Loss = getStatusInfo.HS_Near_Loss>
		<cfset form.CurrentQuarterActionItems = getStatusInfo.Current_Quarter_Action_Items_v>
		<cfset form.Milestone_Assumptions = getStatusInfo.Milestone_Assumptions>
		<cfset form.Projected_Change_In_Scope_Issues = getStatusInfo.Projected_Change_In_Scope_Issues>
		<cfset form.Critical_Path = getStatusInfo.Critical_Path>
		<cfset form.ERP_Stage_ID = getStatusInfo.ERP_Stage_ID>
		<cfset form.Remedial_Technology_ID = getStatusInfo.Remedial_Technology_ID>
		<cfset form.Overall_Project_Status = getStatusInfo.Overall_Project_Status>
		<cfset form.Forecast_Quarter = getStatusInfo.Forecast_Quarter>
		<cfset form.Forecast_Year = getStatusInfo.Forecast_Year>
		<cfset form.RegAgencyID = getStatusInfo.Reg_Agency_ID>
<!---		<cfset form.RegulatoryAgency = getStatusInfo.Regulatory_Agency>--->
		<cfset form.AgencyPerson = getStatusInfo.Agency_Person>
		<cfset form.ImportantSiteInfo = getStatusInfo.Important_Site_Info>
		<cfset form.ImportantGWMInfo = getStatusInfo.Important_GWM_Info>
		<cfset form.ImportantLinks = getStatusInfo.Important_Links>
		<cfset form.ERPNotes = getStatusInfo.ERP_Notes>
	</cfif>
<cfelse>
	<!--- there was an error when upadating --->
	<cfif form.edittype EQ "editStatus">
		<CFQUERY NAME="getMonth" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			select month from WebSite_Admin.dbo.Month where Month_ID = #form.monthtofind#
		</CFQUERY>
	</cfif>
	<cfset selectedYear = dateformat(now(),"yyyy")>
	<cfset form.yeartofind = form.yeartofind>
	<cfset form.monthtofind = form.monthtofind>
	<cfset form.periodtofind = form.periodtofind>
	<cfset form.StatusPortfolioID = form.StatusPortfolioID>
	<cfset form.HS_Loss = form.HS_Loss>
	<cfset form.HS_Near_Loss = form.HS_Near_Loss>
	<cfset form.CurrentQuarterActionItems = form.CurrentQuarterActionItems>
	<cfset form.Milestone_Assumptions = form.Milestone_Assumptions>
	<cfset form.Projected_Change_In_Scope_Issues = form.Projected_Change_In_Scope_Issues>
	<cfset form.Critical_Path = form.Critical_Path>
	<cfset form.ERP_Stage_ID = form.ERP_Stage_ID>
	<cfset form.Remedial_Technology_ID = form.Remedial_Technology_ID>
	<cfset form.Overall_Project_Status = form.Overall_Project_Status>
	<cfset form.Forecast_Quarter = form.Forecast_Quarter>
	<cfset form.Forecast_Year = form.Forecast_Year>
	<cfset form.RegAgencyID = form.RegAgencyID>
<!---	<cfset form.RegulatoryAgency = form.RegulatoryAgency>--->
	<cfset form.AgencyPerson = form.AgencyPerson>
	<cfset form.ImportantSiteInfo = form.ImportantSiteInfo>
	<cfset form.ImportantGWMInfo = form.ImportantGWMInfo>
	<cfset form.ImportantLinks = form.ImportantLinks>
	<cfset form.ERPNotes = form.ERPNotes>
</cfif>

<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR><td class="largeText"></td></TR>
	<TR><TD class="largeText"><strong>Monthly Status</strong></TD></TR>
	<TR>
		<td class="largeText">
			<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
				<tr>
					<td class="largeText" width="1%"><li></li></td>
					<td class="largeText">Use this page to administer the monthly status information. Enter/edit the information and click the <strong>submit information</strong> button at the bottom of the page.</td>
					<td class="largeText" width="2%"></td>
				</tr>
				<tr>
					<td class="largeText"><li></li></td>
					<td class="largeText">If this is a new monthly record, select the appropriate month and year. Once a new monthly record is saved, the month and year cannot be changed.</td>
					<td class="largeText"></td>
				</tr>
				<tr valign="top">
					<td class="largeText"><li></li></td>
					<td class="largeText">To edit milestone information, click the pencil icon to open the <strong>Milestone Status</strong> page.</td>
					<td class="largeText"></td>
				</tr>
				<tr valign="top">
					<td class="largeText"><li></li></td>
					<td class="largeText">Milestone listings in the grid may be sorted by <strong>ERP</strong>, <strong>Milestone</strong>, or <strong>Plan Date</strong>. By default, the information is listed in alphabetical order by milestone. Sorting the milestone records will refresh the page but <strong>not</strong> submit any status information changes.</td>
					<td class="largeText"></td>
				</tr>
				<tr valign="top">
					<td class="largeText"><li></li></td>
					<td class="largeText"><strong>Plan Dates</strong> highlighted in orange indicate an upcoming or possibly late milestone <strong>Plan Date</strong>. <strong>Plan Dates</strong> highlighted in red indicate a late milestone <strong>Plan Date</strong>.</td>
					<td class="largeText"></td>
				</tr>
			</table>
		</td>
	</TR>
	<TR><td class="largeText"><hr color="##0083a9"></td></TR>
</TABLE>

<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#F0F0F0">
	<cfif not isDefined("selectedYear")><cfset selectedYear = dateformat(now(),"yyyy")></cfif>
	<cfif not isDefined("prjMonth")><cfset prjMonth = 1></cfif>
	<cfif not isDefined("form.HS_Loss")><cfset form.HS_Loss = ""></cfif>
	<cfif not isDefined("form.HS_Near_Loss")><cfset form.HS_Near_Loss = ""></cfif>
	<cfif not isDefined("form.CurrentQuarterActionItems")><cfset form.CurrentQuarterActionItems = ""></cfif>
	<cfif not isDefined("form.Milestone_Assumptions")><cfset form.Milestone_Assumptions = ""></cfif>
	<cfif not isDefined("form.Projected_Change_In_Scope_Issues")><cfset form.Projected_Change_In_Scope_Issues = ""></cfif>
	<cfif not isDefined("form.Critical_Path")><cfset form.Critical_Path = ""></cfif>
	<cfparam name="form.Overall_Project_Status" default="">

	<cfoutput>
		<FORM NAME="StatusAdmin" METHOD="POST" ACTION="" enctype="multipart/form-data" onsubmit="return formCheck(#getMilestoneMaxID.MaxID#);">
			<!--- scrub url input for XSS --->
			<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.sorttype")><input type="hidden" name="sorttype" value="#form.sorttype#" /></cfif>
			<cfif isDefined("form.AdminSiteID")><input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#" /></cfif>
			<cfif isDefined("form.yeartofind")><input type="hidden" name="yeartofind" value="#form.yeartofind#" /></cfif>
			<cfif isDefined("form.monthtofind")><input type="hidden" name="monthtofind" value="#form.monthtofind#" /></cfif>
			<cfif isDefined("form.periodtofind")><input type="hidden" name="periodtofind" value="#form.periodtofind#" /></cfif>
			<input type="hidden" name="edittype" value="#form.edittype#" />
			<cfloop query="getRegions">
				<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
					<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
				</cfif>
			</cfloop>
			<cfif isDefined("form.siteidtofind")><input type="hidden" name="siteidtofind" value="#form.siteidtofind#" /></cfif>
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
			<cfif isDefined("form.editStatusID")><input type="Hidden" name="editStatusID" value="#form.editStatusID#"></cfif>

			<!--- Site --->
			<TR>
				<TD class="largeText" width="18%"><strong>Site ID:</strong>&nbsp;#getSiteInfo.Site_ID#</TD>
				<TD class="largeText" width="26%"><strong>Site Name:</strong>&nbsp;#getSiteInfo.Site_Name#</TD>
				<TD class="largeText" width="28%"><strong>Address:</strong>&nbsp;#getSiteInfo.Address#, #getSiteInfo.City#, #getSiteInfo.State_Abbreviation#</TD>
				<TD class="largeText" width="28%"><strong>Site Manager:</strong>&nbsp;<cfif len(getSiteInfo.User_id)>#getSiteInfo.Last_Name#, #getSiteInfo.First_Name#</cfif></TD>
			</TR>
			<!--- portfolio --->
			<TR>
				<TD class="largeText"><strong>Portfolio:</strong>&nbsp;#getSiteInfo.Portfolio#</TD>
				<TD class="largeText"><strong>Portfolio Region:</strong>&nbsp;#getSiteInfo.Region#</TD>
				<cfset oerbFlag = "No">
				<cfif getSiteInfo.Inside_OERB EQ "1"><cfset oerbFlag = "Yes"></cfif>
				<TD class="largeText"><strong>Inside OERB:</strong>&nbsp;#oerbFlag#</TD>
				<TD class="largeText"><strong>Deputy:</strong>&nbsp;#getSiteInfo.Deputy#</TD>
			</TR>
			<!--- year --->
			<TR>
				<TD class="largeText">
					<strong>Year:</strong>&nbsp;
					<cfif form.edittype EQ "editStatus" and isDefined('getStatusInfo.Status_Year')>#getStatusInfo.Status_Year#
					<cfelseif form.edittype EQ "editStatus" and isDefined('form.yeartofind') and form.yeartofind NEQ "">#form.yeartofind#
					<cfelse>
						<select name="yeartofind" class="largeText">
							<cfloop from="2019" to="2030" index="yr">
								<option value="#yr#" <cfif yr EQ selectedYear>selected="selected"</cfif>>#yr#</option>
							</cfloop>
						</select>
					</cfif>
				</TD>
				<TD class="largeText">
					<strong>Month:</strong>&nbsp;
					<cfif form.edittype EQ "editStatus" and isDefined('getStatusInfo.Month')>#getStatusInfo.Month#
					<cfelseif form.edittype EQ "editStatus" and isDefined('form.monthtofind') and form.monthtofind NEQ "">#getmonth.month#
					<cfelse>
					<select name="monthtofind" class="largeText">
						<cfloop query="getMonths">
							<option value="#getMonths.Month_ID#" <cfif isDefined("prjMonth") and prjMonth EQ getMonths.Month_ID>selected="selected"</cfif>>#getMonths.Month#</option>
						</cfloop>
					</select>
					</cfif>
				</TD>
				<TD class="largeText" colspan="2">
					<strong>Status Portfolio:</strong>&nbsp;
					<select name="StatusPortfolioID" class="largeText">
						<option value="0" <cfif isDefined("form.StatusPortfolioID") and form.StatusPortfolioID EQ "0">selected="selected"</cfif>>- select a portfolio -</option>
						<cfloop query="getPortfolios">
							<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.StatusPortfolioID") and form.StatusPortfolioID EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- Ops, OE Contact --->
			<TR>
				<cfset OpsLead = "">
				<cfif len(getSiteInfo.Chevron_PM_ID) and getSiteInfo.Chevron_PM_ID EQ 999999><cfset OpsLead = "Not Applicable"></cfif>
				<cfif len(getSiteInfo.Chevron_PM_ID) and getSiteInfo.Chevron_PM_ID NEQ 999999><cfset OpsLead = getSiteInfo.Ops_Lead></cfif>
				<TD class="largeText">
					<strong>Ops Lead:</strong>&nbsp;#OpsLead#
				</TD>
				<cfset OEContact = "">
				<cfif len(getSiteInfo.OE_Team_Contact_ID) and getSiteInfo.OE_Team_Contact_ID EQ 999999><cfset OEContact = "Not Applicable"></cfif>
				<cfif len(getSiteInfo.OE_Team_Contact_ID) and getSiteInfo.OE_Team_Contact_ID NEQ 999999><cfset OEContact = getSiteInfo.OE_Contact></cfif>
				<TD class="largeText">
					<strong>OE Team Contact:</strong>&nbsp;#OEContact#
				</TD>
				<TD class="largeText"></TD>
				<TD class="largeText"></TD>
			</TR>
			<!--- agency --->
			<TR>
				<TD class="largeText" colspan="3">
					<strong>Reg Agency:</strong>&nbsp;
					<select name="RegAgencyID" class="largeText">
						<option value="0" <cfif isDefined("form.RegAgencyID") and form.RegAgencyID EQ "0">selected="selected"</cfif>>- select a regulatory agency -</option>
						<cfloop query="getRegulatoryAgencies">
							<option value="#getRegulatoryAgencies.Reg_Agency_ID#" <cfif isDefined("form.RegAgencyID") and form.RegAgencyID EQ getRegulatoryAgencies.Reg_Agency_ID>selected="selected"</cfif>>#getRegulatoryAgencies.Reg_Agency#</option>
						</cfloop>
					</select>
				</TD>
				<TD class="largeText">
					<strong>Agency Contact:</strong>&nbsp;
					<INPUT TYPE="Text" NAME="AgencyPerson" SIZE="27" MAXLENGTH="128" CLASS="largeText" value="#form.AgencyPerson#">
				</TD>
			</TR>

			<!--- Attorney_Engagement --->
			<cfif getSiteInfo.Attorney_Engagement EQ 1>
				<TR>
					<TD class="errorText" colspan="4" align="center">*** This Site is Subject to Attorney Engagement or Work Product ***</td>
				</TR>
			</cfif>
</TABLE>

<!--- database update message --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
	<cfif ArrayLen(errormsg)><TR><TD class="errorText" align="center">
	There were errors, please review the following:<br>
	<cfloop index="intError"from="1"to="#ArrayLen(errormsg)#"step="1">
		<li>#errormsg[intError]#</li>
	</cfloop>
	</TD></TR>
	<cfelseif successmsg NEQ ""><TR><TD class="successText" align="center"><div id="msg">*** #successmsg# ***</div></TD></TR>
	<cfelse><TR><TD class="successText" align="center">&nbsp;</TD></TR>
	</cfif>
</TABLE>

<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##FFFFCC">
	<!--- forecast quarter & year --->
	<TR valign="top">
		<TD class="largeText" colspan="2">
			<strong>Forecast Closure Quarter:</strong>&nbsp;
			<select name="Forecast_Quarter" class="largeText">
				<option value="0">- select -</option>
				<cfloop from="1" to="4" index="qtr">
					<option value="#qtr#" <cfif qtr EQ #form.Forecast_Quarter#>selected="selected"</cfif>>Q#qtr#</option>
				</cfloop>
			</select>
			&nbsp;
			<strong>Forecast Closure Year:</strong>&nbsp;
			<select name="Forecast_Year" class="largeText">
				<option value="0">- select -</option>
				<cfloop from="2019" to="2030" index="yr">
					<option value="#yr#" <cfif yr EQ #form.Forecast_Year#>selected="selected"</cfif>>#yr#</option>
				</cfloop>
			</select>
		</TD>
	</TR>

	<!--- health safety info --->
	<TR>
		<TD class="largeText" width="50%" valign="top">
			<strong>Health &amp; Safety Loss:</strong><br />
			<textarea name="HS_Loss" cols="80" rows="1" class="largeText">#form.HS_Loss#</textarea>
		</TD>
		<TD class="largeText" width="50%" valign="top">
			<strong>Health &amp; Safety Near Loss:</strong><br />
			<textarea name="HS_Near_Loss" cols="80" rows="1" class="largeText">#form.HS_Near_Loss#</textarea>
		</TD>
	</TR>

	<!--- Current Action Items, Milestone Assumptions --->
	<TR>
		<TD class="largeText" width="50%">
			<strong>Current Action Items (please update):</strong><br />
			<textarea name="CurrentQuarterActionItems" cols="80" rows="5" class="largeText">#form.CurrentQuarterActionItems#</textarea>
		</TD>
		<TD class="largeText" width="50%">
			<strong>Milestone Assumptions:</strong><br />
			<textarea name="Assumptions" cols="80" rows="5" class="largeText">#form.Milestone_Assumptions#</textarea>
			<input type="hidden" name="Milestone_Assumptions" value="#form.Milestone_Assumptions#">
		</TD>
	</TR>
	
	<!--- Projected Change In Scope --->
	<TR valign="top">
		<TD class="largeText" width="50%">
			<strong>Projected Change In Scope / Issues (please update):</strong><br />
			<textarea name="Projected_Change_In_Scope_Issues" cols="80" rows="5" class="largeText">#form.Projected_Change_In_Scope_Issues#</textarea>
		</TD>
		<TD class="largeText" width="50%" valign="top">
			<cfset vCriticalPath = "Endpoint">
			<cfif getSiteInfo.Portfolio_ID EQ 39><cfset vCriticalPath = "Closure"></cfif>
			<strong>Critical Path to #vCriticalPath#:</strong><br />
			<textarea name="Critical_Path" cols="80" rows="5" class="largeText">#form.Critical_Path#</textarea>
		</TD>
	</TR>

	<!--- Important Site Info --->
	<TR valign="top">
		<TD class="largeText" width="50%">
			<strong>Important Site Info:</strong><br />
			<textarea name="ImportantSiteInfo" cols="80" rows="2" class="largeText">#form.ImportantSiteInfo#</textarea>
		</TD>
		<TD class="largeText" width="50%" valign="top">
			<strong>Important Site GWM Info:</strong><br />
			<textarea name="ImportantGWMInfo" cols="80" rows="2" class="largeText">#form.ImportantGWMInfo#</textarea>
		</TD>
	</TR>

	<!--- Current ERP Stage --->
	<TR valign="top">
		<TD class="largeText" width="50%">
			<strong>Important Links:</strong><br />
			<textarea name="ImportantLinks" cols="80" rows="2" class="largeText">#form.ImportantLinks#</textarea>
			<br>
			<br>
			<strong>Current ERP Stage:</strong>&nbsp;
			<select name="ERP_Stage_ID" class="largeText">
				<option value="0">- select the current erp stage -</option>
				<cfloop query="getERPStages">
					<option class="#getERPStages.ERP_Class#" value="#getERPStages.ERP_Stage_ID#" <cfif isDefined("form.ERP_Stage_ID") and form.ERP_Stage_ID EQ getERPStages.ERP_Stage_ID>Selected</cfif>>#getERPStages.ERP_Stage#</option>
				</cfloop>
			</select>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="Site_Mgt/Documents/ERP_Phases.pdf" class="largeText" target="_blank">view the ERP Stages diagram</a> 
			<br>
			<strong>ERP Stage Notes:</strong><br>
			<textarea name="ERPNotes" cols="80" rows="1" class="largeText">#form.ERPNotes#</textarea>
			<br>
			<br>
			<strong>Remedial Technology:</strong>&nbsp;
			<select name="Remedial_Technology_ID" class="largeText">
				<option value="0">- select the remedial technology -</option>
				<cfloop query="getRemedialTechnologies">
					<option class="largeText" value="#getRemedialTechnologies.Remedial_Technology_ID#" <cfif isDefined("form.Remedial_Technology_ID") and form.Remedial_Technology_ID EQ getRemedialTechnologies.Remedial_Technology_ID>Selected</cfif>>#getRemedialTechnologies.Remedial_Technology#</option>
				</cfloop>
			</select>
		</TD>
		<TD class="largeText" width="50%">
			<strong>Overall Project Status:</strong>&nbsp;
			<select name="Overall_Project_Status" class="largeText">
				<option value="" <cfif form.Overall_Project_Status EQ "">Selected</cfif>>- select -</option>
				<option value="G" class="ProjStatGreen" <cfif form.Overall_Project_Status EQ "G">Selected</cfif>>On Track</option>
				<option value="Y" class="ProjStatYellow" <cfif form.Overall_Project_Status EQ "Y">Selected</cfif>>At Risk</option>
				<option value="R" class="ProjStatRed" <cfif form.Overall_Project_Status EQ "R">Selected</cfif>>Late</option>
			</select>
			<br>
			<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1">
				<tr>
					<td class="largeText"><i>On Track: Forecast closure same as or earlier than planned closure.</i></td>
				</tr>
				<tr>
					<td class="largeText"><i>At Risk: Forecast closure later than planned closure (planned closure date still in future), but before period of performance end date.</i></td>
				</tr>
				<tr>	
					<td class="largeText"><i>Late: Planned closure date is past, or Forecast closure past period of performance end date.</i></td>
				</tr>
			</TABLE>
		</TD>
	</TR>
</TABLE>

<!--- spacer --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff"><tr><td></td></tr></TABLE>

<!--- buttons --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
	<TR align="center">
		<TD>
			<input type="submit" value="submit information" class="FormBodyButton" name="submitinfo">
			<input type="submit" value="return to site management page" class="FormBodyButton" name="btnReturn">
		</TD>
	</TR>
		</FORM>
</TABLE>

<!--- spacer --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff"><tr><td></td></tr></TABLE>

<!--- set thisPeriod --->
<cfif isDefined("form.periodtofind") and len(form.periodtofind)>
	<cfset thisPeriod = form.periodtofind>
<cfelse>
	<cfif isDefined("selectedYear")><cfif len(prjMonth) EQ 1><cfset prjMonth = "0" & prjMonth></cfif><cfset thisPeriod = selectedYear & prjMonth></cfif>
</cfif>

<!--- Change Logs for site --->
<cfmodule template="q_getClosedChangeLogs.cfm" AdminSiteID="#form.AdminSiteID#" StatusPortfolioID="#form.StatusPortfolioID#" Return="getClosedChangeLogs">
<cfmodule template="q_getOpenChangeLogs.cfm" AdminSiteID="#form.AdminSiteID#" StatusPortfolioID="#form.StatusPortfolioID#" Return="getOpenChangeLogs">
<cfset r = 0>
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
	<tr height="20"><td width="100%" class="ListHeaderBlue" align="center">Change Logs</td></tr>
	<tr>
		<TD width="100%" align="center" valign="top">
			<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999">
				<!--- Change Logs --->
				<cfif getClosedChangeLogs.RecordCount NEQ 0 or getOpenChangeLogs.RecordCount NEQ 0>
					<tr valign="top">
						<TD class="accountTextBold" align="center" width="3%"></td>
						<TD class="accountTextBold" align="center" width="7%">Status</td>
						<TD class="accountTextBold" align="center" width="5%">Log ID</td>
						<TD class="accountTextBold" align="center" width="9%">Finalized Date</td>
						<TD class="accountTextBold" align="center" width="39%">Milestone Info</td>
						<TD class="accountTextBold" align="center" width="10%">Final Approved Change Value</td>
						<TD class="accountTextBold" align="center" width="7%">View FCO</td>
						<TD class="accountTextBold" align="center" width="10%">FCO Status</td>
						<TD class="accountTextBold" align="center" width="10%">Milestone Update Status</td>
					</tr>
					<cfloop query="getClosedChangeLogs">
						<tr valign="top">
							<!--- view --->
							<TD class="row#r#" align="center"><a href="#ChangeLogLinkV2#&CLID=#getClosedChangeLogs.Actual_Change_Log_ID#&SID=#getClosedChangeLogs.Admin_Site_ID#" target="_blank">view</a></TD>
							<!--- status --->
							<TD class="row#r#" align="center">Finalized</TD>
							<!--- Change Log ID --->
							<TD class="row#r#" align="center">#getClosedChangeLogs.Actual_Change_Log_ID#</TD>
							<!--- Finalized Date --->
							<CFModule template="q_getFinalizedDate.cfm" CLID="#getClosedChangeLogs.Change_Log_ID#" VER="#getClosedChangeLogs.fco_type#" Return="getFinalizedDate">
							<TD class="row#r#" align="center">#dateformat(getFinalizedDate.Finalized_Date,"mm/dd/yyyy")#</TD>
							<!--- Milestone --->
							<CFModule template="q_getFCOMilestones.cfm" CLID="#getClosedChangeLogs.Change_Log_ID#" VER="#getClosedChangeLogs.fco_type#" Return="FCOMilestones">
							<TD class="row#r#">
								<SPAN TITLE="#FCOMilestones#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(FCOMilestones,77)#<cfif len(FCOMilestones) GT 77>...</cfif></SPAN>								
							</TD>
							<!--- Change Value --->
							<cfset value = getClosedChangeLogs.Draft_Change_Value>
							<cfif getClosedChangeLogs.fco_type EQ "v2">
								<CFModule template="../Change_Log/q_getChangeValue.cfm" CLID="#getClosedChangeLogs.Change_Log_ID#" Return="ChangeValue">
								<cfset value = ChangeValue>
							</cfif>
							<TD class="row#r#" align="center">#dollarformat(Value)#</TD>
							<!--- FCO document --->
							<TD class="row#r#" align="center">
								<cfif len(getClosedChangeLogs.CompiledFCO)>
									<A HREF="javascript: var n=window.open('components/GetDoc.cfm?editChangeLogID=#getClosedChangeLogs.Change_Log_ID#&DocType=ChangeLog#getClosedChangeLogs.FCO_Type#', '', 'height=700,width=900,resizable')">view FCO</A>
								</cfif>
							</TD>
							<!--- FCO Status --->
							<cfif getClosedChangeLogs.Chevron_Approval_Status EQ "S"><cfset CASClass = "ReportBodyOrange"><cfset ChevronApprovalStatus = "In Progress">
							<cfelseif getClosedChangeLogs.Chevron_Approval_Status EQ "Y"><cfset CASClass = "ReportBodyBlue"><cfset ChevronApprovalStatus = "Pending Approval">
							<cfelseif getClosedChangeLogs.Chevron_Approval_Status EQ "G"><cfset CASClass = "ReportBodyGreen"><cfset ChevronApprovalStatus = "Approved by Chevron">
							<cfelseif getClosedChangeLogs.Chevron_Approval_Status EQ "B"><cfset CASClass = "ReportBodyGrey"><cfset ChevronApprovalStatus = "Rejected by Chevron">
							<cfelse><cfset CASClass = "ReportBody#r#"><cfset ChevronApprovalStatus = getClosedChangeLogs.Chevron_Approval_Status>
							</cfif>
							<cfif ChevronApprovalStatus EQ "Approved by Chevron"><cfset CASClass = "ReportBodyGreen">
							<cfelseif ChevronApprovalStatus EQ "Finalized"><cfset CASClass = "ReportBodyGrey">
							</cfif>
							<TD class="#CASClass#" align="center">#ChevronApprovalStatus#</TD>
							<!--- Milestone Update Status --->
							<cfif getClosedChangeLogs.Milestone_Update_Status EQ "R"><cfset MUSClass = "ReportBodyYellow"><cfset MilestoneUpdateStatus = "Needs Follow Up">
							<cfelseif getClosedChangeLogs.Milestone_Update_Status EQ "Y"><cfset MUSClass = "ReportBodyOrange"><cfset MilestoneUpdateStatus = "Not Complete">
							<cfelseif getClosedChangeLogs.Milestone_Update_Status EQ "G"><cfset MUSClass = "ReportBodyGreen"><cfset MilestoneUpdateStatus = "Complete">
							<cfelseif getClosedChangeLogs.Milestone_Update_Status EQ "W"><cfset MUSClass = "ReportBodyBlue"><cfset MilestoneUpdateStatus = "Not Applicable">
							<cfelse><cfset MUSClass = "ReportBody#r#"><cfset MilestoneUpdateStatus = "">
							</cfif>
							<TD class="#MUSClass#" align="center">#MilestoneUpdateStatus#</TD>
						</tr>
						<cfset r = 1-r>
					</cfloop>
					<cfloop query="getOpenChangeLogs">
						<tr valign="top">
							<!--- view --->
							<TD class="row#r#" align="center"><a href="#ChangeLogLinkV1#&CLID=#getOpenChangeLogs.Change_Log_ID#&SID=#getOpenChangeLogs.Admin_Site_ID#" target="_blank">view</a></TD>
							<!--- status --->
							<TD class="row#r#" align="center">In Progress</TD>
							<!--- Change Log ID --->
							<TD class="row#r#" align="center">#getOpenChangeLogs.Actual_Change_Log_ID#</a></TD>
							<!--- Date_Logged --->
							<TD class="row#r#" align="center"></TD>
							<!--- Milestone --->
							<TD class="row#r#">
								<cfif isDefined("FCOMilestones")>
									<SPAN TITLE="#FCOMilestones#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'"></SPAN>
								</cfif>
							</TD>
							<!--- Change Value --->
							<TD class="row#r#" align="center"></TD>
							<!--- FCO document --->
							<TD class="row#r#" align="center">
								<cfif len(getOpenChangeLogs.CompiledFCO)>
									<A HREF="javascript: var n=window.open('components/GetDoc.cfm?editChangeLogID=#getOpenChangeLogs.Change_Log_ID#&DocType=ChangeLog#getOpenChangeLogs.FCO_Type#', '', 'height=700,width=900,resizable')">view FCO</A>
								</cfif>
							</TD>
							<!--- FCO Status --->
							<cfif getOpenChangeLogs.Chevron_Approval_Status EQ "S"><cfset CASClass = "ReportBodyOrange"><cfset ChevronApprovalStatus = "In Progress">
							<cfelseif getOpenChangeLogs.Chevron_Approval_Status EQ "Y"><cfset CASClass = "ReportBodyBlue"><cfset ChevronApprovalStatus = "Pending Approval">
							<cfelseif getOpenChangeLogs.Chevron_Approval_Status EQ "G"><cfset CASClass = "ReportBodyGreen"><cfset ChevronApprovalStatus = "Approved by Chevron">
							<cfelseif getOpenChangeLogs.Chevron_Approval_Status EQ "B"><cfset CASClass = "ReportBodyGrey"><cfset ChevronApprovalStatus = "Rejected by Chevron">
							<cfelse><cfset CASClass = "ReportBody#r#"><cfset ChevronApprovalStatus = getOpenChangeLogs.Chevron_Approval_Status>
							</cfif>
							<cfif ChevronApprovalStatus EQ "Approved by Chevron"><cfset CASClass = "ReportBodyGreen">
							<cfelseif ChevronApprovalStatus EQ "Finalized"><cfset CASClass = "ReportBodyGrey">
							</cfif>
							<TD class="#CASClass#" align="center">#ChevronApprovalStatus#</TD>
							<!--- Milestone Update Status --->
							<cfif getOpenChangeLogs.Milestone_Update_Status EQ "R"><cfset MUSClass = "ReportBodyYellow"><cfset MilestoneUpdateStatus = "Needs Follow Up">
							<cfelseif getOpenChangeLogs.Milestone_Update_Status EQ "Y"><cfset MUSClass = "ReportBodyOrange"><cfset MilestoneUpdateStatus = "Not Complete">
							<cfelseif getOpenChangeLogs.Milestone_Update_Status EQ "G"><cfset MUSClass = "ReportBodyGreen"><cfset MilestoneUpdateStatus = "Complete">
							<cfelseif getOpenChangeLogs.Milestone_Update_Status EQ "W"><cfset MUSClass = "ReportBodyBlue"><cfset MilestoneUpdateStatus = "Not Applicable">
							<cfelse><cfset MUSClass = "ReportBody#r#"><cfset MilestoneUpdateStatus = "">
							</cfif>
							<TD class="#MUSClass#" align="center">#MilestoneUpdateStatus#</TD>
						</tr>
						<cfset r = 1-r>
					</cfloop>
				<cfelse>
					<!--- no change logs --->
					<tr valign="top"><TD class="row#r#" colspan="9" align="center"><i>there are no change logs for this site</i></td></tr>
				</cfif>
			</TABLE>
		</td>
	</tr>
</TABLE>
	
<!--- Advocacy for site --->
<cfmodule template="q_getRegulatory.cfm" AdminSiteID="#form.AdminSiteID#" Return="getRegulatory">
<cfmodule template="q_getAccessLUC.cfm" AdminSiteID="#form.AdminSiteID#" Return="getAccessLUC">
<cfmodule template="q_getPublicAffairs.cfm" AdminSiteID="#form.AdminSiteID#" Return="getPublicAffairs">
<cfset r = 0>
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
	<tr height="20"><td width="100%" class="ListHeaderBlue" align="center">Advocacy</td></tr>
	<tr>
		<TD width="100%" align="center" valign="top">
			<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999">
				<cfif (getRegulatory.RecordCount NEQ 0) or (getAccessLUC.RecordCount NEQ 0) or (getPublicAffairs.RecordCount NEQ 0)>
					<!--- Regulatory --->
					<cfif getRegulatory.RecordCount NEQ 0>
						<cfloop query="getRegulatory">
							<tr valign="top">
								<!--- Advocacy Type --->
								<TD class="row#r#" width="4%" align="right"><strong>Type:</strong>&nbsp;</td>
								<TD class="row#r#" width="7%"><a href="#RegulatoryLink#&RID=#getRegulatory.Regulatory_ID#" target="_blank">Regulatory</a></TD>
								<!--- Type of Change --->
								<TD class="row#r#" width="12%" align="right"><strong>Action:</strong>&nbsp;</td>
								<TD class="row#r#" width="46%"><SPAN TITLE="#getRegulatory.Regulatory_Action#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getRegulatory.Regulatory_Action,80)#<cfif len(getRegulatory.Regulatory_Action) GT 80>...</cfif></SPAN></TD>
								<!--- Date --->
								<TD class="row#r#" width="5%" align="right"><strong>Date:</strong>&nbsp;</td>
								<TD class="row#r#" width="8%">#dateformat(getRegulatory.Regulatory_Date,"mm/dd/yyyy")#</TD>
								<!--- Complete --->
								<TD class="row#r#" width="10%" align="right"><strong>Complete Date:</strong>&nbsp;</td>
								<TD class="row#r#" width="8%"><cfif len(getRegulatory.Complete_Date)>#dateformat(getRegulatory.Complete_Date,"mm/dd/yyyy")#<cfelse>&nbsp;</cfif></TD>
							</tr>
							<cfset r = 1-r>
						</cfloop>
					</cfif>
					<!--- Access LUC --->
					<cfif getAccessLUC.RecordCount NEQ 0>
						<cfloop query="getAccessLUC">
							<tr valign="top">
								<!--- Advocacy Type --->
								<TD class="row#r#" align="right"><strong>Type:</strong>&nbsp;</td>
								<TD class="row#r#"><a href="#AccessLUCLink#&ALID=#getAccessLUC.AccessLUC_ID#" target="_blank">Access/LUC</a></TD>
								<!--- Type of Change --->
								<TD class="row#r#" align="right"><strong>SPL Notes:</strong>&nbsp;</td>
								<TD class="row#r#" colspan="3"><SPAN TITLE="#getAccessLUC.SPL_Notes#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getAccessLUC.SPL_Notes,100)#<cfif len(getAccessLUC.SPL_Notes) GT 100>...</cfif></SPAN></TD>
								<!--- Complete --->
								<TD class="row#r#" align="right"><strong>Complete Date:</strong>&nbsp;</td>
								<TD class="row#r#" width="8%"><cfif len(getAccessLUC.Complete_Date)>#dateformat(getAccessLUC.Complete_Date,"mm/dd/yyyy")#<cfelse>&nbsp;</cfif></TD>
							</tr>
							<cfset r = 1-r>
						</cfloop>
					</cfif>
					<!--- Public Affairs --->
					<cfif getPublicAffairs.RecordCount NEQ 0>
						<cfloop query="getPublicAffairs">
							<tr valign="top">
								<!--- Advocacy Type --->
								<TD class="row#r#" align="right"><strong>Type:</strong>&nbsp;</td>
								<TD class="row#r#"><a href="#PublicAffairsLink#&PAID=#getPublicAffairs.Public_Affairs_ID#" target="_blank">Public Affairs</a></TD>
								<!--- Assessment Date --->
								<TD class="row#r#" align="right"><strong>Assessment Date:</strong>&nbsp;</td>
								<TD class="row#r#">#dateformat(getPublicAffairs.Assessment_Date,"mm/dd/yyyy")#</TD>
								<!--- action --->
								<cfset action = "">
								<cfset actionCnt = 0>
								<cfset evaluate("actionClass = 'row#r#'")>
								<cfif getPublicAffairs.Q1 EQ 1><cfset actionCnt = actionCnt+1></cfif>
								<cfif getPublicAffairs.Q2 EQ 1><cfset actionCnt = actionCnt+1></cfif>
								<cfif getPublicAffairs.Q3 EQ 1><cfset actionCnt = actionCnt+1></cfif>
								<cfif getPublicAffairs.Q4 EQ 1><cfset actionCnt = actionCnt+1></cfif>
								<cfif getPublicAffairs.Q5 EQ 1><cfset actionCnt = actionCnt+1></cfif>
								<cfif getPublicAffairs.Q6 EQ 1><cfset actionCnt = actionCnt+1></cfif>
								<cfif actionCnt LTE 1><cfset action = "Monitor"><cfset actionClass = "StatGreen"></cfif>
								<cfif actionCnt EQ 2><cfset action = "Consult reqd"><cfset actionClass = "StatYellow"></cfif>
								<cfif actionCnt GTE 3><cfset action = "Assmnt reqd"><cfset actionClass = "StatRed"></cfif>
								<TD class="row#r#" align="right"><strong>Action:</strong>&nbsp;</td>
								<TD class="#actionClass#" align="center">#action#</TD>
								<!--- Comments Date --->
								<TD class="row#r#" align="right"><strong>Comments Date:</strong>&nbsp;</td>
								<TD class="row#r#" width="8%"><cfif len(getPublicAffairs.Comments_Date)>#dateformat(getPublicAffairs.Comments_Date,"mm/dd/yyyy")#<cfelse>&nbsp;</cfif></TD>
							</tr>
							<cfset r = 1-r>
						</cfloop>
					</cfif>
				<cfelse>
					<!--- no logs --->
					<tr valign="top"><TD class="row#r#" colspan="4" align="center"><i>there are no entries for this site</i></td></tr>
				</cfif>
			</TABLE>
		</td>
	</tr>
</TABLE>

<!--- SIMS link & projects for site --->
<cfmodule template="q_getSIMS.cfm" AdminSiteID="#form.AdminSiteID#" Return="getSIMS">
<cfmodule template="q_getProjects.cfm" AdminSiteID="#form.AdminSiteID#" PID="#form.StatusPortfolioID#" Return="getProjects">
<cfset r = 0>
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
	<tr height="20"><td width="100%" class="ListHeaderBlue" align="center">SIMS / Projects</td></tr>
	<tr>
		<TD width="100%" align="center" valign="top">
			<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999">
				<!--- SIMS --->
				<cfif getProjects.RecordCount NEQ 0>
					<tr valign="top">
						<TD class="accountTextBold" align="center" width="10%">SIMS</td>
						<TD class="accountTextBold" align="center" width="15%">Project Number</td>
						<TD class="accountTextBold" align="center" width="35%">Project Name</td>
						<TD class="accountTextBold" align="center" width="20%">Project Manager</td>
						<TD class="accountTextBold" align="center" width="10%">Start Date</td>
						<TD class="accountTextBold" align="center" width="10%">Status</td>
					</tr>
					<cfloop query="getProjects">
						<tr valign="top">
							<!--- SIMS --->
							<TD class="row#r#"><a href="#SIMSLink#&SID=#getSIMS.Admin_Site_ID#" target="_blank">#getSIMS.Admin_Site_ID#</a></TD>
							<!--- Project Number --->
							<TD class="row#r#" align="center">#getProjects.Project_Number#</TD>
							<!--- Project Name --->
							<TD class="row#r#">#getProjects.Project_Name#</TD>
							<!--- Project Manager --->
							<TD class="row#r#">#getProjects.Project_Manager_Name#</TD>
							<!--- Start Date --->
							<TD class="row#r#" align="center">#dateformat(getProjects.Start_Date, "mm/dd/yyyy")#</TD>
							<!--- Status --->
							<TD class="row#r#" align="center">#getProjects.Status#</TD>
						</tr>
						<cfset r = 1-r>
					</cfloop>
				<cfelse>
					<!--- no projects --->
					<tr valign="top"><TD class="row#r#" colspan="6" align="center"><i>there are no projects for this site</i></td></tr>
				</cfif>
			</TABLE>
		</td>
	</tr>
</TABLE>

<!--- milestones for site --->
<cfmodule template="q_getMilestones.cfm" TYPE="site" Sort="#form.sortType#" AdminSiteID="#form.AdminSiteID#" StatusPortfolioID="#form.StatusPortfolioID#" Return="getSiteMilestones">
<cfinclude template="q_getWatchlistMilestones.cfm">
<cfset r = 0>
<cfset totalMilestoneAmount = 0>
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
	<tr height="20"><td width="100%" class="ListHeaderBlue" align="center">Milestones</td></tr>
	<tr>
		<TD width="100%" align="center" valign="top">
			<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999">
				<!--- milestones --->
				<cfif getSiteMilestones.RecordCount NEQ 0>
					<tr valign="top">
						<TD class="accountTextBold" align="center" width="2%">&nbsp;</td>
						<TD class="accountTextBold" align="center" width="2%">&nbsp;</td>
						<!--- sortERP --->
						<FORM NAME="sortERP" id="sortERP" ACTION="" METHOD="post">
							<!--- scrub url input for XSS --->
							<cfinclude template="/Common/XSS_Scubber.cfm" >
							<input type="hidden" name="edittype" value="#form.edittype#" />
							<input type="hidden" name="sorttype" value="erp" />
							<input type="hidden" name="sort" value="yes" />
							<cfif isDefined("form.SiteMilestoneID")><input type="hidden" name="SiteMilestoneID" value="#form.SiteMilestoneID#" /></cfif>
							<cfif isDefined("editMilestone")><input type="hidden" name="editMilestone" value="editMilestone" /></cfif>
							<cfif isDefined("form.AdminSiteID")><input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#" /></cfif>
							<cfif isDefined("form.yeartofind")><input type="hidden" name="yeartofind" value="#form.yeartofind#" /></cfif>
							<cfif isDefined("form.monthtofind")><input type="hidden" name="monthtofind" value="#form.monthtofind#" /></cfif>
							<cfif isDefined("form.periodtofind")><input type="hidden" name="periodtofind" value="#form.periodtofind#" /></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
							<cfif isDefined("form.siteidtofind")><input type="hidden" name="siteidtofind" value="#form.siteidtofind#" /></cfif>
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
							<cfif isDefined("form.editStatusID")><input type="Hidden" name="editStatusID" value="#form.editStatusID#"></cfif>
							<input type="hidden" name="MilestoneID" value="#getSiteMilestones.ID#" />
							<input type="hidden" name="MilestonePlanDate" value="#getSiteMilestones.Milestone_Plan_Date#" />
							<TD class="accountTextBold" align="center" width="8%">
								<a href="javascript:{}" onclick="document.getElementById('sortERP').submit(); return false;">ERP</a>
							</td>
						</FORM>
						<!--- sortMilestone --->
						<FORM NAME="sortMilestone" id="sortMilestone" ACTION="" METHOD="post">
							<!--- scrub url input for XSS --->
							<cfinclude template="/Common/XSS_Scubber.cfm" >
							<input type="hidden" name="edittype" value="#form.edittype#" />
							<input type="hidden" name="sorttype" value="milestone" />
							<input type="hidden" name="sort" value="yes" />
							<cfif isDefined("form.SiteMilestoneID")><input type="hidden" name="SiteMilestoneID" value="#form.SiteMilestoneID#" /></cfif>
							<cfif isDefined("editMilestone")><input type="hidden" name="editMilestone" value="editMilestone" /></cfif>
							<cfif isDefined("form.AdminSiteID")><input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#" /></cfif>
							<cfif isDefined("form.yeartofind")><input type="hidden" name="yeartofind" value="#form.yeartofind#" /></cfif>
							<cfif isDefined("form.monthtofind")><input type="hidden" name="monthtofind" value="#form.monthtofind#" /></cfif>
							<cfif isDefined("form.periodtofind")><input type="hidden" name="periodtofind" value="#form.periodtofind#" /></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
							<cfif isDefined("form.siteidtofind")><input type="hidden" name="siteidtofind" value="#form.siteidtofind#" /></cfif>
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
							<cfif isDefined("form.editStatusID")><input type="Hidden" name="editStatusID" value="#form.editStatusID#"></cfif>
							<input type="hidden" name="MilestoneID" value="#getSiteMilestones.ID#" />
							<input type="hidden" name="MilestonePlanDate" value="#getSiteMilestones.Milestone_Plan_Date#" />
							<TD class="accountTextBold" align="center" width="9%">
								<a href="javascript:{}" onclick="document.getElementById('sortMilestone').submit(); return false;">Milestone</a>
							</td>
						</FORM>
						<TD class="accountTextBold" align="center" width="6%">Amount</td>
						<TD class="accountTextBold" align="center" width="6%">Baseline</td>
						<!--- sortPlanDate --->
						<FORM NAME="sortPlanDate" id="sortPlanDate" ACTION="" METHOD="post">
							<!--- scrub url input for XSS --->
							<cfinclude template="/Common/XSS_Scubber.cfm" >
							<input type="hidden" name="edittype" value="#form.edittype#" />
							<input type="hidden" name="sorttype" value="PlanDate" />
							<input type="hidden" name="sort" value="yes" />
							<cfif isDefined("form.SiteMilestoneID")><input type="hidden" name="SiteMilestoneID" value="#form.SiteMilestoneID#" /></cfif>
							<cfif isDefined("editMilestone")><input type="hidden" name="editMilestone" value="editMilestone" /></cfif>
							<cfif isDefined("form.AdminSiteID")><input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#" /></cfif>
							<cfif isDefined("form.yeartofind")><input type="hidden" name="yeartofind" value="#form.yeartofind#" /></cfif>
							<cfif isDefined("form.monthtofind")><input type="hidden" name="monthtofind" value="#form.monthtofind#" /></cfif>
							<cfif isDefined("form.periodtofind")><input type="hidden" name="periodtofind" value="#form.periodtofind#" /></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
							<cfif isDefined("form.siteidtofind")><input type="hidden" name="siteidtofind" value="#form.siteidtofind#" /></cfif>
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
							<cfif isDefined("form.editStatusID")><input type="Hidden" name="editStatusID" value="#form.editStatusID#"></cfif>
							<input type="hidden" name="MilestoneID" value="#getSiteMilestones.ID#" />
							<input type="hidden" name="MilestonePlanDate" value="#getSiteMilestones.Milestone_Plan_Date#" />
							<TD class="accountTextBold" align="center" width="6%">
								<a href="javascript:{}" onclick="document.getElementById('sortPlanDate').submit(); return false;">Plan Date</a>
							</td>
						</FORM>
						<TD class="accountTextBold" align="center" width="6%">Claimed</td>
						<TD class="accountTextBold" align="center" width="4%">ACS</td>
						<TD class="accountTextBold" align="center" width="4%">Skip</td>
						<TD class="accountTextBold" align="center" width="9%">FCO</td>
						<TD class="accountTextBold" align="center" width="9%">Deliverable</td>
						<TD class="accountTextBold" align="center" width="4%">File</td>
						<TD class="accountTextBold" align="center" width="5%">Delay?</td>
						<TD class="accountTextBold" align="center" width="20%">Notes</td>
					</tr>
					<cfloop query="getSiteMilestones">
						<tr valign="top">
						<!--- edit icon --->
							<FORM NAME="editMilestone" ACTION="" METHOD="post">
								<!--- scrub url input for XSS --->
								<cfinclude template="/Common/XSS_Scubber.cfm" >
								<td valign="top" class="row#r#">
									<input type="submit" name="btnEditMilestone" value="" style="background: url(images/icon_pencil.gif) no-repeat; height: 25px; width: 23px; border: none; cursor: pointer;">
									<input type="hidden" name="edittype" value="#form.edittype#" />
									<input type="hidden" name="editMilestone" value="editMilestone" />
									<input type="hidden" name="SiteMilestoneID" value="#getSiteMilestones.SiteMilestoneID#" />
									<cfif isDefined("form.sorttype")><input type="hidden" name="sorttype" value="#form.sorttype#" /></cfif>
									<cfif isDefined("form.AdminSiteID")><input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#" /></cfif>
									<cfif isDefined("form.yeartofind")><input type="hidden" name="yeartofind" value="#form.yeartofind#" /></cfif>
									<cfif isDefined("form.monthtofind")><input type="hidden" name="monthtofind" value="#form.monthtofind#" /></cfif>
									<cfif isDefined("form.periodtofind")><input type="hidden" name="periodtofind" value="#form.periodtofind#" /></cfif>
									<cfloop query="getRegions">
										<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
											<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
										</cfif>
									</cfloop>
									<cfif isDefined("form.siteidtofind")><input type="hidden" name="siteidtofind" value="#form.siteidtofind#" /></cfif>
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
									<cfif isDefined("form.editStatusID")><input type="Hidden" name="editStatusID" value="#form.editStatusID#"></cfif>
									<input type="hidden" name="MilestoneID" value="#getSiteMilestones.ID#" />
									<input type="hidden" name="MilestonePlanDate" value="#getSiteMilestones.Milestone_Plan_Date#" />
								</td>
							</FORM>
							<!--- claimed --->
							<TD class="row#r#" align="center">
								<cfif getSiteMilestones.Claim EQ 1><img src="images/icon_greencheck.gif" alt="claimed" border="0"><cfelse>&nbsp;</cfif>
							</TD>
							<!--- ERP --->
							<TD class="row#r#">#getSiteMilestones.ERP_Stage#</TD>
							<!--- milestone --->
							<TD class="row#r#">#getSiteMilestones.Milestone#</TD>
							<!--- amount --->
							<cfset totalMilestoneAmount = totalMilestoneAmount + getSiteMilestones.Milestone_Amount>
							<TD class="row#r#" align="right">#dollarformat(getSiteMilestones.Milestone_Amount)#</TD>
							<!--- baseline date --->
							<cfset Baseline_Month = right(getSiteMilestones.Milestone_Baseline_Date,2)>
							<cfset Baseline_Year = left(getSiteMilestones.Milestone_Baseline_Date,4)>
							<TD class="row#r#" align="center"><cfif len(getSiteMilestones.Milestone_Baseline_Date)>#Baseline_Month#/#Baseline_Year#</cfif></TD>
							<!--- plan date --->
							<cfset Plan_Month = right(getSiteMilestones.Milestone_Plan_Date,2)>
							<cfset Plan_Year = left(getSiteMilestones.Milestone_Plan_Date,4)>
							<!--- color code --->
							<cfset class = "row" & r>
							<cfset orangeDate = CreateDate(Plan_Year, Plan_Month, "20")>
							<cfset redDate = DateAdd("m", 1, CreateDate(Plan_Year, Plan_Month, "12"))>
							<cfif getSiteMilestones.Claim NEQ 1 and dateformat(now(),"mm/dd/yyyy") GTE orangeDate><cfset class = "StatOrange"></cfif>
							<cfif getSiteMilestones.Claim NEQ 1 and dateformat(now(),"mm/dd/yyyy") GTE redDate><cfset class = "Statred"></cfif>
							<TD class="#class#" align="center">#Plan_Month#/#Plan_Year#</TD>
							<!--- claimed --->
							<cfset claimed_Month = "">
							<cfset claimed_Year = "">
							<cfif getSiteMilestones.Claim EQ 1>
								<cfset claimed_Month = right(getSiteMilestones.Period,2)>
								<cfset claimed_Year = left(getSiteMilestones.Period,4)>
							</cfif>
							<TD class="row#r#" align="center"><cfif len(claimed_Month) and len(claimed_Year)>#claimed_Month#/#claimed_Year#<cfelse>&nbsp;</cfif></TD>
							<!--- ACS --->
							<TD class="row#r#" align="center">
								<cfif getSiteMilestones.ACS_Milestone EQ 1><img src="images/icon_greencheck.gif" alt="yes" border="0"></cfif>						
							</TD>
							<!--- skip --->
							<TD class="row#r#" align="center">
								<cfif len(getSiteMilestones.Skip)>Yes<cfelse>&nbsp;</cfif>
							</TD>
							<!--- fco --->
							<TD class="row#r#">
								<cfif len(getSiteMilestones.FCO)>#getSiteMilestones.FCO#<cfelse>&nbsp;</cfif>
							</TD>
							<!--- deliverable --->
							<TD class="row#r#">
								<cfif len(getSiteMilestones.Deliverable)>#getSiteMilestones.Deliverable#<cfelse>&nbsp;</cfif>
							</TD>
							<!--- Milestone Doc --->
							<TD class="row#r#" align="center">
								<cfif len(getSiteMilestones.Milestone_Doc)>
									<A HREF="javascript: var n=window.open('components/GetDoc.cfm?SiteMilestoneID=#getSiteMilestones.SiteMilestoneID#&DocType=SiteMileStone', '', 'height=700,width=900,resizable')">view file</A>
								<cfelse>
									&nbsp;
								</cfif>
							</TD>
							<!--- delay reason --->
							<TD class="row#r#" align="center">
								<cfif len(getSiteMilestones.Delay_Reason) and getSiteMilestones.Delay_Reason NEQ 0>
									#getSiteMilestones.Delay_Reason#
								<cfelse>&nbsp; 
								</cfif>
							</TD>
							<!--- notes --->
							<TD class="row#r#">
								<cfif len(getSiteMilestones.Notes)><SPAN TITLE="#getSiteMilestones.Notes#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getSiteMilestones.Notes,80)#<cfif len(getSiteMilestones.Notes) GT 80>...</cfif></SPAN><cfelse>&nbsp;</cfif>								
							</TD>
						</tr>
						<cfset r = 1-r>
					</cfloop>
					<!--- milestone total --->
					<cfset r = 1-r>
					<tr valign="top">
						<TD class="TotalRowOrange" colspan="3">Milestone Total</td>
						<TD class="TotalRowOrange" colspan="2" align="right">#dollarformat(totalMilestoneAmount)#</td>
						<TD class="TotalRowOrange" colspan="10">&nbsp;</td>
					</tr>
				<cfelse>
					<!--- no milestones --->
					<tr valign="top"><TD class="row#r#" colspan="15" align="center"><i>there are no milestones for this site</i></td></tr>
				</cfif>
			</table>
		</TD>
	</tr>
	<tr height="20"><td width="100%" class="ListHeaderBlue" align="center">Uncommitted Milestones</td></tr>
	<tr>
		<TD width="100%" align="center" valign="top">
			<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999">
				<!--- watchlist milestones --->
				<cfif getWatchlistMilestones.RecordCount NEQ 0>
					<tr valign="top">
						<TD class="accountTextBold" align="center" width="9%">Milestone</td>
						<TD class="accountTextBold" align="center" width="6%">Anticipated Claim Date</td>
						<TD class="accountTextBold" align="center" width="6%">Amount</td>
						<TD class="accountTextBold" align="center" width="6%">Watchlist Probability</td>
					</tr>
					<cfset totalWatchMilestoneAmount = 0>
					<cfloop query="getWatchlistMilestones">
						<tr valign="top">
							<!--- milestone --->
							<TD class="row#r#">#getWatchlistMilestones.Milestone#</TD>
							<!--- Anticipated Claim Date --->
							<TD class="row#r#" align="center"><cfif len(getWatchlistMilestones.Anticipated_Claim_Year)>#getWatchlistMilestones.Anticipated_Claim_Month#/#getWatchlistMilestones.Anticipated_Claim_Year#</cfif></TD>
							<!--- amount --->
							<cfset totalWatchMilestoneAmount = totalWatchMilestoneAmount + getWatchlistMilestones.Milestone_Amount>
							<TD class="row#r#" align="right">#dollarformat(getWatchlistMilestones.Milestone_Amount)#</TD>
							<!--- Probability --->
							<TD class="row#r#" align="right">#getWatchlistMilestones.Watchlist_Probability#%</TD>
						</tr>
						<cfset r = 1-r>
					</cfloop>
					<!--- milestone total --->
					<cfset r = 1-r>
					<tr valign="top">
						<TD class="TotalRowOrange" colspan="1">Milestone Total</td>
						<TD class="TotalRowOrange" colspan="2" align="right">#dollarformat(totalWatchMilestoneAmount)#</td>
						<TD class="TotalRowOrange" colspan="9">&nbsp;</td>
					</tr>
				<cfelse>
					<!--- no milestones --->
					<tr valign="top"><TD class="row#r#" colspan="7" align="center"><i>there are no uncommitted milestones for this site</i></td></tr>
				</cfif>
			</table>
		</TD>
	</tr>
	</cfoutput>
</TABLE>
<script>document.StatusAdmin.RegAgencyID.focus();</script>
