<!----------------------------------------------------------------------------------------------------------
Description:
	update regulatory action record

History:
	2/7/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<cfif not ArrayLen(errormsg)>
	<!--- update regulatory action --->
	<cfquery name="updRegulatory" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		UPDATE PPMH.dbo.Regulatory
		SET Regulatory_Action = '#form.RegulatoryAction#'
				,Regulatory_Date = '#form.RegulatoryDate#'
				,Complete_Date = <cfif len(form.CompleteDate)>'#form.CompleteDate#'<cfelse>NULL</cfif>
				,Complete = <cfif len(form.CompleteDate)>1<cfelse>0</cfif>
		WHERE ID = '#form.RegulatoryID#'
	</cfquery>
</cfif>
