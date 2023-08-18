<!-------------------------------------------
Description:
	account admin page

History:
	1/11/2019 - created
-------------------------------------------->

<script src="scripts/divHider.js"></script>

<SCRIPT>
	var btnWhichButton;
	function validate() {
		var strAlert = '';
	 	if (btnWhichButton.value == 'Save'){
			if (document.AdminAccount.FirstName.value == ''){strAlert = strAlert + 'Please enter the first name.\n';}
			if (document.AdminAccount.LastName.value == ''){strAlert = strAlert + 'Please enter the last name.          \n';}
			if (document.AdminAccount.Email.value == ''){strAlert = strAlert + 'Please enter the email.          \n';}
			if (strAlert != ''){
				alert(strAlert);
				return false;
			}
		}
	}
</SCRIPT>

<cfparam name="msgSuccess" default="&nbsp;" type="string" >
<cfparam name="msgError" default="" type="string" >
<cfparam name="form.AccessType" default="WithOutAccess" type="string" >

<!--- update account --->
<cfif isDefined("form.btnUpdateAccount") and form.edittype EQ "editUserRecord">
	<cfinclude template="q_updAccountInfo.cfm">
</cfif>

<!--- add account --->
<cfif isDefined("form.btnUpdateAccount") and form.edittype EQ "addUserRecord">
	<cfinclude template="q_addAccountInfo.cfm">
	<cfif not len(msgError)>
		<cfset form.edittype = "editUserRecord">
		<cfset form.edtUserID = getNewUserID.newUserID>
	</cfif>
</cfif>

<!--- get the account info --->
<cfif isDefined("Form.edtUserID")>
	<cfinclude template="q_getAccountInfo.cfm">
	<cfset form.FirstName = getAccountInfo.First_Name>
	<cfset form.LastName = getAccountInfo.Last_Name>
	<cfset form.Email = getAccountInfo.Email>
	<cfset form.CompanyID = getAccountInfo.Company_ID>
	<cfset form.ProjectManager = getAccountInfo.PM>
	<cfset form.AccessLevel = getAccountInfo.AccessLevel>
	<cfset form.SiteManager = getAccountInfo.Site_Manager>
<cfelse>
	<cfset form.FirstName = "">
	<cfset form.LastName = "">
	<cfset form.Email = "">
	<cfset form.CompanyID = "1">
	<cfset form.ProjectManager = 0>
	<cfset form.AccessLevel = "1,2,3">
	<cfset form.SiteManager = 0>
</cfif>

<!--- help text --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR>
		<td class="largeText" align="left" width="1%"></td>
		<td class="largeText" align="left">&nbsp;</td>
		<td class="largeText" align="left" width="1%"></td>
	</TR>
  <TR>
		<td class="largeText" align="left" width="1%">
		<td class="largeText" align="left"><strong>Account Management</strong></TD>
		<td class="largeText" align="left" width="1%">
	</TR>
	<TR>
		<td class="largeText" align="left" width="1%">
		<td class="largeText" align="left">
			<li>Use this page to add/update account information.</li>
			<li><strong>First Name</strong>, <strong>Last Name</strong> and <strong>Email</strong> fields are required.</li>
			<li>Indicate whether or not the user is a <strong>Project Manager</strong>.</li>
			<li>Select the <strong>Web Site Sections</strong> to which the user needs access.</li>
		</td>
		<td class="largeText" align="left" width="1%">
	</TR>
	<TR><td class="largeText" colspan="3"><hr></td></TR>
</TABLE>
	
