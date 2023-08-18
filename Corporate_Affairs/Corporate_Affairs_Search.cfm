<!----------------------------------------------------------------------------------------------------------
Description:
	Corporate Affairs requirements search page

History:
	1/11/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfset FromError = "">
<cfset ToError = "">
<cfset errormsg = "">

<SCRIPT>
function buttonDisable() {
	if (document.CorporateAffairsSearch.btnAddCorpAffairs) document.CorporateAffairsSearch.btnAddCorpAffairs.style.visibility='hidden';
	if (document.CorporateAffairsSearch.lblExcelButton) document.CorporateAffairsSearch.lblExcelButton.style.visibility='hidden';
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
<cfinvoke component="Components.getPortfolios" method="CorpAffairsPortfolios" returnvariable="getPortfolios"></cfinvoke>
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- delete CorporateAffairs record --->
<cfif isDefined("form.deleteCorporateAffairs") and form.deleteCorporateAffairs EQ "deleteCorporateAffairs">
	<cfinclude template="q_delCorporateAffairs.cfm">
</cfif>

<!--- search for the site --->
<cfif isDefined("form.SiteIDtofind") or isDefined("url.CAID")>
	<cfinclude template="q_getDistinctCorporateAffairs.cfm">
</cfif>

<!--- help text --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR valign="top">
		<td class="largeText" width="1%"></td>
		<td class="largeText" width="1%"></td>
		<td class="largeText"></td>
		<td class="largeText" width="1%"></td>
	</TR>
	<TR valign="top">
		<td class="largeText"></td>
		<td class="largeText" colspan="2"><strong>Communication Triggers and Notification Tracking</strong></TD>
		<td class="largeText"></td>
	</TR>
	<TR valign="top">
		<td class="largeText"></td>
		<td class="largeText"><li></li></td>
		<td class="largeText">Use this page to track communication triggers and notifications</td>
		<td class="largeText"></td>
	</TR>
	<TR valign="top">
		<td class="largeText"></td>
		<td class="largeText"><li></li></td>
		<td class="largeText">Communication triggers reflect new developments at a site that may prompt revisiting technical, legal, or community strategy at the site.</td>
		<td class="largeText"></td>
	</TR>
	<TR valign="top">
		<td class="largeText"></td>
		<td class="largeText"><li></li></td>
		<td class="largeText">Search by selecting and / or filling in the any fields below and clicking Search. Exact terms are not necessary, substrings of a search item may be used. To display all records, leave the fields blank and click the Search button. Once displayed, you will be able to enter, edit, or delete the resulting information.</td>
		<td class="largeText"></td>
	</TR>
	<TR valign="top">
		<td class="largeText"></td>
		<td class="largeText"><li></li></td>
		<td class="largeText">If creating a new entry, use the Create Entry button. New entries must include project information and a selection of the relevant communication trigger(s). Once saved, an automated email will be sent to the Chevron Ops Lead for the project and the appropriate contacts at Chevron Corporate Affairs.</td>
		<td class="largeText"></td>
	</TR>
</TABLE>

<!--- search form --->
<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="##ffffff">
		<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
		<form name="CorporateAffairsSearch" action="" method="post">
			<!--- scrub url input for XSS --->
			<cfinclude template="/Common/XSS_Scubber.cfm" >
			<!--- Site Portfolio, Region --->
			<TR>
				<td class="largeText"></td>
				<td class="largeText" align="right"><strong>Site Portfolio:</strong>&nbsp;</td>
				<td class="largeText" colspan="2" valign="top">
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

			<!--- Site Manager, deputy, dates --->
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
					<input type="text" name="FromDateToFind" class="largeText" size="15" maxlength="10" <cfif isDefined("form.FromDateToFind") and len(form.FromDateToFind)>value="#form.FromDateToFind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp1']:document.TaskPopUp1_Position), document.forms.CorporateAffairsSearch.FromDateToFind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp1_Position" ID="TaskPopUp1_Position" BORDER="0" ALT="Date"></A>
					<cfif len(FromError)><span class="errortext"><i>#FromError#</i></span></cfif>
					&nbsp;
					<strong>To:</strong>&nbsp;
					<input type="text" name="ToDateToFind" class="largeText" size="15" maxlength="10" <cfif isDefined("form.ToDateToFind") and len(form.ToDateToFind)>value="#form.ToDateToFind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp2']:document.TaskPopUp2_Position), document.forms.CorporateAffairsSearch.ToDateToFind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp2_Position" ID="TaskPopUp2_Position" BORDER="0" ALT="Date"></A>
					<cfif len(ToError)><span class="errortext"><i>#ToError#</i></span></cfif>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
	
			<!--- buttons --->
			<TR>
				<td class="largeText" align="right"></td>
				<td class="largeText" align="right"></td>
				<td class="largeText">
					<input type="Submit" name="Search" class="largeTextButton" value="Search" onClick="buttonDisable();">
					<input type="Submit" name="btnAddCorpAffairs" class="largeTextButton" value="Add New Communication Record">
					<input type="hidden" name="edittype" value="addCorporateAffairs" />
					<cfif isDefined("getDistinctCorporateAffairs") and getDistinctCorporateAffairs.RecordCount GT 0>
						<CFSET FileName="CorporateAffairs_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
						<input type="button" name="lblExcelButton" class="largeTextButton" value="Open Excel File" ONCLICK="window.open('#Request.ExcelPath#/#FileName#')">
					</cfif>
				</td>
			</TR>
			<TR>
				<td class="largeText" align="right" width="1%"></td>
				<td class="largeText" align="right" width="10%">&nbsp;</td>
				<td class="largeText">&nbsp;</td>
			</TR>
		</form>
	</TABLE>
</cfoutput>

<!--- display site information --->
<cfif isDefined("getDistinctCorporateAffairs")>
	<cfset expRowCount = 0>
	<cfset row = 1>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="silver">
		<TR>
			<td ALIGN="center" class="ServiceListHeader" width="1%"></td>
			<td ALIGN="center" class="ServiceListHeader" width="7%">Site ID</td>
			<td ALIGN="center" class="ServiceListHeader" width="15%">Site Name</td>
			<td ALIGN="center" class="ServiceListHeader" width="15%">Address</td>
			<td ALIGN="center" class="ServiceListHeader" width="27%">Category</td>
			<td ALIGN="center" class="ServiceListHeader" width="27%">Description</td>
			<td ALIGN="center" class="ServiceListHeader" width="7%">Trigger Date</td>
			<td ALIGN="center" class="ServiceListHeader" width="1%"></td>
		</tr>
		<cfif getDistinctCorporateAffairs.RecordCount GT 0>
			<cfoutput query="getDistinctCorporateAffairs">
				<cfset row = 1-row>
				<cfmodule template="q_getCorporateAffairs.cfm" CAID="#getDistinctCorporateAffairs.Corporate_Affairs_ID#" Return="getCorporateAffairs">
				<TR>
					<cfset expRowCount = expRowCount + 1>
					<!--- edit record --->
					<FORM NAME="editCorpAffairs" ACTION="" METHOD="post">
						<!--- scrub url input for XSS --->
						<cfinclude template="/Common/XSS_Scubber.cfm" >
						<td valign="top" class="row#row#">
							<input type="Image" name="imgEditCorpAffairs" src="images/icon_pencil.gif" border="0" onclick="submit()" alt="edit CorporateAffairs information">
							<input type="hidden" name="btnEditCorpAffairs" value="btnEditCorpAffairs" />
							<input type="hidden" name="edittype" value="editCorpAffairs" />
							<input type="hidden" name="CorporateAffairsID" value="#getDistinctCorporateAffairs.Corporate_Affairs_ID#" />
							<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
							<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
							<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
							<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
							<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
							<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
							<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
							<cfif isDefined("form.FromDateToFind")><input type="Hidden" name="FromDateToFind" value="#form.FromDateToFind#"></cfif>
							<cfif isDefined("form.ToDateToFind")><input type="Hidden" name="ToDateToFind" value="#form.ToDateToFind#"></cfif>
							<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
						</td>
					</FORM>
					<td valign="top" class="row#row#">#getDistinctCorporateAffairs.Site_ID#</td>
					<td valign="top" class="row#row#">#getDistinctCorporateAffairs.Site_Name#</td>
					<td valign="top" class="row#row#">#getDistinctCorporateAffairs.Address#, #getDistinctCorporateAffairs.City#, #getDistinctCorporateAffairs.State_Abbreviation#</td>
					<td valign="top" class="row#row#" colspan="2">
						<table width="100%" cellspacing="0" cellpadding="0">
						<cfloop query="getCorporateAffairs">
							<tr valign="top">
								<cfset expRowCount = expRowCount + 1>
								<cfset tdcolor = "row" & #row#>
								<cfif (getCorporateAffairs.CurrentRow) MOD 2 EQ 0><cfset tdcolor = "blue1"></cfif>
								<td class="#tdcolor#" width="50%">#getCorporateAffairs.Trigger_Category_ID#. #getCorporateAffairs.Trigger_Category#</td>
								<td class="#tdcolor#">#getCorporateAffairs.Trigger_Description#</td>
							</tr>
						</cfloop>
						</table>
					</td>
					<td valign="top" ALIGN="center" class="row#row#">#dateformat(getDistinctCorporateAffairs.Trigger_Date,"mm/dd/yyyy")#</td>
					<!--- delete record --->
					<FORM NAME="deleteCorporateAffairs" ACTION="" METHOD="post">
						<!--- scrub url input for XSS --->
						<cfinclude template="/Common/XSS_Scubber.cfm" >
						<td valign="top" class="row#row#" width="1%">
							<input type="Image" name="btnDeleteCorporateAffairs" src="images/icon_trash.gif" border="0" onclick="if (confirm('Delete this record?')){submit()}; return false" alt="delete this record">
							<input type="hidden" name="deleteCorporateAffairs" value="deleteCorporateAffairs" />
							<input type="hidden" name="delCorporateAffairsID" value="#getDistinctCorporateAffairs.Corporate_Affairs_ID#" />
							<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
							<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
							<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
							<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
							<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
							<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
							<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
							<cfif isDefined("form.FromDateToFind")><input type="Hidden" name="FromDateToFind" value="#form.FromDateToFind#"></cfif>
							<cfif isDefined("form.ToDateToFind")><input type="Hidden" name="ToDateToFind" value="#form.ToDateToFind#"></cfif>
							<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
							<cfloop query="getRegions">
								<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
									<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
								</cfif>
							</cfloop>
						</td>
					</FORM>
				</tr>
			</cfoutput>
			<cfinclude template="Corporate_Affairs_export.cfm">
		<cfelse>
			<cfset row = 1-row>
			<cfoutput>
			<TR>
				<td ALIGN="center" valign="top" colspan="8" class="row#row#"><em>There are no records that match your search parameters</em></td>
			</tr>
			</cfoutput>
		</cfif>
	</TABLE>
</cfif>
<script>document.CorporateAffairsSearch.SitePortfolioToFind.focus();</script>
