<!-------------------------------------------
Description:
	user account search page

History:
	1/11/2019 - created
-------------------------------------------->

<!--- delete user --->
<cfif isDefined("form.editType") and form.editType EQ "deleteUserRecord">
 	<cfinclude template="q_delAccountInfo.cfm">
</cfif>

<!--- reset user --->
<cfif isDefined("form.editType") and form.editType EQ "resetUserRecord">
 	<cfinclude template="../Components/q_updPassword.cfm">
	<CFModule template="../Components/f_Email_Notifcation.cfm" NoticeType="accountreset" Email="#form.Email#" FirstName="#form.FirstName#" PWD="#strRandomPassword#">
</cfif>

<!--- toggle PM off --->
<cfif isDefined("form.editType") and form.editType EQ "togglePMOff">
 	<cfmodule template="../Components/q_updUserPM.cfm" toggle="0" uid="#form.toggleUserID#">
</cfif>
<!--- toggle PM on --->
<cfif isDefined("form.editType") and form.editType EQ "togglePMOn">
 	<cfmodule template="../Components/q_updUserPM.cfm" toggle="1" uid="#form.toggleUserID#">
</cfif>

<!--- get accounts --->
<cfif isDefined("form.LastNameToFind")>
	<cfmodule template="q_getAccounts.cfm" Type="WithAccess" Return="WithAccess">
	<cfmodule template="q_getAccounts.cfm" Type="WithoutAccess" Return="WithOutAccess">
</cfif>

<!--- help text --->
<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="#ffffff">
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText"></td>
		<td class="largeText" width="1%"></td>
	</TR>
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText" ><strong>User Account Management</strong></TD>
		<td class="largeText" width="1%"></td>
	</TR>
	<TR>
		<td class="largeText" width="1%"></td>
		<td class="largeText" >
			<li>Use this page to manage user account information.</li>
			<li>Search by entering the <strong>First Name</strong> and/or <strong>Last Name</strong> or a substring of either and click the <strong>Search</strong> button. Leave all fields blank to list all users.</li>
			<li>User accounts matching the search criteria will be listed. Once listed, the user information may updated by clicking the <strong>pencil</strong> icon.</li>
			<li>Toggle the <strong>PM</strong> indicator by clicking the <span style="color:green; font-weight:bold;">Checkmark</span> or the <span style="color:red; font-weight:bold;">X</span>. Click the <strong>reset</strong> icon to reset a user's password. Click the <strong>trash can</strong> icon to to delete a user.</li>
			<li>After conducting a search, a new user may be entered by clicking the <strong>Add New User</strong> button.</li>
		</td>
		<td class="largeText" width="1%"></td>
	</TR>
</TABLE>

<!--- search form --->
<cfoutput>
	<TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" bgcolor="##ffffff">
		<TR><td class="largeText" colspan="3"><hr color="##0083a9"></td></TR>
		<form name="searchAccounts" action="" method="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
			<!--- first name --->
			<TR>
				<td class="largeText" align="right" ></td>
				<td class="largeText" align="right" ><strong>First Name:</strong>&nbsp;</td>
				<td class="largeText" >
					<input type="Text" name="FirstNameToFind" class="largeText" size="30" <cfif isDefined("form.FirstNameToFind")>value="#trim(form.FirstNameToFind)#"</cfif>>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
		
			<!--- last name --->
			<TR>
				<td class="largeText" align="right" ></td>
				<td class="largeText" align="right" ><strong>Last Name:</strong>&nbsp;</td>
				<td class="largeText" >
					<input type="Text" name="LastNameToFind" class="largeText" size="30" <cfif isDefined("form.LastNameToFind")>value="#trim(form.LastNameToFind)#"</cfif>>
				</td>
			</TR>
			<tr><td colspan="3" height="5"></td></tr>
		
			<!--- buttons --->
			<TR>
				<td class="largeText" align="right" ></td>
				<td class="largeText" align="right" >&nbsp;</td>
				<td class="largeText" >
					<input type="Submit" name="btnSearch" class="largeTextButton" value="Search">
					<cfif isDefined("form.LastNameToFind")>
						<input type="Submit" name="btnAddAccnt" class="largeTextButton" value="Add New User">
						<input type="hidden" name="edittype" value="addUserRecord" />
					</cfif>
				</td>
			</TR>
			<TR>
				<td class="largeText" align="right" width="1%"></td>
				<td class="largeText" align="right" width="7%">&nbsp;</td>
				<td class="largeText" >&nbsp;</td>
			</TR>
		</form>
	</TABLE>
</cfoutput>

