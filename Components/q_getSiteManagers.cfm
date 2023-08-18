<!--------------------------------------------------------------
Description:
	get the PM info

History:
	1/09/2018 - created
--------------------------------------------------------------->

<!--- get the PMs --->
<CFQUERY NAME="getSiteManagers" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.User_ID, a.Last_Name, a.First_Name
	FROM WebSite_Admin.dbo.Web_Site_Users as a
		inner join WebSite_Admin.dbo.Web_Site_User_Attribute as b on a.User_id = b.User_ID and b.Site_Manager = 1
	where a.active = 1
	ORDER BY a.Last_Name, a.First_Name
</CFQUERY>
