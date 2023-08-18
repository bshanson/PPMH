<!----------------------------------------------------------------------------------------------------------
Description:
	regulatory requirements admin page

History:
	2/7/2020 - created
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

<!--- get sites --->
<cfinclude template="../components/q_getSites.cfm">

<!--- replace double quote with single quote --->
<cfloop collection="#form#" item="name">
	<cfif name NEQ "imgEditRegulatory.X" and name NEQ "imgEditRegulatory.Y">
		<cfset "form.#name#" = #replace(evaluate("form.#name#"),chr(34),"'","all")#>
	</cfif>
</cfloop>

<!--- update regulatory info --->
<cfif isDefined("form.btnUpdateRegulatory")>
	<!--- edit record --->
	<cfif isDefined("form.edittype") AND form.edittype EQ "editRegulatory">
		<cfinclude template="q_updRegulatory.cfm" >
	</cfif>

	<!--- add new record --->
	<cfif isDefined("form.edittype") AND form.edittype EQ "addRegulatory">
		<cfinclude template="q_addRegulatory.cfm" >
	</cfif>
</cfif>

<!--- set form info --->
<cfif form.edittype EQ "editRegulatory">
	<cfif not ArrayLen(errormsg)>
		<!--- get Regulatory Info --->
		<cfif isDefined("form.RegulatoryID")>
			<cfinclude template="q_getRegulatoryInfo.cfm">
		</cfif>
		<cfset form.AdminSiteID = getRegulatoryInfo.Admin_Site_ID>
		<cfset form.SiteID = getRegulatoryInfo.Site_ID>
		<cfset form.SiteName = getRegulatoryInfo.Site_Name>
		<cfset form.Address = getRegulatoryInfo.Address>
		<cfset form.City = getRegulatoryInfo.City>
		<cfset form.StateAbbreviation = getRegulatoryInfo.State_Abbreviation>
		<cfset form.RegulatoryAction = getRegulatoryInfo.Regulatory_Action>
		<cfset form.RegulatoryDate = dateformat(getRegulatoryInfo.Regulatory_Date, "mm/dd/yyyy")>
		<cfset form.CompleteDate = dateformat(getRegulatoryInfo.Complete_Date, "mm/dd/yyyy")>
	<cfelse>
		<cfset form.AdminSiteID = form.AdminSiteID>
		<cfset form.SiteID = form.SiteID>
		<cfset form.SiteName = form.SiteName>
		<cfset form.Address = form.Address>
		<cfset form.City = form.City>
		<cfset form.StateAbbreviation = form.StateAbbreviation>
		<cfset form.RegulatoryAction = form.RegulatoryAction>
		<cfset form.RegulatoryDate = form.RegulatoryDate>
		<cfset form.CompleteDate	= form.CompleteDate>
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
		<td class="largeText" ><strong>Regulatory Requirement / Action Tracking Administration</strong></TD>
		<td class="largeText" width="1%"></td>
	</TR>
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText" align="left">
			<li>Use this page to administer regulatory requirements / actions information. Enter / edit the information and click the <strong>Save</strong> button.</li>
		</td>
		<td class="largeText" width="1%"></td>
	</TR>
</TABLE>

<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
		<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
		<FORM NAME="RegulatoryAdmin" METHOD="POST" ACTION="">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.RegulatoryID")><input type="Hidden" name="RegulatoryID" value="#form.RegulatoryID#"></cfif>
			<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
			<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
			<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
			<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
			<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
			<cfif isDefined("form.edittype")><input type="hidden" name="edittype" value="#form.edittype#" /></cfif>
			<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
			<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
			<cfif isDefined("form.RegulatoryFromDatetofind")><input type="Hidden" name="RegulatoryFromDatetofind" value="#form.RegulatoryFromDatetofind#"></cfif>
			<cfif isDefined("form.RegulatoryToDatetofind")><input type="Hidden" name="RegulatoryToDatetofind" value="#form.RegulatoryToDatetofind#"></cfif>
			<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
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

			<TR>
				<TD class="largeText" align="right"><strong>Site:</strong>&nbsp;</TD>
				<TD class="largeText">
					<cfif isDefined("form.edittype") and form.edittype EQ "editRegulatory">
						<input type="Hidden" name="AdminSiteID" value="#form.AdminSiteID#">
						<input type="Hidden" name="SiteID" value="#form.SiteID#">
						<input type="Hidden" name="SiteName" value="#form.SiteName#">
						<input type="Hidden" name="Address" value="#form.Address#">
						<input type="Hidden" name="City" value="#form.City#">
						<input type="Hidden" name="StateAbbreviation" value="#form.StateAbbreviation#">
						#form.SiteID#, #form.SiteName#, #form.Address#, #form.City#, #form.StateAbbreviation#
					<cfelse>
						<select name="AdminSiteID" class="accountText">
							<option value="">select a site</option>
							<cfloop query="getSites">
								<option value="#getSites.Admin_Site_ID#" <cfif isDefined("form.AdminSiteID") and form.AdminSiteID EQ getSites.Admin_Site_ID>selected="selected"</cfif>>#getSites.Site_ID#, #getSites.Site_Name#, #getSites.Address#, #getSites.City#, #getSites.State_Abbreviation#</option>
							</cfloop>
						</select>
					</cfif>
				</TD>
			</TR>

			<!--- Req / Action --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Requirement / Action:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<textarea name="RegulatoryAction" cols="139" rows="10" class="largeText"><cfif isDefined("form.RegulatoryAction")>#form.RegulatoryAction#</cfif></textarea>
				</TD>
			</TR>

			<!--- Date --->
			<TR>
				<TD class="largeText" align="right"><strong>Date:</strong>&nbsp;</TD>
				<TD class="largeText">
					<INPUT TYPE="text" name="RegulatoryDate" size="15" maxlength="10" class="largeText" VALUE="<cfif isDefined('form.RegulatoryDate')>#form.RegulatoryDate#</cfif>">
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp1']:document.TaskPopUp1_Position), document.forms.RegulatoryAdmin.RegulatoryDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp1_Position" ID="TaskPopUp1_Position" BORDER="0" ALT="Date"></A>
				</TD>
			</TR>

			<!--- Completion Date --->
			<TR>
				<TD class="largeText" align="right"><strong>Completion Date:</strong>&nbsp;</TD>
				<TD class="largeText">
					<INPUT TYPE="text" name="CompleteDate" size="15" maxlength="10" class="largeText" VALUE="<cfif isDefined('form.CompleteDate')>#form.CompleteDate#</cfif>">
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp2']:document.TaskPopUp2_Position), document.forms.RegulatoryAdmin.CompleteDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp2_Position" ID="TaskPopUp2_Position" BORDER="0" ALT="Date"></A>
				</TD>
			</TR>

			<!--- buttons --->
			<tr>
				<td width="13%"></td>
				<td>
					<input type="submit" name="btnUpdateRegulatory" value="Save" class="FormBodyButton">
					<input type="submit" name="btnReturn" value="Return" class="FormBodyButton" />
				</td>
			</tr>
		</FORM>
	</TABLE>
</cfoutput>
<cfif isDefined("form.edittype") and form.edittype EQ "editRegulatory">
	<script>document.RegulatoryAdmin.RegulatoryAction.focus();</script>
<cfelse>
	<script>document.RegulatoryAdmin.AdminSiteID.focus();</script>
</cfif>
