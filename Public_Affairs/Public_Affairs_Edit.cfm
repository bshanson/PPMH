<!----------------------------------------------------------------------------------------------------------
Description:
	Public Affairs admin page

History:
	5/24/2021 - created
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
	<cfif name NEQ "imgEditPublicAffairs.X" and name NEQ "imgEditPublicAffairs.Y">
		<cfset "form.#name#" = #replace(evaluate("form.#name#"),chr(34),"'","all")#>
	</cfif>
</cfloop>

<!--- update PublicAffairs info --->
<cfif isDefined("form.btnUpdatePublicAffairs")>
	<!--- edit record --->
	<cfif isDefined("form.edittype") AND form.edittype EQ "editPublicAffairs">
		<cfinclude template="q_updPublicAffairs.cfm" >
	</cfif>

	<!--- add new record --->
	<cfif isDefined("form.edittype") AND form.edittype EQ "addPublicAffairs">
		<cfinclude template="q_addPublicAffairs.cfm" >
	</cfif>
</cfif>

<!--- set form info --->
<cfif form.edittype EQ "editPublicAffairs">
	<cfif not ArrayLen(errormsg)>
		<!--- get PublicAffairs Info --->
		<cfif isDefined("form.PublicAffairsID")>
			<cfinclude template="q_getPublicAffairsInfo.cfm">
		</cfif>
		<cfset form.AdminSiteID = getPublicAffairsInfo.Admin_Site_ID>
		<cfset form.SiteID = getPublicAffairsInfo.Site_ID>
		<cfset form.SiteName = getPublicAffairsInfo.Site_Name>
		<cfset form.Address = getPublicAffairsInfo.Address>
		<cfset form.City = getPublicAffairsInfo.City>
		<cfset form.StateAbbreviation = getPublicAffairsInfo.State_Abbreviation>
		<cfset form.q1 = getPublicAffairsInfo.q1>
		<cfset form.q2 = getPublicAffairsInfo.q2>
		<cfset form.q3 = getPublicAffairsInfo.q3>
		<cfset form.q4 = getPublicAffairsInfo.q4>
		<cfset form.q5 = getPublicAffairsInfo.q5>
		<cfset form.q6 = getPublicAffairsInfo.q6>
		<cfset form.q7 = getPublicAffairsInfo.q7>
		<cfset form.q8 = getPublicAffairsInfo.q8>
		<cfset form.q1describe = getPublicAffairsInfo.q1_describe>
		<cfset form.q2describe = getPublicAffairsInfo.q2_describe>
		<cfset form.q3describe = getPublicAffairsInfo.q3_describe>
		<cfset form.q4describe = getPublicAffairsInfo.q4_describe>
		<cfset form.q5describe = getPublicAffairsInfo.q5_describe>
		<cfset form.q6describe = getPublicAffairsInfo.q6_describe>
		<cfset form.q7describe = getPublicAffairsInfo.q7_describe>
		<cfset form.q8describe = getPublicAffairsInfo.q8_describe>
		<cfset form.AssessmentDate = dateformat(getPublicAffairsInfo.Assessment_Date, "mm/dd/yyyy")>
		<cfset form.CommentsDate = dateformat(getPublicAffairsInfo.Comments_Date, "mm/dd/yyyy")>
		<cfset form.Comments = getPublicAffairsInfo.Comments>
	<cfelse>
		<cfset form.AdminSiteID = form.AdminSiteID>
		<cfset form.SiteID = form.SiteID>
		<cfset form.SiteName = form.SiteName>
		<cfset form.Address = form.Address>
		<cfset form.City = form.City>
		<cfset form.StateAbbreviation = form.StateAbbreviation>
		<cfset form.q1 = form.q1>
		<cfset form.q2 = form.q2>
		<cfset form.q3 = form.q3>
		<cfset form.q4 = form.q4>
		<cfset form.q5 = form.q5>
		<cfset form.q6 = form.q6>
		<cfset form.q7 = form.q7>
		<cfset form.q8 = form.q8>
		<cfset form.q1describe = form.q1describe>
		<cfset form.q2describe = form.q2describe>
		<cfset form.q3describe = form.q3describe>
		<cfset form.q4describe = form.q4describe>
		<cfset form.q5describe = form.q5describe>
		<cfset form.q6describe = form.q6describe>
		<cfset form.q7describe = form.q7describe>
		<cfset form.q8describe = form.q8describe>
		<cfset form.AssessmentDate	= form.AssessmentDate>
		<cfset form.CommentsDate	= form.CommentsDate>
		<cfset form.Comments = form.Comments>
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
		<td class="largeText" ><strong>Public Affairs Administration</strong></TD>
		<td class="largeText" width="1%"></td>
	</TR>
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText" align="left">
			<li>Use this page to administer public affairs information. Enter / edit the information and click the <strong>Save</strong> button.</li>
		</td>
		<td class="largeText" width="1%"></td>
	</TR>
