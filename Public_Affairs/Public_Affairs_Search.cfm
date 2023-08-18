<!----------------------------------------------------------------------------------------------------------
Description:
	Public Affairs search page

History:
	5/24/2021 - created
----------------------------------------------------------------------------------------------------------->

<cfset errormsg = "">

<SCRIPT>
function buttonDisable() {
	if (document.frmGetSites.btnAddPublicAffairs) document.frmGetSites.btnAddPublicAffairs.style.visibility='hidden';
	if (document.frmGetSites.lblExcelButton) document.frmGetSites.lblExcelButton.style.visibility='hidden';
}
</SCRIPT>

<!--- calendar scripts --->
<CFIF NOT IsDefined("Request.PopupInitialized")>
	<LINK REL="stylesheet" type="text/css" href="scripts/CalendarPopup/popcalendar.css">
	<SCRIPT LANGUAGE="javaScript" SRC="scripts/CalendarPopup/popcalendar.js"></SCRIPT>	
	<CFSET Request.PopupInitialized = "Yes">
</CFIF>

<!--- initialize form.SortBy --->
<cfparam name="form.SortBy" default="a.Site_ID">

<!--- get Site Managers --->
<cfinclude template="../components/q_getSiteManagers.cfm">
<!--- get states --->
<cfinclude template="../components/q_getStates.cfm">
<!--- get portfolios --->
<cfinclude template="../components/q_getPortfolios.cfm">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- delete Public Affairs record --->
<cfif isDefined("form.deletePublicAffairs") and form.deletePublicAffairs EQ "deletePublicAffairs">
	<cfinclude template="q_delPublicAffairs.cfm" >
</cfif>

