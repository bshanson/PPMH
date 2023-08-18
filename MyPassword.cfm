<!-------------------------------------------
Description:
	user account form, called from prebanner

History:
	2/06/2020 - created
-------------------------------------------->

<cfinclude template="/admin/dbinfo.cfm">
<cfif (request.now GT request.StartDate) and (request.now LT request.EndDate)>
<cfelse>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
	<title><CFOUTPUT>#Request.WebTitle#</CFOUTPUT></title>
</head>

<SCRIPT>
function validateForm(formObj) {
	if (formObj.Password1.value=='')
		{alert(alertPassword1); formObj.Password1.focus(); return false;}
	if (formObj.Password2.value=='')
		{alert(alertPassword2); formObj.Password2.focus(); return false;}
	if (formObj.Password1.value != formObj.Password2.value)
		{alert(alertNoMatch); formObj.Password1.value = ''; formObj.Password2.value = ''; formObj.Password1.focus(); return false;}
	if (formObj.Password1.value==currentPassword)
		{alert(alertSameAsEmail); formObj.Password1.value = ''; formObj.Password2.value = ''; formObj.Password1.focus(); return false;}
	if (formObj.Password1.value.length <= 5)
		{alert(alertShortPassword); formObj.Password1.value = ''; formObj.Password2.value = ''; formObj.Password1.focus(); return false;}
	return true;
}
</SCRIPT>

<!--- change the password --->
<cfif isDefined("form.btnChangePassword")>
	<cfinvoke component="Components.getUserInfo" method="ChangePassword" returnvariable="theMessage">
		<cfinvokeargument name="password" value="#Form.password2#" />
	</cfinvoke>
</cfif>

<!--- create new password --->
<cfif isDefined("form.btnNewPassword")>
	<cfinvoke component="Components.getUserInfo" method="ChangePassword" returnvariable="theMessage">
		<cfinvokeargument name="password" value="#Form.password2#" />
	</cfinvoke>
</cfif>

