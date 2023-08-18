<!----------------------------------------------------------------------------------------------------------
Description:
	AccessLUC requirements admin page

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
<cfset canEdit = "false">
<cfset disabled = 'disabled="true"'>
<cfinclude template="../components/q_getAccessLUCAdmins.cfm">
<cfif listfind(canEditList,Session.Security.UserID)><cfset canEdit = "true"><cfset disabled = ''></cfif>

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

<cfparam name="form.Onsite" default="1">

<!--- get Portfolios --->
<cfinclude template="../components/q_getPortfolios.cfm">
<!--- get sites --->
<cfinclude template="../components/q_getSites.cfm">
<!--- get Agreement Types --->
<cfinclude template="q_getAgreementTypes.cfm">
<!--- get Arcadis Chevron Forms --->
<cfinclude template="q_getArcadisChevronForms.cfm">
<!--- get SPls --->
<cfinclude template="q_getSPLs.cfm">
<!--- get Priority --->
<cfinclude template="q_getPriority.cfm">
<!--- get Milestone In Place --->
<cfinclude template="q_getMilestoneInPlace.cfm">
<!--- get Stages --->
<cfinclude template="q_getStages.cfm">
<!--- get Term Letter Sent --->
<cfinclude template="q_getTermLetterSent.cfm">

<!--- replace double quote with single quote --->
<cfloop collection="#form#" item="name">
	<cfif name NEQ "imgEditAccessLUC.X" and name NEQ "imgEditAccessLUC.Y">
		<cfset "form.#name#" = #replace(evaluate("form.#name#"),chr(34),"'","all")#>
	</cfif>
</cfloop>

<!--- update AccessLUC info --->
<cfif isDefined("form.btnUpdateAccessLUC")>
	<!--- edit record --->
	<cfif isDefined("form.edittype") AND form.edittype EQ "editAccessLUC">
		<cfinclude template="q_updAccessLUC.cfm" >
	</cfif>

	<!--- add new record --->
	<cfif isDefined("form.edittype") AND form.edittype EQ "addAccessLUC">
		<cfinclude template="q_addAccessLUC.cfm" >
	</cfif>
</cfif>

