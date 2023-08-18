<!-------------------------------------------
Description:
	query to get the user accesslevel for the website and set the session variables

History:
	1/11/2019 - created
-------------------------------------------->

<cfcomponent>
	<cffunction name="getLevel"
			  			hint="login the user" 
			  			returntype="String">
		<!--- get the user info --->
		<CFQUERY NAME="getUserID" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			SELECT a.User_ID, a.Company_ID, b.Subcontractor
			FROM WebSite_Admin.dbo.Web_Site_Users as a
				inner join WebSite_Admin.dbo.Web_Site_Companies as b on a.Company_ID = b.Company_ID
			WHERE a.Email = '#arguments.email#'
		</CFQUERY>
		
		<!--- set the user info session variables --->
		<cfif getUserID.RecordCount NEQ 0>
			<CFSET Session.Security.UserID = getUserID.User_ID>
			<CFSET Session.Security.CompanyID = getUserID.Company_ID>
			<CFSET Session.Security.Subcontractor = getUserID.Subcontractor>
		
			<!--- get the accesslevel info --->
			<CFQUERY NAME="getAccessLevel" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
				SELECT c.AccessLevel
				FROM WebSite_Admin.dbo.Web_Site_Users as a
						 INNER JOIN WebSite_Admin.dbo.Web_Site_User_Access as c on a.User_ID = c.User_ID
						 INNER JOIN WebSite_Admin.dbo.Web_Site as d on c.Web_Site_ID = d.Web_Site_ID and d.Web_Site = '#Request.WebSiteID#'
				WHERE a.User_ID = <cfqueryparam value="#Session.Security.UserID#" cfsqltype="CF_SQL_INTEGER">
			</CFQUERY>
			<cfif getAccessLevel.RecordCount NEQ 0>
				<CFSET evaluate("Session.Security.AccessLevel_#Request.WebSiteID# = getAccessLevel.AccessLevel")>
			</cfif>
		</CFIF>
	</cffunction>
</cfcomponent>
