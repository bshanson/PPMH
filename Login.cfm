<!--------------------------------------------------------------------------
Description:
	application log-in procedure, called from application.cfm

Parameters:
	Email - user id of person logging in
	Password - password of person loggin in

History:
	2/06/2020 - created
--------------------------------------------------------------------------->

<cfparam name="Session.Security.Email" default="">
<cfparam name="Session.Security.NumAttempts" default="0">
<cfparam name="Session.Security.IpAddress" default="">
<cfparam name="Session.Security.UserLock" default="false">
<cfparam name="Session.Security.LockTime" default="">

<CFSET Email = "">
<CFSET Password = "">
<CFSET Authenticated = "No">
<CFSET LoginMessageCode = "000">
<CFSET NumAttempts = 0>
<CFSET IsLock = false>

<!--- get the url for the current page --->
<CFSET Return = "#Request.Protocol#//#HTTP.Server_Name#" & "#HTTP.SCRIPT_NAME#">
<CFIF IsDefined("HTTP.Query_String") AND Len("#HTTP.Query_String#")><CFSET Return = return & "?#HTTP.Query_String#"></CFIF>

<CFSET SuperUserSwitchingID = YesNoFormat(IsDefined("Session.Security.SuperUser") AND IsDefined("Session.Security.Email") AND Session.Security.SuperUser NEQ Session.Security.Email)>
<CFIF SuperUserSwitchingID>
	<cfif isDefined("getUserInfo")>
		is superuser need to switch user id
		<CFSET Request.UserInfo = getUserInfo>
		<CFEXIT METHOD="EXITTEMPLATE">
	<cfelse>
		<cfinclude template="logout.cfm">
	</cfif>
</CFIF>

<!--- log-in --->
<cfif isDefined("form.btnLogin")>
	<cfinvoke component="Components.getUserInfo" method="Login" returnvariable="Authenticated">
		<cfinvokeargument name="Password" value="#Form.Password#" />
	</cfinvoke>
</CFIF>

<!---- log-in failed redisplay login screen ---->
<CFIF Authenticated EQ "No">
	<CFIF IsDefined("Form.Email") AND IsDefined("Form.Password")>
		<CFSET LoginMessageCode = "001">
		<cfinvoke component="Components.getUserInfo" method="FindAccount" returnvariable="getUserInfo">
			<cfinvokeargument name="Email" value="#Form.Email#" />
		</cfinvoke>
		<cfif getUserInfo.RecordCount GT 0>
			<cfinvoke component="Components.getUserInfo" method="AttemptCountStatus" returnvariable="NumAttempts">
				<cfinvokeargument name="Email" value="#Form.Email#" />
			</cfinvoke>
			<cfif NumAttempts GTE 5>
				<cfinvoke component="Components.getUserInfo" method="LockStatus" returnvariable="IsLock">
					<cfinvokeargument name="Email" value="#Form.Email#" />
				</cfinvoke>
				<CFSET LoginMessageCode = "006">
				<cfif NOT IsLock>
					<cfinvoke component="Components.getUserInfo" method="LockUser">
						<cfinvokeargument name="Email" value="#Form.Email#" />
					</cfinvoke>
					<CFModule template="components/f_Email_Notifcation.cfm" NoticeType="lockedaccount" UID="#getUserInfo.User_ID#" Email="#getUserInfo.Email#">
				<cfelse>
					<cfinvoke component="Components.getUserInfo" method="LockTimerStatus" returnvariable="OldLock">
						<cfinvokeargument name="Email" value="#Form.Email#" />
					</cfinvoke>
					<cfif OldLock>
						<cfinvoke component="Components.getUserInfo" method="UnlockUser">
							<cfinvokeargument name="Email" value="#Form.Email#" />
						</cfinvoke>
						<cfinvoke component="Components.getUserInfo" method="ClearAttemptCount">
							<cfinvokeargument name="Email" value="#Form.Email#" />
						</cfinvoke>
						<CFSET LoginMessageCode = "001">
					</cfif>
				</cfif>
			<cfelse>
				<cfinvoke component="Components.getUserInfo" method="IncreaseAttemptCount">
					<cfinvokeargument name="Email" value="#Form.Email#" />
				</cfinvoke>
			</cfif>
		<cfelse>
			<cfinvoke component="Components.getUserSessionInfo" method="SetUserName">
				<cfinvokeargument name="Email" value="#Form.Email#" />
			</cfinvoke>
			<cfif Session.Security.NumAttempts GTE 5>
				<cfif Session.Security.UserLock EQ "true">
					<cfinvoke component="Components.getUserSessionInfo" method="LockTimerStatus"></cfinvoke>
					<cfif ClearLock>
						<cfinvoke component="Components.getUserSessionInfo" method="UnlockSessionUser"></cfinvoke>
						<cfinvoke component="Components.getUserSessionInfo" method="ClearAttempts"></cfinvoke>
					</cfif>
				<cfelse>
					<cfinvoke component="Components.getUserSessionInfo" method="LockSessionUser"></cfinvoke>
					<cfinvoke component="Components.getUserSessionInfo" method="SetIpAddress"></cfinvoke>
					<cfinvoke component="Components.getUserSessionInfo" method="SaveBadUser"></cfinvoke>
					<CFModule template="components/f_Email_Notifcation.cfm" NoticeType="lockedaccount">
					<CFSET LoginMessageCode = "006">
				</cfif>
			<cfelse>
				<cfinvoke component="Components.getUserSessionInfo" method="IncrementAttempts"></cfinvoke>
			</cfif>
		</cfif>
	</CFIF>
	<CFModule template="LoginForm.cfm" MessageCode="#LoginMessageCode#">
	<CFABORT>
<CFELSE>
	<cfinvoke component="Components.getUserInfo" method="ClearAttemptCount">
		<cfinvokeargument name="Email" value="#Form.Email#" />
	</cfinvoke>
</CFIF>