<!--- set form info --->
<cfif form.edittype EQ "editAccessLUC">
	<cfif not ArrayLen(errormsg)>
		<!--- get AccessLUC Info --->
		<cfif isDefined("form.AccessLUCID")>
			<cfinclude template="q_getAccessLUCInfo.cfm">
		</cfif>
		<cfset form.AdminSiteID = getAccessLUCInfo.Admin_Site_ID>
		<cfset form.PortfolioID = getAccessLUCInfo.Portfolio_ID>
		<cfset form.Onsite = getAccessLUCInfo.Onsite>
		<cfset form.AgreementTypeID = getAccessLUCInfo.Agreement_Type_ID>
		<cfset form.ArcadisChevronFormID = getAccessLUCInfo.Arcadis_Chevron_Form_ID>
		<cfset form.splid = getAccessLUCInfo.SPL_ID>
		<cfset form.Priorityid = getAccessLUCInfo.Priority_id>
		<cfset form.OutsideCounselInvolved = getAccessLUCInfo.Outside_Counsel_Involved>
		<cfset form.MilestoneInPlaceID = getAccessLUCInfo.Milestone_In_Place_ID>
		<cfset form.StageID = getAccessLUCInfo.Stage_ID>
		<cfif len("getAccessLUCInfo.Expiration_Date")><cfset form.ExpirationDate = dateformat(getAccessLUCInfo.Expiration_Date,"mm/dd/yyyy")><cfelse><cfset form.ExpirationDate = ""></cfif>
		<cfset form.FieldWorkNotification = getAccessLUCInfo.Field_Work_Notification>
		<cfset form.TermLetterSentID = getAccessLUCInfo.Term_Letter_Sent_ID>
		<cfset form.SPLNotes = getAccessLUCInfo.SPL_Notes>
		<cfset form.UntilCompletion = getAccessLUCInfo.Until_Completion>
		<cfset form.CompleteDate = dateformat(getAccessLUCInfo.Complete_Date, "mm/dd/yyyy")>
		<cfset form.AccessProperty = getAccessLUCInfo.Access_Property>
	<cfelse>
		<cfset form.AdminSiteID = form.AdminSiteID>
		<cfset form.PortfolioID = form.PortfolioID>
		<cfset form.Onsite = form.Onsite>
		<cfset form.AgreementTypeID = form.AgreementTypeID>
		<cfset form.ArcadisChevronFormID = form.ArcadisChevronFormID>
		<cfif isDefined("form.splid")><cfset form.splid = form.splid></cfif>
		<cfif isDefined("form.Priorityid")><cfset form.Priorityid = form.Priorityid></cfif>
		<cfif isDefined("form.OutsideCounselInvolved")><cfset form.OutsideCounselInvolved = form.OutsideCounselInvolved></cfif>
		<cfif isDefined("form.MilestoneInPlaceID")><cfset form.MilestoneInPlaceID = form.MilestoneInPlaceID></cfif>
		<cfset form.StageID = form.StageID>
		<cfset form.ExpirationDate	= form.ExpirationDate>
		<cfif isDefined("form.FieldWorkNotification")><cfset form.FieldWorkNotification = form.FieldWorkNotification></cfif>
		<cfif isDefined("form.TermLetterSentID")><cfset form.TermLetterSentID = form.TermLetterSentID></cfif>
		<cfset form.SPLNotes = form.SPLNotes>
		<cfif isDefined("form.UntilCompletion")><cfset form.UntilCompletion = form.UntilCompletion></cfif>
		<cfset form.CompleteDate	= form.CompleteDate>
		<cfset form.AccessProperty = form.AccessProperty>
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
		<td class="largeText" ><strong>Access/LUC Requirement / Action Tracking Administration</strong></TD>
		<td class="largeText" width="1%"></td>
	</TR>
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText" align="left">
			<li>Use this page to administer Access/LUC requirements / actions information. Enter / edit the information and click the <strong>Save</strong> button.</li>
		</td>
		<td class="largeText" width="1%"></td>
	</TR>
</TABLE>

