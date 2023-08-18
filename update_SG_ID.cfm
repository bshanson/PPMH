<!--------------------------------------------------------------
Description:
	update SG ID
--------------------------------------------------------------->

<!--- get the Sites --->
<!---<CFQUERY NAME="getSGID" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT ID, Site_ID, Site_Name, SG_ID
	FROM TurboScope.dbo.Admin_Site_Temp_SG
</CFQUERY>

<cfloop query="getSGID" >
	<CFQUERY NAME="updSites" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		update TurboScope.dbo.Admin_Site
		set SG_ID = #getSGID.SG_ID#
		where id = #getSGID.ID#
	</CFQUERY>
</cfloop>

<CFQUERY NAME="getSites" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT ID, Site_ID, Site_Name, SG_ID
	FROM TurboScope.dbo.Admin_Site
	where SG_ID is not null
</CFQUERY>
<cfdump var="#getSites#">--->
