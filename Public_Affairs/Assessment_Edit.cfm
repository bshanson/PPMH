<!-------------------------------------------
Description:
	assessment edit page

History:
	5/24/2021 - created
-------------------------------------------->

<cfparam name="Site_ID" default="1">

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
<cfinclude template="../components/q_getPortfolios.cfm">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- search for the site --->
<cfif isDefined("form.SiteIDtofind") or isDefined("url.RID")>
	<cfinclude template="q_getRegulatory.cfm" >
</cfif>


<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="##ffffff">
		<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
		<form name="frmGetSites" action="" method="post">
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
					<!--- <strong>Date - From:</strong>&nbsp;
					<input type="text" name="RegulatoryFromDatetofind" class="largeText" size="15" maxlength="10" <cfif isDefined("form.RegulatoryFromDatetofind") and len(form.RegulatoryFromDatetofind)>value="#form.RegulatoryFromDatetofind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp1']:document.TaskPopUp1_Position), document.forms.frmGetSites.RegulatoryFromDatetofind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp1_Position" ID="TaskPopUp1_Position" BORDER="0" ALT="Date"></A>
					<strong>To:</strong>&nbsp;
					<input type="text" name="RegulatoryToDatetofind" class="largeText" size="15" maxlength="10" <cfif isDefined("form.RegulatoryToDatetofind") and len(form.RegulatoryToDatetofind)>value="#form.RegulatoryToDatetofind#"</cfif>>
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp2']:document.TaskPopUp2_Position), document.forms.frmGetSites.RegulatoryToDatetofind, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp2_Position" ID="TaskPopUp2_Position" BORDER="0" ALT="Date"></A>
                    --->
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
					<!--- <cfif isDefined("getRegulatory")>
						<input type="Submit" name="btnAddRegulatory" class="largeTextButton" value="Add New Regulatory Record">
						<input type="hidden" name="edittype" value="addRegulatory" />
					</cfif>
					<cfif isDefined("getRegulatory") and getRegulatory.RecordCount GT 0>
						<CFSET FileName="Regulatory_#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"HHmmss")#.xls">
						<input type="button" name="lblExcelButton" class="largeTextButton" value="Open Excel File" ONCLICK="window.open('#Request.ExcelPath#/#FileName#')">
					</cfif> --->
				</td>
			</TR>
			<TR>
				<td class="largeText" align="right" width="1%"></td>
				<td class="largeText" align="right" width="8%">&nbsp;</td>
				<td class="largeText" >&nbsp;</td>
			</TR>
            <cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)>
                <cfset Site_Id = form.SiteIDtofind>
            </cfif>
		</form>
	</TABLE>
</cfoutput>

<cfoutput>
    <cfinclude template="q_getQuestions.cfm">

    <TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
        <tr>
            <cfif numFlags GTE "3">
                <td style="background-color:##FF0000" class="largeText">Detailed assessment required = notification to Steven Perry and Bridget Butterly.</td>
            <cfelseif numFlags EQ "2">
                <td style="background-color:##FFFF00" class="largeText">Public affairs consult required = notification to Steven Perry and Bridget Butterly.</td>
            <cfelse>
                <td style="background-color:##008000" class="largeText">Continue to monitor for change = no notification needed at this time.</td>
            </cfif>
        </tr>
        <FORM NAME="AssessAnswer" ACTION="q_updAssess.cfm" METHOD="POST">
            <cfloop query="qGetQuestions">
                <input type="hidden" name="FlagOn_#QId#" value="#FlagOn#">
                <input type="hidden" name="Site_ID" value="#Site_Id#">
                <input type="hidden" name="QTitle_#QId#" value="#QTitle#">
                <input type="hidden" name="QText_#QId#" value="#QText#">
                <input type="hidden" name="DescribeText_#QId#" value="#DescribeText#">
                <tr align="left"><th>#replace(QTitle,"|",",","all")#</th></tr>
                <tr>
                    <td class="largeText">#replace(QText,"|",",","all")#</td>
                    <td class="largeText">
                        <select name="Bit_#QId#">
                            <option value="0" <cfif #QValue# EQ false>selected</cfif>>No</option>
                            <option value="1"<cfif #QValue# EQ true>selected</cfif>>Yes</option>
                        </select>
                    </td>
                </tr>
                <tr><td class="largeText">#replace(DescribeText,"|",",","all")#</td></tr>
                <tr><td class="largeText"><textarea name="Response_#QId#">#replace(DescribeResponse,"|",",","all")#</textarea></td></tr>
            </cfloop>
            <TR align="center">
		        <TD class="largeText">
			        <input type="submit" value="submit information" class="FormBodyButton" name="submitinfo">
		        </TD>
	        </TR>
        </FORM>
    </TABLE>
</cfoutput>