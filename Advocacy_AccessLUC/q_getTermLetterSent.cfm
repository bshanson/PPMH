<!--------------------------------------------------------------
Description:
	get the Term Letter Sent

History:
	1/10/2022 - created
--------------------------------------------------------------->

<!--- get the Term Letter Sent --->
<CFQUERY NAME="getTermLetterSent" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Term_Letter_Sent_ID, Term_Letter_Sent
	FROM #Request.WebSite#.dbo.AccessLUC_Term_Letter_Sent
	where active = 1
	ORDER BY Term_Letter_Sent_ID
</CFQUERY>
