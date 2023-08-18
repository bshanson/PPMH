<!-------------------------------------------
Description:
	query to get the info from Site_Status from Site_Status_Temp table
-------------------------------------------->

<!--- get reg agency --->
<CFQUERY NAME="getRegAgency" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Reg_Agency_ID, Reg_Agency
	FROM PPMH.dbo.Site_Reg_Agency
	ORDER BY Reg_Agency
</CFQUERY>
<cfloop query="getRegAgency">
	<!--- update Site_Status --->
	<CFQUERY NAME="update" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		update PPMH.dbo.Site_Status
		set Reg_Agency_ID = #getRegAgency.Reg_Agency_ID#
		where Regulatory_Agency = '#getRegAgency.Reg_Agency#' 
	</CFQUERY>
</cfloop>
done