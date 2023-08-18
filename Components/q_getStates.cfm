<!-------------------------------------------
Description:
	query to get a list of the states

History:
	1/11/2019 - created
-------------------------------------------->

<!--- get the states --->
<CFQUERY NAME="getStates" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.State_ID, a.State
	FROM TurboScope.dbo.Admin_State as a
	WHERE a.Country_ID = 1
	Order by a.State
</CFQUERY>
