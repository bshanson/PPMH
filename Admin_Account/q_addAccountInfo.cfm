<!-------------------------------------------
Description:
	query to add the user info

History:
	1/11/2019 - created
-------------------------------------------->

<cfparam name="request.AccessLevel" default="" type="string" >
<cfset msgSuccess = "*** The information has been added ***">
<cfset msgError = "">

<!--- get the ID of the web site --->
<CFQUERY NAME="getWebSiteID" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	select Web_Site_ID 
	from WebSite_Admin.dbo.Web_Site 
	where Web_Site = <cfqueryparam value="#Request.WebSiteID#" cfsqltype="CF_SQL_VARCHAR">
</CFQUERY>
<cfset WebSiteID = getWebSiteID.Web_Site_ID>

<!--- search for email --->
<CFQUERY NAME="getEmail" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT email
	from WebSite_Admin.dbo.Web_Site_Users
	where email = <cfqueryparam value="#trim(lcase(form.Email))#" cfsqltype="CF_SQL_VARCHAR">
		and active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>

<!--- if not found --->
<cfif getEmail.recordcount EQ 0>
	<!--- build an array --->
	<cfset arrValidChars = ListToArray("A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,U,V,W,X,Y,Z,2,3,4,5,6,7,8,9" &
									   ",a,b,c,d,e,f,g,h,i,j,k,m,n,o,p,q,r,s,t,u,v,w,x,y,z,$,@,!,-,_") />
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
	
	<!--- get the id of the portal parent pages --->
	<CFQUERY NAME="getPortalID" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		select ID, AccessLevel
		from #Request.WebSiteID#.dbo.Portal
		where ParentID = <cfqueryparam value="0" cfsqltype="CF_SQL_INTEGER">
		order by id
	</CFQUERY>

	<!--- define request.AccessLevel --->
	<cfloop query="getPortalID" >
		<cfif isDefined("form.portalid#getPortalID.id#")>
			<cfset request.AccessLevel = listappend(request.AccessLevel,getPortalID.AccessLevel)>
		</cfif>
	</cfloop>

	<!--- add account to WebSite_Users --->
	<CFQUERY NAME="addAccountInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		insert into WebSite_Admin.dbo.Web_Site_Users
			(Password, First_Name, Last_Name, Company_ID, Email, Active, SuperUser)
		values
			(<cfqueryparam value="#encEmail#" cfsqltype="CF_SQL_VARCHAR">
			 ,<cfqueryparam value="#trim(form.FirstName)#" cfsqltype="CF_SQL_VARCHAR">
			 ,<cfqueryparam value="#trim(form.LastName)#" cfsqltype="CF_SQL_VARCHAR">
			 ,<cfqueryparam value="#form.CompanyID#" cfsqltype="CF_SQL_INTEGER">
			 ,<cfqueryparam value="#trim(lcase(form.Email))#" cfsqltype="CF_SQL_VARCHAR">
			 ,<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
			 ,<cfqueryparam value="0" cfsqltype="CF_SQL_INTEGER">
			 )
	</CFQUERY>

	<!--- get the new user id --->
	<CFQUERY NAME="getNewUserID" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		SELECT max(User_ID) as newUserID
		FROM WebSite_Admin.dbo.Web_Site_Users
		WHERE Active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
	</CFQUERY>

	<!--- add account to Web_Site_User_Access --->
	<CFQUERY NAME="insertUserAccess" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		insert into WebSite_Admin.dbo.Web_Site_User_Access
			(Web_Site_ID, User_ID, AccessLevel)
		values
			(<cfqueryparam value="#WebSiteID#" cfsqltype="CF_SQL_INTEGER">,
			 <cfqueryparam value="#getNewUserID.newUserID#" cfsqltype="CF_SQL_INTEGER">,
			 <cfqueryparam value="#request.AccessLevel#" cfsqltype="CF_SQL_VARCHAR">
			)
	</CFQUERY>
	<!--- add account to user attributes --->
	<CFQUERY NAME="insertUserAttributes" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		insert into WebSite_Admin.dbo.Web_Site_User_Attribute
			(User_ID, PM, Site_Manager)
		values
			(<cfqueryparam value="#getNewUserID.newUserID#" cfsqltype="CF_SQL_INTEGER">
			 ,<cfif isDefined("form.ProjectManager")><cfqueryparam value="#form.ProjectManager#" cfsqltype="CF_SQL_INTEGER"><cfelse>NULL</cfif>
			 ,<cfif isDefined("form.SiteManager")><cfqueryparam value="#form.SiteManager#" cfsqltype="CF_SQL_INTEGER"><cfelse>NULL</cfif>
			)
	</CFQUERY>
	<cfset form.AccessType = "WithAccess">

	<!--- send email notice --->
	<CFModule template="../Components/f_Email_Notifcation.cfm" NoticeType="accountnew" Email="#form.Email#" FirstName="#form.FirstName#" PWD="#strRandomPassword#">

<!--- if email found --->
<cfelse>
	<cfset msgSuccess = "">
	<cfset msgError = "*** An account with the email address, " & trim(lcase(form.Email)) & ", has already been created. Please enter a different email. ***">
</cfif>
