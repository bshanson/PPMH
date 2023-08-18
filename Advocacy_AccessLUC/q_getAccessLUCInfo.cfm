<!----------------------------------------------------------------------------------------------------------
Description:
	get a AccessLUC record

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the record --->
<cfquery name="getAccessLUCInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.ID as AccessLUC_ID, a.Onsite, a.Agreement_Type_ID, a.Arcadis_Chevron_Form_ID, a.SPL_ID, a.Priority_ID, 
				 a.Outside_Counsel_Involved, a.Milestone_In_Place_ID, a.Milestone_ID, a.Stage_ID, a.Expiration_Date, 
				 a.Term_Letter_Sent_ID, a.SPL_Notes, a.Final_Document, a.Field_Work_Notification, a.Complete, a.Complete_Date, a.Until_Completion,
				 a.Access_Property, 
         b.ID as Admin_Site_ID, b.Site_ID, b.Site_Name, b.Address, b.City, b.Portfolio_ID, 
				 c.State_ID, c.State_Abbreviation,
				 d.Portfolio
	FROM #Request.WebSite#.dbo.AccessLUC as a
			 inner join TurboScope.dbo.Admin_Site as b on a.site_ID = b.ID
			 inner join TurboScope.dbo.Admin_State as c on b.State_id = c.State_id
			 inner join TurboScope.dbo.Admin_Portfolio as d on b.Portfolio_id = d.Portfolio_id
	WHERE a.ID = #form.AccessLUCID#
</cfquery>
