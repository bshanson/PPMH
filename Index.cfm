<!-------------------------------------------
Description:
	index page

History:
	2/06/2020 - created
-------------------------------------------->

<cfif (request.now GT request.StartDate) and (request.now LT request.EndDate)>
<cfelse>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
	<meta http-equiv="Content-Security-Policy" content="object-src *; img-src *;">
	<title><CFOUTPUT>#Request.WebTitle#</CFOUTPUT></title>
</head>

<CFPARAM NAME="Form.TabID" DEFAULT="">
<CFPARAM NAME="URL.TabID" DEFAULT="#Form.TabID#">
<CFIF IsDefined("Form.Child")>
	<CFPARAM NAME="URL.Child" DEFAULT="#Form.Child#">
</CFIF>
<CFSET SelectedTabID="#URL.TabID#">

<cfoutput>
	<body BGCOLOR="#Request.ApplicationBGColor#">
		<cfinclude template="PreBanner.cfm">
		<cfif isDefined("Session.Security.CompanyID") and Session.Security.CompanyID EQ 1><cfinclude template="website_menu.cfm"></cfif>
		<cfinclude template="Banner.cfm">
		<table width="#Request.ApplicationWidth#" bgcolor="##ffffff" cellspacing="0" cellpadding="0" align="center"><tr><td>
			<cfif isDefined("Session.Security.AccessLevel_#Request.WebSiteID#")>
				<!--- track the user --->
				<cfinclude template="components/q_track_users.cfm">

				<!--- menu bar --->
				<CFModule template="components/TabBar.cfm" SelectedTabID="#SelectedTabID#">

				<!--- main content --->
				<CFModule template="components/TabContent.cfm" SelectedTabID="#SelectedTabID#">
			<cfelse>
				<TABLE WIDTH="100%" CELLSPACING="1" CELLPADDING="0" border="0" align="center">
					<TR><TD ALIGN="center" bgcolor="#Request.MenuColor#" class="menuText">&nbsp;</TD></TR>
					<TR><TD ALIGN="center" class="largeText">&nbsp;</TD></TR>
					<TR><TD ALIGN="center" class="largeText">&nbsp;</TD></TR>
					<TR><TD ALIGN="center" class="xlargeText">You do not have access to this web site</TD></TR>
					<TR><TD ALIGN="center" class="largeText">&nbsp;</TD></TR>
					<TR><TD ALIGN="center" class="largeText">&nbsp;</TD></TR>
					<TR><TD ALIGN="center" class="largeText">&nbsp;</TD></TR>
				</TABLE>
			</cfif>
		</td></tr></table>
		<CFModule template="Footer.cfm">
	</body>
</cfoutput>
</html>
</cfif>

