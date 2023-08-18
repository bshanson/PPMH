<!----------------------------------------------------------------------------------------------------------
Description:
	get status info

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getSiteStatus" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.Status_ID, a.Site_ID, a.Period, a.Status_Year, a.Status_Month, a.HS_Loss, a.HS_Near_Loss, 
				 a.Current_Quarter_Action_Items_v, a.Milestone_Assumptions, a.Projected_Change_In_Scope_Issues, 
				 a.ERP_Stage_ID, a.Remedial_Technology_ID, a.Update_Date, a.Critical_Path, a.Overall_Project_Status, 
				 a.Forecast_Quarter, a.Forecast_Year, a.Portfolio_ID,
				 b.Closure_Month, b.Closure_Year, b.COP_ID, b.COP_Region_ID,
				 c.ERP_Stage, c.ERP_Class,
				 d.Remedial_Technology,
				 e.Portfolio
	from PPMH.dbo.Site_Status as a
		inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.ID
		left join PPMH.dbo.ERP_Stage as c on a.ERP_Stage_ID = c.ERP_Stage_ID
		left join PPMH.dbo.Remedial_Technology as d on a.Remedial_Technology_ID = d.Remedial_Technology_ID
		inner join TurboScope.dbo.Admin_Portfolio as e on a.Portfolio_ID = e.Portfolio_ID
	where a.Site_id = #form.AdminSiteID#
				<cfif isDefined("form.StatusPortfolioToFind") and form.StatusPortfolioToFind NEQ 0> and a.portfolio_id = #form.StatusPortfolioToFind#
				<cfelse> and a.portfolio_id = b.portfolio_id
				</cfif>
	order by a.period desc
</cfquery>
