<!----------------------------------------------------------------------------------------------------------
Description:
	add reg action

History:
	2/7/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<cfif not ArrayLen(errormsg)>
	<!--- add reg action --->
	<CFQUERY NAME="addRegulatory" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		insert into PPMH.dbo.Regulatory
			(Site_ID, Regulatory_Action, Regulatory_Date, Complete_Date, Complete)
		values
			('#form.AdminSiteID#'
			,'#form.RegulatoryAction#'
			,'#form.RegulatoryDate#'
			,<cfif len(form.CompleteDate)>'#form.CompleteDate#'<cfelse>NULL</cfif>
			,<cfif len(form.CompleteDate)>1<cfelse>0</cfif>
			)
	</CFQUERY>

	<!--- get the id of the new record --->
	<CFQUERY NAME="getmaxid" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select max(id) as maxid from PPMH.dbo.Regulatory
	</CFQUERY>
	<cfset form.RegulatoryID = getmaxid.maxid>
	<cfset form.edittype = "editRegulatory">
</cfif>
