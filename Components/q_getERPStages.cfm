<!----------------------------------------------------------------------------------------------------------
Description:
	get all ERP Stages

History:
	2/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<CFQUERY NAME="getERPStages" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select ERP_Stage_ID, ERP_Stage, Active, ERP_Class
	from PPMH.dbo.ERP_Stage 
	where Active = 1
	ORDER BY Sort_Order
</CFQUERY>
