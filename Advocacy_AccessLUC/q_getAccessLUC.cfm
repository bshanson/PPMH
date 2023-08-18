<!----------------------------------------------------------------------------------------------------------
Description:
	get AccessLUC records

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfset RegionsToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionsToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionsToFind = listappend(RegionsToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<cfif not isDefined("URL.ALID")>
	<!--- get the max forecast and max closure year --->
	<cfquery name="getMaxForecast" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT Site_ID, MAX(Forecast_Year) AS maxYear, MAX(Forecast_Quarter) AS maxQuarter
		FROM #Request.WebSite#.dbo.Site_Status
		GROUP BY Site_ID
	union
		SELECT ID as Site_ID, Closure_Year AS maxYear, ceiling(Closure_Month/3.0) AS maxQuarter
		FROM TurboScope.dbo.Admin_Site
		where Portfolio_ID = <cfqueryparam value="#form.SitePortfolioToFind#" cfsqltype="cf_sql_integer" >
			and Closure_year > 0 
			and Closure_year < 999999
			and Status = 'A'
			and id not in (SELECT DISTINCT Site_ID from #Request.WebSite#.dbo.Site_Status)
	</cfquery>
	
	<!--- build site list --->
	<cfset listSiteID = "">
	<cfquery name="getForecastInfo" dbtype="query" >
		SELECT Site_ID, maxYear, maxQuarter
		FROM getMaxForecast
		<cfif isDefined("form.ClosureToFind") and form.ClosureToFind NEQ 0>
			where maxYear = #left(form.ClosureToFind,4)# and maxQuarter = #right(form.ClosureToFind,1)#
		</cfif>
	</cfquery>
	<cfif getForecastInfo.RecordCount NEQ 0><cfset listSiteID = valuelist(getForecastInfo.Site_ID)></cfif>
</cfif>

<!--- get the AccessLUC records --->
<cfquery name="getAccessLUC" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.ID as AccessLUC_ID, a.Onsite, a.Agreement_Type_ID, a.Arcadis_Chevron_Form_ID, a.SPL_ID, a.Priority_ID, 
				 a.Outside_Counsel_Involved, a.Milestone_In_Place_ID, a.Field_Work_Notification, a.Until_Completion,
				 a.Milestone_ID, a.Stage_ID, a.Expiration_Date, a.Term_Letter_Sent_ID, a.SPL_Notes, a.Final_Document, a.Complete, a.Complete_Date, 
				 a.Access_Property,
				 b.ID as Admin_Site_ID, b.Site_ID, b.Site_Name, b.Address, b.City, b.State_id, b.Zip_Code,
				 c.State_Abbreviation, 
				 d.Last_Name + ', ' + d.First_Name as SM_Name,
				 e.Portfolio,
				 f.Last_Name + ', ' + f.First_Name as SPL_Name,
				 g.Agreement_Type,
				 h.Priority,
				 i.Stage,
				 j.Milestone_In_Place,
				 k.Term_Letter_Sent,
				 l.Arcadis_Chevron_Form
	FROM #Request.WebSite#.dbo.AccessLUC as a
			 inner join TurboScope.dbo.Admin_Site as b on a.site_ID = b.ID
			 inner join TurboScope.dbo.Admin_State as c on b.State_id = c.State_id
			 left join WebSite_Admin.dbo.Web_Site_Users as d on b.SM_ID = d.User_id 
			 inner join TurboScope.dbo.Admin_Portfolio as e on b.Portfolio_id = e.Portfolio_id
			 left join WebSite_Admin.dbo.Web_Site_Users as f on SPL_ID = f.User_id 
			 left join #Request.WebSite#.dbo.AccessLUC_Agreement_Type as g on a.Agreement_Type_ID = g.Agreement_Type_ID
			 left join #Request.WebSite#.dbo.AccessLUC_Priority as h on a.Priority_ID = h.Priority_ID
			 left join #Request.WebSite#.dbo.AccessLUC_Stage as i on a.Stage_ID = i.Stage_ID
			 left join #Request.WebSite#.dbo.AccessLUC_Milestone_In_Place as j on a.Milestone_In_Place_ID = j.Milestone_In_Place_ID
			 left join #Request.WebSite#.dbo.AccessLUC_Term_Letter_Sent as k on a.Term_Letter_Sent_ID = k.Term_Letter_Sent_ID
			 left join #Request.WebSite#.dbo.AccessLUC_Arcadis_Chevron_Form as l on a.Arcadis_Chevron_Form_ID = l.Arcadis_Chevron_Form_ID
	WHERE a.Site_ID is not null
				<cfif isDefined("URL.ALID")> and a.ID = #URL.ALID#</cfif>
				<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> and b.Portfolio_ID = #form.SitePortfolioToFind#</cfif>
				<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND b.Site_ID like ('%#form.SiteIDtofind#%')</cfif>
				<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND b.Site_Name like ('%#form.SiteNameToFind#%')</cfif>
				<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND b.Address like ('%#form.AddressToFind#%')</cfif>
				<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND b.City like ('%#form.CityToFind#%')</cfif>
				<cfif isDefined("form.StateToFind") and form.StateToFind NEQ 0> AND c.State_ID = (#form.StateToFind#)</cfif>
				<cfif isDefined("form.smtofind") and form.smtofind NEQ 0> and b.SM_ID = #form.smtofind#</cfif>
				<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0> and b.Portfolio_Deputy_ID = #form.DeputyToFind#</cfif>
				<cfif isDefined("form.SPLToFind") and form.SPLToFind NEQ 0>and a.SPL_ID = #form.SPLToFind#</cfif>
				<cfif isDefined("form.PriorityToFind") and len(form.PriorityToFind)>and a.Priority_ID = #form.PriorityToFind#</cfif>
				<cfif isDefined("form.CompletedToFind")>and a.Complete = 1</cfif>
				<cfif len(RegionsToFind)> and b.COP_Region_ID in (#RegionsToFind#)</cfif>
				<cfif isDefined("listSiteID") and len(listSiteID)>and a.site_id in (#listSiteID#)</cfif>
	ORDER BY b.Site_ID, a.ID
</cfquery>
