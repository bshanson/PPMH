<!----------------------------------------------------------------------------------------------------------
Description:
	search for a given monthly info for a site

History:
	2/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getStatusInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Status_ID, a.Site_ID, a.Period, a.Status_Year, a.Status_Month, a.Portfolio_ID, a.HS_Loss, a.HS_Near_Loss,
				 a.Current_Quarter_Action_Items_v, a.Milestone_Assumptions, a.Projected_Change_In_Scope_Issues, 
				 a.ERP_Stage_ID, a.ERP_Notes, a.Remedial_Technology_ID, a.Critical_Path, a.Overall_Project_Status, 
				 a.Forecast_Quarter, a.Forecast_Year, 
				 a.Regulatory_Agency, a.Reg_Agency_ID, 
				 a.Agency_Person, a.Important_Site_Info, 
				 a.Important_GWM_Info, a.Important_Links,
				 c.Month,
				 e.ERP_Stage,
				 f.Portfolio,
				 h.Reg_Agency
	FROM PPMH.dbo.Site_Status as a 
			 inner join WebSite_Admin.dbo.Month as c on a.Status_Month = c.Month_ID
			 LEFT OUTER JOIN PPMH.dbo.ERP_Stage as e on a.ERP_Stage_ID = e.ERP_Stage_ID
			 LEFT JOIN TurboScope.dbo.Admin_Portfolio as f on a.Portfolio_ID = f.Portfolio_ID
			 LEFT JOIN #Request.WebSite#.dbo.Site_Reg_Agency as h on a.Reg_Agency_ID = h.Reg_Agency_ID
	WHERE a.Status_ID = '#form.editStatusID#'
</cfquery>
