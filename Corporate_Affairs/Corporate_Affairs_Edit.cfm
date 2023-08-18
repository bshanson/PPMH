<!----------------------------------------------------------------------------------------------------------
Description:
	Corporate Affairs requirements admin page

History:
	1/11/2022 - created
----------------------------------------------------------------------------------------------------------->

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

<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- get all Sites --->
<cfinclude template="../components/q_getAllSites.cfm">
<!--- linked select function --->
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
	function initLinkedSelect(from, to, options)
	{
		(from.style || from).visibility = "visible";
		arr_to.push(to);
		arr_options.push(options);
		from.onchange = function()
		{
			change_them_all(from, arr_to, arr_options)
		}
		from.onchange();
	}
	
	// change portfolio and sites
	function change_them_all(from, arr_to, arr_options)
	{
		for (j=0; j<arr_to.length; j++)
		{
			change_them(from, arr_to[j], arr_options[j]) ;
		}
	}
	
	// change site elements
	function change_them(from, to, options) 
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
<cfinvoke component="Components.getPortfolios" method="CorpAffairsPortfolios" returnvariable="getPortfolios"></cfinvoke>
<!--- get sites --->
<cfinclude template="q_getSites.cfm">

<cfparam name="form.Onsite" default="1">

<!--- replace double quote with single quote --->
<cfloop collection="#form#" item="name">
	<cfif name NEQ "imgEditCorpAffairs.X" and name NEQ "imgEditCorpAffairs.Y">
		<cfset "form.#name#" = #replace(evaluate("form.#name#"),chr(34),"'","all")#>
	</cfif>
</cfloop>

<!--- update CorporateAffairs info --->
<cfif isDefined("form.btnUpdateCorpAffairs")>
	<!--- edit record --->
	<cfif isDefined("form.edittype") AND form.edittype EQ "editCorpAffairs">
		<cfinclude template="q_updCorporateAffairs.cfm" >
	</cfif>

	<!--- add new record --->
	<cfif isDefined("form.edittype") AND form.edittype EQ "addCorporateAffairs">
		<cfinclude template="q_addCorporateAffairs.cfm" >
	</cfif>
</cfif>

<!--- set form info --->
<cfif form.edittype EQ "editCorpAffairs">
	<cfif not ArrayLen(errormsg)>
		<!--- get CorporateAffairs Info --->
		<cfif isDefined("form.CorporateAffairsID")>
			<cfinclude template="q_getCorporateAffairsInfo.cfm">
		</cfif>
		<cfset form.AdminSiteID = getCorporateAffairsInfo.Admin_Site_ID>
		<cfset form.SiteID = getCorporateAffairsInfo.Site_ID>
		<cfset form.PortfolioID = getCorporateAffairsInfo.Portfolio_ID>
		<cfset form.SiteName = getCorporateAffairsInfo.Site_Name>
		<cfset form.Address = getCorporateAffairsInfo.Address>
		<cfset form.City = getCorporateAffairsInfo.City>
		<cfset form.StateAbbreviation = getCorporateAffairsInfo.State_Abbreviation>
		<cfset form.TrackingDate = dateformat(getCorporateAffairsInfo.Tracking_Date, "mm/dd/yyyy")>
		<cfset form.TriggerDate = dateformat(getCorporateAffairsInfo.Trigger_Date, "mm/dd/yyyy")>
		<cfset form.Description = getCorporateAffairsInfo.Description>
	<cfelse>
		<cfset form.AdminSiteID = form.AdminSiteID>
		<cfset form.SiteID = form.SiteID>
		<cfset form.PortfolioID = form.PortfolioID>
		<cfset form.SiteName = form.SiteName>
		<cfset form.Address = form.Address>
		<cfset form.City = form.City>
		<cfset form.StateAbbreviation = form.StateAbbreviation>
		<cfset form.TrackingDate	= form.TrackingDate>
		<cfset form.TriggerDate = form.TriggerDate>
		<cfset form.Description = form.Description>
	</cfif>
</cfif>

