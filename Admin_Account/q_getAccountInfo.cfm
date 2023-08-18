<!-------------------------------------------
Description:
	query to find the account info

History:
	1/11/2019 - created
-------------------------------------------->

<!--- find the account with access --->
<cfif form.AccessType EQ "WithAccess">
	<CFQUERY NAME="getAccountInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		SELECT a.User_ID, a.First_Name, a.Last_Name, a.Company_ID, a.Email, a.Active, a.Password, a.SuperUser, 
					 b.Company_Name, b.Subcontractor,
					 c.AccessLevel,
					 e.PM, e.Site_Manager
		FROM WebSite_Admin.dbo.Web_Site_Users as a
				 INNER JOIN WebSite_Admin.dbo.Web_Site_Companies as b on a.Company_ID = b.Company_ID
				 INNER JOIN WebSite_Admin.dbo.Web_Site_User_Access as c on a.User_ID = c.User_ID
				 INNER JOIN WebSite_Admin.dbo.Web_Site as d on c.Web_Site_ID = d.Web_Site_ID and d.Web_Site = '#Request.WebSiteID#'
				 left join WebSite_Admin.dbo.Web_Site_User_Attribute as e on a.user_id = e.user_id
		WHERE a.User_ID = <cfqueryparam value="#Form.edtUserID#" cfsqltype="CF_SQL_INTEGER">
	</CFQUERY>
<cfelse>
	<CFQUERY NAME="getAccountInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		SELECT a.User_ID, a.First_Name, a.Last_Name, a.Company_ID, a.Email, a.Active, a.Password, a.SuperUser, 
					 b.Company_Name, b.Subcontractor,
					 0 as AccessLevel,
					 e.PM, e.Site_Manager
		FROM WebSite_Admin.dbo.Web_Site_Users as a
				 INNER JOIN WebSite_Admin.dbo.Web_Site_Companies as b on a.Company_ID = b.Company_ID
				 left join WebSite_Admin.dbo.Web_Site_User_Attribute as e on a.user_id = e.user_id
		WHERE a.User_ID = <cfqueryparam value="#Form.edtUserID#" cfsqltype="CF_SQL_INTEGER">
	</CFQUERY>
</cfif>
