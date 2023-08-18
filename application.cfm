<cfif cgi.https EQ "off"><cfoutput><META HTTP-EQUIV='REFRESH' CONTENT='0;URL=https://#HTTP.Server_Name#/#http.Script_name#'></cfoutput></cfif>
<CFAPPLICATION NAME="EnvWebApp" SESSIONMANAGEMENT="Yes" SETCLIENTCOOKIES="Yes">
<LINK REL="stylesheet" TYPE="text/css" HREF="styles/style.css">

<cfinclude template="/admin/dbinfo.cfm">
<cfif (request.now GT request.StartDate) and (request.now LT request.EndDate)>
	<br>The Portfolio & Project Management Hub web application is off-line for system enhancements.<br>
<cfelse>
	
<cfset Request.Protocol = "http:">
<cfif CGI.SERVER_PORT_SECURE EQ "1">
	<cfset Request.Protocol = "https:">
</cfif>

<CFSET Request.WebSiteID = "PPMH">
<CFSET Request.WebSite = "PPMH">
<CFSET Request.Site="PPMH">
<CFSET Request.WebTitle = "Portfolio & Project Management Hub">
<CFSET Request.WebSiteIDNo = "46">
<CFSET request.datasource = "BigDog">
<cfset Request.BaseURL = "index.cfm">
<CFSET Request.ApplicationBGColor = "##ACAAAA">
<cfset Request.TableBorderColor = "##ffffff">
<CFSET Request.MenuColor = "##0083A9">
<CFSET Request.MenuBorderColor = "##ffffff">
<CFSET Request.FooterColor = "##0083A9">
<CFSET Request.TableHeader = "##f7b44b">
<CFSET Request.TableRCF = "##F7F7F7">
<CFSET Request.ApplicationWidth = "1450">
<CFSET Request.FooterWidth = Request.ApplicationWidth-2>
<CFSET Request.TempPath = "c:\inetpub\wwwroot\PPMH\temp">
<CFSET Request.ExcelPath = "/PPMH/temp">
<CFSET Request.UploadPath = "c:\inetpub\wwwroot\PPMH\Milestone_Documents">
<CFSET Request.MileStonePath = "/PPMH/Milestone_Documents">
<CFSET Request.FCOUploadPath = "c:\inetpub\wwwroot\PPMH\FCO_Documents">
<CFSET Request.FCOPath = "/PPMH/FCO_Documents">
<CFSET Request.LUCUploadPath = "c:\inetpub\wwwroot\#Request.WebSite#\LUC_Documents">
<CFSET Request.LUCPath = "/#Request.WebSite#/LUC_Documents">
<CFSET Request.SharePointPath = "https://arcadiso365.sharepoint.com/teams/ChevronFCO/Shared Documents">
<CFSET Request.AttorneyPath = "/#Request.WebSite#/Attorney_Letters">
<CFSET Request.AttorneyUploadPath = "c:\inetpub\wwwroot\#Request.WebSite#\Attorney_Letters">
<CFSET Request.TmpDocFiles = "c:\inetpub\wwwroot\TmpDocFiles">

<!--- start and end year --->
<cfset Request.startYear = "2020">
<cfset Request.endYear = Request.startYear + 10>
<!--- change log start and end year --->
<cfset Request.startYearChangeLog = dateformat(now(),"yyyy")>
<cfset Request.endYearChangeLog = Request.startYearChangeLog + 2>

<cfif findnocase("MyPassword_Reset.cfm",cgi.script_name)>
	<CFmodule template="MyPassword_Reset.cfm">
	<cfabort>
</cfif>

<cfif not isDefined("Session.Security.LoggedIn") or not isDefined("Session.Security.UserID") or not isDefined("Session.Security.ProjectTypes")>
	<CFmodule template="Login.cfm">
</CFIF>

<cfif not isDefined("Session.Security.UserID") or not isDefined("Session.Security.AccessLevel_#Request.WebSiteID#")>
	<cfinvoke component="Components.getAccessLevel" method="getLevel">
		<cfinvokeargument name="Email" value="#Session.Security.Email#" />
	</cfinvoke>
</CFIF>

<!--- check to see if password needs resetting --->
<cfif isDefined("Session.Security.LoggedIn")>
	<cfif not isDefined("btnNewPassword")>
		<cfif isDefined("Session.Security.AccessLevel_#Request.WebSiteID#") and findnocase("Logout.cfm",cgi.script_name) EQ 0>
			<cfif isDefined("Session.Security.Email")>
				<cfset encEmail = trim(encrypt(Session.Security.Email,request.seed))>
				<CFQUERY NAME="getPassword" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
					SELECT Password
					FROM WebSite_Admin.dbo.Web_Site_Users
					WHERE user_ID = #Session.Security.UserID#
				</CFQUERY>
				<!--- password needs resetting --->
				<cfif getPassword.Password EQ encEmail>
					<CFModule template="MyPassword.cfm" msgCreate="You must create a new password">
					<CFABORT>
				</cfif>
			</cfif>
		</cfif>
	<cfelse>
		<cfset request.msgChanged = "Your new password has been created.">
	</cfif>
</cfif>
</cfif>
