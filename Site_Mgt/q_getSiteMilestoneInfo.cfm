<!----------------------------------------------------------------------------------------------------------
Description:
	get site's claimed milestones

History:
	12/15/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfquery name="getSiteMilestoneInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Milestone_ID, a.Milestone_Amount, a.Milestone_Plan_Date, a.Year,
				 a.Site_ID, a.Period, a.Milestone_Doc, a.On_Track,
				 a.Skip, a.FCO, a.Deliverable, a.Notes, a.Claim, a.Site_Milestone_ID,
				 a.Delay_Reason_ID,
				 b.id, b.Milestone, b.UploadDoc,
				 c.ERP_Stage,
				 e.Primary_Backup
	FROM PPMH.dbo.Site_Milestones AS a 
		INNER JOIN PPMH.dbo.Milestones AS b ON a.Milestone_ID = b.id and b.Active = 1
		LEFT JOIN PPMH.dbo.ERP_Stage AS c ON b.ERP_Stage_ID = c.ERP_Stage_ID and c.Active = 1
		LEFT join PPMH.dbo.Milestones_Backup as e on b.Primary_Backup_ID = e.Primary_Backup_ID
	WHERE a.ID = #form.SiteMilestoneID#
 </cfquery>
