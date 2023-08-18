<!--------------------------------------------------------------
Description:
	get the region managers (deputies)

History:
	2/04/2022 - created
--------------------------------------------------------------->

<!--- get the region managers (deputies)) --->
<CFQUERY NAME="getRegionManagers" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT DISTINCT a.User_ID,
		b.First_Name, b.Last_Name
	FROM TurboScope.dbo.Admin_Portfolio_Deputy as a
		inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID
	ORDER BY b.Last_Name, b.First_Name
</CFQUERY>
