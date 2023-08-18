<!----------------------------------------------------------------------------------------------------------
Description:
	change tracking xml version

History:
	9/20/2022 - created
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
  <Style ss:ID="s86">
   <NumberFormat ss:Format="&quot;$&quot;#,##0.00"/>
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
  <Style ss:ID="s91">
   <Alignment ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <Interior/>
   <NumberFormat ss:Format="&quot;$&quot;#,##0.00"/>
   <Protection/>
  </Style>
  <Style ss:ID="sBlue">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#000000"/>
   <Interior ss:Color="#99B1CA" ss:Pattern="Solid"/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="sOrange">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#000000"/>
   <Interior ss:Color="#F2B087" ss:Pattern="Solid"/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="sYellow">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#000000"/>
   <Interior ss:Color="#F8DA9A" ss:Pattern="Solid"/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="sGreen">
   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#000000"/>
   <Interior ss:Color="#80B9BB" ss:Pattern="Solid"/>
   <NumberFormat/>
   <Protection/>
  </Style>
 </Styles>
 
<cfoutput>
		<cfset colspan="16">
		<Worksheet ss:Name="Change Log">
			<!--- define columns --->
			<Table ss:ExpandedColumnCount="#colspan#" ss:ExpandedRowCount="#expRowCount#" x:FullColumns="1" x:FullRows="1">
			<Column ss:StyleID="s78" ss:Width="100"/> <!--- Site ID --->
			<Column ss:StyleID="s78" ss:Width="150"/> <!--- Site Name --->
			<Column ss:StyleID="s78" ss:Width="150"/> <!--- address --->
			<Column ss:StyleID="s78" ss:Width="110"/> <!--- city --->
			<Column ss:StyleID="s78" ss:Width="50"/> <!--- state --->
			<Column ss:StyleID="s78" ss:Width="70"/> <!--- zip code --->
			<Column ss:StyleID="s78" ss:Width="110"/> <!--- Site Portfolio --->
			<Column ss:StyleID="s78" ss:Width="150"/> <!--- Site Manager --->
			<Column ss:StyleID="s78" ss:Width="120"/> <!--- Change Log Portfolio --->
			<Column ss:StyleID="s83" ss:Width="135"/> <!--- Date Chevron Approved --->
			<Column ss:StyleID="s78" ss:Width="300"/> <!--- Milestones --->
			<Column ss:StyleID="s78" ss:Width="200"/> <!--- Type of Change --->
			<Column ss:StyleID="s78" ss:Width="200"/> <!--- Reason for Change --->
			<Column ss:StyleID="s86" ss:Width="100"/> <!--- current value --->
			<Column ss:StyleID="s86" ss:Width="100"/> <!--- new value --->
			<Column ss:StyleID="s86" ss:Width="100"/> <!--- Value of Change --->
	
			<!--- header --->
			<Row>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Site ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Site Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Address</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">City</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Zip Code</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Site Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Site Manager</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Change Log Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Date Chevron Approved</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Milestones</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Type of Change</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Reason for Change</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Current Value</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">New Change</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Value of Change</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			</Row>
		 
			<!--- data --->
			<cfloop query="getChangeLogs">
				<cfmodule template="q_getMilestoneList.cfm" VType="#getChangeLogs.FCO_Type#" CLID="#getChangeLogs.Change_Log_ID#" Return="MilestoneList">
				<!--- V1 --->
				<cfif getChangeLogs.FCO_Type EQ "V1">
					<Row>
						<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Zip_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.SMName#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Log_Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<cfif len(getChangeLogs.Date_Logged)>
							<Cell ss:StyleID="s79"><Data ss:Type="DateTime">#dateformat(getChangeLogs.Date_Logged,"yyyy-mm-dd")#T00:00:00.000</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<cfelse>
							<Cell ss:StyleID="s77"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						</cfif>
						<!--- milestone list --->
						<Cell ss:StyleID="s77"><Data ss:Type="String">#MilestoneList#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- Change Type --->
						<cfmodule template="q_getChangeLogChangeType.cfm" VType="#getChangeLogs.FCO_Type#" CLID="#getChangeLogs.Change_Log_ID#" Return="ChangeTypes">
						<cfset ChangeTypes = ReplaceNoCase(ChangeTypes, "Other Please Describe", getChangeLogs.Change_Type_Other, "all" )>
						<Cell ss:StyleID="s77"><Data ss:Type="String">#ChangeTypes#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- Change reason --->
						<cfmodule template="q_getChangeLogChangeReason.cfm" VType="#getChangeLogs.FCO_Type#" CLID="#getChangeLogs.Change_Log_ID#" Return="ChangeReason">
						<Cell ss:StyleID="s77"><Data ss:Type="String">#ChangeReason#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- current value --->
						<Cell ss:StyleID="s91"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- new value --->
						<Cell ss:StyleID="s91"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- total value --->
						<cfmodule template="q_getChangeValue.cfm" VType="#getChangeLogs.FCO_Type#" CLID="#getChangeLogs.Change_Log_ID#" Return="getValueTotal">
						<cfset ChangeValue = getValueTotal.Change_Value>
						<cfif getChangeLogs.Chevron_Approval_Status EQ "B"><cfset ChangeValue = 0></cfif>
						<Cell ss:StyleID="s91"><Data ss:Type="Number">#ChangeValue#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					</Row>
				</cfif>
				<!--- V2 --->
				<cfif getChangeLogs.FCO_Type EQ "V2">
					<cfif getChangeLogs.Current_Status_ID NEQ 6>
						<cfset nRows = MilestoneList.RecordCount-1>
						<cfset ssMergeDown = 'ss:MergeDown="' & nRows & '"'>
						<cfset ssIndex = ''>
						<cfloop query="MilestoneList" >
							<Row>
								<cfif MilestoneList.CurrentRow EQ 1>
									<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
									<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
									<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
									<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
									<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
									<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Zip_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
									<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
									<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.SMName#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
									<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Log_Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
									<cfif getChangeLogs.Current_Status_ID EQ 11>
										<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
									<cfelse>
										<cfif len(getChangeLogs.Date_Logged)>
											<Cell #ssMergeDown# ss:StyleID="s79"><Data ss:Type="DateTime">#dateformat(getChangeLogs.Date_Logged,"yyyy-mm-dd")#T00:00:00.000</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
										<cfelse>
											<Cell #ssMergeDown# ss:StyleID="s77"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
										</cfif>
									</cfif>
								</cfif>
								<cfif MilestoneList.CurrentRow GT 1><cfset ssIndex = 'ss:Index="11"'></cfif>
								<!--- milestone list --->
								<Cell #ssIndex# ss:StyleID="s77"><Data ss:Type="String">#MilestoneList.Milestone#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
								<!--- Change Type --->
								<Cell ss:StyleID="s77"><Data ss:Type="String">#MilestoneList.Change_Type#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
								<!--- Change reason --->
								<Cell ss:StyleID="s77"><Data ss:Type="String">#MilestoneList.Change_Reason#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
								<!--- values --->
								<CFModule template="q_getChangeValue.cfm" CLID="#getChangeLogs.Change_Log_ID#" VType="V2" UR="#MilestoneList.Unique_Row#" Return="getValueTotal">
								<cfset CurrentValue = 0>
								<cfset NewValue = 0>
								<cfif isDefined("getValueTotal.CurrentValueTotal") and len(getValueTotal.CurrentValueTotal)><cfset CurrentValue = getValueTotal.CurrentValueTotal></cfif>
								<cfif isDefined("getValueTotal.NewValueTotal") and len(getValueTotal.NewValueTotal)><cfset NewValue = getValueTotal.NewValueTotal></cfif>
								<Cell ss:StyleID="s91"><Data ss:Type="Number">#CurrentValue#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
								<Cell ss:StyleID="s91"><Data ss:Type="Number">#NewValue#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
								<cfif MilestoneList.CurrentRow EQ 1>
									<!--- total value --->
									<cfset ChangeValue = 0>
									<cfmodule template="q_getChangeValue.cfm" VType="#getChangeLogs.FCO_Type#" CLID="#getChangeLogs.Change_Log_ID#" CSID="#getChangeLogs.Current_Status_ID#" Return="getValueTotal">
									<cfif (isDefined("getValueTotal.NewValueTotal") and len(getValueTotal.NewValueTotal)) and (isDefined("getValueTotal.CurrentValueTotal") and len(getValueTotal.CurrentValueTotal))>
										<cfset ChangeValue = getValueTotal.NewValueTotal - getValueTotal.CurrentValueTotal>
									<cfelse><cfset ChangeValue = getChangeLogs.Change_Value>
									</cfif>
									<cfif getChangeLogs.Current_Status_ID EQ 11><cfset ChangeValue = 0></cfif>
									<Cell #ssMergeDown# ss:StyleID="s91"><Data ss:Type="Number">#ChangeValue#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
								</cfif>
							</Row>
						</cfloop>
					</cfif>
					<cfif getChangeLogs.Current_Status_ID EQ 6>
						<Row>
							<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_ID#, (#getChangeLogs.FCO_Type#), stat=(#getChangeLogs.Current_Status_ID#)</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Zip_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Site_Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.SMName#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.Log_Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<cfif getChangeLogs.Current_Status_ID EQ 11>
								<Cell ss:StyleID="s77"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<cfelse>
								<cfif len(getChangeLogs.Date_Logged)>
									<Cell ss:StyleID="s79"><Data ss:Type="DateTime">#dateformat(getChangeLogs.Date_Logged,"yyyy-mm-dd")#T00:00:00.000</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
								<cfelse>
									<Cell ss:StyleID="s77"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
								</cfif>
							</cfif>

							<!--- milestone list --->
							<Cell ss:StyleID="s77"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>

							<!--- Change Type --->
							<Cell ss:StyleID="s77"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>

							<!--- Change reason --->
							<Cell ss:StyleID="s77"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>

							<!--- values --->
							<CFModule template="q_getChangeValue.cfm" CLID="#getChangeLogs.Change_Log_ID#" VType="V2" UR="#MilestoneList.Unique_Row#" Return="getValueTotal">
							<cfset CurrentValue = 0>
							<cfset NewValue = 0>
							<cfif isDefined("getValueTotal.CurrentValueTotal") and len(getValueTotal.CurrentValueTotal)><cfset CurrentValue = getValueTotal.CurrentValueTotal></cfif>
							<cfif isDefined("getValueTotal.NewValueTotal") and len(getValueTotal.NewValueTotal)><cfset NewValue = getValueTotal.NewValueTotal></cfif>
							<Cell ss:StyleID="s91"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<Cell ss:StyleID="s91"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
							<!--- total value --->
							<cfset ChangeValue = 0>
							<cfmodule template="q_getChangeValue.cfm" VType="#getChangeLogs.FCO_Type#" CLID="#getChangeLogs.Change_Log_ID#" CSID="#getChangeLogs.Current_Status_ID#" Return="getValueTotal">
							<cfif (isDefined("getValueTotal.NewValueTotal") and len(getValueTotal.NewValueTotal)) and (isDefined("getValueTotal.CurrentValueTotal") and len(getValueTotal.CurrentValueTotal))>
								<cfset ChangeValue = getValueTotal.NewValueTotal - getValueTotal.CurrentValueTotal>
							<cfelse><cfset ChangeValue = 0>
							</cfif>
							<cfif getChangeLogs.Current_Status_ID EQ 11><cfset ChangeValue = 0></cfif>
							<Cell ss:StyleID="s91"><Data ss:Type="Number">#ChangeValue#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						</Row>
					</cfif>
				</cfif>
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
  <AutoFilter x:Range="R1C1:R#expRowCount#C#colspan#" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
 </Worksheet>
</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
