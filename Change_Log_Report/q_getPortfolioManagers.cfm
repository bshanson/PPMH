<!--------------------------------------------------------------
Description:
	get the Portfolio Managers

History:
	9/20/2022 - created
--------------------------------------------------------------->

<!--- get the Portfolio Managers --->
<CFQUERY NAME="getPortfolioManagers" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT b.User_ID, b.Last_Name, b.First_Name
	FROM WebSite_Admin.dbo.Web_Site_User_Attribute as a
		inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID and b.active = 1 
	where (a.Portfolio_Manager = 1)
	ORDER BY b.Last_Name, b.First_Name
</CFQUERY>
