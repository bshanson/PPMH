<!--------------------------------------------------------------------------
This template will load a group of pages

Parameters:
	List - List of page ids to show

History:
	1/11/2019 - created
--------------------------------------------------------------------------->

<CFPARAM NAME="Attributes.List"			DEFAULT="">
<CFPARAM NAME="Attributes.PageSide"	DEFAULT="2">

<!--- get all active portlettes for this web site --->
<CFQUERY NAME="getAllPages" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		SELECT a.ID, a.Portal_ID, a.Page_ID, a.Column_Type, a.Sort_Order, b.ID AS Expr1, 
					 b.Label, b.Name, b.Category, b.Sub_Category, b.Width, b.File_Name, b.Active
		FROM #Request.WebSiteID#.dbo.Portal_Pages AS a 
				 INNER JOIN #Request.WebSiteID#.dbo.Pages AS b ON a.Page_ID = b.ID
		WHERE (a.Portal_ID IN
					(SELECT ID
					FROM #Request.WebSiteID#.dbo.Portal
					WHERE (ID IN (#Attributes.List#))))
					AND a.Column_Type = #Attributes.PageSide#
</CFQUERY>

<!--- Loop through all of the selections in this column --->
<CFLOOP LIST="#Attributes.List#" INDEX="id" DELIMITERS=", ">
	<!--- Get the Portlette for the specified ID value --->
	<CFQUERY NAME="PortletteInfo" DBTYPE="QUERY">
		SELECT * 
		FROM getAllPages
		WHERE Portal_ID = #ID#
	</CFQUERY>
	
	<!--- Grab our content from the database --->
	<CFOUTPUT QUERY="PortletteInfo">
		<CFSILENT>
		<CFSET Template="#PortletteInfo.File_Name#">
		
		<CFSET AttributesToPass = StructNew()>
		<CFSET AttributesToPass.Name = PortletteInfo.Label>
		<CFSET AttributesToPass.UniqueName = PortletteInfo.Name>
		<CFSET AttributesToPass.PortletteID = PortletteInfo.ID>
		<CFSET AttributesToPass.PageSide = Attributes.PageSide>
		<CFSET AttributesToPass.TemplateName = Template>

		</CFSILENT>

 		<!--- Load the template, passing it all of its attributes --->
		<TR>
			<TD bgcolor="#Request.TableBorderColor#">
				<CFSET Path = "#GetDirectoryFromPath(GetBaseTemplatePath())##Template#">
				<CFIF FileExists(Path)>
					<CFMODULE TEMPLATE="../#Template#" attributeCollection="#AttributesToPass#">
				<CFELSE>
					<CFTRY>
						<CFMODULE TEMPLATE="../#Template#" attributeCollection="#AttributesToPass#">
						<CFCATCH>
							<DIV ALIGN="left">
								<CFIF #CFCATCH.Type# IS "MISSINGINCLUDE">
									<B>#Template# not found.</B>
									<cfdump var="#cfcatch#">
								<CFELSE>
									<CFRETHROW>
								</CFIF>
							</DIV>
						</CFCATCH>
					</CFTRY>
				</CFIF>
 			</TD>
		</TR>
		
		<CFSET temp = StructClear(AttributesToPass)>
	</CFOUTPUT>
</CFLOOP>