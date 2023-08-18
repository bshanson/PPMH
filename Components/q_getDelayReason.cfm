<!--------------------------------------------------------------
Description:
	get the Delay Reasons

History:
	6/29/2021 - created
--------------------------------------------------------------->

<!--- get the DelayReasons --->
<CFQUERY NAME="getDelayReasons" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Delay_Reason_ID, Delay_Reason
	FROM PPMH.dbo.Delay_Reason
	Where Active = 1
	ORDER BY Delay_Reason_ID
</CFQUERY>
