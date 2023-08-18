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
function validateLogin(formObj) {
	if (formObj.FirstName.value=='')
		{alert(alertFirstName); formObj.FirstName.focus(); return false;}
	if (formObj.LastName.value=='')
		{alert(alertLastName); formObj.LastName.focus(); return false;}
	if (formObj.Email.value=='')
		{alert(alertEmail); formObj.Email.focus(); return false;}
	return true;
}
</SCRIPT>

<!--- update account --->
<cfif isDefined("form.btnUpdateMyAccount")>
	<cfinvoke component="Components.getUserInfo" method="UpdateMyAccount" returnvariable="msgUpdate">
		<cfinvokeargument name="FirstName" value="#form.FirstName#" />
		<cfinvokeargument name="LastName" value="#form.LastName#" />
		<cfinvokeargument name="Email" value="#form.Email#" />
	</cfinvoke>
</cfif>

<!--- get the user info --->
<cfinclude template="components/q_getUserInfoOther.cfm">

<cfoutput>
<BODY BGCOLOR="#Request.ApplicationBGColor#" ONLOAD="document.forms.MyAccount.FirstName.focus()">
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
								<TD CLASS="largeText" ALIGN="left"><strong>My Account Management</strong></TD>
							</TR>
							<cfif not isDefined("form.btnUpdateMyAccount")>
								<TR>
									<TD CLASS="largeText" ALIGN="center"></TD>
									<TD CLASS="largeText" ALIGN="left">Use this page to update your account information.</TD>
								</TR>
							</cfif>
							<TR>
								<TD CLASS="largeText" ALIGN="center"></TD>
								<TD CLASS="largeText" ALIGN="left">&nbsp;</TD>
							</TR>
							<cfif isDefined("form.btnUpdateMyAccount")>
								<TR>
									<TD CLASS="largeText" ALIGN="center"></TD>
									<TD CLASS="largeText" ALIGN="left"><span class="successText">#msgUpdate#</span></TD>
								</TR>
							</cfif>
							<cfif not isDefined("form.btnUpdateMyAccount")>
								<FORM NAME="MyAccount" ACTION="MyAccount.cfm" METHOD="POST" onSubmit="return validateLogin(this)">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
									<!--- first name --->
									<TR>
										<TD CLASS="largeText" ALIGN="right"><strong>First Name:</strong>&nbsp;</TD>
										<TD CLASS="largeText">
											<INPUT TYPE="Text" NAME="FirstName" SIZE="40" MAXLENGTH="50" CLASS="largeText" value="#getUserInfoOther.First_Name#">
										</TD>
									</TR>
									<!--- last name --->
									<TR>
										<TD CLASS="largeText" ALIGN="right"><strong>Last Name:</strong>&nbsp;</TD>
										<TD CLASS="largeText">
											<INPUT TYPE="Text" NAME="LastName" SIZE="40" MAXLENGTH="50" CLASS="largeText" value="#getUserInfoOther.Last_Name#">
										</TD>
									</TR>
									<!--- email --->
									<TR>
										<TD CLASS="largeText" ALIGN="right"><strong>Email:</strong>&nbsp;</TD>
										<TD CLASS="largeText">
											<INPUT TYPE="Text" NAME="Email" SIZE="60" MAXLENGTH="100" CLASS="largeText" value="#getUserInfoOther.email#">
										</TD>
									</TR>
	
									<TR>
										<TD CLASS="largeText" ALIGN="center"></TD>
										<TD CLASS="largeText" ALIGN="left"></TD>
									</TR>
									<TR>
										<TD CLASS="largeText" ALIGN="center"></TD>
										<TD CLASS="largeText" ALIGN="left">
											<INPUT TYPE="Submit" name="btnUpdateMyAccount" VALUE="Update My Account" CLASS="largeText">
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
	<cfoutput>var alertFirstName = "Please enter your first name."</cfoutput>;
	<cfoutput>var alertLastName = "Please enter your last name."</cfoutput>;
	<cfoutput>var alertEmail = "Please enter your full email address."</cfoutput>;
</SCRIPT>
</body>
</html>
</cfif>
