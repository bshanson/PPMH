<!--------------------------------------------------------------------------
This template will create the drop down menus

Parameters:
	AllPages - query containing info about every active page
	ParentPages - query containing info about the items that form menu tabs

History:
	1/11/2019 - created
--------------------------------------------------------------------------->
 
<!---	Script that pops up the menu on mouseovers --->
<SCRIPT>
function popMenu(ID,i,Offset,e){
	if (document.getElementById && document.getElementById('HM_Menu'+i)) {
		eval("document.getElementById('HM_Menu"+i+"').tree.MenuLeft=getAbsoluteLeft(document.getElementById('td"+ID+"'))"+Offset+";");
		eval("document.getElementById('HM_Menu"+i+"').tree.MenuTop=getAbsoluteTop(document.getElementById('td"+ID+"'))+document.getElementById('td"+ID+"').offsetHeight+1;")
	} else if (!document.all && document.layers) { //if netscape 4+
		eval("HM_Menu"+i+".tree.MenuLeft=document.layers.layer"+ID+".pageX"+Offset+";")
		eval("HM_Menu"+i+".tree.MenuTop=document.layers.layer"+ID+".pageY+20;")
	}
	popUp('HM_Menu'+i,e);
}
</SCRIPT>

<!--- calculate the width of each menu tab needs --->
<CFSET SubMenuWidth = (((100 / Attributes.ParentPages.RecordCount)/100))*(Request.ApplicationWidth)>
<CFSET TDWidth = 100 / Attributes.ParentPages.RecordCount & "%">
<CFSET OffsetMenuBy = 0>
<CFSET currentMenu = 0>

<TABLE WIDTH="100%" CELLSPACING="1" CELLPADDING="5" border="0" align="center">
	<TR>
	<!--- create the tabs and javaScript menu for that tab --->
	<CFLOOP QUERY="Attributes.ParentPages">
		<CFSET MenuCreated=0>

		<!--- find out if this tab has any children pages --->
		<CFQUERY NAME="ChildPages" DBTYPE="QUERY">
			SELECT * 
			FROM Attributes.AllPages
			WHERE ParentID = #ID# 
						and AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
						and hidden = 0
			ORDER BY SortOrder, Label
		</CFQUERY>

		<!--- determine the url for the current tab --->
		<CFIF Attributes.ParentPages.URLStr EQ "nowhere">
			<CFSET LINK="">
			<CFSET Target="_self">
			<CFSET NewLink="">
		<CFELSEIF Len(Attributes.ParentPages.URLStr) AND Left(Attributes.ParentPages.URLStr,11) NEQ "javascript:">
			<CFSET LINK="javascript:var w=window.open('#JSStringFormat(Attributes.ParentPages.URLStr)#');">
			<CFSET Target="_self">
		<CFELSEIF Len(Attributes.ParentPages.URLStr)>
			<CFSET LINK="#Attributes.ParentPages.URLStr#">
			<CFSET Target="_blank">
		<CFELSE>
			<CFSET LINK="#Request.BaseURL#?TabID=#Attributes.ParentPages.ID#">
			<CFSET Target="_self">
		</CFIF>

		<CFIF LINK IS "">
			<CFSET LINK="#NewLink#">
		</CFIF>
		
		<!--- If page has child pages, then create a menu for the children --->
		<CFSET MenuScript="">
		<CFIF ChildPages.RecordCount>
			<CFSET currentMenu = currentMenu + 1>
			<CFSET TabID=Attributes.ParentPages.ID>
			<CFSET MenuScript = MenuScript & "HM_Array#currentMenu#=[[#SubMenuWidth#]">
			<!--- get submenus --->
			<CFSET ChildPages_PermissionList = "">
			<CFLOOP QUERY="ChildPages">
				<CFSET ChildPages_PermissionList = ListAppend(ChildPages_PermissionList, ChildPages.ID)>

				<CFQUERY NAME="SubMenuItems_#CurrentRow#" DBTYPE="QUERY">
					SELECT * 
					FROM Attributes.AllPages
					WHERE ID = #ChildPages.ID# 
								and AccessLevel in (#evaluate("Session.Security.AccessLevel_#Request.WebSiteID#")#)
					ORDER BY SortOrder, Label
				</CFQUERY>
				
		 		<CFIF ChildPages.URLStr EQ "nowhere">
					<CFSET SubLink="">
				<CFELSEIF Len(ChildPages.URLStr) AND Left(ChildPages.URLStr,11) NEQ "javascript:">
					<CFSET SubLink="javascript:var w=window.open('#JSStringFormat(ChildPages.URLStr)#');">
				<CFELSEIF Len(ChildPages.URLStr)>
					<CFSET SubLink="#ChildPages.URLStr#">
				<CFELSE>
					<CFSET SubLink="#Request.BaseURL#?TabID=#TabID#&Child=#ChildPages.ID#">
				</CFIF>
				
				<CFIF Link EQ "" AND SubLink NEQ "">
					<CFSET Link=SubLink>
				</CFIF>

				<CFSET MenuScript = MenuScript & ",[""#ChildPages.Label#"", ""#SubLink#"", 1,0,#IIf(Evaluate("SubMenuItems_#CurrentRow#.RecordCount") EQ 0,DE(0),DE(1))#]">
			</CFLOOP>

			<CFSET MenuScript = MenuScript & "]">
		</CFIF>
		
		<CFIF Len(MenuScript)>
			<SCRIPT>
				<CFOUTPUT>#MenuScript#</CFOUTPUT>
			</SCRIPT>
		</CFIF>
		
		<CFOUTPUT>
		<cfset tdClass = "menuText">
		<cfif isDefined("URL.TabID")>
			<cfif (not len(URL.TabID) and Attributes.ParentPages.CurrentRow EQ 1) or (len(URL.TabID) and Attributes.ParentPages.ID EQ URL.TabID)><cfset tdClass = "menuTextSelected"></cfif>
		</cfif>
		<TD NOWRAP ALIGN="center" ID="td#Attributes.ParentPages.ID#" bgcolor="#Request.MenuColor#" width="#tdwidth#" class="#tdClass#">
			<CFIF Attributes.ParentPages.CurrentRow EQ 1>
				<CFSET OffsetX="+00">
			<CFELSEIF Attributes.ParentPages.CurrentRow EQ Attributes.ParentPages.RecordCount>
				<CFSET OffsetX="#NumberFormat(2*OffsetMenuBy, "+00")#">
			<CFELSE>
				<CFSET OffsetX="#NumberFormat(OffsetMenuBy, "+00")#">
			</CFIF>
			<A HREF="#LINK#" TARGET="#Target#"
				 onMouseOver="<CFIF Len(MenuScript)>popMenu('#Attributes.ParentPages.ID#','#currentMenu#','#OffsetX#',event)</CFIF>"
				 onMouseOut= "<CFIF Len(MenuScript)>popDown('HM_Menu#currentMenu#')</CFIF>">
			#Attributes.ParentPages.Label#</A>
		</TD>
		</CFOUTPUT>
	</CFLOOP>

	</TR>
</TABLE>
