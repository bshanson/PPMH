<!----------------------------------------------------------------------------------------------------------
Description:
	get Team members

History:
	9/9/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get Team Members--->
<cfquery name="getTeamMembers" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	<cfif isDefined("form.SendToID") and form.SendToID EQ 2>
	SELECT a.User_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where FCO_Team = 1
	ORDER BY b.Last_Name, b.First_Name

	<cfelseif isDefined("form.SendToID") and form.SendToID EQ 4>
	SELECT a.User_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where ACS_Reviewer = 1
	ORDER BY b.Last_Name, b.First_Name

	<cfelseif isDefined("form.SendToID") and form.SendToID EQ 6>
	SELECT a.User_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where FCO_Team_Lead = 1
	ORDER BY b.Last_Name, b.First_Name

	<cfelseif isDefined("form.SendToID") and form.SendToID EQ 7>
	SELECT a.User_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where Senior_Reviewer = 1
	ORDER BY b.Last_Name, b.First_Name

	<cfelse>
	SELECT a.User_ID, b.First_Name, b.Last_Name
	from #Request.WebSite#.dbo.Site_Users_Attributes as a
	inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID 
	where a.User_ID = 999999999
	ORDER BY b.Last_Name, b.First_Name
	</cfif>
</cfquery>
