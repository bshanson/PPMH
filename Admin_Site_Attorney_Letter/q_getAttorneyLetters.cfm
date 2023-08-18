<!-------------------------------------------
Description:
	query to get Attorney Letters for a site

History:
	10/13/2022 - created
-------------------------------------------->

<cfset RegionToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionToFind = listappend(RegionToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<!--- get the Attorney Letters info --->
<CFQUERY NAME="getAttorneyLetters" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT b.id as AdminID, b.Site_ID as Admin_Site_ID, b.Site_Name, b.Address, b.City, b.Attorney_Engagement,
				 d.State_Abbreviation,
				 f.Portfolio,
				 g.Last_Name + ', ' + g.First_Name as SM_Name
	FROM TurboScope.dbo.Admin_Site as b
		inner join TurboScope.dbo.Admin_State as d on b.State_ID = d.state_id
		left join TurboScope.dbo.Admin_Portfolio as f on b.Portfolio_ID = f.Portfolio_ID
		left join WebSite_Admin.dbo.Web_Site_Users as g on b.SM_ID = g.User_id 
	WHERE b.Attorney_Engagement = 1
				<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0>and b.Portfolio_id = #form.SitePortfolioToFind#</cfif>
				<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND b.Site_ID like ('%#form.SiteIDtofind#%')</cfif>
				<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND b.Site_Name like ('%#form.SiteNameToFind#%')</cfif>
				<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND b.Address like ('%#form.AddressToFind#%')</cfif>
				<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND b.City like ('%#form.CityToFind#%')</cfif>
				<cfif isDefined("form.StateToFind") and form.StateToFind NEQ 0> AND b.State_ID = ('#form.StateToFind#')</cfif>
				<cfif len(RegionToFind)> and b.COP_Region_ID in (#RegionToFind#)</cfif>
	ORDER BY b.Site_ID
</CFQUERY>
