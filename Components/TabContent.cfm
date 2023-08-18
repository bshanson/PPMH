<!--------------------------------------------------------------------------
Description:
	This template builds the web page

History:
	1/11/2019 - created
--------------------------------------------------------------------------->

<!--- get all ports for this web site --->
<CFQUERY NAME="getAllPages" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.ID, a.AccessLevel, a.ParentID, a.Label, a.Name, a.Category, a.SortOrder, a.Active, a.URL
	FROM #Request.WebSiteID#.dbo.Portal as a
	WHERE a.Active = 1
				and a.AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
</CFQUERY>

<CFIF IsDefined("URL.Child") AND IsNumeric(URL.Child)>
	<CFSET SelectedTabID = URL.Child>
<CFELSEIF IsDefined("URL.TabID") AND IsNumeric(URL.TabID)>
	<CFSET SelectedTabID = URL.TabID>
<CFELSEIF IsDefined("Attributes.SelectedTabID") AND IsNumeric(Attributes.SelectedTabID)>
	<CFSET SelectedTabID = Attributes.SelectedTabID>
<CFELSEIF IsDefined("Request.SelectedTabID") AND IsNumeric(Request.SelectedTabID)>
	<CFSET SelectedTabID = Request.SelectedTabID>
</CFIF>

<CFQUERY NAME="CurrentPageInfo" DBTYPE="QUERY">
	SELECT * 
	FROM getAllPages
	WHERE
		<CFIF IsDefined("SelectedTabID") AND IsNumeric(SelectedTabID)>
			ID = #SelectedTabID#
		<CFELSE>
			ParentID = 0
		</CFIF>
			and AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
	ORDER BY SortOrder
</CFQUERY>

<!--- if the current page does not exist redirect the user to the home page --->
<CFIF CurrentPageInfo.RecordCount EQ 0>
	<CFLOCATION URL="index.cfm">
</CFIF>

<CFIF CurrentPageInfo.ParentID EQ 0 OR CurrentPageInfo.ParentID EQ "">
	<CFSET ParentName = CurrentPageInfo.Label>
<CFELSE>
	<CFQUERY NAME="GetParentPage" DBTYPE="QUERY">
		SELECT * 
		FROM getAllPages
		WHERE ID = #CurrentPageInfo.ParentID# 
					AND Active = 1
					and AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
	</CFQUERY>
	<CFSET ParentName = GetParentPage.Label>
</CFIF>
 
<!--- Get any children navigation entries for the selected tab --->
<CFQUERY NAME="ChildPages" DBTYPE="QUERY">
	SELECT * 
	FROM getAllPages
	WHERE
		<CFIF CurrentPageInfo.ParentID EQ 0 OR NOT IsNumeric(CurrentPageInfo.ParentID)>
			ParentID = #CurrentPageInfo.ID#
		<CFELSE>
			ParentID = #CurrentPageInfo.ParentID#
		</CFIF>
			and AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
</CFQUERY>

<CFSET ShowLeftColumn = "no">

<TABLE width="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<TR VALIGN=TOP>
		<!--- left column --->
		<CFIF ShowLeftColumn>
			<TD WIDTH="20%" ALIGN="left">
				<TABLE WIDTH="100%" CELLSPACING="0" CELLPADDING="0">
					<CFIF ChildPages.RecordCount NEQ 0>
						<CFSET AttributesToPass = StructNew()>
						<CFSET AttributesToPass.QueryName = ChildPages>
						<CFSET AttributesToPass.Name = ParentName>
						<CFModule template="Training_Navlette.cfm" ATTRIBUTECOLLECTION="#AttributesToPass#">
					</CFIF>
	
					<CFIF Len(CurrentPageInfo.ID)>
						<CFSET AttributesToPass = StructNew()>
						<CFSET AttributesToPass.List = CurrentPageInfo.ID>
						<CFSET AttributesToPass.PageSide = "1">
						<CFModule template="LoadContent.cfm" ATTRIBUTECOLLECTION="#AttributesToPass#">
					</CFIF>
				</TABLE>
			</TD>
	
			<TD>&nbsp;</TD>
		</CFIF>

		<!--- center column --->
		<TD WIDTH="80%" ALIGN="right">
			<TABLE WIDTH="100%" CELLSPACING="0" CELLPADDING="0">
				<CFSET AttributesToPass = StructNew()>
				<CFSET AttributesToPass.List = CurrentPageInfo.ID>
				<CFSET AttributesToPass.PageSide = "2">
				<CFModule template="LoadContent.cfm" ATTRIBUTECOLLECTION="#AttributesToPass#">
 			</TABLE>
		</TD>
	</TR>
</TABLE>
