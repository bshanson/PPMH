<!----------------------------------------------------------------------------------------------------------
Description:
	AccessLUC requirements search page

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfset errormsg = "">
<cfset canEdit = "false">
<cfinclude template="../components/q_getAccessLUCAdmins.cfm">
<cfif listfind(canEditList,Session.Security.UserID)><cfset canEdit = "true"></cfif>

<SCRIPT>
function buttonDisable() {
	if (document.frmGetSites.btnAddAccessLUC) document.frmGetSites.btnAddAccessLUC.style.visibility='hidden';
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
<cfinclude template="../components/q_getPortfolios.cfm">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- get SPls --->
<cfinclude template="q_getSPLs.cfm">

<!--- delete AccessLUC record --->
<cfif isDefined("form.deleteAccessLUC") and form.deleteAccessLUC EQ "deleteAccessLUC">
	<cfinclude template="q_delAccessLUC.cfm" >
</cfif>

<!--- AccessLUC action was completed --->
<cfif isDefined("form.btnCompleteAccessLUC")>
	<cfinclude template="q_updComplete.cfm">
</cfif>

<!--- search for the site --->
<cfif isDefined("form.SiteIDtofind") or isDefined("url.ALID")>
	<cfinclude template="q_getAccessLUC.cfm" >
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
		<td class="largeText" ><strong>Access/LUC Advocacy</strong></TD>
		<td class="largeText" ></td>
	</TR>
	<TR>
		<td class="largeText" ></td>
		<td class="largeText">
			<li>Use this page to manage Access/LUC advocacy information.</li>
			<li>Search by selecting and / or filling in the any fields below, and clicking the <strong>Search</strong>. Exact terms are not necessary, substrings of a search item may be used.</li>
			<li>To display all records, leave the fields blank and click the <strong>Search</strong> button.</li>
			<li>Once displayed, you will be able to enter, edit or delete the resulting information.</li>
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

			<!--- Site Manager, deputy, SPL --->
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
					<strong>SPL:</strong>&nbsp;
					<select name="SPLToFind" class="largeText">
						<option value="0" <cfif isDefined("form.SPLToFind") and form.SPLToFind EQ "0">selected="selected"</cfif>>- select the spl -</option>
						<cfloop query="getSPLs" >
						<option value="#getSPLs.User_ID#" <cfif isDefined("form.SPLToFind") and form.SPLToFind EQ getSPLs.User_ID>selected="selected"</cfif>>#getSPLs.Last_Name#, #getSPLs.First_Name#</option>
						</cfloop>
					</select>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- forecast closure date, priority, completed --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Forecast Closure:</strong>&nbsp;</td>
				<td class="largeText">
					<select name="ClosureToFind" class="largeText">
						<option value="0" <cfif isDefined("form.ClosureToFind") and form.ClosureToFind EQ "0">selected="selected"</cfif>>- select the date -</option>
						<cfloop from="#Request.startYear#" to="#Request.endYear#" index="yr">
							<cfloop from="1" to="4" index="qtr">
								<option value="#yr##qtr#" <cfif isDefined("form.ClosureToFind") and form.ClosureToFind EQ yr&qtr>selected="selected"</cfif>>#yr# Q#qtr#</option>
							</cfloop>
						</cfloop>
					</select>
					&nbsp;
					<strong>Priority:</strong>&nbsp;
					<select name="PriorityToFind" class="largeText">
						<option value="" <cfif isDefined("form.PriorityToFind") and form.PriorityToFind EQ "">selected</cfif>>- select -</option>
						<option value="1" class="ProjStatGreen" <cfif isDefined("form.PriorityToFind") and form.PriorityToFind EQ 1>selected</cfif>>Low</option>
						<option value="2" class="ProjStatYellow" <cfif isDefined("form.PriorityToFind") and form.PriorityToFind EQ 2>selected</cfif>>Medium</option>
						<option value="3" class="ProjStatRed" <cfif isDefined("form.PriorityToFind") and form.PriorityToFind EQ 3>selected</cfif>>High</option>
					</select>
					&nbsp;
					<strong>Completed:</strong>&nbsp;<input type="checkbox" class="largeText" name="CompletedToFind" <cfif isDefined("CompletedToFind")>checked="checked"</cfif>>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- buttons --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"></td>
				<td class="largeText">
					<input type="Submit" name="Search" class="largeTextButton" value="Search" onClick="buttonDisable();">
					<cfif canEdit>
						<cfif isDefined("getAccessLUC")>
							<input type="Submit" name="btnAddAccessLUC" class="largeTextButton" value="Add New Access/LUC Record">
							<input type="hidden" name="edittype" value="addAccessLUC" />
						</cfif>
					</cfif>
					<cfif isDefined("getAccessLUC") and getAccessLUC.RecordCount GT 0>
						<CFSET FileName="AccessLUC_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
						<input type="button" name="lblExcelButton" class="largeTextButton" value="Open Excel File" ONCLICK="window.open('#Request.ExcelPath#/#FileName#')">
					</cfif>
				</td>
			</TR>
			<TR>
				<td class="largeText" align="right" width="1%"></td>
				<td class="largeText" align="right" width="10%">&nbsp;</td>
				<td class="largeText" >&nbsp;</td>
			</TR>
		</form>
	</TABLE>
</cfoutput>

<!--- display site information --->
<cfif isDefined("getAccessLUC")>
	<cfset row = 1>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="silver">
		<TR>
			<td class="ServiceListHeader" width="1%"></td>
			<td ALIGN="center" class="ServiceListHeader" width="6%">Site ID</td>
			<td ALIGN="center" class="ServiceListHeader" width="10%">Site Name<br>Address</td>
			<td ALIGN="center" class="ServiceListHeader" width="9%">Site Manager</td>
			<td ALIGN="center" class="ServiceListHeader" width="6%">Portfolio</td>
			<td ALIGN="center" class="ServiceListHeader" width="5%">On-site<br>/<br>Off-site</td>
			<td ALIGN="center" class="ServiceListHeader" width="7%">Agreement Type</td>
			<td ALIGN="center" class="ServiceListHeader" width="6%">Milestone in Place</td>
			<td ALIGN="center" class="ServiceListHeader" width="8%">SPL</td>
			<td ALIGN="center" class="ServiceListHeader" width="6%">Stage</td>
			<td ALIGN="center" class="ServiceListHeader" width="7%">Exp Date</td>
			<td ALIGN="center" class="ServiceListHeader" width="11%">Notes</td>
			<td ALIGN="center" class="ServiceListHeader" width="5%">Priority</td>
			<td ALIGN="center" class="ServiceListHeader" width="7%">Forecast Closure Date</td>
			<td ALIGN="center" class="ServiceListHeader" width="5%">Complete</td>
			<cfif canEdit><td class="ServiceListHeader" width="1%"></td></cfif>
		</tr>
		<cfif getAccessLUC.RecordCount GT 0>
			<cfset expRowCount = 4>
			<cfoutput query="getAccessLUC">
				<cfset row = 1-row>
				<cfset expRowCount = expRowCount+1>
				<TR>
					<!--- edit record --->
					<FORM NAME="editAccessLUC" ACTION="" METHOD="post">
						<!--- scrub url input for XSS --->
						<cfinclude template="/Common/XSS_Scubber.cfm" >
						<td valign="top" class="row#row#">
							<cfif canEdit>
								<input type="Image" name="imgEditAccessLUC" src="images/icon_pencil.gif" border="0" onclick="submit()" alt="edit AccessLUC information">
							<cfelse>
								<input type="Image" name="imgEditAccessLUC" src="images/icon_view.gif" border="0" onclick="submit()" alt="view AccessLUC information">
							</cfif>
							<input type="hidden" name="btnEditAccessLUC" value="btnEditAccessLUC" />
							<input type="hidden" name="edittype" value="editAccessLUC" />
							<input type="hidden" name="AccessLUCID" value="#getAccessLUC.AccessLUC_ID#" />
							<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
							<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
							<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
							<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
							<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
							<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
							<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
							<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
							<cfif isDefined("form.SPLToFind")><input type="Hidden" name="SPLToFind" value="#form.SPLToFind#"></cfif>
							<cfif isDefined("form.ClosureToFind")><input type="Hidden" name="ClosureToFind" value="#form.ClosureToFind#"></cfif>
							<cfif isDefined("form.PriorityToFind")><input type="Hidden" name="PriorityToFind" value="#form.PriorityToFind#"></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
							<cfif isDefined("form.CompletedToFind")><input type="Hidden" name="CompletedToFind" value="#form.CompletedToFind#"></cfif>
						</td>
					</FORM>
					<cfset spl = "">
					<cfif getAccessLUC.SPL_ID EQ 1><cfset spl = "Debra Kitsman"></cfif>
					<cfif getAccessLUC.SPL_ID EQ 2><cfset spl = "Megan Martine"></cfif>
					<cfif getAccessLUC.SPL_ID EQ 3><cfset spl = "Debra Kitsman / Megan Martine"></cfif>
					<cfif getAccessLUC.SPL_ID EQ 4><cfset spl = "Willadee Hitchcock"></cfif>
					<td valign="top" class="row#row#">#getAccessLUC.Site_ID#</td>
					<td valign="top" class="row#row#">#getAccessLUC.Site_Name#<br>#getAccessLUC.Address#, #getAccessLUC.City#, #getAccessLUC.State_Abbreviation#<cfif len(getAccessLUC.Zip_Code)>, #getAccessLUC.Zip_Code#</cfif></td>
					<td valign="top" class="row#row#">#getAccessLUC.SM_Name#</td>
					<td valign="top" ALIGN="center" class="row#row#">#getAccessLUC.Portfolio#</td>
					<td valign="top" ALIGN="center" class="row#row#"><cfif getAccessLUC.Onsite EQ 1>On-site</cfif><cfif getAccessLUC.Onsite EQ 0>Off-site</cfif></td>
					<td valign="top" ALIGN="center" class="row#row#">#getAccessLUC.Agreement_Type#</td>
					<td valign="top" ALIGN="center" class="row#row#">#getAccessLUC.Milestone_In_Place#</td>
					<td valign="top" class="row#row#">#getAccessLUC.SPL_Name#</td>
					<td valign="top" ALIGN="center" class="row#row#"><cfif getAccessLUC.Stage_ID EQ 999999>Not Applicable<cfelse>#getAccessLUC.Stage#</cfif></td>
					<!--- highlight red if exp date <= 6 months & not checked --->
					<cfset class = "row" & row>
					<cfif not Complete and len(getAccessLUC.Expiration_Date)>
						<cfif getAccessLUC.Expiration_Date LTE dateformat(now(),"mm/dd/yyyy")><cfset class = "ProjStatRed">
						<cfelseif getAccessLUC.Expiration_Date - 180 LTE now()><cfset class = "ProjStatRed"></cfif>
					</cfif>
					<td valign="top" ALIGN="center" class="#class#"><cfif len(getAccessLUC.Expiration_Date)>#dateformat(getAccessLUC.Expiration_Date,"mm/dd/yyyy")#</cfif></td>
					<td valign="top" class="row#row#">
						<cfif len(getAccessLUC.SPL_Notes)><SPAN TITLE="#getAccessLUC.SPL_Notes#" onmouseover="style.cursor='pointer'" onmouseout="style.cursor='auto'">#left(getAccessLUC.SPL_Notes,100)#<cfif len(getAccessLUC.SPL_Notes) GT 100>...</cfif></SPAN><cfelse>&nbsp;</cfif>
					</td>
					<cfset PriorityClass = "row" & row>
					<cfif getAccessLUC.Priority_ID EQ 1><cfset PriorityClass = "ProjStatGreen"></cfif>
					<cfif getAccessLUC.Priority_ID EQ 2><cfset PriorityClass = "ProjStatYellow"></cfif>
					<cfif getAccessLUC.Priority_ID EQ 3><cfset PriorityClass = "ProjStatRed"></cfif>
					<td valign="top" ALIGN="center" class="#PriorityClass#">#getAccessLUC.Priority#</td>
					<cfModule template="q_getForecastInfo.cfm" SiteID="#getAccessLUC.Admin_Site_ID#" ForecastInfo="getForecastInfo">
					<cfset vForecast = "">
					<cfif len(getForecastInfo.maxYear) and len(getForecastInfo.maxQuarter)><cfset vForecast = getForecastInfo.maxYear & " Q" & getForecastInfo.maxQuarter></cfif>
					<td valign="top" ALIGN="center" class="row#row#">#vForecast#</td>
					<!--- complete check mark --->
					<cfif canEdit>
						<cfif not Complete>
							<form name="frmComplete" method="post" action="">
								<!--- scrub url input for XSS --->
								<cfinclude template="/Common/XSS_Scubber.cfm" >
								<input type="hidden" name="chkAccessLUCID" value="#getAccessLUC.AccessLUC_ID#" />
								<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
								<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
								<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
								<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
								<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
								<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
								<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
								<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
								<cfif isDefined("form.SPLToFind")><input type="Hidden" name="SPLToFind" value="#form.SPLToFind#"></cfif>
								<cfif isDefined("form.ClosureToFind")><input type="Hidden" name="ClosureToFind" value="#form.ClosureToFind#"></cfif>
								<cfif isDefined("form.PriorityToFind")><input type="Hidden" name="PriorityToFind" value="#form.PriorityToFind#"></cfif>
								<cfloop query="getRegions">
									<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
										<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
									</cfif>
								</cfloop>
								<cfif isDefined("form.CompletedToFind")><input type="Hidden" name="CompletedToFind" value="#form.CompletedToFind#"></cfif>
								<td ALIGN="center" valign="top" class="row#row#">
									<button type="submit" class="CompleteButton" name="btnCompleteAccessLUC"><img src="images/checkmark.gif" class="CompleteButton" border="0"></button>
								</td>
							</form>
						<cfelse>
							<td ALIGN="center" valign="top" class="row#row#"><img src="images/checkmark_green_#row#.gif" class="CompleteButton" border="0" alt="reviewed"></td>
						</cfif>
					<cfelse>
						<cfif not Complete>
							<td ALIGN="center" valign="top" class="row#row#">&nbsp</td>
						<cfelse>
							<td ALIGN="center" valign="top" class="row#row#"><img src="images/checkmark_green_#row#.gif" class="CompleteButton" border="0" alt="reviewed"></td>
						</cfif>
					</cfif>
					<!--- delete record --->
					<cfif canEdit>
						<FORM NAME="deleteAccessLUC" ACTION="" METHOD="post">
							<!--- scrub url input for XSS --->
							<cfinclude template="/Common/XSS_Scubber.cfm" >
							<td valign="top" class="row#row#" width="1%">
								<input type="Image" name="btnDeleteAccessLUC" src="images/icon_trash.gif" border="0" onclick="if (confirm('Delete this record?')){submit()}; return false" alt="delete this record">
								<input type="hidden" name="deleteAccessLUC" value="deleteAccessLUC" />
								<input type="hidden" name="delAccessLUCID" value="#getAccessLUC.AccessLUC_ID#" />
								<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
								<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
								<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
								<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
								<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
								<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
								<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
								<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
								<cfif isDefined("form.SPLToFind")><input type="Hidden" name="SPLToFind" value="#form.SPLToFind#"></cfif>
								<cfif isDefined("form.ClosureToFind")><input type="Hidden" name="ClosureToFind" value="#form.ClosureToFind#"></cfif>
								<cfif isDefined("form.PriorityToFind")><input type="Hidden" name="PriorityToFind" value="#form.PriorityToFind#"></cfif>
								<cfloop query="getRegions">
									<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
										<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
									</cfif>
								</cfloop>
								<cfif isDefined("form.CompletedToFind")><input type="Hidden" name="CompletedToFind" value="#form.CompletedToFind#"></cfif>
							</td>
						</FORM>
					</cfif>
				</tr>
			</cfoutput>
			<cfinclude template="AccessLUC_export.cfm">
		<cfelse>
			<cfset row = 1-row>
			<cfoutput>
			<TR>
				<cfif canEdit>
					<td ALIGN="center" valign="top" colspan="16" class="row#row#"><em>There are no records that match your search parameters</em></td>
				<cfelse>
					<td ALIGN="center" valign="top" colspan="15" class="row#row#"><em>There are no records that match your search parameters</em></td>
				</cfif>
			</tr>
			</cfoutput>
		</cfif>
	</TABLE>
</cfif>
<script>document.frmGetSites.SitePortfolioToFind.focus();</script>