<cfoutput>
<BODY BGCOLOR="#Request.ApplicationBGColor#">
	<cfinclude template="PreBanner.cfm">
	<cfinclude template="Banner.cfm">
	<cfif isDefined("Session.Security.AccessLevel_#Request.WebSiteID#")>
		<CFSET SelectedTabID="">
		<CFModule template="components/TabBar.cfm" SelectedTabID="#SelectedTabID#" menuWidth="#Request.ApplicationWidth#">
	
		<table width="#Request.ApplicationWidth#" bgcolor="##ffffff" cellspacing="1" align="center"><tr><td>
			<TABLE WIDTH="100%" CELLSPACING="0" CELLPADDING="0">
				<TR>
					<td>
						<TABLE WIDTH="100%" CELLSPACING="0" CELLPADDING="0" bgcolor="#Request.TableBorderColor#">
							<TR>
								<TD CLASS="largeText" ALIGN="center" width="15%">&nbsp;</TD>
								<TD CLASS="largeText" ALIGN="left" width="85%">&nbsp;</TD>
							</TR>
	
							<TR>
								<TD CLASS="largeText" ALIGN="center"></TD>
								<TD CLASS="largeText" ALIGN="left"><strong>My Password Administration</strong></TD>
							</TR>
							<cfif not isDefined("form.btnChangePassword") and not isDefined("form.btnNewPassword")>
								<TR>
									<TD CLASS="largeText" ALIGN="center"></TD>
									<TD CLASS="largeText" ALIGN="left">Use this page to update your password.</TD>
								</TR>
							</cfif>
							<TR>
								<TD CLASS="largeText" ALIGN="center">&nbsp;</TD>
								<TD CLASS="largeText" ALIGN="left">&nbsp;</TD>
							</TR>
	
							<cfif isDefined("attributes.msgCreate") and (not isDefined("form.btnChangePassword") or not isDefined("form.btnNewPassword"))>
								<TR>
									<TD CLASS="largeText" ALIGN="center"></TD>
									<TD CLASS="largeText" ALIGN="left"><span class="errorText">#attributes.msgCreate#</span></TD>
								</TR>
							</cfif>
							<cfif len(request.msgChanged)>
								<TR>
									<TD CLASS="largeText" ALIGN="center"></TD>
									<TD CLASS="largeText" ALIGN="left"><span class="successText">#request.msgChanged#</span></TD>
								</TR>
							</cfif>
							<cfif isDefined("form.btnChangePassword") and isDefined("theMessage")>
								<TR>
									<TD CLASS="largeText" ALIGN="center"></TD>
									<TD CLASS="largeText" ALIGN="left"><span class="successText">#theMessage#</span></TD>
								</TR>
							</cfif>
							<cfif isDefined("form.btnNewPassword") and isDefined("theMessage")>
								<TR>
									<TD CLASS="largeText" ALIGN="center"></TD>
									<TD CLASS="largeText" ALIGN="left"><span class="successText">#theMessage#</span></TD>
								</TR>
							</cfif>
							<cfif not isDefined("form.btnChangePassword") and not isDefined("form.btnNewPassword")>
								<FORM NAME="MyAccount" ACTION="MyPassword.cfm" METHOD="POST" onSubmit="return validateForm(this)">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
									<!--- password 1 --->
									<TR>
										<TD CLASS="largeText" ALIGN="right"><strong>New Password:</strong>&nbsp;</TD>
										<TD CLASS="largeText">
											<INPUT TYPE="password" NAME="Password1" SIZE="40" MAXLENGTH="50" CLASS="largeText">
										</TD>
									</TR>
									<!--- password 2 --->
									<TR>
										<TD CLASS="largeText" ALIGN="right"><strong>Re-enter New Password:</strong>&nbsp;</TD>
										<TD CLASS="largeText">
											<INPUT TYPE="password" NAME="Password2" SIZE="40" MAXLENGTH="50" CLASS="largeText">
										</TD>
									</TR>
									<TR>
										<TD CLASS="largeText" ALIGN="center"></TD>
										<TD CLASS="largeText" ALIGN="left"></TD>
									</TR>
									<TR>
										<TD CLASS="largeText" ALIGN="center"></TD>
										<TD CLASS="largeText" ALIGN="left">
											<cfif isDefined("attributes.msgCreate")>
												<INPUT TYPE="Submit" name="btnNewPassword" VALUE="Create New Password" CLASS="largeText">
											<cfelse>
												<INPUT TYPE="Submit" name="btnChangePassword" VALUE="Change Password" CLASS="largeText">
											</cfif>
											<INPUT TYPE="button" name="btnCancel" VALUE="Cancel" CLASS="largeText" onclick="window.location.href='index.cfm'">
										</TD>
									</TR>
								</FORM>
							</cfif>
							<TR>
								<TD CLASS="largeText" ALIGN="center">&nbsp;</TD>
								<TD CLASS="largeText" ALIGN="left">&nbsp;</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</td></tr></TABLE>
	<cfelse>
		<table width="#Request.ApplicationWidth#" bgcolor="##ffffff" cellspacing="0" align="center"><tr><td>
			<TABLE WIDTH="100%" CELLSPACING="0" CELLPADDING="0" border="0" align="center">
				<TR><TD ALIGN="center" bgcolor="#Request.MenuColor#" class="menuText">&nbsp;</TD></TR>
				<TR><TD ALIGN="center" class="largeText">&nbsp;</TD></TR>
				<TR><TD ALIGN="center" class="largeText">&nbsp;</TD></TR>
				<TR><TD ALIGN="center" class="xlargeText">You do not have access to this web site</TD></TR>
				<TR><TD ALIGN="center" class="largeText">&nbsp;</TD></TR>
				<TR><TD ALIGN="center" class="largeText">&nbsp;</TD></TR>
				<TR><TD ALIGN="center" class="largeText">&nbsp;</TD></TR>
			</TABLE>
		</td></tr></TABLE>
	</cfif>
</cfoutput>

<CFModule template="Footer.cfm">

<SCRIPT>
	<cfoutput>var alertPassword1 = "Please enter your new password."</cfoutput>;
	<cfoutput>var alertPassword2 = "Please re-enter your new password."</cfoutput>;
	<cfoutput>var alertNoMatch = "Your passwords do not match. Please try again."</cfoutput>;
	<cfoutput>var alertSameAsEmail = "Your password can not be the same as your email."</cfoutput>;
	<cfoutput>var alertShortPassword = "Your password must be at least 6 characters long."</cfoutput>;
	<cfoutput>var currentPassword = "#Session.Security.Email#"</cfoutput>;
</SCRIPT>
</body>
</html>
</cfif>
