<!----------------------------------------------------------------------------------------------------------
Description:
	Regulatory requirements search page

History:
	2/7/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfset errormsg = "">

<SCRIPT>
function buttonDisable() {
	if (document.frmGetSites.btnAddRegulatory) document.frmGetSites.btnAddRegulatory.style.visibility='hidden';
	if (document.frmGetSites.lblExcelButton) document.frmGetSites.lblExcelButton.style.visibility='hidden';
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

<!--- delete regulatory record --->
<cfif isDefined("form.deleteRegulatory") and form.deleteRegulatory EQ "deleteRegulatory">
	<cfinclude template="q_delRegulatory.cfm" >
</cfif>

<!--- regulatory action was completed --->
<cfif isDefined("form.btnCompleteRegulatory")>
	<cfinclude template="q_updComplete.cfm">
</cfif>

<!--- search for the site --->
<cfif isDefined("form.SiteIDtofind") or isDefined("url.RID")>
	<cfinclude template="q_getRegulatory.cfm" >
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
		<td class="largeText" ><strong>Regulatory Advocacy</strong></TD>
		<td class="largeText" ></td>
	</TR>
	<TR>
		<td class="largeText" ></td>
		<td class="largeText">
			<li>Use this page to track regulatory submittals to final approval by the agency/third-party. The purpose of this tool is to track our effort to manage progress when the "ball has left our court".</li>
			<li>Search by selecting and / or filling in the any fields below, and clicking the <strong>Search</strong>. Exact terms are not necessary, substrings of a search item may be used.</li>
			<li>To display all records, leave the fields blank and click the <strong>Search</strong> button.</li>
			<li>Once displayed, you will be able to enter, edit or delete the resulting information.</li>
			<li>All status updates need to include Date, Action (i.e., submittal, approval, called, emailed). Mark as Complete when deliverable is fully approved and "ball is back with Arcadis".</li>
			<li>Cells highlighted in yellow are actions that have not been completed within 30-days. Cells highlighted in red are actions that have not been completed within 60-days.</li>
		</td>
		<td class="largeText" ></td>
	</TR>
</TABLE>

<!--- search form --->
<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="##ffffff">
		<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
		<form name="frmGetSites" action="" method="post">
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
					<strong>Site Name:</strong>&nbsp;
					<input type="Text" name="SiteNameToFind" size="23" class="largeText" <cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)>value="#form.SiteNameToFind#"</cfif>>
					&nbsp;
					<strong>Address:</strong>&nbsp;
					<input type="Text" name="AddressToFind" size="23" class="largeText" <cfif isDefined("form.AddressToFind") and len(form.AddressToFind)>value="#form.AddressToFind#"</cfif>>
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

			<!--- Site Manager, deputy, date --->
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
					<strong>Date - From:</strong>&nbsp;
					<input type="text" name="RegulatoryFromDatetofind" class="largeText" size="15" maxlength="10" <cfif isDefined("form.RegulatoryFromDatetofind") and len(form.RegulatoryFromDatetofind)>value="#form.RegulatoryFromDatetofind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp1']:document.TaskPopUp1_Position), document.forms.frmGetSites.RegulatoryFromDatetofind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp1_Position" ID="TaskPopUp1_Position" BORDER="0" ALT="Date"></A>
					<strong>To:</strong>&nbsp;
					<input type="text" name="RegulatoryToDatetofind" class="largeText" size="15" maxlength="10" <cfif isDefined("form.RegulatoryToDatetofind") and len(form.RegulatoryToDatetofind)>value="#form.RegulatoryToDatetofind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp2']:document.TaskPopUp2_Position), document.forms.frmGetSites.RegulatoryToDatetofind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp2_Position" ID="TaskPopUp2_Position" BORDER="0" ALT="Date"></A>
					<cfif len(errormsg)><span class="errortext"><i>#errormsg#</i></span></cfif>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- buttons --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"></td>
				<td class="largeText">
					<input type="Submit" name="Search" class="largeTextButton" value="Search" onClick="buttonDisable();">
					<cfif isDefined("getRegulatory")>
						<input type="Submit" name="btnAddRegulatory" class="largeTextButton" value="Add New Regulatory Record">
						<input type="hidden" name="edittype" value="addRegulatory" />
					</cfif>
					<cfif isDefined("getRegulatory") and getRegulatory.RecordCount GT 0>
						<CFSET FileName="Regulatory_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
						<input type="button" name="lblExcelButton" class="largeTextButton" value="Open Excel File" ONCLICK="window.open('#Request.ExcelPath#/#FileName#')">
					</cfif>
				</td>
			</TR>
			<TR>
				<td class="largeText" align="right" width="1%"></td>
				<td class="largeText" align="right" width="8%">&nbsp;</td>
				<td class="largeText" >&nbsp;</td>
			</TR>
		</form>
	</TABLE>
</cfoutput>

