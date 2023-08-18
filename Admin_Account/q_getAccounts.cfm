<!-------------------------------------------
Description:
	query to get the Accounts

History:
	1/11/2019 - created
-------------------------------------------->

<cfparam name="form.CompanyNameToFind" default="arcadis" type="string" >

<!--- get the users info --->
<cfif attributes.type EQ "WithAccess">
	<CFQUERY NAME="getAccounts" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		SELECT a.User_ID, a.First_Name, a.Last_Name, a.Company_ID, a.Email, a.Active, a.Password, a.SuperUser, 
					 b.Company_Name,
					 d.AccessLevel,
					 f.PM
		FROM WebSite_Admin.dbo.Web_Site_Users as a
				 INNER JOIN WebSite_Admin.dbo.Web_Site_Companies as b on a.Company_ID = b.Company_ID
				 INNER JOIN WebSite_Admin.dbo.Web_Site_User_Access as d on a.User_ID = d.User_ID
				 INNER JOIN WebSite_Admin.dbo.Web_Site as e on d.Web_Site_ID = e.Web_Site_ID and e.Web_Site = '#Request.WebSiteID#'
				 left join WebSite_Admin.dbo.Web_Site_User_Attribute as f on a.user_id = f.user_id
		WHERE a.active = 1
					and a.Last_Name like <cfqueryparam value="%#trim(form.LastNameToFind)#%" cfsqltype="CF_SQL_VARCHAR">
	 				and a.first_Name like <cfqueryparam value="%#trim(form.FirstNameToFind)#%" cfsqltype="CF_SQL_VARCHAR">
	 				and b.Company_Name like <cfqueryparam value="%#trim(form.CompanyNameToFind)#%" cfsqltype="CF_SQL_VARCHAR">
		ORDER BY a.Last_Name, a.First_Name
	</CFQUERY>
<cfelse>
	<CFQUERY NAME="getAccounts" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		SELECT a.User_ID, a.First_Name, a.Last_Name, a.Company_ID, a.Email, a.Active, a.Password,
					 b.Company_Name,
					 f.PM
		FROM WebSite_Admin.dbo.Web_Site_Users as a
				 INNER JOIN WebSite_Admin.dbo.Web_Site_Companies as b on a.Company_ID = b.Company_ID
				 left join WebSite_Admin.dbo.Web_Site_User_Attribute as f on a.user_id = f.user_id
		WHERE a.active = 1
					and a.Last_Name like <cfqueryparam value="%#form.LastNameToFind#%" cfsqltype="CF_SQL_VARCHAR">
	 				and a.first_Name like <cfqueryparam value="%#form.FirstNameToFind#%" cfsqltype="CF_SQL_VARCHAR">
	 				and b.Company_Name like <cfqueryparam value="%#form.CompanyNameToFind#%" cfsqltype="CF_SQL_VARCHAR">
					and a.user_ID not in (SELECT User_ID FROM WebSite_Admin.dbo.Web_Site_User_Access WHERE (Web_Site_ID = (select Web_Site_ID from WebSite_Admin.dbo.Web_Site where Web_Site = '#Request.Site#')))
		ORDER BY a.Last_Name, a.First_Name
	</CFQUERY>
</cfif>

<CFSET "Caller.#Attributes.Return#" = "#getAccounts#">
