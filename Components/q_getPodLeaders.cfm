<!--------------------------------------------------------------
Description:
	get the Pod Leader info

History:
	3/16/2021 - created
--------------------------------------------------------------->

<!--- get the Pod Leaders --->
<CFQUERY NAME="getPodLeaders" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.id, a.Pod_Number, a.User_ID,
		b.First_Name + ' ' + b.Last_name as Pod_Leader
	FROM TurboScope.dbo.Admin_Pod_Leader as a
		inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID
		<cfif len(attributes.cid)>where a.company_id = <cfqueryparam value="#attributes.cid#" cfsqltype="CF_SQL_integer"></cfif>
	ORDER BY a.Pod_Number, Pod_Leader
</CFQUERY>

<CFSET "Caller.#Attributes.Return#" = "#getPodLeaders#">
