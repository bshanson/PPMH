<!--------------------------------------------------------------
Description:
	get the Chevron Portfolio Managers

History:
	4/3/2020 - created
--------------------------------------------------------------->

<!--- get the Chevron Portfolio Managers --->
<CFQUERY NAME="getChevronPortfolioManagers" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT User_ID, Last_Name, First_Name
	FROM WebSite_Admin.dbo.Web_Site_Users
	WHERE (User_ID IN (1315, 777, 1359, 1940, 9447, 1372, 9448, 9449, 866, 733, 9450, 8861, 9451, 1941, 4010, 9452, 9506, 6195, 9401, 1864, 9535, 9538, 9539, 9540, 9541,
	9542, 9543, 9544, 9545, 9546, 9547, 9548, 9549, 9550, 9551, 9552, 9553, 747, 9570, 1413, 9596))
		AND (Active = 1)
	ORDER BY Last_Name, First_Name
</CFQUERY>