<!--- search results --->
<cfoutput>
	<cfset row = 1>
	<cfif isDefined("WithAccess")>
		<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
			<tr><td>
				<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999">
					<tr><td colspan="10" class="AccessListHeader">Users who have access to the #Request.WebTitle# web site</td></tr>
					<tr>
						<td width="2%" class="ServiceListHeader">&nbsp;</td>
						<cfif Session.Security.UserID EQ 1>
							<td width="4%" class="ServiceListHeader"><strong>ID</strong></td>
							<td width="10%" class="ServiceListHeader"><strong>First Name</strong></td>
						<cfelse>
							<td width="14%" class="ServiceListHeader"><strong>First Name</strong></td>
						</cfif>
						<td width="14%" class="ServiceListHeader"><strong>Last Name</strong></td>
						<td width="17%" class="ServiceListHeader"><strong>Company</strong></td>
						<td width="17%" class="ServiceListHeader"><strong>Email</strong></td>
						<td width="27%" class="ServiceListHeader"><strong>Page Access</strong></td>
						<td width="3%" align="center" class="ServiceListHeader"><strong>PM</strong></td>
						<td width="2%" class="ServiceListHeader">&nbsp;</td>
						<td width="2%" class="ServiceListHeader">&nbsp;</td>
					</tr>
					<cfif isDefined("WithAccess") and WithAccess.recordcount NEQ 0>
						<cfloop query="WithAccess">
							<cfset row = 1-row>
							<TR>
								<!--- edit user --->
								<FORM NAME="editUser1" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<input type="Image" name="btnEditAccnt" src="images/icon_pencil.gif" border="0" onclick="submit()" alt="edit this user">
										<input type="hidden" name="edittype" value="editUserRecord" />
										<input type="hidden" name="edtUserID" value="#WithAccess.User_ID#" />
										<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
										<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
										<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
										<input type="hidden" name="AccessType" value="WithAccess" />
									</td>
								</FORM>
		
								<cfif Session.Security.UserID EQ 1>
									<td class="row#row#">#WithAccess.user_id#</td>
								</cfif>
								<td class="row#row#">#WithAccess.First_Name#</td>
								<td class="row#row#">#WithAccess.Last_Name#</td>
								<td class="row#row#">#WithAccess.Company_Name#</td>
								<td class="row#row#">#WithAccess.Email#</td>
								<cfmodule template="q_getAccessTo.cfm" AccessLevel="#WithAccess.AccessLevel#" Return="AccessTo">
								<td class="row#row#">#AccessTo#</td>

								<!--- toggle PM on/off --->
								<FORM NAME="togglePM1" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td align="center" class="row#row#">
										<cfif WithAccess.PM EQ 1>
											<input type="Image" name="btnDeleteAccnt" src="images/icon_greencheck.gif" border="0" onclick="{submit()}; return false" alt="toggle this user">
											<input type="hidden" name="edittype" value="togglePMOff" />
											<input type="hidden" name="toggleUserID" value="#WithAccess.User_ID#" />
											<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
											<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
											<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
										<cfelse>
											<input type="Image" name="btnDeleteAccnt" src="images/icon_redx.gif" border="0" onclick="{submit()}; return false" alt="toggle this user">
											<input type="hidden" name="edittype" value="togglePMOn" />
											<input type="hidden" name="toggleUserID" value="#WithAccess.User_ID#" />
											<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
											<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
											<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
										</cfif>
									</td>
								</FORM>
		
								<!--- reset user --->
								<FORM NAME="resetUser1" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<input type="Image" name="btnDeleteAccnt" src="images/icon_reset.gif" border="0" onclick="if (confirm('Are you sure you want to reset this account?')){submit()}; return false" alt="reset this user">
										<input type="hidden" name="edittype" value="resetUserRecord" />
										<input type="hidden" name="resetUserID" value="#WithAccess.User_ID#" />
										<input type="hidden" name="email" value="#WithAccess.Email#" />
										<input type="hidden" name="firstname" value="#WithAccess.First_Name#" />
										<input type="hidden" name="btnResetPassword" value="btnResetPassword" />
										<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
										<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
										<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
									</td>
								</FORM>

								<!--- delete user --->
								<FORM NAME="deleteUser1" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<input type="Image" name="btnDeleteAccnt" src="images/icon_trash.gif" border="0" onclick="if (confirm('Are you sure you want to delete this record?')){submit()}; return false" alt="delete this user">
										<input type="hidden" name="edittype" value="deleteUserRecord" />
										<input type="hidden" name="delUserID" value="#WithAccess.User_ID#" />
										<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
										<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
										<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
									</td>
								</FORM>
							</TR>
						</cfloop>
					<cfelse>
						<cfset row = 1-row>
						<TR>
							<td class="row#row#" align="center" colspan="10"><em>There are no records that match your search parameters</em></td>
						</TR>
					</cfif>
				</TABLE>
			</td></tr>
		</TABLE>
	</cfif>

	<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
		<tr><td>&nbsp;</td></tr>
	</TABLE>

	<cfif isDefined("WithOutAccess")>
		<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##ffffff">
			<tr><td>
				<TABLE WIDTH="100%" CELLPADDING="1" CELLSPACING="1" bgcolor="##999999">
					<tr><td colspan="9" class="AccessListHeader">Users who do not have access to the #Request.WebTitle# web site</td></tr>
					<tr>
						<td width="2%" class="ServiceListHeader">&nbsp;</td>
						<cfif Session.Security.UserID EQ 1>
							<td width="4%" class="ServiceListHeader"><strong>ID</strong></td>
							<td width="10%" class="ServiceListHeader"><strong>First Name</strong></td>
						<cfelse>
							<td width="14%" class="ServiceListHeader"><strong>First Name</strong></td>
						</cfif>
						<td width="14%" class="ServiceListHeader"><strong>Last Name</strong></td>
						<td width="17%" class="ServiceListHeader"><strong>Company</strong></td>
						<td width="44%" class="ServiceListHeader"><strong>Email</strong></td>
						<td width="3%" align="center" class="ServiceListHeader"><strong>PM</strong></td>
						<td width="2%" class="ServiceListHeader">&nbsp;</td>
						<td width="2%" class="ServiceListHeader">&nbsp;</td>
					</tr>
					<cfset row = 1>
					<cfif isDefined("WithOutAccess") and WithOutAccess.recordcount NEQ 0>
						<cfloop query="WithOutAccess">
							<cfset row = 1-row>
							<TR>
								<!--- edit user --->
								<FORM NAME="editUser2" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<input type="Image" name="btnEditAccnt" src="images/icon_pencil.gif" border="0" onclick="submit()" alt="edit this user">
										<input type="hidden" name="edittype" value="editUserRecord" />
										<input type="hidden" name="edtUserID" value="#WithOutAccess.User_ID#" />
										<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
										<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
										<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
										<input type="hidden" name="AccessType" value="WithOutAccess" />
									</td>
								</FORM>
		
								<cfif Session.Security.UserID EQ 1>
									<td class="row#row#">#WithOutAccess.user_id#</td>
								</cfif>

								<td class="row#row#">#WithOutAccess.First_Name#</td>
								<td class="row#row#">#WithOutAccess.Last_Name#</td>
								<td class="row#row#">#WithOutAccess.Company_Name#</td>
								<td class="row#row#">#WithOutAccess.Email#</td>

								<!--- toggle PM on/off --->
								<FORM NAME="togglePM2" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td align="center" class="row#row#">
										<cfif WithOutAccess.PM EQ 1>
											<input type="Image" name="btnDeleteAccnt" src="images/icon_greencheck.gif" border="0" onclick="{submit()}; return false" alt="toggle this user">
											<input type="hidden" name="edittype" value="togglePMOff" />
											<input type="hidden" name="toggleUserID" value="#WithOutAccess.User_ID#" />
											<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
											<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
											<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
										<cfelse>
											<input type="Image" name="btnDeleteAccnt" src="images/icon_redx.gif" border="0" onclick="{submit()}; return false" alt="toggle this user">
											<input type="hidden" name="edittype" value="togglePMOn" />
											<input type="hidden" name="toggleUserID" value="#WithOutAccess.User_ID#" />
											<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
											<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
											<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
										</cfif>
									</td>
								</FORM>
		
								<!--- reset user --->
								<FORM NAME="resetUser2" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<input type="Image" name="btnDeleteAccnt" src="images/icon_reset.gif" border="0" onclick="if (confirm('Are you sure you want to reset this account?')){submit()}; return false" alt="reset this user">
										<input type="hidden" name="edittype" value="resetUserRecord" />
										<input type="hidden" name="resetUserID" value="#WithOutAccess.User_ID#" />
										<input type="hidden" name="email" value="#WithOutAccess.Email#" />
										<input type="hidden" name="firstname" value="#WithOutAccess.First_Name#" />
										<input type="hidden" name="btnResetPassword" value="btnResetPassword" />
										<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
										<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
										<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
									</td>
								</FORM>

								<!--- delete user --->
								<FORM NAME="deleteUser2" ACTION="" METHOD="post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
									<td ALIGN="center" valign="middle" class="row#row#">
										<input type="Image" name="btnDeleteAccnt" src="images/icon_trash.gif" border="0" onclick="if (confirm('Are you sure you want to delete this record?')){submit()}; return false" alt="delete this user">
										<input type="hidden" name="edittype" value="deleteUserRecord" />
										<input type="hidden" name="delUserID" value="#WithOutAccess.User_ID#" />
										<cfif isDefined("form.LastNameToFind")><input type="hidden" name="LastNameToFind" value="#form.LastNameToFind#" /></cfif>
										<cfif isDefined("form.FirstNameToFind")><input type="hidden" name="FirstNameToFind" value="#form.FirstNameToFind#" /></cfif>
										<cfif isDefined("form.CompanyNameToFind")><input type="hidden" name="CompanyNameToFind" value="#form.CompanyNameToFind#" /></cfif>
									</td>
								</FORM>
							</TR>
						</cfloop>
					<cfelse>
						<cfset row = 1-row>
						<TR>
							<td class="row#row#" align="center" colspan="9"><em>There are no records that match your search parameters</em></td>
						</TR>
					</cfif>
				</TABLE>
			</td></tr>
		</TABLE>
	</cfif>
</cfoutput>
<script>document.searchAccounts.FirstNameToFind.focus();</script>
