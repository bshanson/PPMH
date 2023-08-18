<!-------------------------------------------------------------------------------------------------------
Description:
	This template will allow a superuser to login as a different user

History:
	2/06/2020 - created
--------------------------------------------------------------------------------------------------------->

<HTML>
<HEAD>
	<META http-equiv="content-type" content="text/html; charset=UTF-8">
	<TITLE>Impersonate</TITLE>
</HEAD>

<CFIF NOT IsDefined("Form.searchField") and NOT IsDefined("Form.ChangeUser") AND NOT IsDefined("URL.ChangeBack")>
	<BODY onLoad="document.searchForm.searchField.focus()">
			<TABLE border="0" cellspacing="0" cellpadding="2" width="100%" class="mediumText">
				<TR>
					<TD align="left" WIDTH="25%" class="mediumText">Enter all or part of the name to be searched</TD>
				</TR>
				<TR>
					<TD ALIGN="left" class="mediumText">
						<FORM NAME="searchForm" ACTION="" METHOD="Post">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
							<INPUT TYPE="Text" NAME="searchField" SIZE="50" class="mediumText" <CFIF IsDefined("Form.searchField")>VALUE="#Form.searchField#"</CFIF>>
							<br>
							<INPUT TYPE="Submit" VALUE="Search" class="largeText">
							<INPUT TYPE="button" VALUE="Cancel" class="largeText" ONCLICK="window.close()">
						</FORM>
					</TD>
				</TR>
			</TABLE>
	</BODY>
<cfelse>
	<body>
		<CFIF IsDefined("Form.searchField")>
			<cfquery NAME="getAllUsers" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
				select a.User_ID, a.Email, a.First_Name, a.Last_Name, a.Company_ID, a.Active, a.SuperUser, a.Password, a.NoEmail, 
							 b.Company_Name
				from WebSite_Admin.dbo.Web_Site_Users as a
						 inner join WebSite_Admin.dbo.Web_Site_Companies as b on a.company_id=b.company_id
				where a.last_name like <cfqueryparam value="%#Form.searchField#%" cfsqltype="CF_SQL_VARCHAR">
							and a.user_id in (select user_id from WebSite_Admin.dbo.Web_Site_User_Access where Web_Site_ID = (SELECT Web_Site_ID FROM WebSite_Admin.dbo.Web_Site where web_site= '#Request.WebSiteID#'))
							and a.active = 1
				order by a.last_name
			</cfquery>

			<CFOUTPUT>
			<TABLE border="0" cellspacing="0" cellpadding="2" width="100%" class="mediumText">
				<TR>
					<TD align="left" WIDTH="25%" class="mediumText">Select the user that you would like to switch to</TD>
				</TR>
				<TR>
					<TD ALIGN="left" class="mediumText"">
						<FORM ACTION="" METHOD="post" NAME="SuperUserSwitch" ID="SuperUserSwitch">
<!--- scrub url input for XSS --->
<cfinclude template="/Common/XSS_Scubber.cfm" >
							<SELECT NAME="ChangeUser" class="mediumText" SIZE="#Min(20, getAllUsers.RecordCount)#">
								<CFLOOP QUERY="getAllUsers">
									<OPTION VALUE="#email#" class="mediumText" <CFIF email EQ Session.Security.Email>SELECTED</CFIF>>#last_name#, #first_name#, #company_name#</OPTION>
								</CFLOOP>
							</SELECT>
							<BR>
							<INPUT TYPE="button" VALUE="Go" class="largeText" ONCLICK="window.opener.name='MainWindow'; this.form.target='MainWindow'; this.form.submit(); window.close()">
							<INPUT TYPE="button" VALUE="Cancel" class="largeText" ONCLICK="window.close()">
						</FORM>	
					</TD>
				</TR>
			</TABLE>
			</CFOUTPUT>
		
		<!--- if the superUser has selected to switch to another user, then set up the needed session variables --->
		<CFELSEIF NOT IsDefined("URL.ChangeBack")>
			<!--- Set session variables, so that superuser will be able to return to his old self --->
			<CFIF NOT IsDefined("Session.Security.OldUserID")>
				<CFSET Session.Security.OldUserID = Session.Security.UserID>
				<CFSET Session.Security.OldEmail = Session.Security.Email>
			</CFIF>
			
			<CFQUERY NAME="getUserInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
				SELECT a.User_ID, a.First_Name, a.Last_Name, a.Company_ID, a.Email, a.Active, a.Password, a.SuperUser,
							 b.Company_Name, b.Subcontractor,
							 c.AccessLevel,
							 e.Project_Types
				FROM WebSite_Admin.dbo.Web_Site_Users as a
						 INNER JOIN WebSite_Admin.dbo.Web_Site_Companies as b on a.Company_ID = b.Company_ID
						 INNER JOIN WebSite_Admin.dbo.Web_Site_User_Access as c on a.User_ID = c.User_ID
						 INNER JOIN WebSite_Admin.dbo.Web_Site as d on c.Web_Site_ID = d.Web_Site_ID and d.Web_Site = '#Request.WebSiteID#'
						 LEFT JOIN WebSite_Admin.dbo.Web_Site_User_Attribute as e on a.User_ID = e.User_ID
				where email like '%#Form.ChangeUser#%'
							and a.active = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
			</CFQUERY>

			<!--- delete the accesslevel cookies --->
			<cfquery name="getWebSites" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
			 select Web_Site
			 from WebSite_Admin.dbo.Web_Site
			</cfquery>
			<cfloop query="getWebSites" >
				<CFCOOKIE NAME="AccessLevel_#getWebSites.Web_Site#" EXPIRES="NOW">
			</cfloop>
			<CFINCLUDE TEMPLATE="components/SetCookies.cfm">
			<CFSET Session.Security.Superuser = Session.Security.OldEmail>
		
			<CFOUTPUT><META HTTP-EQUIV='REFRESH' CONTENT='0;URL=#Replace(URL.Return,'^^','&','all')#'></CFOUTPUT>
		</CFIF>
	</body>
</CFIF>
</HTML>
