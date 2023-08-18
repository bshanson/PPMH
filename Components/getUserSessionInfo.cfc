<!-------------------------------------------
Description:
	cfc to track a non-valid user, number of attempts of that user to log into the site, and the user's IP address

History:
	9/2/2022 - created
-------------------------------------------->

<cfcomponent>
	<cffunction name="SetUserName" hint="Sets the session.security.email to the submitted email">
		<cfset Session.Security.Email = arguments.Email>
	</cffunction>

	<cffunction name="IncrementAttempts" hint="Increases the number of attempts by one">
		<cfset Session.Security.NumAttempts = Session.Security.NumAttempts + 1>
	</cffunction>
	
	<cffunction name="ClearAttempts" hint="Clear number of attempts">
		<cfset Session.Security.NumAttempts = 0>
	</cffunction>
	
	<cffunction name="SetIpAddress" hint="Set the session.security.ipaddress to the current ip address">
		<cfset Session.Security.IpAddress = cgi.remote_addr>
	</cffunction>
	
	<cffunction name="LockSessionUser" hint="Set the user lock to true">
		<cfset Session.Security.UserLock = "true">
	</cffunction>
	
	<cffunction name="UnlockSessionUser" hint="Set the user lock to false">
		<cfset Session.Security.UserLock = "false">
	</cffunction>
	
	<cffunction name="SetLockTime" hint="Set the lock timer to now">
		<cfset Session.Security.LockTime = CreateODBCDateTime(Now())>
	</cffunction>

	<cffunction name="LockTimerStatus" returntype="Boolean" hint="Check amount of time user has been locked">
		<cfset NumMin = 0>
		<cfset ClearLock = false>
		<cfset NumMin = datediff("n",Session.Security.LockTime,CreateODBCDateTime(Now()))>
		<cfif NumMin GTE 5>
			<cfset ClearLock = true>
		</cfif>
		<cfreturn ClearLock>
	</cffunction>
    
	<cffunction name="SaveBadUser" hint="Save the bad user info to the table">
		<cfquery name="DoesExist"  datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT COALESCE(TotalAttempts,0) as TotalAttempts
			FROM WebSite_Admin.dbo.Brute_Force_Tries
			WHERE UserName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.Security.Email#">
			AND IPAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.Security.IpAddress#">
		</cfquery>
		<cfif DoesExist.RecordCount GT 0>
			<cfset CurrAttempts = DoesExist.TotalAttempts + Session.Security.NumAttempts>
			<cfquery name="UpdateUser" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
				UPDATE WebSite_Admin.dbo.Brute_Force_Tries
				SET TotalAttempts = <cfqueryparam cfsqltype="cf_sql_integer" value="#CurrAttempts#">
				WHERE UserName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.Security.Email#">
				AND IPAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.Security.IpAddress#">
			</cfquery>
		<cfelse>
			<cfquery name="InsertUser" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
				INSERT INTO WebSite_Admin.dbo.Brute_Force_Tries
				(UserName, IPAddress, TotalAttempts)
				VALUES
				(<cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.Security.Email#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.Security.IpAddress#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#Session.Security.NumAttempts#">)
			</cfquery>
		</cfif>
	</cffunction>
</cfcomponent>