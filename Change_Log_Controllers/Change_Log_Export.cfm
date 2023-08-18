<!----------------------------------------------------------------------------------------------------------
Description:
	change tracking xml version

History:
	4/3/2020 - created
----------------------------------------------------------------------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>

<!--- store the XML data --->
<cfsavecontent variable="XMLData">
	<!--- XML declaration  --->
	<?xml version="1.0"?>
	<?mso-application progid="Excel.Sheet"?>
 
	<!--- the workbook root element stores characteristics and properties of the workbook --->
	<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
		xmlns:o="urn:schemas-microsoft-com:office:office"
		xmlns:x="urn:schemas-microsoft-com:office:excel"
		xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
		xmlns:html="http://www.w3.org/TR/REC-html40">
 
		<!--- DocumentProperties stores metadata related to the document --->
		<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
			<Author></Author>
		</DocumentProperties>
 
		<!--- workbook-level characteristics and properties of the document --->
		<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
			<WindowHeight>12000</WindowHeight>
			<WindowWidth>21000</WindowWidth>
			<WindowTopX>0</WindowTopX>
			<WindowTopY>0</WindowTopY>
			<ProtectStructure>False</ProtectStructure>
			<ProtectWindows>False</ProtectWindows>
		</ExcelWorkbook>
	
	<!--- styles of components of the workbook --->
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s74">
   <Alignment ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <Interior/>
   <NumberFormat ss:Format="0"/>
   <Protection/>
  </Style>
  <Style ss:ID="s75">
   <NumberFormat ss:Format="0"/>
  </Style>
  <Style ss:ID="s77">
   <Alignment ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <Interior/>
   <NumberFormat ss:Format="@"/>
   <Protection/>
  </Style>
  <Style ss:ID="s78">
   <NumberFormat ss:Format="@"/>
  </Style>
  <Style ss:ID="s79">
   <Alignment ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <Interior/>
   <NumberFormat ss:Format="Short Date"/>
   <Protection/>
  </Style>

  <Style ss:ID="s80" ss:Name="Hyperlink">
   <Font ss:FontName="Arial" ss:Size="9" ss:Color="#0563C1" ss:Underline="Single"/>
  </Style>
  <Style ss:ID="s81" ss:Parent="s80">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Interior/>
   <NumberFormat ss:Format="@"/>
   <Protection/>
  </Style>

  <Style ss:ID="s83">
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s84">
   <Alignment ss:Horizontal="Right" ss:Vertical="Top"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <NumberFormat ss:Format="&quot;$&quot;#,##0.00"/>
  </Style>
  <Style ss:ID="s86">
   <NumberFormat ss:Format="&quot;$&quot;#,##0.00"/>
  </Style>
  <Style ss:ID="s87">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" ss:Size="9" ss:Bold="1"/>
   <Interior ss:Color="#CCFFCC" ss:Pattern="Solid"/>
   <NumberFormat ss:Format="0"/>
  </Style>
  <Style ss:ID="s88">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" ss:Size="9" ss:Bold="1"/>
   <Interior ss:Color="#CCFFCC" ss:Pattern="Solid"/>
   <NumberFormat ss:Format="@"/>
  </Style>
  <Style ss:ID="s90">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" ss:Size="9" ss:Bold="1"/>
   <Interior ss:Color="#CCFFCC" ss:Pattern="Solid"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s91">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" ss:Size="9" ss:Bold="1"/>
   <Interior ss:Color="#CCFFCC" ss:Pattern="Solid"/>
   <NumberFormat ss:Format="&quot;$&quot;#,##0.00"/>
  </Style>
  <Style ss:ID="sRed">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#FFFFFF"/>
   <Interior ss:Color="#FF0000" ss:Pattern="Solid"/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="sYellow">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#000000"/>
   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="sGreen">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#FFFFFF"/>
   <Interior ss:Color="#00B050" ss:Pattern="Solid"/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="sOrange">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#000000"/>
   <Interior ss:Color="#FFA500" ss:Pattern="Solid"/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="sSilver">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#000000"/>
   <Interior ss:Color="#C0C0C0" ss:Pattern="Solid"/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="sBlack">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#FFFFFF"/>
   <Interior ss:Color="#000000" ss:Pattern="Solid"/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="sWhite">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#000000"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
 </Styles>
 
