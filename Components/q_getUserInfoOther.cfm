<!-------------------------------------------
Description:
	query to get the user info other info

History:
	1/11/2019 - created
-------------------------------------------->

<!--- get the other user info --->
<CFQUERY NAME="getUserInfoOther" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.First_Name, a.Last_Name, a.Email,
				 b.PM, b.Program_Manager, b.Supervisor, b.Supervisor_ID
	FROM WebSite_Admin.dbo.Web_Site_Users as a
			 left join WebSite_Admin.dbo.Web_Site_User_Attribute as b on a.user_id = b.user_id
	WHERE a.User_ID = <cfqueryparam value="#Session.Security.UserID#" cfsqltype="CF_SQL_INTEGER">
</CFQUERY>
