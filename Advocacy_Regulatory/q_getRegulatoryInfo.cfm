<!----------------------------------------------------------------------------------------------------------
Description:
	get a regulatory record

History:
	2/7/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the record --->
<cfquery name="getRegulatoryInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.ID as Regulatory_ID, a.Regulatory_Action, a.Regulatory_Date, a.Complete, a.Complete_Date, 
				 b.ID as Admin_Site_ID, b.Site_ID, b.Site_Name, b.Address, b.City, 
				 c.State_ID, c.State_Abbreviation
	FROM PPMH.dbo.Regulatory as a
			 inner join TurboScope.dbo.Admin_Site as b on a.site_ID = b.ID
			 inner join TurboScope.dbo.Admin_State as c on b.State_id = c.State_id
	WHERE a.ID = #form.RegulatoryID#
</cfquery>