<cfoutput>
		<Worksheet ss:Name="Change Log">
			<!--- define columns --->
			<Table ss:ExpandedColumnCount="28" ss:ExpandedRowCount="#expRowCount#" x:FullColumns="1" x:FullRows="1">
			<Column ss:StyleID="s75" ss:Width="90"/> <!--- Change Log ID --->
			<Column ss:StyleID="s75" ss:Width="120"/> <!--- Change Log Portfolio --->
			<Column ss:StyleID="s78" ss:Width="100"/> <!--- site --->
			<Column ss:StyleID="s78" ss:Width="150"/> <!--- address --->
			<Column ss:StyleID="s78" ss:Width="110"/> <!--- city --->
			<Column ss:StyleID="s78" ss:Width="50"/> <!--- state --->
			<Column ss:StyleID="s78" ss:Width="70"/> <!--- zip code --->
			<Column ss:StyleID="s75" ss:Width="110"/> <!--- Site Portfolio --->
			<Column ss:StyleID="s83" ss:Width="95"/> <!--- date logged --->
			<Column ss:StyleID="s78" ss:Width="100"/> <!--- entity --->
			<Column ss:StyleID="s78" ss:Width="200"/> <!--- type of change --->
			<Column ss:StyleID="s78" ss:Width="200"/> <!--- reason for change --->
			<Column ss:StyleID="s78" ss:Width="200"/> <!--- reason detail --->
			<Column ss:StyleID="s78" ss:Width="300"/> <!--- additional info --->
			<Column ss:StyleID="s78" ss:Width="300"/> <!--- list any new milestones --->
			<Column ss:StyleID="s86" ss:Width="100"/> <!--- value --->
			<Column ss:StyleID="s78" ss:Width="140"/> <!--- assumptions --->
			<Column ss:StyleID="s83" ss:Width="130"/> <!--- end date --->
			<Column ss:StyleID="s78" ss:Width="200"/> <!--- Arcadis Portfolio Mgr --->
			<Column ss:StyleID="s78" ss:Width="205"/> <!--- Chevron Portfolio Mgr --->
			<Column ss:StyleID="s78" ss:Width="155"/> <!--- if change documented --->
			<Column ss:StyleID="s78" ss:Width="100"/> <!--- Site Manager --->
			<Column ss:StyleID="s78" ss:Width="200"/> <!--- Email Reference --->
			<Column ss:StyleID="s78" ss:Width="300"/> <!--- Oracle Update --->
			<Column ss:StyleID="s78" ss:Width="135"/> <!--- chev approval status --->
			<Column ss:StyleID="s78" ss:Width="125"/> <!--- Oracle Process Status --->
			<Column ss:StyleID="s78" ss:Width="130"/> <!--- Milestone Update Status --->
			<Column ss:StyleID="s78" ss:Width="100"/> <!--- fco document --->
	
			<!--- header --->
			<Row>
				<Cell ss:StyleID="s87"><Data ss:Type="String">Change Log ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Change Log Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Facility ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Address</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">City</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Zip Code</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Site Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s90"><Data ss:Type="String">Date Logged</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Entity</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Type of Change</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Reason for Change</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Reason Detail</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Additional Relevant Information</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">New Milestones With Fees</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s91"><Data ss:Type="String">Value of Change</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Site Specific Assumptions</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s90"><Data ss:Type="String">Period of Performance</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Date Approved by Arcadis Portfolio Mgr</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Date Approved by Chevron Portfolio Mgr</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">If change documented, which</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Site Manager</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Reference ID of Email</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Oracle Status Notes</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Chevron Approval Status</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Oracle Process Status</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Milestone Update Status</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">FCO Document</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			</Row>
		 
			<!--- data --->
			<cfloop query="getChangeLogs">
				<Row>
					<Cell ss:StyleID="s74"><Data ss:Type="String">#getChangeLogs.Actual_Change_Log_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Log_Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Zip_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s79"><Data ss:Type="DateTime">#dateformat(getChangeLogs.Date_Logged,"yyyy-mm-dd")#T00:00:00.000</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Initiating_Entity#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfinclude template="q_getChangeLogChangeType.cfm">
					<cfset vChangeTypes = ReplaceNoCase(vChangeTypes, "Other Please Describe", getChangeLogs.Change_Type_Other, "all" )>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#vChangeTypes#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfinclude template="q_getChangeLogChangeReason.cfm">
					<Cell ss:StyleID="s77"><Data ss:Type="String">#vChangeReasons#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfinclude template="q_getChangeLogReasonDetail.cfm">
					<cfset vReasonDetails = ReplaceNoCase(vReasonDetails, "Other Please Describe", getChangeLogs.Reason_Detail_Other, "all" )>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#vReasonDetails#</ss:Data></Cell>
					<cfmodule template="../components/f_ReplaceCharacters.cfm" FieldName="#getChangeLogs.Additional_Information#" varNewValue="vAdditionalInformation">
					<Cell ss:StyleID="s77"><Data ss:Type="String">#vAdditionalInformation#</ss:Data></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Milestone_List#</ss:Data></Cell>
					<Cell ss:StyleID="s84"><Data ss:Type="Number">#getChangeLogs.Change_Value#</ss:Data></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Assumptions#</ss:Data></Cell>

					<!--- PerformancePeriodEndDate --->
					<cfif getChangeLogs.Performance_Period_End_Date EQ "1/1/1900"><cfset PerformancePeriodEndDate = "NA"><cfset ssType = "String">
					<cfelse><cfset PerformancePeriodEndDate = dateformat(getChangeLogs.Performance_Period_End_Date,"yyyy-mm-dd") & "T00:00:00.000"><cfset ssType = "DateTime">
					</cfif>

					<Cell ss:StyleID="s79"><Data ss:Type="#ssType#">#PerformancePeriodEndDate#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.PortfolioManagerName#<cfif len(getChangeLogs.Portfolio_Manager_Approval_Date)>, #dateformat(getChangeLogs.Portfolio_Manager_Approval_Date,"mm/dd/yyyy")#</cfif>, <cfif len(getChangeLogs.Approval_Description)>#getChangeLogs.Approval_Description#</cfif></ss:Data></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.ChevronPMName#<cfif len(getChangeLogs.Chevron_PM_Approval_Date)>, #dateformat(getChangeLogs.Chevron_PM_Approval_Date,"mm/dd/yyyy")#</cfif></ss:Data></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Amendment#</ss:Data></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.SMName#</ss:Data></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Email_Reference#</ss:Data></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Oracle_Update#</ss:Data></Cell>

					<!--- chevron approval status --->
					<cfif getChangeLogs.Chevron_Approval_Status EQ "S"><cfset ssCASStyle = "sSilver"><cfset ChevronApprovalStatus = "In Progress">
					<cfelseif getChangeLogs.Chevron_Approval_Status EQ "Y"><cfset ssCASStyle = "sYellow"><cfset ChevronApprovalStatus = "Pending Approval">
					<cfelseif getChangeLogs.Chevron_Approval_Status EQ "G"><cfset ssCASStyle = "sGreen"><cfset ChevronApprovalStatus = "Approved by Chevron">
					<cfelseif getChangeLogs.Chevron_Approval_Status EQ "B"><cfset ssCASStyle = "sBlack"><cfset ChevronApprovalStatus = "Rejected by Chevron">
					<cfelse><cfset ssCASStyle = "Default"><cfset ChevronApprovalStatus = "">
					</cfif>
					<Cell ss:StyleID="#ssCASStyle#"><Data ss:Type="String">#ChevronApprovalStatus#</ss:Data></Cell>

					<!--- Oracle Process Status --->
					<cfif getChangeLogs.Internal_Status EQ "R"><cfset ssISStyle = "sRed"><cfset InternalStatus = "Problem">
					<cfelseif getChangeLogs.Internal_Status EQ "Y"><cfset ssISStyle = "sYellow"><cfset InternalStatus = "Needs Follow Up">
					<cfelseif getChangeLogs.Internal_Status EQ "G"><cfset ssISStyle = "sGreen"><cfset InternalStatus = "Complete">
					<cfelseif getChangeLogs.Internal_Status EQ "O"><cfset ssISStyle = "sOrange"><cfset InternalStatus = "Pending Project Close">
					<cfelse><cfset ssISStyle = "Default"><cfset InternalStatus = "">
					</cfif>
					<Cell ss:StyleID="#ssISStyle#"><Data ss:Type="String">#InternalStatus#</ss:Data></Cell>

					<!--- Milestone Update Status --->
					<cfif getChangeLogs.Milestone_Update_Status EQ "R"><cfset ssISStyle = "sRed"><cfset MilestoneUpdateStatus = "Needs Follow Up">
					<cfelseif getChangeLogs.Milestone_Update_Status EQ "Y"><cfset ssISStyle = "sYellow"><cfset MilestoneUpdateStatus = "Not Complete">
					<cfelseif getChangeLogs.Milestone_Update_Status EQ "G"><cfset ssISStyle = "sGreen"><cfset MilestoneUpdateStatus = "Complete">
					<cfelseif getChangeLogs.Milestone_Update_Status EQ "W"><cfset ssISStyle = "sWhite"><cfset MilestoneUpdateStatus = "Not Applicable">
					<cfelse><cfset ssISStyle = "Default"><cfset MilestoneUpdateStatus = "">
					</cfif>
					<Cell ss:StyleID="#ssISStyle#"><Data ss:Type="String">#MilestoneUpdateStatus#</ss:Data></Cell>

					<!--- fco --->
					<cfif len(getChangeLogs.FCO_File_Name)>
						<Cell ss:StyleID="s81" ss:HRef="#Request.Protocol#//#HTTP.Server_Name#/#Request.FCOPath#/#getChangeLogs.FCO_File_Name#"><Data ss:Type="String">view the document</ss:Data></Cell>
					<cfelse>
						<Cell ss:StyleID="s77"><Data ss:Type="String"></ss:Data></Cell>
					</cfif>
				</Row>
				</cfloop>
		  </Table>

  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <Selected/>
   <FreezePanes/>
   <FrozenNoSplit/>
   <SplitHorizontal>1</SplitHorizontal>
   <TopRowBottomPane>1</TopRowBottomPane>
   <ActivePane>2</ActivePane>
   <Panes>
    <Pane>
     <Number>3</Number>
    </Pane>
    <Pane>
     <Number>2</Number>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
  <AutoFilter x:Range="R1C1:R#expRowCount#C28" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
 </Worksheet>
</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
