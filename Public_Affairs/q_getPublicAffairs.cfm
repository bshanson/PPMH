<!----------------------------------------------------------------------------------------------------------
Description:
	get Public Affairs records

History:
	5/24/2021 - created
----------------------------------------------------------------------------------------------------------->

<cfset RegionsToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionsToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionsToFind = listappend(RegionsToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<!--- get the Public Affairs records --->
<cfquery name="getPublicAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Public_Affairs_ID, a.Site_ID as Public_Affairs_Site_ID, a.Q1, a.Q1_Describe, a.Q2, a.Q2_Describe, a.Q3, a.Q3_Describe, a.Q4, a.Q4_Describe, 
				 a.Q5, a.Q5_Describe, a.Q6, a.Q6_Describe, a.Q7, a.Q7_Describe, a.Q8, a.Q8_Describe, a.Assessment_Date,
				 b.ID as Admin_Site_ID, b.Site_ID, b.Site_Name, b.Address, b.City, b.State_id, b.Zip_Code,
				 c.State_Abbreviation, 
				 d.Last_Name, d.First_Name, d.User_id
	FROM PPMH.dbo.Public_Affairs as a
			 inner join TurboScope.dbo.Admin_Site as b on a.site_ID = b.ID
			 inner join TurboScope.dbo.Admin_State as c on b.State_id = c.State_id
			 left join WebSite_Admin.dbo.Web_Site_Users as d on b.SM_ID = d.User_id 
	WHERE a.Public_Affairs_ID is not NULL
				<cfif isDefined("URL.PAID")> and a.Public_Affairs_ID = #URL.PAID#</cfif>
				<cfif isDefined("URL.SID")> and b.Site_ID = '#URL.SID#'</cfif>
				<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> AND b.Portfolio_ID = #form.SitePortfolioToFind#</cfif>
				<cfif len(RegionsToFind)> and b.COP_Region_ID in (#RegionsToFind#)</cfif>
				<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND b.Site_ID like ('%#form.SiteIDtofind#%')</cfif>
				<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND b.Site_Name like ('%#form.SiteNameToFind#%')</cfif>
				<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND b.Address like ('%#form.AddressToFind#%')</cfif>
				<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND b.City like ('%#form.CityToFind#%')</cfif>
				<cfif isDefined("form.StateToFind") and form.StateToFind NEQ 0> AND c.State_ID = (#form.StateToFind#)</cfif>
				<cfif isDefined("form.smtofind") and form.smtofind NEQ 0>and b.SM_ID = <cfqueryparam value="#form.smtofind#" cfsqltype="cf_sql_integer" ></cfif>
				<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0>and b.Portfolio_Deputy_ID = <cfqueryparam value="#form.DeputyToFind#" cfsqltype="cf_sql_integer" ></cfif>
	ORDER BY #form.SortBy#
</cfquery>
