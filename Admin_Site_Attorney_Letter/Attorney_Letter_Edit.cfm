<!-------------------------------------------
Description:
	Attorney Letter edit page

History:
	10/13/2022 - created
-------------------------------------------->

<script src="scripts/divHider.js"></script>

<cfset msgSuccess = "">
<cfset arrErrors = ArrayNew(1) />

<!--- get all Sites --->
<cfinclude template="q_getAllSites.cfm">
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

<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">

<!--- update letter --->
<cfif isDefined("form.btnUpdateAttorneyLetter")>
	<cfinclude template="q_updAttorneyLetterInfo.cfm">
</cfif>

<!--- get the Attorney Letter info and set form variables --->
<cfif not ArrayLen(arrErrors)>
	<cfif isDefined("Form.edtAttorneyLetterID")>
		<cfinclude template="q_getAttorneyLetterInfo.cfm">
		<cfset form.AttorneyLetterID = getAttorneyLetterInfo.ID>
		<cfset form.AdminSiteID = getAttorneyLetterInfo.AdminSiteID>
		<cfset form.SiteID = getAttorneyLetterInfo.Site_ID>
		<cfset form.SiteName = getAttorneyLetterInfo.Site_Name>
		<cfset form.DocumentName = getAttorneyLetterInfo.Document_Name>
		<cfset form.FileName = getAttorneyLetterInfo.File_Name>
	<cfelse>
		<cfset form.AdminSiteID = "">
		<cfset form.SiteID = "">
		<cfset form.SiteName = "">
		<cfset form.DocumentName = "">
		<cfset form.FileName = "">
	</cfif>
<cfelse>
	<cfset form.AdminSiteID = form.AdminSiteID>
	<cfset form.SiteID = form.SiteID>
	<cfset form.SiteName = form.SiteName>
	<cfset form.DocumentName = form.DocumentName>
	<cfset form.FileName = form.FileName>
</cfif>

<!--- help text --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR>
		<td class="largeText" width="1%">
		<td class="largeText"></td>
		<td class="largeText" width="1%">
	</TR>
  <TR>
		<td class="largeText" width="1%">
		<td class="largeText"><strong>Attorney Letter Management</strong></TD>
		<td class="largeText" width="1%">
	</TR>
	<TR>
		<td class="largeText" width="1%">
		<td class="largeText">
			<li>Use this page to add/update attorney letter information.</li>
			<li>Enter/update the information and click <strong>Save</strong> to save the changes to the database. Click <strong>Reset</strong> to reset all form values to the values when the form is first displayed or following a save.</li>
		</td>
		<td class="largeText" width="1%">
	</TR>
	<TR><td class="largeText" colspan="3"><hr></td></TR>
</TABLE>
	
