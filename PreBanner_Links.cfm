<!----------------------------------------------------------
Description:
	Displays the welcome and logout links

History:
	2/06/2020 - created
---------------------------------------------------------->

<!--- determine if the current user is superuser --->
<CFSET IsSuperUser = "No">
<cfif Session.Security.SuperUser NEQ "No"><CFSET IsSuperUser = "Yes"></cfif>

<!--- get the url for the current page --->
<CFSET Return = "#Request.Protocol#//#HTTP.Server_Name#" & "#HTTP.SCRIPT_NAME#">
<CFIF IsDefined("HTTP.Query_String") AND Len("#HTTP.Query_String#")><CFSET Return = return & "?#HTTP.Query_String#"></CFIF>

<!--- display --->
<CFOUTPUT>
	Welcome,
	<CFIF IsSuperUser>
<A HREF="javascript: var n=window.open('Impersonate.cfm?Return=#Replace(Return,'&','^^','all')#', '', 'height=350,width=350,resizable')">#Session.Security.Firstname#</A>
<!---#Session.Security.Firstname#--->
	<CFELSE>
		#Session.Security.Firstname#
	</CFIF>
 	| <A HREF="MyAccount.cfm">My Account</A>
 	| <A HREF="MyPassword.cfm">My Password</A>
	| <A HREF="Logout.cfm">Logout</A>
</CFOUTPUT>
