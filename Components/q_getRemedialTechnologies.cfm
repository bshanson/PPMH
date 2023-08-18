<!----------------------------------------------------------------------------------------------------------
Description:
	get all Remedial Technologies

History:
	11/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<CFQUERY NAME="getRemedialTechnologies" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select Remedial_Technology_ID, Remedial_Technology
	from PPMH.dbo.Remedial_Technology
	where Active = 1
	ORDER BY Remedial_Technology
</CFQUERY>
