<!--------------------------------------------------------------
Description:
	get OE Team Contacts info

History:
	9/28/2022 - created
--------------------------------------------------------------->

<!--- get the OE Team Contacts --->
<CFQUERY NAME="getOETeamContacts" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT b.User_ID, b.First_Name, b.Last_name
	FROM ppmh.dbo.Site_Users_Attributes as a
		inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID and active = <cfqueryparam value="1" cfsqltype="cf_sql_integer" >
	where OE_Team_Contact = <cfqueryparam value="1" cfsqltype="cf_sql_integer" >
	order by b.Last_name, b.First_Name  
</CFQUERY>
