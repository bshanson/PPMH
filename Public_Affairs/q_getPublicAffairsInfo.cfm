<!----------------------------------------------------------------------------------------------------------
Description:
	get a public affairs record

History:
	5/24/2021 - created
----------------------------------------------------------------------------------------------------------->

<!--- get the record --->
<cfquery name="getPublicAffairsInfo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.Public_Affairs_ID, a.Site_ID as Public_Affairs_Site_ID, a.Q1, a.Q1_Describe, a.Q2, a.Q2_Describe, a.Q3, a.Q3_Describe, a.Q4, a.Q4_Describe, 
				 a.Q5, a.Q5_Describe, a.Q6, a.Q6_Describe, a.Q7, a.Q7_Describe, a.Q8, a.Q8_Describe, a.Assessment_Date,
				 a.Comments_Date, a.Comments,
				 b.ID as Admin_Site_ID, b.Site_ID, b.Site_Name, b.Address, b.City, 
				 c.State_ID, c.State_Abbreviation
	FROM PPMH.dbo.Public_Affairs as a
			 inner join TurboScope.dbo.Admin_Site as b on a.site_ID = b.ID
			 inner join TurboScope.dbo.Admin_State as c on b.State_id = c.State_id
	WHERE a.Public_Affairs_ID = #form.PublicAffairsID#
</cfquery>
