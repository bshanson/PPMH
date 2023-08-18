<!----------------------------------------------------------------------------------------------------------
Description:
	cfc to the various Site Users Attributes

History:
	07/01/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfcomponent>
	<!--- project controllers --->
	<cffunction name="ProjectControllers"
			  			hint="get the project controllers" 
			  			returntype="String">
		<CFQUERY NAME="getProjectControllers" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			select User_ID
			from PPMH.dbo.Site_Users_Attributes
			where Project_Controller = 1
		</CFQUERY>
		<cfset ControllerList = valuelist(getProjectControllers.User_ID)>
		<cfreturn ControllerList>
	</cffunction>

	<!--- Milestone Managers --->
	<cffunction name="MilestoneManagers"
			  			hint="get the milestone managers" 
			  			returntype="String">
		<CFQUERY NAME="getMilestoneManagers" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			select User_ID
			from PPMH.dbo.Site_Users_Attributes
			where Milestone_Manager = 1
		</CFQUERY>
		<cfset MilestoneManagerList = valuelist(getMilestoneManagers.User_ID)>
		<cfreturn MilestoneManagerList>
	</cffunction>
</cfcomponent>
