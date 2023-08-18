<!-------------------------------------------
Description:
	query to get the review sites

History:
	3/26/2020 - created
-------------------------------------------->

<cfset RegionsToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionsToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionsToFind = listappend(RegionsToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<CFQUERY NAME="getReviewSites" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.ID, a.Site_ID, a.Site_Name, a.Address, a.City, a.Zip_Code, a.COP_ID, a.COP_Region_ID, a.Colloquial_Name, a.Inside_OERB,
		a.Reimbursement_Eligible, a.EIM_ID,
		b.State_Abbreviation,
		c.Country,
		d.Program,
		e.Portfolio,
		f.last_name + ', ' + f.first_name as Deputy_Name,
		g.last_name + ', ' + g.first_name as Ops_Lead,
		h.Facility_Type,
		i.Portfolio,
		j.Region,
		k.Locus_ID,
		l.SG_Code
	FROM TurboScope.dbo.Admin_Site as a
		left join TurboScope.dbo.Admin_State as b on a.state_ID = b.State_ID
		left join WebSite_Admin.dbo.Country as c on a.Country_ID = c.Country_ID
		left join TurboScope.dbo.Admin_Program as d on a.Program_ID = d.Program_ID
		left join TurboScope.dbo.Admin_Portfolio as e on a.Portfolio_ID = e.Portfolio_ID
		left join WebSite_Admin.dbo.Web_Site_Users as f on a.Portfolio_Deputy_ID = f.User_ID
		left join WebSite_Admin.dbo.Web_Site_Users as g on a.Chevron_PM_ID = g.User_ID
		left join TurboScope.dbo.Admin_Facility_Type as h on a.Facility_Type_ID = h.Facility_Type_ID
		left join TurboScope.dbo.Admin_Portfolio as i on a.Portfolio_ID = i.Portfolio_ID
		left join TurboScope.dbo.Admin_COP_Region as j on a.COP_Region_ID = j.COP_Region_ID
		left join TurboScope.dbo.Admin_Site_Locus as k on a.ID = k.Site_ID 
		left join TurboScope.dbo.Admin_Strategic_Groupings as l on a.SG_ID = l.SG_ID 
	WHERE a.Site_ID is not NULL
		and a.Status = 'A'
		<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> AND a.Portfolio_ID = #form.SitePortfolioToFind#</cfif>
		<cfif len(RegionsToFind)> and a.COP_Region_ID in (#RegionsToFind#)</cfif>
		<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND a.Site_ID like ('%#trim(form.SiteIDtofind)#%')</cfif>
		<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND a.Site_Name like ('%#trim(form.SiteNameToFind)#%')</cfif>
		<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND a.Address like ('%#trim(form.AddressToFind)#%')</cfif>
		<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND a.City like ('%#trim(form.CityToFind)#%')</cfif>
		<cfif isDefined("form.StateToFind") and form.StateToFind NEQ "0"> AND a.State_ID = (#form.StateToFind#)</cfif>
		<cfif isDefined("form.smtofind") and form.smtofind NEQ 0> AND a.SM_ID = ('#form.smtofind#')</cfif>
		<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0> AND a.Portfolio_Deputy_ID = ('#form.DeputyToFind#')</cfif>
		<cfif isDefined("form.ChevronOpsToFind") and form.ChevronOpsToFind NEQ 0> AND a.Chevron_PM_ID = ('#form.ChevronOpsToFind#')</cfif>
		<cfif Session.Security.CompanyID EQ 253>AND a.Portfolio_ID in (39, 40, 41, 42, 46, 51, 37, 20, 44, 21, 50, 43, 32, 29, 35)</cfif>
	ORDER BY b.State_Abbreviation, a.Site_ID
</CFQUERY>
