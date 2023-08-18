<!--------------------------------------------------------------------------
Description:
	Set the users session variables

History:
	01/11/2019 - created
--------------------------------------------------------------------------->

<!--- session variables --->
<cfif NOT isDefined("Session.Security.UserID")>
	<CFSCRIPT>
		Session.Security = StructNew();
		StructInsert(Session.Security, "LoggedIn", "");
		StructInsert(Session.Security, "UserID", "");
		StructInsert(Session.Security, "Firstname", "");
		StructInsert(Session.Security, "LastName", "");
		StructInsert(Session.Security, "Email", "");
		StructInsert(Session.Security, "AccessLevel_#Request.WebSiteID#", "");
		StructInsert(Session.Security, "CompanyID", "");
		StructInsert(Session.Security, "Subcontractor", "");
		StructInsert(Session.Security, "Admin", "");
		StructInsert(Session.Security, "ProjectTypes", "");
		StructInsert(Session.Security, "Superuser", "No");
		StructInsert(Session.Security, "OldEmail", "");
		StructInsert(Session.Security, "OldUserID", "");
	</CFSCRIPT>
</cfif>
<CFSET Session.Security.LoggedIn = "Yes">
<CFSET Session.Security.UserID = getUserInfo.User_ID>
<CFSET Session.Security.Firstname = getUserInfo.First_Name>
<CFSET Session.Security.LastName = getUserInfo.Last_Name>
<CFSET Session.Security.Email = getUserInfo.Email>
<CFSET evaluate("Session.Security.AccessLevel_#Request.WebSiteID# = getUserInfo.AccessLevel")>
<CFSET Session.Security.CompanyID = getUserInfo.Company_ID>
<CFSET Session.Security.ProjectTypes = getUserInfo.Project_Types>
<cfif isDefined("getUserInfo.Subcontractor")><CFSET Session.Security.Subcontractor = getUserInfo.Subcontractor></cfif>
<cfif isDefined("getUserInfo.Admin")><CFSET Session.Security.Admin = getUserInfo.Email></cfif>
<cfif isDefined("getUserInfo.SuperUser") and getUserInfo.SuperUser EQ 1><CFSET Session.Security.Superuser = getUserInfo.Email></cfif>
