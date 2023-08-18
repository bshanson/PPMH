<!----------------------------------------------------------------------------------------------------------
Description:
	search for the status info for the prior month

History:
	2/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<CFQUERY NAME="getPriorSiteStatusInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.Status_ID, a.Site_ID, a.Period, a.Status_Year, a.Status_Month, a.HS_Loss, a.HS_Near_Loss, 
				 a.Current_Quarter_Action_Items_v, a.Milestone_Assumptions, a.Projected_Change_In_Scope_Issues, a.ERP_Stage_ID, a.ERP_Notes,
				 a.Remedial_Technology_ID, a.Update_Date, a.Critical_Path, a.Overall_Project_Status, a.Forecast_Quarter, a.Forecast_Year, 
				 a.Portfolio_ID, 
				 a.Regulatory_Agency, a.Reg_Agency_ID,
				 a.Agency_Person, a.Important_Site_Info, a.Important_GWM_Info, a.Important_Links,
 				 c.Reg_Agency
	from PPMH.dbo.Site_Status as a
			LEFT JOIN #Request.WebSite#.dbo.Site_Reg_Agency as c on a.Reg_Agency_ID = c.Reg_Agency_ID
	where a.Site_id = #form.AdminSiteID#
				<cfif isDefined("form.StatusPortfolioToFind") and form.StatusPortfolioToFind NEQ 0> and a.portfolio_id = #form.StatusPortfolioToFind#
				<cfelse> and a.portfolio_id = #getSiteInfo.Portfolio_ID#
				</cfif>
	ORDER BY Status_Year DESC, Status_Month DESC
</CFQUERY>
