<!-------------------------------------------
Description:
	cfc to login a user, get the user info and reset password

History:
	1/11/2019 - created
-------------------------------------------->

<cfcomponent>
	<!--- login --->
	<cffunction name="Login"
			  			hint="login the user" 
			  			returntype="String">
		<!--- get encrypted version of password --->
		<cfset encpwd = trim(encrypt(arguments.Password,request.seed))>
		<!--- get the user info --->
		<CFQUERY NAME="getUserInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT a.User_ID, a.First_Name, a.Last_Name, a.Company_ID, a.Email, a.SuperUser, 
						 b.Subcontractor,
						 c.AccessLevel,
						 e.Project_Types
			FROM WebSite_Admin.dbo.Web_Site_Users as a
					 INNER JOIN WebSite_Admin.dbo.Web_Site_Companies as b on a.Company_ID = b.Company_ID
					 INNER JOIN WebSite_Admin.dbo.Web_Site_User_Access as c on a.User_ID = c.User_ID
					 INNER JOIN WebSite_Admin.dbo.Web_Site as d on c.Web_Site_ID = d.Web_Site_ID and d.Web_Site = <cfqueryparam value="#Request.WebSiteID#" cfsqltype="CF_SQL_VARCHAR">
					 LEFT JOIN WebSite_Admin.dbo.Web_Site_User_Attribute as e on a.User_ID = e.User_ID
			WHERE a.email = <cfqueryparam value="#trim(Form.Email)#" cfsqltype="CF_SQL_VARCHAR"> 
						AND a.active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
						and a.password = '#encpwd#'
						and a.PasswordAttempts < <cfqueryparam value="5" cfsqltype="CF_SQL_INTEGER">
						and (a.isLocked = <cfqueryparam  cfsqltype="cf_sql_bit" value="0"> or a.isLocked is NULL)
		</CFQUERY>
		<!---- set session variables ---->
		<CFSET Authenticated = YesNoFormat(getUserInfo.RecordCount GT 0)>
		<cfif Authenticated><CFINCLUDE TEMPLATE="SetCookies.cfm"></cfif>
		<cfreturn Authenticated>
	</cffunction>

	<!--- reset password --->
	<cffunction name="ResetPassword"
			  			hint="Reset password" 
			  			returntype="String">
		<!--- build an array --->
		<cfset arrValidChars = ListToArray("A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,U,V,W,X,Y,Z,2,3,4,5,6,7,8,9" &
										   ",a,b,c,d,e,f,g,h,i,j,k,m,n,o,p,q,r,s,t,u,v,w,x,y,z,$,@,!,-") />
		<cfset strRandomPassword = "">
		<!--- Shuffle the array --->
		<cfset CreateObject("java","java.util.Collections").Shuffle(arrValidChars)/>
		<cfset passwordLength = 7>
		<!--- Build the password --->
		<cfloop index="i" from="1" to="#passwordLength#">
			<cfset strRandomPassword = strRandomPassword & arrValidChars[#i#]>
		</cfloop>
		<cfset strRandomPassword = lcase(strRandomPassword)>
		<cfset encEmail = trim(encrypt(lcase(strRandomPassword),request.seed))>
		<!--- update --->
		<CFQUERY NAME="updatePassword" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update WebSite_Admin.dbo.Web_Site_Users
			set	Password = <cfqueryparam value="#encEmail#" cfsqltype="CF_SQL_VARCHAR">
				,Enc_User_ID = <cfqueryparam value="#strRandomPassword#" cfsqltype="CF_SQL_VARCHAR">
				,PasswordAttempts = 0
				,isLocked = 0
			where email = <cfqueryparam value="#trim(Form.Email)#" cfsqltype="CF_SQL_VARCHAR">
		</CFQUERY>
		<CFQUERY NAME="updatePassword" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update ExxonMobilTeam.dbo.XOM_Users
			set	password = <cfqueryparam value="#encEmail#" cfsqltype="CF_SQL_VARCHAR">
				,Enc_User_ID = <cfqueryparam value="#strRandomPassword#" cfsqltype="CF_SQL_VARCHAR">
				,PasswordAttempts = 0
				,isLocked = 0
			where email = <cfqueryparam value="#trim(Form.Email)#" cfsqltype="CF_SQL_VARCHAR">
		</CFQUERY>
		<CFQUERY NAME="getUserInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT First_Name, Last_Name, Email, Enc_User_ID
			FROM WebSite_Admin.dbo.Web_Site_Users
			WHERE email = <cfqueryparam value="#trim(Form.Email)#" cfsqltype="CF_SQL_VARCHAR">
		</CFQUERY>
		<cfinvoke component="Components.getMessageCode" method="getMessage" returnvariable="theMessage">
			<cfinvokeargument name="MessageCode" value="005" />
		</cfinvoke>
		<cfreturn theMessage>
	</cffunction>

	<!--- change the password --->
	<cffunction name="ChangePassword"
			  			hint="Change password" 
			  			returntype="String">
		<!--- encrypt the password --->
		<cfset encpwd = trim(encrypt(arguments.password,request.seed))>
		<!--- update the password --->
		<CFQUERY NAME="updatePassword" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update WebSite_Admin.dbo.Web_Site_Users
			set	Password = <cfqueryparam value="#encpwd#" cfsqltype="CF_SQL_VARCHAR">
			where email = <cfqueryparam value="#Session.Security.Email#" cfsqltype="CF_SQL_VARCHAR">
		</CFQUERY>
		<CFQUERY NAME="updatePassword" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update ExxonMobilTeam.dbo.XOM_Users
			set	password = <cfqueryparam value="#encpwd#" cfsqltype="CF_SQL_VARCHAR">
			where email = <cfqueryparam value="#Session.Security.Email#" cfsqltype="CF_SQL_VARCHAR">
		</CFQUERY>
		<cfinvoke component="Components.getMessageCode" method="getMessage" returnvariable="theMessage">
			<cfinvokeargument name="MessageCode" value="002" />
		</cfinvoke>
		<cfreturn theMessage>
	</cffunction>

	<!--- update account --->
	<cffunction name="UpdateMyAccount"
			  			hint="Update my account" 
			  			returntype="String">
		<CFQUERY NAME="updateUserInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update WebSite_Admin.dbo.Web_Site_Users
			set
				First_Name = <cfqueryparam value="#trim(arguments.FirstName)#" cfsqltype="CF_SQL_VARCHAR">,
				Last_Name = <cfqueryparam value="#trim(arguments.LastName)#" cfsqltype="CF_SQL_VARCHAR">,
				Email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">
			WHERE User_ID = <cfqueryparam value="#Session.Security.UserID#" cfsqltype="CF_SQL_INTEGER">
		</CFQUERY>
		<!--- update XOM account --->
		<CFQUERY NAME="updateUserInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update ExxonMobilTeam.dbo.XOM_Users
			set
				First_Name = <cfqueryparam value="#trim(arguments.FirstName)#" cfsqltype="CF_SQL_VARCHAR">,
				Last_Name = <cfqueryparam value="#trim(arguments.LastName)#" cfsqltype="CF_SQL_VARCHAR">,
				Email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">
			WHERE Email = <cfqueryparam value="#trim(Session.Security.Email)#" cfsqltype="CF_SQL_VARCHAR">
		</CFQUERY>
		<!--- update XOM LPS account --->
		<CFQUERY NAME="updateUserInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update ExxonMobilLPS.dbo.XOMLPS_Users
			set
				First_Name = <cfqueryparam value="#trim(arguments.FirstName)#" cfsqltype="CF_SQL_VARCHAR">,
				Last_Name = <cfqueryparam value="#trim(arguments.LastName)#" cfsqltype="CF_SQL_VARCHAR">,
				Email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">
			WHERE Email = <cfqueryparam value="#trim(Session.Security.Email)#" cfsqltype="CF_SQL_VARCHAR">
		</CFQUERY>
		<CFSET Session.Security.Firstname = trim(form.FirstName)>
		<CFSET Session.Security.LastName = trim(form.LastName)>
		<CFSET Session.Security.Email = trim(form.Email)>

		<cfinvoke component="Components.getMessageCode" method="getMessage" returnvariable="theMessage">
			<cfinvokeargument name="MessageCode" value="004" />
		</cfinvoke>
		<cfreturn theMessage>
	</cffunction>

	<!--- find the account --->
	<cffunction name="FindAccount"
			  			hint="Find my account" 
			  			returntype="Any" >
		<CFQUERY NAME="getUserInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT a.User_ID, a.First_Name, a.Last_Name, a.Company_ID, a.Email, a.Enc_User_ID,
						 b.Company_Name,
						 c.AccessLevel
			FROM WebSite_Admin.dbo.Web_Site_Users as a
					 INNER JOIN WebSite_Admin.dbo.Web_Site_Companies as b on a.Company_ID = b.Company_ID
					 INNER JOIN WebSite_Admin.dbo.Web_Site_User_Access as c on a.User_ID = c.User_ID
					 INNER JOIN WebSite_Admin.dbo.Web_Site as d on c.Web_Site_ID = d.Web_Site_ID and d.Web_Site = <cfqueryparam value="#Request.WebSiteID#" cfsqltype="CF_SQL_VARCHAR">
			WHERE a.email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">
						and a.active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
		</CFQUERY>
		<cfreturn getUserInfo>
	</cffunction>

	<!--- Check how many times user has attempted to login --->
	<cffunction name="AttemptCountStatus" returntype="numeric" hint="Find login attempts">
		<cfset PasswordAttempts = 0>
		<cfquery name="NumAttempts" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT PasswordAttempts
			FROM WebSite_Admin.dbo.Web_Site_Users
			WHERE email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">
			and active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
		<cfif len(NumAttempts.PasswordAttempts)><cfset PasswordAttempts = NumAttempts.PasswordAttempts></cfif>
		<cfreturn PasswordAttempts>
	</cffunction>

	<!--- Check if user account is locked --->
	<cffunction name="LockStatus" returntype="Boolean" hint="See if user account is locked">
		<cfset isLocked = 0>
		<cfquery name="IsLock" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT isLocked
			FROM WebSite_Admin.dbo.Web_Site_Users
			WHERE email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">
			and active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
		<cfif len(IsLock.isLocked)><cfset isLocked = IsLock.isLocked></cfif>
		<cfreturn isLocked>
	</cffunction>
	
	<!--- Check if lock is longer than 5 minutes --->
	<cffunction name="LockTimerStatus" returntype="Boolean" hint="See if user account is locked">
		<cfset OldLock = false>
		<cfquery name="LockTime" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT datediff(minute,LastLocked,GETDATE()) AS TimeElapsed
			FROM WebSite_Admin.dbo.Web_Site_Users
			WHERE email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">
			and active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
		<cfif LockTime.TimeElapsed GTE 5>
			<cfset OldLock = true>
		</cfif>
		<cfreturn OldLock>
	</cffunction>
	
	<!--- Add to number of user attempts --->
	<cffunction name="IncreaseAttemptCount" hint="Add one to number of user attempts">
		<cfquery name="AddAttempt" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update WebSite_Admin.dbo.Web_Site_Users
			set PasswordAttempts = isNull(PasswordAttempts,0) + 1
			OUTPUT INSERTED.PasswordAttempts
			where (email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">)
			and active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
	</cffunction>

	<!--- Lock user account --->
	<cffunction name="LockUser" hint="Lock the user">
		<cfquery name="SetLock" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update WebSite_Admin.dbo.Web_Site_Users
			set isLocked = <cfqueryparam value = "1" CFSQLType="CF_SQL_BIT">,
				LastLocked = <cfqueryparam CFSQLType="CF_SQL_TIMESTAMP" value="#CreateODBCDateTime(Now())#">
			where (email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">)
			and active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
	</cffunction>

	<!--- Clear number of user attempts --->
	<cffunction name="ClearAttemptCount" hint="Set attempts to zero">
		<cfquery name="ClearAttempts" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update WebSite_Admin.dbo.Web_Site_Users
			set PasswordAttempts = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
			where (email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">)
			and active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
	</cffunction>

	<!--- Unlock user account --->
	<cffunction name="UnlockUser" hint="Unlock the user">
		<cfquery name="SetLock" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			update WebSite_Admin.dbo.Web_Site_Users
			set isLocked = <cfqueryparam value = "0" CFSQLType = "CF_SQL_BIT">
			where (email = <cfqueryparam value="#trim(arguments.Email)#" cfsqltype="CF_SQL_VARCHAR">)
			and active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
	</cffunction>
</cfcomponent>
