<!--------------------------------------------------------------------------
Description:
	This template will create the menu bar
	If URL.ChildID is defined, a javaScript menu will open when the menu item is moused over

Parameters:
	TabID - currently selected tab id (optional)

History:
	1/11/2019 - created
--------------------------------------------------------------------------->

<cfset menuWidth = "100%">
<cfif isDefined("attributes.menuWidth")><cfset menuWidth = attributes.menuWidth></cfif>

<!--- get all pages --->
<CFQUERY NAME="getAllPages" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.ID, a.AccessLevel, a.ParentID, a.Label, a.Name, a.Category, a.SortOrder, a.Active, a.URL as URLStr, a.hidden
	FROM #Request.WebSiteID#.dbo.Portal as a
	WHERE a.Active = 1
				and a.AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
</CFQUERY>

<!--- get the parent pages --->
<CFQUERY NAME="getParentPages" DBTYPE="QUERY">
	SELECT ID, AccessLevel, ParentID, Label, Name, Category, SortOrder, Active, URLStr, hidden
	FROM getAllPages
	WHERE ParentID = 0 
				and AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
	ORDER BY SortOrder
</CFQUERY>

<!--- determine what current page --->
<CFIF IsDefined("Attributes.SelectedTabID") AND IsNumeric(Attributes.SelectedTabID)>
	<CFSET currentPage = Attributes.SelectedTabID>
<CFELSEIF IsDefined("URL.Child") AND IsNumeric(URL.Child)>
	<CFSET currentPage = URL.Child>
<CFELSEIF IsDefined("URL.TabID") AND IsNumeric(URL.TabID)>
	<CFSET currentPage = URL.TabID>
<CFELSE>
	<CFSET currentPage = getParentPages.ID>
</CFIF>

<!--- query to get the info for this page --->
<CFQUERY NAME="CurrentPageInfo" DBTYPE="QUERY">
	SELECT ID, AccessLevel, ParentID, Label, Name, Category, SortOrder, Active, URLStr, hidden
	FROM getAllPages 
	WHERE ID = #currentPage#
				and AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
</CFQUERY>

<!--- if the current page is blank, use its first child as a page --->
<CFIF CurrentPageInfo.URLStr EQ "nowhere">
	<CFQUERY NAME="ChildPages" DBTYPE="QUERY">
		SELECT ID, AccessLevel, ParentID, Label, Name, Category, SortOrder, Active, URLStr, hidden
		FROM getAllPages
		WHERE ParentID = #currentPage#
					and AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
		ORDER BY SortOrder, Label
	</CFQUERY>
	
	<CFIF ChildPages.RecordCount NEQ 0>
		<CFSET currentPage = ChildPages.ID>
	</CFIF>
</CFIF>

<CFSET Request.SelectedTabID = currentPage>

<!--- now determine which tab should be highlighted --->
<CFIF CurrentPageInfo.ParentID NEQ 0 AND CurrentPageInfo.ParentID NEQ "">
	<CFQUERY NAME="ParentPageInfo" DBTYPE="QUERY">
		SELECT ID, AccessLevel, ParentID, Label, Name, Category, SortOrder, Active, URLStr, hidden
		FROM getAllPages
		WHERE ID = #CurrentPageInfo.ParentID#
					and AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
	</CFQUERY>
	
	<CFIF ParentPageInfo.ParentID EQ 0 OR CurrentPageInfo.ParentID EQ "">
		<CFSET currentTab = CurrentPageInfo.ParentID>
	<CFELSE>
		<CFSET currentTab = ParentPageInfo.ParentID>
	</CFIF>
<CFELSE>
	<CFSET currentTab = CurrentPageInfo.ID>
</CFIF>

<CFSET Caller.SelectedTabID="#currentTab#">

<!--- get the url for the current page --->
<CFSET Return = "#Request.Protocol#//#HTTP.Server_Name#" & "#HTTP.SCRIPT_NAME#">
<CFIF IsDefined("HTTP.Query_String") AND Len("#HTTP.Query_String#")><CFSET Return = return & "?#HTTP.Query_String#"></CFIF>

<!--- the following is a list of all the settings that can be dynamically changed with the menu --->
<SCRIPT LANGUAGE="JavaScript1.2" TYPE="text/javascript">
HM_PG_MenuWidth = 150;
HM_PG_FontFamily = "Verdana, Geneva, Arial, Helvetica, sans-serif";
HM_PG_FontSize = 8;									// dropdown menu font size
HM_PG_FontBold = true;							// dropdown menu font 
HM_PG_FontItalic = false;						// dropdown menu font 
HM_PG_FontColor = "white";					// dropdown menu font color
HM_PG_FontColorOver = "black";			// dropdown menu rollover font color
HM_PG_BGColor = "#0083A9";					// dropdown menu bg color
HM_PG_BGColorOver = "#b2d9e5";			// dropdown menu rollover bg color
HM_PG_ItemPadding = 3;

HM_PG_BorderWidth = 1;
HM_PG_BorderColor = "white";
HM_PG_BorderStyle = "solid";
HM_PG_SeparatorSize = 2;
HM_PG_SeparatorColor = "white";
HM_PG_ImageSrc = "Images/tri.gif";
HM_PG_ImageSize = 5;
HM_PG_ImageHorizSpace = 0;
HM_PG_ImageVertSpace = 0;

HM_PG_KeepHilite = false; 
HM_PG_ClickStart = false;
HM_PG_ClickKill = false;
HM_PG_ChildOverlap = 20;
HM_PG_ChildOffset = 10;
HM_PG_ChildPerCentOver = null;
HM_PG_TopSecondsVisible = .2;
HM_PG_StatusDisplayBuild = 0;
HM_PG_StatusDisplayLink = 1;
HM_PG_UponDisplay = null;
HM_PG_UponHide = null;

HM_PG_RightToLeft = false;
</SCRIPT>

<!--- Create the menu --->
<CFOUTPUT>
	<TABLE BORDER="0" WIDTH="#menuWidth#" CELLSPACING="0" CELLPADDING="0" align="center">
		<TR>
			<TD BGCOLOR="#Request.MenuBorderColor#">
				<CFModule template="Menu.cfm" SelectedTab="#currentTab#" AllPages="#getAllPages#" ParentPages="#getParentPages#" AttributeCollection="#Attributes#">
			</TD>
		</TR>
	</TABLE>
</CFOUTPUT>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="Scripts/HM_Loader.js" TYPE='text/javascript'></SCRIPT>
