<!--------------------------------------------------------------------------
Description:
	delete the users cookies

History:
	2/06/2020 - created
--------------------------------------------------------------------------->

<cflock timeout=20 scope="Session" type="Exclusive">
	<cfset StructDelete(Session, "Security")>
</cflock>

<cfquery name="getWebSites" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
 select Web_Site
 from WebSite_Admin.dbo.Web_Site
</cfquery>

<CFCOOKIE NAME="LoggedIn" EXPIRES="NOW">
<CFCOOKIE NAME="UserID" EXPIRES="NOW">
<CFCOOKIE NAME="Firstname" EXPIRES="NOW">
<CFCOOKIE NAME="LastName" EXPIRES="NOW">
<CFCOOKIE NAME="Email" EXPIRES="NOW">
<cfloop query="getWebSites">
	<cfif isDefined("Cookie.AccessLevel_#getWebSites.Web_Site#")>
		<CFCOOKIE NAME="AccessLevel_#getWebSites.Web_Site#" EXPIRES="NOW">
	</cfif>
</cfloop>
<CFIF IsDefined("Cookie.CompanyID")><CFCOOKIE NAME="CompanyID" EXPIRES="NOW"></cfif>
<CFIF IsDefined("Cookie.Subcontractor")><CFCOOKIE NAME="Subcontractor" EXPIRES="NOW"></cfif>
<CFIF IsDefined("Cookie.Admin")><CFCOOKIE NAME="Admin" EXPIRES="NOW"></cfif>
<CFIF IsDefined("Cookie.SuperUser")><CFCOOKIE NAME="Superuser" EXPIRES="NOW"></cfif>

<cfoutput><META HTTP-EQUIV='REFRESH' CONTENT='0;URL=#Request.Protocol#//#HTTP.Server_Name#/#Request.Site#'></cfoutput>
