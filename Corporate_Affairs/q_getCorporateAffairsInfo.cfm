<!----------------------------------------------------------------------------------------------------------
Description:
	get a Corporate Affairs record

History:
	1/11/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the record --->
<cfquery name="getCorporateAffairsInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Corporate_Affairs_ID, a.Tracking_Date, a.Trigger_Date, a.Description, a.Created_By,
				 b.ID as Admin_Site_ID, b.Site_ID, b.Site_Name, b.Address, b.City, b.Portfolio_ID, 
				 c.State_ID, c.State_Abbreviation,
				 d.first_name, d.last_name, d.email
	FROM #Request.WebSite#.dbo.Corporate_Affairs as a
			 inner join TurboScope.dbo.Admin_Site as b on a.site_ID = b.ID
			 inner join TurboScope.dbo.Admin_State as c on b.State_id = c.State_id
			 left join WebSite_Admin.dbo.Web_Site_Users as d on a.Created_By = d.User_id 
	WHERE a.Corporate_Affairs_ID = #form.CorporateAffairsID#
</cfquery>