<!--- display site information --->
<cfif isDefined("getRegulatory")>
	<cfset row = 1>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="silver">
		<TR>
			<td class="ServiceListHeader" width="1%"></td>
			<td class="ServiceListHeader" width="8%">Site ID</td>
			<td class="ServiceListHeader" width="15%">Site Name</td>
			<td class="ServiceListHeader" width="19%">Address</td>
			<td class="ServiceListHeader" width="10%">Site Manager</td>
			<td class="ServiceListHeader" width="33%">Regulatory Action</td>
			<td ALIGN="center" class="ServiceListHeader" width="7%">Date</td>
			<td ALIGN="center" class="ServiceListHeader" width="6%">Complete</td>
			<td class="ServiceListHeader" width="1%"></td>
		</tr>
		<cfif getRegulatory.RecordCount GT 0>
			<cfset expRowCount = 4>
			<cfoutput query="getRegulatory">
				<cfset row = 1-row>
				<cfset expRowCount = expRowCount+1>
				<TR>
					<!--- edit record --->
					<FORM NAME="editRegulatory" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
						<cfset class = "row" & row>
						<cfif not getRegulatory.Complete and now() - getRegulatory.Regulatory_Date GTE 60>
							<cfset class = "rowRed">
						<cfelseif not getRegulatory.Complete and now() - getRegulatory.Regulatory_Date GTE 30>
							<cfset class = "rowYellow">
						</cfif>
						<td valign="top" class="row#row#">
							<input type="submit" name="imgEditRegulatory" value="" alt="edit" style="background: url(images/icon_pencil.gif) no-repeat; height: 25px; width: 23px; border: none; cursor: pointer;">
							<input type="hidden" name="btnEditRegulatory" value="btnEditRegulatory" />
							<input type="hidden" name="edittype" value="editRegulatory" />
							<input type="hidden" name="RegulatoryID" value="#getRegulatory.Regulatory_ID#" />
							<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
							<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
							<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
							<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
							<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
							<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
							<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
							<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
							<cfif isDefined("form.RegulatoryFromDatetofind")><input type="Hidden" name="RegulatoryFromDatetofind" value="#form.RegulatoryFromDatetofind#"></cfif>
							<cfif isDefined("form.RegulatoryToDatetofind")><input type="Hidden" name="RegulatoryToDatetofind" value="#form.RegulatoryToDatetofind#"></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
						</td>
					</FORM>
					<td valign="top" class="#class#">#getRegulatory.Site_ID#</td>
					<td valign="top" class="#class#">#getRegulatory.Site_Name#</td>
					<td valign="top" class="#class#">#getRegulatory.Address#, #getRegulatory.City#, #getRegulatory.State_Abbreviation#<cfif len(getRegulatory.Zip_Code)>, #getRegulatory.Zip_Code#</cfif></td>
					<td valign="top" class="#class#"><cfif len(getRegulatory.User_id)>#getRegulatory.Last_Name#, #getRegulatory.First_Name#</cfif></td>
					<cfset varRegulatoryAction = Replace(getRegulatory.Regulatory_Action, chr(10), "<br/>", "ALL")>
					<td valign="top" class="#class#">#varRegulatoryAction#</td>
					<td valign="top" ALIGN="center" class="#class#">#dateformat(getRegulatory.Regulatory_Date,"mm/dd/yyyy")#</td>
					<!--- complete check mark --->
					<cfif not getRegulatory.Complete>
						<form name="frmComplete" method="post" action="">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
							<input type="hidden" name="RegulatoryID" value="#getRegulatory.Regulatory_ID#" />
							<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
							<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
							<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
							<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
							<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
							<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
							<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
							<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
							<cfif isDefined("form.RegulatoryFromDatetofind")><input type="Hidden" name="RegulatoryFromDatetofind" value="#form.RegulatoryFromDatetofind#"></cfif>
							<cfif isDefined("form.RegulatoryToDatetofind")><input type="Hidden" name="RegulatoryToDatetofind" value="#form.RegulatoryToDatetofind#"></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
							<td ALIGN="center" valign="top" class="#class#">
								<button type="submit" class="CompleteButton" name="btnCompleteRegulatory"><img src="images/checkmark.gif" class="CompleteButton" border="0"></button>
							</td>
						</form>
					<cfelse>
						<td ALIGN="center" valign="top" class="#class#"><img src="images/checkmark_green_#row#.gif" class="CompleteButton" border="0" alt="reviewed"></td>
					</cfif>
					<!--- delete record --->
					<FORM NAME="deleteRegulatory" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
						<td valign="top" class="row#row#" width="1%">
							<input type="Image" name="btnDeleteRegulatory" src="images/icon_trash.gif" border="0" onclick="if (confirm('Delete this record?')){submit()}; return false" alt="delete this record">
							<input type="hidden" name="deleteRegulatory" value="deleteRegulatory" />
							<input type="hidden" name="RegulatoryID" value="#getRegulatory.Regulatory_ID#" />
							<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
							<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
							<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
							<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
							<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
							<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
							<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
							<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
							<cfif isDefined("form.RegulatoryFromDatetofind")><input type="Hidden" name="RegulatoryFromDatetofind" value="#form.RegulatoryFromDatetofind#"></cfif>
							<cfif isDefined("form.RegulatoryToDatetofind")><input type="Hidden" name="RegulatoryToDatetofind" value="#form.RegulatoryToDatetofind#"></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
						</td>
					</FORM>
				</tr>
			</cfoutput>
			<cfinclude template="regulatory_export.cfm">
		<cfelse>
			<cfset row = 1-row>
			<cfoutput>
			<TR>
				<td ALIGN="center" valign="top" colspan="9" class="row#row#"><em>There are no records that match your search parameters</em></td>
			</tr>
			</cfoutput>
		</cfif>
	</TABLE>
</cfif>
<script>document.frmGetSites.SitePortfolioToFind.focus();</script>
