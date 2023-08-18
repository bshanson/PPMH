<!-------------------------------------------
Description:
	application password reset form, called from Login.cfm

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
	if (formObj.Email.value=='')
		{alert(alertEmail); formObj.Email.focus(); return false;}
	return true;
}
</SCRIPT>

<!--- get the url for the current page --->
<CFSET Return = "#Request.Protocol#//#HTTP.Server_Name#" & "#HTTP.SCRIPT_NAME#">
<CFIF IsDefined("HTTP.Query_String") AND Len("#HTTP.Query_String#")><CFSET Return = return & "?#HTTP.Query_String#"></CFIF>

<!--- look up user account --->
<cfif isDefined("form.btnFindAccount")>
	<cfinvoke component="Components.getUserInfo" method="FindAccount" returnvariable="getUserInfo">
		<cfinvokeargument name="Email" value="#form.Email#" />
	</cfinvoke>
	<cfif getUserInfo.RecordCount EQ 0>
		<cfinvoke component="Components.getMessageCode" method="getMessage" returnvariable="theMessage">
			<cfinvokeargument name="MessageCode" value="003" />
		</cfinvoke>
	</cfif>
</cfif>

<!--- reset password --->
<cfif isDefined("form.btnResetPassword")>
	<cfinvoke component="Components.getUserInfo" method="ResetPassword" returnvariable="theMessage">
		<cfinvokeargument name="Email" value="#Form.Email#" />
	</cfinvoke>
	<cfinvoke component="Components.getUserInfo" method="FindAccount" returnvariable="getUserInfo">
		<cfinvokeargument name="Email" value="#form.Email#" />
	</cfinvoke>
</cfif>

<cfoutput>
<BODY BGCOLOR="#Request.ApplicationBGColor#" ONLOAD="document.forms.frmUserInfo.Email.focus()">
	<cfinclude template="PreBanner.cfm">
	<cfinclude template="Banner.cfm">

	<table width="#Request.ApplicationWidth#" bgcolor="##ffffff" cellspacing="1" align="center"><tr><td>
		<TABLE WIDTH="100%" CELLSPACING="1" CELLPADDING="0" BGCOLOR="#Request.TableBorderColor#">
			<tr><td bgcolor="#Request.MenuColor#" class="largeText">&nbsp;</td></tr>
		</TABLE>
	
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
							<TD CLASS="largeText" ALIGN="left"><strong>Password Reset</strong></TD>
						</TR>
						<TR>
							<TD CLASS="largeText" ALIGN="center"></TD>
							<TD CLASS="largeText" ALIGN="left">Use this page to reset your password.</TD>
						</TR>
						<TR>
							<TD CLASS="largeText" ALIGN="center"></TD>
							<TD CLASS="largeText" ALIGN="left">&nbsp;</TD>
						</TR>
						<cfif isDefined("form.btnResetPassword")>
							<TR>
								<TD CLASS="largeText" ALIGN="center"></TD>
								<TD CLASS="largeText" ALIGN="left">If #form.email# matches the email address on your account, we'll send you your new log-in information.</TD>
							</TR>
							<TR>
								<TD CLASS="largeText" ALIGN="center"></TD>
								<TD CLASS="largeText" ALIGN="left"><a href="/#Request.Site#">Click here to open the Log In page.</a></TD>
							</TR>
							<cfif isDefined("getUserInfo") and getUserInfo.RecordCount NEQ 0>							
								<CFModule template="components/f_Email_Notifcation.cfm" NoticeType="accountreset" Email="#getUserInfo.Email#" FirstName="#getUserInfo.First_Name#" PWD="#getUserInfo.Enc_User_ID#">
							</cfif>
						</cfif>
						<cfif not isDefined("form.btnResetPassword")>
							<FORM NAME="frmUserInfo" ACTION="#Return#" METHOD="POST" onSubmit="return validateLogin(this)">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
								<TR>
									<TD CLASS="largeText" ALIGN="right"><strong>Email:</strong>&nbsp;</TD>
									<TD CLASS="largeText">
										<INPUT TYPE="Text" NAME="Email" SIZE="40" MAXLENGTH="50" CLASS="largeText" <CFIF IsDefined("Form.Email")>VALUE="#Form.Email#"</CFIF>><cfif isDefined("theMessage")> <span class="errorText">#theMessage#</span></cfif>
									</TD>
								</TR>
								<cfif isDefined("getUserInfo") and getUserInfo.RecordCount NEQ 0>
									<TR>
										<TD CLASS="largeText" ALIGN="center"></TD>
										<TD CLASS="largeText" ALIGN="left">&nbsp;</TD>
									</TR>
									<TR>
										<TD CLASS="largeText" ALIGN="center"></TD>
										<TD CLASS="largeText" ALIGN="left">The following account information has been found:</TD>
									</TR>

									<!--- first name --->
									<TR>
										<TD CLASS="largeText" ALIGN="right"><strong>First Name:</strong>&nbsp;</TD>
										<TD CLASS="largeText">#getUserInfo.First_Name#</TD>
									</TR>
									<!--- last name --->
									<TR>
										<TD CLASS="largeText" ALIGN="right"><strong>Last Name:</strong>&nbsp;</TD>
										<TD CLASS="largeText">#getUserInfo.Last_Name#</TD>
									</TR>
									<!--- company --->
									<TR>
										<TD CLASS="largeText" ALIGN="right"><strong>Company:</strong>&nbsp;</TD>
										<TD CLASS="largeText">#getUserInfo.Company_Name#</TD>
									</TR>

									<TR>
										<TD CLASS="largeText" ALIGN="center"></TD>
										<TD CLASS="largeText" ALIGN="left">&nbsp;</TD>
									</TR>
									<TR>
										<TD CLASS="largeText" ALIGN="center"></TD>
										<TD CLASS="largeText" ALIGN="left">Click the Reset Password button to reset your account.</TD>
									</TR>
									<TR>
										<TD CLASS="largeText" ALIGN="center"></TD>
										<TD CLASS="largeText" ALIGN="left">If the account does not belong to you, reenter your email and click the Find Account button.</TD>
									</TR>
									<TR>
										<TD CLASS="largeText" ALIGN="center"></TD>
										<TD CLASS="largeText" ALIGN="left">&nbsp;</TD>
									</TR>
								</cfif>
								<TR>
									<TD CLASS="largeText" ALIGN="center"></TD>
									<TD CLASS="largeText" ALIGN="left">
										<INPUT TYPE="Submit" name="btnResetPassword" VALUE="Reset Password" CLASS="largeText">
										<INPUT TYPE="button" name="btnCancel" VALUE="Cancel" CLASS="largeText" onclick="window.location.href='#Request.Protocol#//#HTTP.Server_Name#/#Request.Site#'">
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
	</TR></TD></TABLE>
</cfoutput>

<CFModule template="Footer.cfm">

<SCRIPT>
	var alertEmail = "Please enter your full email address.";
</SCRIPT>
</body>
</html>
</cfif>