<!--- form --->
<cfoutput>
	<table width="100%" bgcolor="##ffffff" cellspacing="1">

		<cfif len(msgSuccess)><tr><td colspan="2" class="successText" align="center"><div id="msg">#msgSuccess#</div></td></tr></cfif>
		<cfif len(msgError)><tr><td colspan="2" class="errorText" align="center">#msgError#</td></tr></cfif>

		<FORM NAME="AdminAccount" ACTION="" METHOD="POST" onSubmit="return validate()">
			<!--- scrub url input for XSS --->
			<cfinclude template="/Common/XSS_Scubber.cfm" >
			<cfif isDefined("form.edtUserID")><input type="hidden" name="edtUserID" value="#form.edtUserID#" /></cfif>
			<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
			<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
			<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
			<input type="hidden" name="edittype" value="#form.edittype#" />
			<input type="hidden" name="AccessType" value="#form.AccessType#" />
			<!--- id --->
			<cfif Session.Security.UserID EQ 1>
				<TR>
					<TD CLASS="largeText" ALIGN="right"><strong>User ID:</strong>&nbsp;</TD>
					<TD CLASS="largeText">
						<cfif isDefined("form.edtUserID")>#form.edtUserID#</cfif>
					</TD>
				</TR>
				<tr><td colspan="2" height="5"></td></tr>
			</cfif>

			<!--- first name --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>First Name:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<INPUT TYPE="Text" NAME="FirstName" SIZE="40" MAXLENGTH="50" CLASS="largeText" value="#form.FirstName#">
				</TD>
			</TR>
			<tr><td colspan="2" height="5"></td></tr>

			<!--- last name --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Last Name:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<INPUT TYPE="Text" NAME="LastName" SIZE="40" MAXLENGTH="50" CLASS="largeText" value="#form.LastName#">
				</TD>
			</TR>
			<tr><td colspan="2" height="5"></td></tr>

			<!--- email --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Email:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<INPUT TYPE="Text" NAME="Email" SIZE="60" MAXLENGTH="100" CLASS="largeText" value="#form.Email#">
				</TD>
			</TR>
			<tr><td colspan="2" height="5"></td></tr>

			<!--- company --->
			<input type="hidden" name="CompanyID" value="#form.CompanyID#" />

			<!--- project manager --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Project Manager:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<input type="Radio" name="ProjectManager" value="1" class="largeText" <cfif form.ProjectManager EQ 1>checked</cfif>>Yes
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="Radio" name="ProjectManager" value="0" class="largeText" <cfif form.ProjectManager EQ 0>checked</cfif>>No
				</TD>
			</TR>
	
			<!--- site manager --->
			<TR>
				<TD CLASS="largeText" ALIGN="right"><strong>Site Manager:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<input type="Radio" name="SiteManager" value="1" class="largeText" <cfif form.SiteManager EQ 1>checked</cfif>>Yes
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="Radio" name="SiteManager" value="0" class="largeText" <cfif form.SiteManager EQ 0>checked</cfif>>No
				</TD>
			</TR>
	
			<cfmodule template="q_getAccessTo.cfm" AccessLevel="#form.AccessLevel#" Pages="Pages">
			<!--- web site sections --->
			<TR valign="top">
				<TD CLASS="largeText" ALIGN="right"><strong>Web Site Sections:</strong>&nbsp;</TD>
				<TD CLASS="largeText">
					<cfloop from="1" to="0" step="-1" index="act">
						<cfif act EQ 1>Active: <cfelse> Inactive: </cfif>
						<cfmodule template="q_getPortalPages.cfm" Active="#act#" getPortalPages="getPortalPages">
						<cfloop query="getPortalPages" >
							<input type="checkbox" class="largeText" name="PortalID#getPortalPages.ID#" value="#getPortalPages.ID#" <cfif listfind(Pages,getPortalPages.ID)>checked="checked"</cfif>>#getPortalPages.Name#&nbsp;&nbsp;&nbsp;
							<cfif getPortalPages.CurrentRow MOD 7 EQ 0><br></cfif>
						</cfloop>
						<br>
					</cfloop>
				</TD>
			</TR>
			<tr><td colspan="2" height="5"></td></tr>

			<!--- buttons --->
			<TR>
				<TD CLASS="largeText" ALIGN="center"></TD>
				<TD CLASS="largeText" ALIGN="left">
					<INPUT TYPE="Submit" name="btnUpdateAccount" CLASS="largeTextButton" VALUE="Save" onclick="btnWhichButton=this">
					<input type="reset" name="btnReset" class="largeTextButton" value="Reset">
					<input type="Submit" name="btnReturn" class="largeTextButton" value="Return" onclick="btnWhichButton=this">
				</TD>
			</TR>
		</FORM>
		<TR>
			<TD CLASS="largeText" ALIGN="center" width="13%">&nbsp;</TD>
			<TD CLASS="largeText" ALIGN="left" width="87%">&nbsp;</TD>
		</TR>
	</TABLE>
</cfoutput>
<script>document.AdminAccount.FirstName.focus();</script>
