<!----------------------------------------------------------------------------------------------------------
Description:
	get All Team members

History:
	9/9/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get All Team Members--->
<cfquery name="getTeamMembersTmp" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.User_ID, '2' as Team_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where FCO_Team = 1

union 

	SELECT a.User_ID, '4' as Team_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where ACS_Reviewer = 1

union 

	SELECT a.User_ID, '6' as Team_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where FCO_Team_Lead = 1

union 

	SELECT a.User_ID, '7' as Team_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where Senior_Reviewer = 1

union 

	SELECT a.User_ID, '1' as Team_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where a.user_id = 999999

union 

	SELECT a.User_ID, '3' as Team_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where a.user_id = 999999

union 

	SELECT a.User_ID, '5' as Team_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where a.user_id = 999999

union 

	SELECT a.User_ID, '8' as Team_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where a.user_id = 999999

union 

	SELECT a.User_ID, '9' as Team_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where a.user_id = 999999

union 

	SELECT a.User_ID, '11' as Team_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where a.user_id = 999999

	ORDER BY b.Last_Name, b.First_Name
</cfquery>

<!--- get distinct team members --->
<cfquery name="getTeamMembersDistinct" dbtype="query">
	SELECT distinct User_ID, First_Name, Last_Name
	from getTeamMembersTmp
	ORDER BY Last_Name, First_Name
</cfquery>

<!--- add rows to query object, this will display a "select" row in the assign to list --->
<cfset TeamIDList = "1,2,3,4,5,6,7,8,9,11">
<cfloop list="#TeamIDList#" index="t">
	<cfset QueryAddRow(getTeamMembersTmp) />
	<cfset getTeamMembersTmp["User_ID"][getTeamMembersTmp.RecordCount] = "" />
	<cfset getTeamMembersTmp["Team_ID"][getTeamMembersTmp.RecordCount] = "#t#" />
	<cfset getTeamMembersTmp["First_Name"][getTeamMembersTmp.RecordCount] = "" />
	<cfset getTeamMembersTmp["Last_Name"][getTeamMembersTmp.RecordCount] = "- select the member -" />
</cfloop>

<cfquery name="getTeamMembersAll" dbtype="query">
	SELECT User_ID, Team_ID, First_Name, Last_Name
	from getTeamMembersTmp
	ORDER BY Last_Name, First_Name
</cfquery>
