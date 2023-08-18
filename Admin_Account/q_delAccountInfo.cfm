<!-------------------------------------------
Description:
	query to delete the user info

History:
	1/11/2019 - created
-------------------------------------------->

<!--- delete account --->
<CFQUERY NAME="deleteAccountInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	update WebSite_Admin.dbo.Web_Site_Users
	set active = 0
	WHERE User_ID = <cfqueryparam value="#form.delUserID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>

<!--- get web sites user has access to --->
<CFQUERY NAME="getUserAccess" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	select Web_Site_ID, User_ID, AccessLevel
	FROM WebSite_Admin.dbo.Web_Site_User_Access
	WHERE User_ID = <cfqueryparam value="#form.delUserID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>

<cfloop query="getUserAccess" >
	<!--- if user is STMS user --->
	<cfif getUserAccess.Web_Site_ID EQ 2>
		<!--- find and delete user from project teams --->
		<CFQUERY NAME="getProjectTeams" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT Project_Team_ID
			FROM STMS.dbo.Project_Team
			WHERE (Project_Team_List LIKE '#form.delUserID#,%') 
						OR (Project_Team_List LIKE '%,#form.delUserID#,%') 
						OR (Project_Team_List LIKE '%,#form.delUserID#')
		</CFQUERY>
		<cfloop query="getProjectTeams" >
			<CFQUERY NAME="getProjectTeamList" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
				SELECT Project_Team_List
				FROM STMS.dbo.Project_Team
				WHERE Project_Team_ID = #getProjectTeams.Project_Team_ID# 
			</CFQUERY>
			<cfset PTList = valuelist(getProjectTeamList.Project_Team_List)>
			<cfset PTList = ListDeleteAt(PTList,ListFind(PTList,form.delUserID))>
			<CFQUERY NAME="updProjectTeams" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
				update STMS.dbo.Project_Team
				set Project_Team_List = '#PTList#'
				WHERE Project_Team_ID = #getProjectTeams.Project_Team_ID#
			</CFQUERY>
		</cfloop>
	</cfif>
</cfloop>

<cfset msgSuccess = "*** The information has been updated ***">
