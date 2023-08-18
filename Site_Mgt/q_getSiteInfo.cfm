<!----------------------------------------------------------------------------------------------------------
Description:
	get site info

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfif not find(',', form.AdminSiteID)>
	<cfquery name="getSiteInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select a.ID as Admin_Site_ID, a.Site_ID, a.Site_Name, a.Address, a.City, a.Site_Name, a.Portfolio_ID, a.Portfolio_Deputy_ID, 
			a.Chevron_PM_ID, a.COP_Region_ID, a.Inside_OERB, a.OE_Team_Contact_ID, a.Attorney_Engagement,
			c.State_Abbreviation, 
			d.User_id, d.Last_Name, d.First_Name,
			e.Region,
			f.Portfolio,
			g.last_name + ', ' + g.first_name as Ops_Lead,
			h.last_name + ', ' + h.first_name as Deputy,
			i.last_name + ', ' + i.first_name as OE_Contact
		from TurboScope.dbo.Admin_Site as a
			inner join TurboScope.dbo.Admin_Portfolio as b on a.Portfolio_ID = b.Portfolio_ID
			inner join TurboScope.dbo.Admin_State as c on a.State_id = c.State_id
			left join WebSite_Admin.dbo.Web_Site_Users as d on a.SM_ID = d.User_id 
			left join TurboScope.dbo.Admin_COP_Region as e on a.COP_Region_ID = e.COP_Region_ID
			left join TurboScope.dbo.Admin_Portfolio as f on a.Portfolio_ID = f.Portfolio_ID
			left join WebSite_Admin.dbo.Web_Site_Users as g on a.Chevron_PM_ID = g.User_ID
			left join WebSite_Admin.dbo.Web_Site_Users as h on a.Portfolio_Deputy_ID = h.User_ID
			left join WebSite_Admin.dbo.Web_Site_Users as i on a.OE_Team_Contact_ID = i.User_ID 
		where a.id = <cfqueryparam value="#form.AdminSiteID#" cfsqltype="cf_sql_integer" >
		order by a.Site_ID, a.Site_Name
	</cfquery>
<cfelse>
	<cfset searchErrormsg = "*** select only one site to retrieve ***" />
</cfif>