<!--- search for the site --->
<cfif isDefined("form.SiteIDtofind") or isDefined("url.PAID") or isDefined("url.SID")>
	<cfinclude template="q_getPublicAffairs.cfm" >
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
		<td class="largeText" ><strong>Public Affairs</strong></TD>
		<td class="largeText" ></td>
	</TR>
	<TR>
		<td class="largeText" ></td>
		<td class="largeText">
			<li>Use this page to track public affairs assessments.</li>
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
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- sort --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"><strong>Sort By:</strong>&nbsp;</td>
				<td class="largeText">
					<input type="radio" id="SortSiteID" name="SortBy" value="a.Site_ID" <cfif isDefined("form.SortBy") and form.SortBy EQ "a.Site_ID">checked="checked"</cfif>>
					<label for="SortSiteId">Site ID</label>
					&nbsp;
					<input type="radio" id="SortAssmntDate" name="SortBy" value="a.Assessment_Date" <cfif isDefined("form.SortBy") and form.SortBy EQ "a.Assessment_Date">checked="checked"</cfif>>
					<label for="SortAssmntDate">Assmnt Date</label>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- buttons --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"></td>
				<td class="largeText">
					<input type="Submit" name="Search" class="largeTextButton" value="Search" onClick="buttonDisable();">
					<cfif isDefined("getPublicAffairs")>
						<input type="Submit" name="btnAddPublicAffairs" class="largeTextButton" value="Add New Public Affairs Record">
						<input type="hidden" name="edittype" value="addPublicAffairs" />
					</cfif>
					<cfif isDefined("getPublicAffairs") and getPublicAffairs.RecordCount GT 0>
						<CFSET FileName="PublicAffairs_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
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
<cfif isDefined("getPublicAffairs")>
	<cfset row = 1>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="silver">
		<TR>
			<td class="ServiceListHeader" colspan="6"></td>
			<td class="ServiceListHeader" align="center" colspan="8">Questions</td>
			<td class="ServiceListHeader" colspan="2"></td>
		</tr>
		<TR>
			<td class="ServiceListHeader" width="1%"></td>
			<td class="ServiceListHeader" width="8%" align="center">Site ID</td>
			<td class="ServiceListHeader" width="14%" align="center">Site Name</td>
			<td class="ServiceListHeader" width="18%" align="center">Address</td>
			<td class="ServiceListHeader" width="10%" align="center">Site Manager</td>
			<td class="ServiceListHeader" width="8%" align="center">Assmnt Date</td>
			<td class="ServiceListHeader" width="4%" align="center">1</td>
			<td class="ServiceListHeader" width="4%" align="center">2</td>
			<td class="ServiceListHeader" width="4%" align="center">3</td>
			<td class="ServiceListHeader" width="4%" align="center">4</td>
			<td class="ServiceListHeader" width="4%" align="center">5</td>
			<td class="ServiceListHeader" width="4%" align="center">6</td>
			<td class="ServiceListHeader" width="4%" align="center">7</td>
			<td class="ServiceListHeader" width="4%" align="center">8</td>
			<td class="ServiceListHeader" width="8%" align="center">Action</td>
			<td class="ServiceListHeader" width="1%" align="center"></td>
		</tr>
		<cfif getPublicAffairs.RecordCount GT 0>
			<cfset expRowCount = 4>
			<cfoutput query="getPublicAffairs">
				<cfset row = 1-row>
				<cfset expRowCount = expRowCount+1>
				<TR>
					<!--- edit record --->
					<FORM NAME="editPublicAffairs" ACTION="" METHOD="post">
						<!--- scrub url input for XSS --->
						<cfinclude template="/Common/XSS_Scubber.cfm" >
						<cfset class = "row" & row>
						<td valign="top" class="row#row#">
							<input type="submit" name="imgEditPublicAffairs" value="" alt="edit" style="background: url(images/icon_pencil.gif) no-repeat; height: 25px; width: 23px; border: none; cursor: pointer;">
							<input type="hidden" name="btnEditPublicAffairs" value="btnEditPublicAffairs" />
							<input type="hidden" name="edittype" value="editPublicAffairs" />
							<input type="hidden" name="PublicAffairsID" value="#getPublicAffairs.Public_Affairs_ID#" />
							<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
							<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
							<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
							<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
							<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
							<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
							<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
							<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
							<cfif isDefined("form.SortBy")><input type="Hidden" name="SortBy" value="#form.SortBy#"></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
						</td>
					</FORM>
					<cfset action = "">
					<cfset actionCnt = 0>
					<cfset actionClass = class>
					<td valign="top" class="#class#">#getPublicAffairs.Site_ID#</td>
					<td valign="top" class="#class#">#getPublicAffairs.Site_Name#</td>
					<td valign="top" class="#class#">#getPublicAffairs.Address#<br>#getPublicAffairs.City#, #getPublicAffairs.State_Abbreviation#<cfif len(getPublicAffairs.Zip_Code)>, #getPublicAffairs.Zip_Code#</cfif></td>
					<td valign="top" class="#class#"><cfif len(getPublicAffairs.User_id)>#getPublicAffairs.Last_Name#, #getPublicAffairs.First_Name#</cfif></td>
					<td valign="top" class="#class#" align="center">#dateformat(getPublicAffairs.Assessment_Date,"mm/dd/yyyy")#</td>
					<td valign="top" class="#class#" align="center">#yesnoformat(getPublicAffairs.Q1)#</td>
					<td valign="top" class="#class#" align="center">#yesnoformat(getPublicAffairs.Q2)#</td>
					<td valign="top" class="#class#" align="center">#yesnoformat(getPublicAffairs.Q3)#</td>
					<td valign="top" class="#class#" align="center">#yesnoformat(getPublicAffairs.Q4)#</td>
					<td valign="top" class="#class#" align="center">#yesnoformat(getPublicAffairs.Q5)#</td>
					<td valign="top" class="#class#" align="center">#yesnoformat(getPublicAffairs.Q6)#</td>
					<td valign="top" class="#class#" align="center">#yesnoformat(getPublicAffairs.Q7)#</td>
					<td valign="top" class="#class#" align="center">#yesnoformat(getPublicAffairs.Q8)#</td>
					<cfif getPublicAffairs.Q1 EQ 1><cfset actionCnt = actionCnt+1></cfif>
					<cfif getPublicAffairs.Q2 EQ 1><cfset actionCnt = actionCnt+1></cfif>
					<cfif getPublicAffairs.Q3 EQ 1><cfset actionCnt = actionCnt+1></cfif>
					<cfif getPublicAffairs.Q4 EQ 1><cfset actionCnt = actionCnt+1></cfif>
					<cfif getPublicAffairs.Q5 EQ 1><cfset actionCnt = actionCnt+1></cfif>
					<cfif getPublicAffairs.Q6 EQ 1><cfset actionCnt = actionCnt+1></cfif>
					<cfif actionCnt LTE 1><cfset action = "Monitor"><cfset actionClass = "StatGreen"></cfif>
					<cfif actionCnt EQ 2><cfset action = "Consult reqd"><cfset actionClass = "StatYellow"></cfif>
					<cfif actionCnt GTE 3><cfset action = "Assmnt reqd"><cfset actionClass = "StatRed"></cfif>
					<td valign="top" align="center" class="#actionClass#">#action#</td>

					<!--- delete record --->
					<FORM NAME="deletePublicAffairs" ACTION="" METHOD="post">
						<!--- scrub url input for XSS --->
						<cfinclude template="/Common/XSS_Scubber.cfm" >
						<td valign="top" class="row#row#" width="1%">
							<input type="Image" name="btnDeletePublicAffairs" src="images/icon_trash.gif" border="0" onclick="if (confirm('Delete this record?')){submit()}; return false" alt="delete this record">
							<input type="hidden" name="deletePublicAffairs" value="deletePublicAffairs" />
							<input type="hidden" name="PublicAffairsID" value="#getPublicAffairs.Public_Affairs_ID#" />
							<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
							<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
							<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
							<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
							<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
							<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
							<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
							<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
							<cfif isDefined("form.SortBy")><input type="Hidden" name="SortBy" value="#form.SortBy#"></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
						</td>
					</FORM>
				</tr>
			</cfoutput>
			<cfinclude template="Public_Affairs_export.cfm">
		<cfelse>
			<cfset row = 1-row>
			<cfoutput>
			<TR>
				<td ALIGN="center" valign="top" colspan="16" class="row#row#"><em>There are no records that match your search parameters</em></td>
			</tr>
			</cfoutput>
		</cfif>
	</TABLE>
</cfif>
<script>document.frmGetSites.SitePortfolioToFind.focus();</script>
