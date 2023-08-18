<!----------------------------------------------------------------------------------------------------------
Description:
	mark reg action as complete

History:
	2/7/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- mark reg action as complete --->
<cfquery name="updComplete" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	UPDATE PPMH.dbo.Regulatory
	SET Complete = 1
			,Complete_Date = getDate()
	WHERE ID = '#form.RegulatoryID#'
</cfquery>
