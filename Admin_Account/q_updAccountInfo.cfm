<!-------------------------------------------
Description:
	query to update the user info

History:
	1/11/2019 - created
-------------------------------------------->

<cfparam name="request.AccessLevel" default="" type="string" >

<!--- get the ID of the web site --->
<CFQUERY NAME="getWebSiteID" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	select Web_Site_ID 
	from WebSite_Admin.dbo.Web_Site
	where Web_Site = <cfqueryparam value="#Request.WebSiteID#" cfsqltype="CF_SQL_VARCHAR">
</CFQUERY>
<cfset WebSiteID = getWebSiteID.Web_Site_ID>

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

<!--- update account --->
<CFQUERY NAME="updateAccountInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	update WebSite_Admin.dbo.Web_Site_Users
	set
		First_Name = <cfqueryparam value="#trim(form.FirstName)#" cfsqltype="CF_SQL_VARCHAR">,
		Last_Name = <cfqueryparam value="#trim(form.LastName)#" cfsqltype="CF_SQL_VARCHAR">,
		Company_ID = <cfqueryparam value="#form.CompanyID#" cfsqltype="CF_SQL_INTEGER">,
		Email = <cfqueryparam value="#trim(lcase(form.Email))#" cfsqltype="CF_SQL_VARCHAR">
	WHERE User_ID = <cfqueryparam value="#form.edtUserID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>

<!--- update pm user attribute --->
<CFQUERY NAME="updateUserAttributes" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	update WebSite_Admin.dbo.Web_Site_User_Attribute
	set
		PM = <cfif isDefined("form.ProjectManager")><cfqueryparam value="#form.ProjectManager#" cfsqltype="CF_SQL_INTEGER"><cfelse>NULL</cfif>
		,Site_Manager = <cfif isDefined("form.SiteManager")><cfqueryparam value="#form.SiteManager#" cfsqltype="CF_SQL_INTEGER"><cfelse>NULL</cfif>
	WHERE User_ID = <cfqueryparam value="#form.edtUserID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>

<!--- update access level --->
<CFQUERY NAME="deleteAccessLevel" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	delete from WebSite_Admin.dbo.Web_Site_User_Access
	WHERE User_ID = <cfqueryparam value="#form.edtUserID#" cfsqltype="CF_SQL_INTEGER">
				and Web_Site_ID = <cfqueryparam value="#WebSiteID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>
<cfif len(request.AccessLevel)>
	<CFQUERY NAME="inserAccessLevel" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		insert into WebSite_Admin.dbo.Web_Site_User_Access
			(Web_Site_ID, User_ID, AccessLevel)
		values
			(<cfqueryparam value="#WebSiteID#" cfsqltype="CF_SQL_INTEGER">,
			 <cfqueryparam value="#form.edtUserID#" cfsqltype="CF_SQL_INTEGER">,
			 <cfqueryparam value="#request.AccessLevel#" cfsqltype="CF_SQL_VARCHAR">
			)
	</CFQUERY>
	<cfset form.AccessType = "WithAccess">
<cfelse>
	<cfset form.AccessType = "WithOutAccess">
</cfif>

<cfset msgSuccess = "*** The information has been updated ***">