<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText"></td>
		<td class="largeText" width="1%"></td>
	</TR>
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText" ><strong>Communication Triggers and Notification Tracking</strong></TD>
		<td class="largeText" width="1%"></td>
	</TR>
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText" align="left">
			<li>Use this page to track communication triggers and notifications.</li>
			<li>Enter / edit the information and click the Save button.</li>
			<li>Once saved, an automated email will be sent to the Chevron Ops Lead for the project and the appropriate contacts at Chevron Corporate Affairs.</li>
		</td>
		<td class="largeText" width="1%"></td>
	</TR>
</TABLE>

<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
		<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
		<FORM NAME="CorporateAffairsEdit" METHOD="POST" ACTION="">
			<!--- scrub url input for XSS --->
			<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.CorporateAffairsID")><input type="Hidden" name="CorporateAffairsID" value="#form.CorporateAffairsID#"></cfif>
			<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
			<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
			<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
			<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
			<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
			<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
			<cfif isDefined("form.edittype")><input type="hidden" name="edittype" value="#form.edittype#" /></cfif>
			<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
			<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
			<cfloop query="getRegions">
				<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
					<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
				</cfif>
			</cfloop>
			<cfif isDefined("form.SiteID")><input type="Hidden" name="SiteID" value="#form.SiteID#"></cfif>
			<cfif isDefined("form.SiteName")><input type="Hidden" name="SiteName" value="#form.SiteName#"></cfif>
			<cfif isDefined("form.Address")><input type="Hidden" name="Address" value="#form.Address#"></cfif>
			<cfif isDefined("form.City")><input type="Hidden" name="City" value="#form.City#"></cfif>
			<cfif isDefined("form.StateAbbreviation")><input type="Hidden" name="StateAbbreviation" value="#form.StateAbbreviation#"></cfif>
			<cfif isDefined("form.TriggerDescription")><input type="Hidden" name="TriggerDescription" value="#form.TriggerDescription#"></cfif>

			<cfif ArrayLen(errormsg)><TR><TD colspan="2" class="errorText" align="center">
			There were errors, please review the following:<br>
			<cfloop index="intError"from="1"to="#ArrayLen(errormsg)#"step="1">
				<li>#errormsg[intError]#</li>
			</cfloop>
			</TD></TR>
			<cfelseif len(successmsg)><TR><TD colspan="2" class="successText" align="center"><div id="msg">*** #successmsg# ***</div></TD></TR>
			<cfelse><TR><TD colspan="2" class="successText" align="center">&nbsp;</TD></TR>
			</cfif>

			<!--- Portfolio --->
			<TR>
				<TD class="largeText" width="6%" align="right"><strong>Portfolio:</strong>&nbsp;</TD>
				<TD class="largeText">
					<select name="PortfolioID" id="PortfolioID" class="largeText" onchange="initLinkedSelect(element['PortfolioID'],element['AdminSiteID'],optionData)">
						<option value="0">- select a portfolio -</option>
						<cfloop query="getPortfolios">
							<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.PortfolioID") and form.PortfolioID EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- site --->
			<TR>
				<TD class="largeText" align="right"><strong>Site ID:</strong>&nbsp;</TD>
				<TD class="largeText">
					<select name="AdminSiteID" id="AdminSiteID" class="largeText">
						<option value="0">- select a site -</option>
						<cfloop query="getSites">
							<option value="#getSites.Admin_Site_ID#" <cfif isDefined("form.AdminSiteID") and form.AdminSiteID EQ getSites.Admin_Site_ID>selected="selected"</cfif>>#getSites.Site_ID#, #getSites.Site_Name#, #getSites.Address#, #getSites.City#, #getSites.State_Abbreviation#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- Date --->
			<TR>
				<TD class="largeText" align="right"><strong>Notification Date:</strong>&nbsp;</TD>
				<TD class="largeText">
					<INPUT TYPE="text" name="TrackingDate" size="15" maxlength="10" class="largeText" VALUE="<cfif isDefined('form.TrackingDate')>#form.TrackingDate#</cfif>">
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp1']:document.TaskPopUp1_Position), document.forms.CorporateAffairsEdit.TrackingDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp1_Position" ID="TaskPopUp1_Position" BORDER="0" ALT="Date"></A>
					<i>If the Notification Date is different than today's date, a comment about prior notification must be included in the Description below.</i>
				</TD>
			</TR>

			<!--- Date of Trigger --->
			<TR>
				<TD class="largeText" align="right"><strong>Date of Trigger Event:</strong>&nbsp;</TD>
				<TD class="largeText">
					<INPUT TYPE="text" name="TriggerDate" size="15" maxlength="10" class="largeText" VALUE="<cfif isDefined('form.TriggerDate')>#form.TriggerDate#</cfif>">
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp2']:document.TaskPopUp2_Position), document.forms.CorporateAffairsEdit.TriggerDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp2_Position" ID="TaskPopUp2_Position" BORDER="0" ALT="Date"></A>
				</TD>
			</TR>

			<!--- Description --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Description:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<INPUT TYPE="text" name="Description" size="135" maxlength="300" class="largeText" VALUE="<cfif isDefined('form.Description')>#form.Description#</cfif>">
				</TD>
			</TR>

			<!--- Triggers --->
			<cfinclude template="q_getTriggerCategorys.cfm" >
			<cfif isDefined("form.CorporateAffairsID")><cfmodule template="q_getTriggerList.cfm" CAID="#form.CorporateAffairsID#" Return="TriggerList"></cfif>
			<cfset row=1>
			<TR>
				<TD class="largeText"></TD>
				<TD class="largeText">
					<TABLE WIDTH="95%" CELLPADDING="0" CELLSPACING="1" bgcolor="##ffffff"><tr><td>
					<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" align="center" bgcolor="##ffffff"><tr><td>
					<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="##000000">
						<TR>
							<TD class="ListHeaderBlue" align="center" width="30%"><strong>Trigger Category</strong></td>
							<TD class="ListHeaderBlue" align="center" width="70%"><strong>Trigger Description</strong></td>
						</TR>
						<cfset numberTriggerDescriptions = 0>
						<cfloop query="getTriggerCategorys"> 
							<cfinclude template="q_getTriggerDescriptions.cfm" >
							<cfset row=1-row>
							<cfset numberTriggerDescriptions = numberTriggerDescriptions + getTriggerDescriptions.RecordCount>
							<TR>
								<TD class="row#row#" align="center">
									<TABLE WIDTH="100%" CELLPADDING="2" CELLSPACING="0" bgcolor="##ffffff">
										<tr valign="top"">
											<td class="row#row#" width="5%" align="right">#getTriggerCategorys.CurrentRow#.</td>
											<td class="row#row#" width="95%">#getTriggerCategorys.Trigger_Category#</td>
										</tr>
									</table>
								</td>
								<TD class="row#row#">
									<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="##A9A9A9">
										<cfloop query="getTriggerDescriptions" >
											<tr>
												<td class="row#row#" width="99%">#getTriggerDescriptions.Trigger_Description#</td>
												<TD class="row#row#" align="center"><input type="checkbox" name="td#getTriggerDescriptions.Trigger_Description_ID#" <cfif isDefined("TriggerList") and listfind(TriggerList, getTriggerDescriptions.Trigger_Description_ID)>checked="checked"</cfif>></td>
											</tr>
										</cfloop>
									</table>
								</td>
							</TR>
						</cfloop>
						<input type="hidden" name="noTriggerDescriptions" value="#numberTriggerDescriptions#">
					</table>
					</td></tr></table>
					</td></tr></table>
				</td>
			</TR>

			<!--- buttons --->
			<tr>
				<td width="13%"></td>
				<td>
					<input type="submit" name="btnUpdateCorpAffairs" value="Save" class="FormBodyButton">
					<input type="submit" name="btnReturn" value="Return" class="FormBodyButton" />
				</td>
			</tr>
		</FORM>
	</TABLE>
</cfoutput>
<cfif isDefined("form.edittype") and form.edittype EQ "editCorpAffairs">
	<script>document.CorporateAffairsEdit.Description.focus();</script>
<cfelse>
	<script>document.CorporateAffairsEdit.PortfolioID.focus();</script>
</cfif>
<SCRIPT>var element=document.forms['CorporateAffairsEdit'].elements;</SCRIPT>