<!--- form --->
<cfoutput>
	<table width="100%" bgcolor="##ffffff" cellspacing="1">
		<FORM NAME="AttorneyLetter" ACTION="" METHOD="POST" enctype="multipart/form-data">
			<!--- scrub url input for XSS --->
			<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.edtAttorneyLetterID")><input type="hidden" name="edtAttorneyLetterID" value="#form.edtAttorneyLetterID#" /></cfif>
			<cfif isDefined("form.SitePortfolioToFind")><input type="hidden" name="SitePortfolioToFind" value="#form.SitePortfolioToFind#" /></cfif>
			<cfif isDefined("form.SiteIDToFind")><input type="hidden" name="SiteIDToFind" value="#form.SiteIDToFind#" /></cfif>
			<cfif isDefined("form.SiteNameToFind")><input type="hidden" name="SiteNameToFind" value="#form.SiteNameToFind#" /></cfif>
			<cfif isDefined("form.AddressToFind")><input type="hidden" name="AddressToFind" value="#form.AddressToFind#" /></cfif>
			<cfif isDefined("form.CityToFind")><input type="hidden" name="CityToFind" value="#form.CityToFind#" /></cfif>
			<cfif isDefined("form.StateToFind")><input type="hidden" name="StateToFind" value="#form.StateToFind#" /></cfif>
			<cfloop query="getRegions">
				<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")>
					<input type="hidden" name="RegionToFind#getRegions.COP_Region_ID#" value="on" />
				</cfif>
			</cfloop>
			<input type="hidden" name="edittype" value="#form.edittype#" />

			<!--- message --->
			<cfif ArrayLen(arrErrors)>
				<cfset msgSuccess = "">
				<tr><td colspan="2" class="errorText" align="center">
					There were errors, please review and correct the following:<br>
					<!--- Loop over form errors to output --->
					<cfloop index="intError" from="1" to="#ArrayLen(arrErrors)#" step="1">
						&bull; #arrErrors[intError]#<br>
					</cfloop>
				</td></tr>
			</cfif>
			<cfif len(msgSuccess)><tr><td class="successText" align="center" colspan="2"><div id="msg">*** #msgSuccess# ***</div></td></tr></cfif>
			<cfif not len(msgSuccess) and not ArrayLen(arrErrors)><tr><td class="successText" align="center" colspan="2"><div id="msg">&nbsp;</div></td></tr></cfif>

			<!--- add --->
			<cfif (form.edittype EQ "AddAttorneyLetterRecord")>
				<input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#">
				<input type="hidden" name="SiteName" value="#form.SiteName#">
				<cfinclude template="q_getPortfolios.cfm">
				<cfinclude template="q_getSites.cfm">
				<!--- portfolio --->
				<TR valign="top">
					<TD CLASS="largeText" ALIGN="right"><strong>Portfolio:</strong>&nbsp;</TD>
					<TD CLASS="largeText">
						<select name="PortfolioID" id="PortfolioID" class="largeText" onchange="initLinkedSelect(element['PortfolioID'],element['SiteID'],optionData)">
							<option value="0">- select a portfolio -</option>
							<cfloop query="getPortfolios">
								<option value="#getPortfolios.Portfolio_ID#" <cfif isDefined("form.PortfolioID") and form.PortfolioID EQ getPortfolios.Portfolio_ID>selected="selected"</cfif>>#getPortfolios.Portfolio#</option>
							</cfloop>
						</select>
					</TD>
				</TR>
				<!--- Site--->
				<TR valign="top">
					<TD class="largeText" align="right"><strong>Site:</strong>&nbsp;</TD>
					<TD class="largeText">
						<select name="SiteID" id="SiteID" class="largeText">
							<option value="0">- select a site -</option>
							<cfloop query="getSites">
								<option value="#getSites.Admin_Site_ID#" <cfif isDefined("form.SiteID") and form.SiteID EQ getSites.Admin_Site_ID>selected="selected"</cfif>>#getSites.Site_ID#, #getSites.Site_Name#, #getSites.Address#, #getSites.City#, #getSites.State_Abbreviation#</option>
							</cfloop>
						</select>
					</TD>
				</TR>
			<!--- edit --->
			<cfelse>
				<!--- Site ID --->
				<TR valign="top">
					<TD CLASS="largeText" ALIGN="right"><strong>Site ID:</strong>&nbsp;</TD>
					<TD CLASS="largeText">
							#form.AdminSiteID#
							<input type="hidden" name="SiteID" value="#form.SiteID#">
							<input type="hidden" name="AdminSiteID" value="#form.AdminSiteID#">
					</TD>
				</TR>
	
				<!--- Site Name --->
				<TR valign="top">
					<TD CLASS="largeText" ALIGN="right"><strong>Site Name:</strong>&nbsp;</TD>
					<TD CLASS="largeText">
							#form.SiteName#
							<input type="hidden" name="SiteName" value="#form.SiteName#">
					</TD>
				</TR>
			</cfif>

			<!--- Document Name --->
			<TR valign="top">
				<TD CLASS="largeText" ALIGN="right"><strong>Document:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<input type="text" CLASS="largeText" size="50" maxlength="128" name="DocumentName" value="#form.DocumentName#">
				</TD>
			</TR>

			<!--- File --->
			<TR valign="top">
				<TD CLASS="largeText" ALIGN="right"><strong>File:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<INPUT TYPE="File" name="FileName" size="50" maxlength="128" class="largeText" value="#form.FileName#">
				</TD>
			</TR>

			<!--- File --->
			<cfif isDefined("getAttorneyLetterInfo.File_Name") and len(getAttorneyLetterInfo.File_Name)>
				<TR valign="top">
					<TD CLASS="largeText" ALIGN="right"><strong>View:</strong>&nbsp;</TD>
					<TD CLASS="largeText">
							<A HREF="javascript: var n=window.open('components/GetDoc.cfm?AttorneyLetterID=#form.AttorneyLetterID#&DocType=Attorney', '', 'height=700,width=900,resizable')">view the document</A>
					</TD>
				</TR>
			</cfif>

			<!--- space --->
			<TR><TD CLASS="row0" colspan="2">&nbsp;</TD></TR>

			<!--- buttons --->
			<TR>
				<TD CLASS="largeText" ALIGN="center"></TD>
				<TD CLASS="largeText" ALIGN="left">
					<INPUT TYPE="Submit" name="btnUpdateAttorneyLetter" CLASS="largeTextButton" VALUE="Save">
					<input type="Submit" name="btnReturnAttorneyLetter" class="largeTextButton" value="Return">
					<input type="reset" name="btnReset" class="largeTextButton" value="Reset">
				</TD>
			</TR>
		</FORM>

		<TR><TD CLASS="row0" colspan="2">&nbsp;</TD></TR>

		<!--- column widths --->
		<TR>
			<TD CLASS="largeText" width="12%"></TD>
			<TD CLASS="largeText" width="88%"></TD>
		</TR>
	</TABLE>
</cfoutput>

<cfif (form.edittype EQ "AddAttorneyLetterRecord")>
	<script>document.AttorneyLetter.PortfolioID.focus();</script>
	<SCRIPT>var element=document.forms['AttorneyLetter'].elements;</SCRIPT>
<cfelse>
	<script>document.AttorneyLetter.ProjectName.focus();</script>
</cfif>