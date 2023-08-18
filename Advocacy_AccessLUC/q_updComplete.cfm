<!----------------------------------------------------------------------------------------------------------
Description:
	mark AccessLUC action as complete

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- mark AccessLUC action as complete --->
<cfquery name="updComplete" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	UPDATE #Request.WebSite#.dbo.AccessLUC
	SET Complete = 1
			,Complete_Date = getDate()
	WHERE ID = '#form.chkAccessLUCID#'
</cfquery>