</TABLE>

<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
		<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
		<FORM NAME="PublicAffairsAdmin" METHOD="POST" ACTION="">
			<!--- scrub url input for XSS --->
			<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.PublicAffairsID")><input type="Hidden" name="PublicAffairsID" value="#form.PublicAffairsID#"></cfif>
			<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
			<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
			<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
			<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
			<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
			<cfif isDefined("form.edittype")><input type="hidden" name="edittype" value="#form.edittype#" /></cfif>
			<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
			<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
			<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
			<cfif isDefined("form.SortBy")><input type="Hidden" name="SortBy" value="#form.SortBy#"></cfif>
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
				<TD class="largeText" colspan="2">
					<cfif isDefined("form.edittype") and form.edittype EQ "editPublicAffairs">
						<input type="Hidden" name="AdminSiteID" value="#form.AdminSiteID#">
						<input type="Hidden" name="SiteID" value="#form.SiteID#">
						<input type="Hidden" name="SiteName" value="#form.SiteName#">
						<input type="Hidden" name="Address" value="#form.Address#">
						<input type="Hidden" name="City" value="#form.City#">
						<input type="Hidden" name="StateAbbreviation" value="#form.StateAbbreviation#">
						#form.SiteID#, #form.SiteName#, #form.Address#, #form.City#, #form.StateAbbreviation#
					<cfelse>
						<select name="AdminSiteID" class="accountText">
							<option value="0">select a site</option>
							<cfloop query="getSites">
								<option value="#getSites.Admin_Site_ID#" <cfif isDefined("form.AdminSiteID") and form.AdminSiteID EQ getSites.Admin_Site_ID>selected="selected"</cfif>>#getSites.Site_ID#, #getSites.Site_Name#, #getSites.Address#, #getSites.City#, #getSites.State_Abbreviation#</option>
							</cfloop>
						</select>
					</cfif>
				</TD>
			</TR>

			<!--- space --->
			<tr><TD class="largeText" colspan="2" height="10"></td></tr>

			<!--- Q1 --->
			<TR>
				<TD class="largeText" valign="top" colspan="3">&nbsp;<strong>1)	Complaints, Spills, NOVs</strong>&nbsp;</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top" colspan="2">
					Have there been incidents such as complaints, spills/releases, NOVs, vandalism, or similar?
					<input type="radio" name="q1" class="largeText" value="0" <cfif isDefined("form.q1") and form.q1 EQ 0>checked="checked"</cfif>> No
					<input type="radio" name="q1" class="largeText" value="1" <cfif isDefined("form.q1") and form.q1 EQ 1>checked="checked"</cfif>> Yes
				</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top">If Yes, describe:</TD>
				<TD class="largeText" valign="top">
					<textarea name="Q1Describe" cols="139" rows="2" class="largeText"><cfif isDefined("form.Q1Describe")>#form.Q1Describe#</cfif></textarea>
				</TD>
			</TR>

			<!--- Q2 --->
			<TR>
				<TD class="largeText" valign="top" colspan="3">&nbsp;<strong>2)	Change in Plan</strong>&nbsp;</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top" colspan="2">
					Has there been or do we expect a change in plan, permitting, or project delay that may negatively impact stakeholders (regulators, local/state government, neighbors, schools, community groups,<br>environmental justice groups)? 
					<input type="radio" name="Q2" class="largeText" value="0" <cfif isDefined("form.Q2") and form.Q2 EQ 0>checked="checked"</cfif>> No
					<input type="radio" name="Q2" class="largeText" value="1" <cfif isDefined("form.Q2") and form.Q2 EQ 1>checked="checked"</cfif>> Yes
				</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top">If Yes, describe:</TD>
				<TD class="largeText" valign="top">
					<textarea name="Q2Describe" cols="139" rows="2" class="largeText"><cfif isDefined("form.Q2Describe")>#form.Q2Describe#</cfif></textarea>
				</TD>
			</TR>

			<!--- Q3 --->
			<TR>
				<TD class="largeText" valign="top" colspan="3">&nbsp;<strong>3)	Lack of Action</strong>&nbsp;</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top" colspan="2">
					Has there been or is there now a prolonged period of time with no physical activity or lack of action (actual or perceived) at the site?
					<input type="radio" name="Q3" class="largeText" value="0" <cfif isDefined("form.Q3") and form.Q3 EQ 0>checked="checked"</cfif>> No
					<input type="radio" name="Q3" class="largeText" value="1" <cfif isDefined("form.Q3") and form.Q3 EQ 1>checked="checked"</cfif>> Yes
				</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top">If Yes, describe:</TD>
				<TD class="largeText" valign="top">
					<textarea name="Q3Describe" cols="139" rows="2" class="largeText"><cfif isDefined("form.Q3Describe")>#form.Q3Describe#</cfif></textarea>
				</TD>
			</TR>

			<!--- Q4 --->
			<TR>
				<TD class="largeText" valign="top" colspan="3">&nbsp;<strong>4)	Offsite or Third-Party Impacts</strong>&nbsp;</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top" colspan="2">
					Are there known or likely offsite impacts (actual or perceived), especially involving residential properties, businesses, or sensitive natural resources?
					<input type="radio" name="Q4" class="largeText" value="0" <cfif isDefined("form.Q4") and form.Q4 EQ 0>checked="checked"</cfif>> No
					<input type="radio" name="Q4" class="largeText" value="1" <cfif isDefined("form.Q4") and form.Q4 EQ 1>checked="checked"</cfif>> Yes
				</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top">If Yes, describe:</TD>
				<TD class="largeText" valign="top">
					<textarea name="Q4Describe" cols="139" rows="2" class="largeText"><cfif isDefined("form.Q4Describe")>#form.Q4Describe#</cfif></textarea>
				</TD>
			</TR>

			<!--- Q5 --->
			<TR>
				<TD class="largeText" valign="top" colspan="3">&nbsp;<strong>5)	Field Work and Construction Impacts</strong>&nbsp;</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top" colspan="2">
					Could construction or other field work create odor, dust, noise, traffic, or similar impacts, especially involving neighboring properties, businesses, or sensitive natural resources?
					<input type="radio" name="Q5" class="largeText" value="0" <cfif isDefined("form.Q5") and form.Q5 EQ 0>checked="checked"</cfif>> No
					<input type="radio" name="Q5" class="largeText" value="1" <cfif isDefined("form.Q5") and form.Q5 EQ 1>checked="checked"</cfif>> Yes
				</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top">If Yes, describe:</TD>
				<TD class="largeText" valign="top">
					<textarea name="Q5Describe" cols="139" rows="2" class="largeText"><cfif isDefined("form.Q5Describe")>#form.Q5Describe#</cfif></textarea>
				</TD>
			</TR>

			<!--- Q6 --->
			<TR>
				<TD class="largeText" valign="top" colspan="3">&nbsp;<strong>6)	External Interest or Negative Attention</strong>&nbsp;</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top" colspan="2">
					Is there known or likely negative attention or interest in site issues by neighbors, general public, media, tribal nations, community groups, or others?
					<input type="radio" name="Q6" class="largeText" value="0" <cfif isDefined("form.q6") and form.q6 EQ 0>checked="checked"</cfif>> No
					<input type="radio" name="Q6" class="largeText" value="1" <cfif isDefined("form.q6") and form.q6 EQ 1>checked="checked"</cfif>> Yes
				</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top">If Yes, describe:</TD>
				<TD class="largeText" valign="top">
					<textarea name="Q6Describe" cols="139" rows="2" class="largeText"><cfif isDefined("form.Q6Describe")>#form.Q6Describe#</cfif></textarea>
				</TD>
			</TR>

			<!--- Q7 --->
			<TR>
				<TD class="largeText" valign="top" colspan="3">&nbsp;<strong>7)	External Communications</strong>&nbsp;</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top" colspan="2">
					Have external communications occurred, such as signs, public notices, factsheet mailing, public comment periods, public meetings, or similar?
					<input type="radio" name="Q7" class="largeText" value="0" <cfif isDefined("form.q7") and form.q7 EQ 0>checked="checked"</cfif>> No
					<input type="radio" name="Q7" class="largeText" value="1" <cfif isDefined("form.q7") and form.q7 EQ 1>checked="checked"</cfif>> Yes
				</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top">If Yes, describe:</TD>
				<TD class="largeText" valign="top">
					<textarea name="Q7Describe" cols="139" rows="2" class="largeText"><cfif isDefined("form.Q7Describe")>#form.Q7Describe#</cfif></textarea>
				</TD>
			</TR>

			<!--- Q8 --->
			<TR>
				<TD class="largeText" valign="top" colspan="3">&nbsp;<strong>8)	Communications Plan</strong>&nbsp;</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top" colspan="2">
					Is there a Public Participation Plan or similar communications plan in place (such plans are frequently required by local, state, and/or federal regulators)?
					<input type="radio" name="Q8" class="largeText" value="0" <cfif isDefined("form.q8") and form.q8 EQ 0>checked="checked"</cfif>> No
					<input type="radio" name="Q8" class="largeText" value="1" <cfif isDefined("form.q8") and form.q8 EQ 1>checked="checked"</cfif>> Yes
				</TD>
			</TR>
			<TR>
				<TD class="largeText" valign="top"></TD>
				<TD class="largeText" valign="top">If Yes, describe:</TD>
				<TD class="largeText" valign="top">
					<textarea name="Q8Describe" cols="139" rows="2" class="largeText"><cfif isDefined("form.Q8Describe")>#form.Q8Describe#</cfif></textarea>
				</TD>
			</TR>

			<!--- Assessment Date --->
			<TR>
				<TD class="largeText" align="right"><strong>Assessment Date:</strong>&nbsp;</TD>
				<TD class="largeText" colspan="2">
					<INPUT TYPE="text" name="AssessmentDate" size="15" maxlength="10" class="largeText" VALUE="<cfif isDefined('form.AssessmentDate')>#form.AssessmentDate#</cfif>">
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['AssessmentDate']:document.AssessmentDate_Position), document.forms.PublicAffairsAdmin.AssessmentDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="AssessmentDate_Position" ID="AssessmentDate_Position" BORDER="0" ALT="Date"></A>
				</TD>
			</TR>

			<!--- space --->
			<tr><TD class="largeText" colspan="2" height="10"></td></tr>

			<!--- Yellow line --->
			<TR>
				<TD class="RowYellow" align="center" colspan="2"><strong>For Public Affairs Only</strong>&nbsp;</TD>
			</TR>

			<!--- space --->
			<tr><TD class="largeText" colspan="2" height="10"></td></tr>

			<!--- Public Affairs Comment Date --->
			<TR>
				<TD class="largeText" align="right"><strong>Comment Date:</strong>&nbsp;</TD>
				<TD class="largeText" colspan="2">
					<INPUT TYPE="text" name="CommentsDate" size="15" maxlength="10" class="largeText" VALUE="<cfif isDefined('form.CommentsDate')>#form.CommentsDate#</cfif>">
					<A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['CommentsDate']:document.CommentsDate_Position), document.forms.PublicAffairsAdmin.CommentsDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="CommentsDate_Position" ID="CommentsDate_Position" BORDER="0" ALT="Date"></A>
				</TD>
			</TR>

			<!--- Comment --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Comments:</strong>&nbsp;</TD>
				<TD class="largeText" colspan="2">
					<textarea name="Comments" cols="139" rows="2" class="largeText"><cfif isDefined("form.Comments")>#form.Comments#</cfif></textarea>
				</TD>
			</TR>

			<!--- buttons --->
			<tr>
				<td></td>
				<td colspan="2">
					<input type="submit" name="btnUpdatePublicAffairs" value="Save" class="largeTextButton">
					<input type="submit" name="btnReturn" value="Return" class="largeTextButton" />
				</td>
			</tr>
			<tr>
				<td width="9%"></td>
				<td width="7.5%"></td>
				<td></td>
			</tr>
		</FORM>
	</TABLE>
</cfoutput>
<cfif isDefined("form.edittype") and form.edittype EQ "editPublicAffairs">
	<script>document.PublicAffairsAdmin.PublicAffairsAction.focus();</script>
<cfelse>
	<script>document.PublicAffairsAdmin.AdminSiteID.focus();</script>
</cfif>