<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
		<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
		<FORM NAME="AccessLUCAdmin" METHOD="POST" ACTION="" enctype="multipart/form-data">
			<!--- scrub url input for XSS --->
			<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.AccessLUCID")><input type="Hidden" name="AccessLUCID" value="#form.AccessLUCID#"></cfif>
			<cfif isDefined("form.SitePortfolioToFind")><input type="Hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#"></cfif>
			<cfif isDefined("form.SiteIDtofind")><input type="Hidden" name="SiteIDtofind" value="#form.SiteIDtofind#"></cfif>
			<cfif isDefined("form.AddressToFind")><input type="Hidden" name="AddressToFind" value="#form.AddressToFind#"></cfif>
			<cfif isDefined("form.SiteNameToFind")><input type="Hidden" name="SiteNameToFind" value="#form.SiteNameToFind#"></cfif>
			<cfif isDefined("form.CityToFind")><input type="Hidden" name="CityToFind" value="#form.CityToFind#"></cfif>
			<cfif isDefined("form.StateToFind")><input type="Hidden" name="StateToFind" value="#form.StateToFind#"></cfif>
			<cfif isDefined("form.edittype")><input type="hidden" name="edittype" value="#form.edittype#" /></cfif>
			<cfif isDefined("form.smtofind")><input type="Hidden" name="smtofind" value="#form.smtofind#"></cfif>
			<cfif isDefined("form.DeputyToFind")><input type="Hidden" name="DeputyToFind" value="#form.DeputyToFind#"></cfif>
			<cfif isDefined("form.SPLToFind")><input type="Hidden" name="SPLToFind" value="#form.SPLToFind#"></cfif>
			<cfif isDefined("form.ClosureToFind")><input type="Hidden" name="ClosureToFind" value="#form.ClosureToFind#"></cfif>
			<cfif isDefined("form.PriorityToFind")><input type="Hidden" name="PriorityToFind" value="#form.PriorityToFind#"></cfif>
			<cfif isDefined("form.CompletedToFind")><input type="Hidden" name="CompletedToFind" value="#form.CompletedToFind#"></cfif>
			<cfloop query="getRegions">
				<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
					<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
				</cfif>
			</cfloop>
			
			<!--- success / error message --->
			<cfif ArrayLen(errormsg)><TR><TD colspan="2" class="errorText" align="center">
			There were errors, please review the following:<br>
			<cfloop index="intError"from="1"to="#ArrayLen(errormsg)#"step="1">
				<li>#errormsg[intError]#</li>
			</cfloop>
			</TD></TR>
			<cfelseif len(successmsg)><TR><TD colspan="2" class="successText" align="center"><div id="msg">*** #successmsg# ***</div></TD></TR>
			<cfelse><TR><TD colspan="2" class="successText" align="center">&nbsp;</TD></TR>
			</cfif>
		</table>

		<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="1" bgcolor="##ffffff">
			<!--- Portfolio --->
			<TR>
				<TD class="largeText" width="6%" align="right"><strong>Portfolio:</strong>&nbsp;</TD>
				<TD class="largeText">
					<select name="PortfolioID" id="PortfolioID" class="largeText" #disabled# onchange="initLinkedSelect(element['PortfolioID'],element['AdminSiteID'],optionData)">
						<option value="0">- select a portfolio -</option>
						<cfloop query="getPortfolios">
							<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.PortfolioID") and form.PortfolioID EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
						</cfloop>
					</select>
				</TD>
			</TR>
			
			<!--- site --->
			<TR>
				<TD class="largeText" align="right"><strong>Site:</strong>&nbsp;</TD>
				<TD class="largeText">
					<select name="AdminSiteID" id="AdminSiteID" class="largeText" #disabled#>
						<option value="0">- select a site -</option>
						<cfloop query="getSites">
							<option value="#getSites.Admin_Site_ID#" <cfif isDefined("form.AdminSiteID") and form.AdminSiteID EQ getSites.Admin_Site_ID>selected="selected"</cfif>>#getSites.Site_ID#, #getSites.Site_Name#, #getSites.Address#, #getSites.City#, #getSites.State_Abbreviation#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- Onsite/offsite --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>On-site / Off-site:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<input type="radio" name="onsite" class="largeText" value="1" #disabled# <cfif isDefined("form.onsite") and form.onsite EQ 1>checked="checked"</cfif>>On-site
					&nbsp;&nbsp;
					<input type="radio" name="onsite" class="largeText" value="0" #disabled# <cfif isDefined("form.onsite") and form.onsite EQ 0>checked="checked"</cfif>>Off-site
				</TD>
			</TR>

			<!--- Access Property --->
			<TR>
				<TD class="largeText" align="right"><strong>Access Property:</strong>&nbsp;</TD>
				<TD class="largeText">
					<INPUT TYPE="text" name="AccessProperty" size="100" maxlength="128" class="largeText" #disabled# VALUE="<cfif isDefined('form.AccessProperty')>#form.AccessProperty#</cfif>">
				</TD>
			</TR>

			<!--- type of agreement --->
			<TR>
				<TD class="largeText" align="right"><strong>Type of Agreement:</strong>&nbsp;</TD>
				<TD class="largeText">
					<select name="AgreementTypeID" class="largeText" #disabled#>
						<option value="0" <cfif isdefined("form.AgreementTypeID") and form.AgreementTypeID EQ 0>selected</cfif>>- select type of agreement -</option>
						<cfloop query="getAgreementTypes">
							<option value="#getAgreementTypes.Agreement_Type_ID#" <cfif isdefined("form.AgreementTypeID") and form.AgreementTypeID EQ getAgreementTypes.Agreement_Type_ID>selected</cfif>>#getAgreementTypes.Agreement_Type#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- Arcadis Chevron Form --->
			<TR>
				<TD class="largeText" align="right"><strong>Arcadis / Chevron Form:</strong>&nbsp;</TD>
				<TD class="largeText">
					<select name="ArcadisChevronFormID" class="largeText" #disabled#>
						<option value="0" <cfif isdefined("form.ArcadisChevronFormID") and form.ArcadisChevronFormID EQ 0>selected</cfif>>- select the Arcadis or Chevron form -</option>
						<option value="999999" <cfif isdefined("form.ArcadisChevronFormID") and form.ArcadisChevronFormID EQ 999999>selected</cfif>>Not Applicable</option>
						<cfloop query="getArcadisChevronForms">
							<option value="#getArcadisChevronForms.Arcadis_Chevron_Form_ID#" <cfif isdefined("form.ArcadisChevronFormID") and form.ArcadisChevronFormID EQ getArcadisChevronForms.Arcadis_Chevron_Form_ID>selected</cfif>>#getArcadisChevronForms.Arcadis_Chevron_Form#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- SPL --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>SPL:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<cfloop query="getSPLs">
						<input type="radio" name="splid" class="largeText" value="#getSPLs.User_ID#" #disabled# <cfif isDefined("form.splid") and form.splid EQ getSPLs.User_ID>checked="checked"</cfif>>#getSPLs.First_Name# #getSPLs.Last_Name#
						&nbsp;&nbsp;
					</cfloop>
				</TD>
			</TR>

			<!--- Priority --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Priority:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<cfloop query="getPriority">
						<input type="radio" name="Priorityid" class="largeText" value="#getPriority.Priority_ID#" #disabled# <cfif isDefined("form.Priorityid") and form.Priorityid EQ getPriority.Priority_ID>checked="checked"</cfif>>#getPriority.Priority#
						&nbsp;&nbsp;
					</cfloop>
				</TD>
			</TR>

			<!--- Outside Counsel Involved --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Outside Counsel Involved:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<input type="radio" name="OutsideCounselInvolved" class="largeText" value="1" #disabled# <cfif isDefined("form.OutsideCounselInvolved") and form.OutsideCounselInvolved EQ 1>checked="checked"</cfif>>Yes
					&nbsp;&nbsp;
					<input type="radio" name="OutsideCounselInvolved" class="largeText" value="0" #disabled# <cfif isDefined("form.OutsideCounselInvolved") and form.OutsideCounselInvolved EQ 0>checked="checked"</cfif>>No
				</TD>
			</TR>

			<!--- Milestone in Place --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Milestone in Place:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<cfloop query="getMilestoneInPlace">
						<input type="radio" name="MilestoneInPlaceID" class="largeText" #disabled# value="#getMilestoneInPlace.Milestone_In_Place_ID#" <cfif isDefined("form.MilestoneInPlaceID") and form.MilestoneInPlaceID EQ getMilestoneInPlace.Milestone_In_Place_ID>checked="checked"</cfif>>#getMilestoneInPlace.Milestone_In_Place#
						&nbsp;&nbsp;
					</cfloop>
				</TD>
			</TR>

			<!--- Stage --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Stage:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<select name="StageID" class="largeText" #disabled#>
						<option value="0" <cfif isdefined("form.StageID") and form.StageID EQ 0>selected</cfif>>- select the stage -</option>
						<option value="999999" <cfif isdefined("form.StageID") and form.StageID EQ 999999>selected</cfif>>Not Applicable</option>
						<cfloop query="getStages">
							<option value="#getStages.Stage_ID#" <cfif isdefined("form.StageID") and form.StageID EQ getStages.Stage_ID>selected</cfif>>#getStages.Stage_ID# - #getStages.Stage#</option>
						</cfloop>
					</select>
				</TD>
			</TR>

			<!--- Expiration Date --->
			<TR>
				<TD class="largeText" align="right"><strong>Expiration Date:</strong>&nbsp;</TD>
				<TD class="largeText">
					<INPUT TYPE="text" name="ExpirationDate" size="15" maxlength="10" #disabled# class="largeText" VALUE="<cfif isDefined('form.ExpirationDate')>#form.ExpirationDate#</cfif>">
					<cfif canEdit><A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp2']:document.TaskPopUp2_Position), document.forms.AccessLUCAdmin.ExpirationDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp2_Position" ID="TaskPopUp2_Position" BORDER="0" ALT="Date"></A></cfif>
				</TD>
			</TR>

			<!--- Until Completion Of Work--->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Until Completion Of Work:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<input type="radio" name="UntilCompletion" class="largeText" value="1" #disabled# <cfif isDefined("form.UntilCompletion") and form.UntilCompletion EQ 1>checked="checked"</cfif>>Yes
					&nbsp;&nbsp;
					<input type="radio" name="UntilCompletion" class="largeText" value="0" #disabled# <cfif isDefined("form.UntilCompletion") and form.UntilCompletion EQ 0>checked="checked"</cfif>>No
				</TD>
			</TR>

			<!--- Field Work Notification Required --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Field Work Notification Required:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<input type="radio" name="FieldWorkNotification" class="largeText" value="1" #disabled# <cfif isDefined("form.FieldWorkNotification") and form.FieldWorkNotification EQ 1>checked="checked"</cfif>>Yes
					&nbsp;&nbsp;
					<input type="radio" name="FieldWorkNotification" class="largeText" value="0" #disabled# <cfif isDefined("form.FieldWorkNotification") and form.FieldWorkNotification EQ 0>checked="checked"</cfif>>No
				</TD>
			</TR>

			<!--- Term Letter Sent --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>Term Letter Sent:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<cfloop query="getTermLetterSent">
						<input type="radio" name="TermLetterSentID" class="largeText" #disabled# value="#getTermLetterSent.Term_Letter_Sent_ID#" <cfif isDefined("form.TermLetterSentID") and form.TermLetterSentID EQ getTermLetterSent.Term_Letter_Sent_ID>checked="checked"</cfif>>#getTermLetterSent.Term_Letter_Sent#
						&nbsp;&nbsp;
					</cfloop>
				</TD>
			</TR>

			<!--- SPL Notes --->
			<TR>
				<TD class="largeText" align="right" valign="top"><strong>SPL Notes:</strong>&nbsp;</TD>
				<TD class="largeText" valign="top">
					<textarea name="SPLNotes" cols="125" rows="5" class="largeText" #disabled#><cfif isDefined("form.SPLNotes")>#form.SPLNotes#</cfif></textarea>
				</TD>
			</TR>

			<!--- Final Document --->
			<TR>
				<TD class="largeText" align="right"><strong>Final Document:</strong>&nbsp;</TD>
				<TD class="largeText">
					<INPUT TYPE="File" name="FinalDocument" size="50" maxlength="128" class="largeText" #disabled#>
					<cfif isDefined("getAccessLUCInfo.Final_Document") and len(getAccessLUCInfo.Final_Document)>
						&nbsp;
						<A HREF="javascript: var n=window.open('components/GetDoc.cfm?AccessLUCID=#form.AccessLUCID#&DocType=ALuc', '', 'height=700,width=900,resizable')">view the document</A>
						&nbsp;
						<cfif canEdit><input type="Checkbox" name="FinalDocDelete">delete the document</cfif>
					</cfif>
				</TD>
			</TR>

			<!--- Completion Date --->
			<TR>
				<TD class="largeText" align="right"><strong>Completion Date:</strong>&nbsp;</TD>
				<TD class="largeText">
					<INPUT TYPE="text" name="CompleteDate" size="15" maxlength="10" class="largeText" #disabled# VALUE="<cfif isDefined('form.CompleteDate')>#form.CompleteDate#</cfif>">
					<cfif canEdit><A HREF="javascript:var x=popUpCalendar((document.layers?document.layers['TaskPopUp3']:document.TaskPopUp3_Position), document.forms.AccessLUCAdmin.CompleteDate, 'mm/dd/yyyy', '','1',-100);"><IMG SRC="/CommonImages/cal.gif" NAME="TaskPopUp3_Position" ID="TaskPopUp3_Position" BORDER="0" ALT="Date"></A></cfif>
				</TD>
			</TR>

			<!--- buttons --->
			<tr>
				<td width="19%"></td>
				<td>
					<cfif canEdit><input type="submit" name="btnUpdateAccessLUC" value="Save" class="FormBodyButton"></cfif>
					<input type="submit" name="btnReturn" value="Return" class="FormBodyButton" />
				</td>
			</tr>
		</FORM>
	</TABLE>
</cfoutput>

<script>document.AccessLUCAdmin.PortfolioID.focus();</script>
<SCRIPT>var element=document.forms['AccessLUCAdmin'].elements;</SCRIPT>
