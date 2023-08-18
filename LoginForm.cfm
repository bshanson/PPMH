<!-------------------------------------------
Description:
	application log-in form, called from Login.cfm

History:
	2/06/2020 - created
-------------------------------------------->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
	<title><CFOUTPUT>#Request.WebTitle#</CFOUTPUT></title>
</head>

<SCRIPT>
function validateLogin(formObj) {
	if (formObj.Email.value=='')
		{alert('Please enter your email.'); formObj.Email.focus(); return false;}
	if (formObj.Password.value=='')
		{alert('Please enter your password.'); formObj.Password.focus(); return false;}
	return true;
}
</SCRIPT>

<!--- get the url for the current page --->
<CFSET Return = "#Request.Protocol#//#HTTP.Server_Name#" & "#HTTP.SCRIPT_NAME#">
<CFIF IsDefined("HTTP.Query_String") AND Len("#HTTP.Query_String#")><CFSET Return = return & "?#HTTP.Query_String#"></CFIF>

<CFPARAM NAME="Attributes.MessageCode" DEFAULT="000">
<cfinvoke component="Components.getMessageCode" method="getMessage" returnvariable="theMessage">
	<cfinvokeargument name="MessageCode" value="#Attributes.MessageCode#" />
</cfinvoke>

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

						<TR bgcolor="#Request.TableBorderColor#">
							<TD CLASS="largeText" ALIGN="center" width="15%"></TD>
							<TD CLASS="largeText" ALIGN="left" width="85%"><strong>Log In</strong></TD>
						</TR>

						<!--- query for the page labels for the form --->
						<FORM NAME="frmUserInfo" ACTION="#Return#" METHOD="POST" onSubmit="return validateLogin(this)">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
								<TR>
									<TD CLASS="largeText" ALIGN="right"><strong>Email:</strong>&nbsp;</TD>
									<TD CLASS="largeText">
										<INPUT TYPE="Text" NAME="Email" SIZE="40" MAXLENGTH="50" CLASS="largeText"
											<CFIF IsDefined("Form.Email")>VALUE="#Form.Email#"</CFIF>
											<cfif (Attributes.MessageCode EQ "006")>disabled</cfif>
										>
										<cfif len(theMessage)> <span class="errorText">#theMessage#</span></cfif>
									</TD>
								</TR>
								<TR>
									<TD CLASS="largeText" ALIGN="right"><strong>Password:</strong>&nbsp;</TD>
									<TD CLASS="largeText">
										<INPUT TYPE="Password" NAME="Password" SIZE="40" MAXLENGTH="50" CLASS="largeText"
											<cfif (Attributes.MessageCode EQ "006")>disabled</cfif>
										>
									</TD>
								</TR>

								<TD CLASS="largeText" ALIGN="center"></TD>
								<TD CLASS="largeText" ALIGN="left">
									<INPUT TYPE="Submit" name="btnLogin" VALUE="Login" CLASS="largeText"
										<cfif (Attributes.MessageCode EQ "006")>disabled</cfif>
									>
								</TD>
							</TR>
						</FORM>
		
						<tr><td colspan="2">&nbsp;</td></tr>
		
 						<TR>
							<td></td>
							<TD CLASS="largeText">
								<a href="MyPassword_Reset.cfm">Did you forget your password?</a>
								<br><br>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</td></tr></TABLE>
</cfoutput>

<CFModule template="Footer.cfm">

</body>
</html>
