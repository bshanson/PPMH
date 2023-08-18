<!----------------------------------------------------------------------------------------------------------
Description:
	get regulatory records

History:
	2/7/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfset RegionsToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionsToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionsToFind = listappend(RegionsToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<!--- check for valid dates --->
<cfset errormsg = "">
<cfif (isDefined("form.RegulatoryFromDatetofind") and len(form.RegulatoryFromDatetofind)) and not isDate(form.RegulatoryFromDatetofind)><cfset errormsg = "enter a valid From date"></cfif>
<cfif (isDefined("form.RegulatoryToDatetofind") and len(form.RegulatoryToDatetofind)) and not isDate(form.RegulatoryToDatetofind)>
	<cfif not len(errormsg)>
		<cfset errormsg = "enter a valid To date">
	<cfelse>
		<cfset errormsg = "enter a valid From and To date">
	</cfif>
</cfif>

<cfif not len(errormsg)>
	<!--- get the regulatory records --->
	<cfquery name="getRegulatory" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT a.ID as Regulatory_ID, a.Regulatory_Action, a.Regulatory_Date, a.Complete, a.Complete_Date, 
					 b.ID as Admin_Site_ID, b.Site_ID, b.Site_Name, b.Address, b.City, b.State_id, b.Zip_Code,
					 c.State_Abbreviation, 
					 d.Last_Name, d.First_Name, d.User_id
		FROM PPMH.dbo.Regulatory as a
				 inner join TurboScope.dbo.Admin_Site as b on a.site_ID = b.ID
				 inner join TurboScope.dbo.Admin_State as c on b.State_id = c.State_id
				 left join WebSite_Admin.dbo.Web_Site_Users as d on b.SM_ID = d.User_id 
		WHERE a.ID is not NULL
<cfif isDefined("URL.RID")> and a.ID = #URL.RID#</cfif>
					<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> AND b.Portfolio_ID = #form.SitePortfolioToFind#</cfif>
					<cfif len(RegionsToFind)> and b.COP_Region_ID in (#RegionsToFind#)</cfif>
					<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND b.Site_ID like ('%#form.SiteIDtofind#%')</cfif>
					<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND b.Site_Name like ('%#form.SiteNameToFind#%')</cfif>
					<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND b.Address like ('%#form.AddressToFind#%')</cfif>
					<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND b.City like ('%#form.CityToFind#%')</cfif>
					<cfif isDefined("form.StateToFind") and form.StateToFind NEQ 0> AND c.State_ID = (#form.StateToFind#)</cfif>
					<cfif isDefined("form.RegulatoryFromDatetofind") and len(form.RegulatoryFromDatetofind)> AND a.Regulatory_Date >= ('#form.RegulatoryFromDatetofind#')</cfif>
					<cfif isDefined("form.RegulatoryToDatetofind") and len(form.RegulatoryToDatetofind)> AND a.Regulatory_Date <= ('#form.RegulatoryToDatetofind#')</cfif>
					<cfif isDefined("form.smtofind") and form.smtofind NEQ 0>and b.SM_ID = <cfqueryparam value="#form.smtofind#" cfsqltype="cf_sql_integer" ></cfif>
					<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0>and b.Portfolio_Deputy_ID = <cfqueryparam value="#form.DeputyToFind#" cfsqltype="cf_sql_integer" ></cfif>
		ORDER BY a.Regulatory_Date desc
	</cfquery>
</cfif>
