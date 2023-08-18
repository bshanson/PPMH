<!-------------------------------------------
Description:
	tracks pages that user has visited

History:
	1/11/2019 - created
-------------------------------------------->

<!--- get the url for the current page --->
<CFSET trackedURL = "#Request.Protocol#//#HTTP.Server_Name##HTTP.SCRIPT_NAME#">
<CFIF IsDefined("HTTP.Query_String") AND Len("#HTTP.Query_String#")><CFSET trackedURL = trackedURL & "?#HTTP.Query_String#"></CFIF>

<!--- track the URL --->
<CFQUERY datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	INSERT #Request.WebSiteID#.dbo.Track_Users (User_ID, Date_Time, URL, Remote_IP)
	VALUES (<cfqueryparam value="#Session.Security.UserID#" cfsqltype="CF_SQL_INTEGER">
					,<cfqueryparam value="#DateFormat(Now(),"mm/dd/yyyy")# #TimeFormat(Now(),"HH:mm:ss")#" cfsqltype="CF_SQL_VARCHAR">
					,<cfqueryparam value="#trackedURL#" cfsqltype="CF_SQL_VARCHAR">
					,<cfqueryparam value="#cgi.Remote_Addr#" cfsqltype="CF_SQL_VARCHAR">
					)
</CFQUERY>
