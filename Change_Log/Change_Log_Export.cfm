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

  <Style ss:ID="s71">
   <Alignment ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <Interior/>
   <NumberFormat ss:Format="&quot;$&quot;#,##0.00"/>
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
 </Styles>
 
<cfoutput>
		<Worksheet ss:Name="Change Log">
			<!--- define columns --->
			<Table ss:ExpandedColumnCount="13" ss:ExpandedRowCount="#expRowCount#" x:FullColumns="1" x:FullRows="1">
			<Column ss:StyleID="s78" ss:Width="100"/> <!--- Change Log ID --->
			<Column ss:StyleID="s78" ss:Width="120"/> <!--- Change Log Portfolio --->
			<Column ss:StyleID="s78" ss:Width="120"/> <!--- site --->
			<Column ss:StyleID="s78" ss:Width="150"/> <!--- address --->
			<Column ss:StyleID="s78" ss:Width="120"/> <!--- city --->
			<Column ss:StyleID="s78" ss:Width="70"/> <!--- state --->
			<Column ss:StyleID="s78" ss:Width="70"/> <!--- zip code --->
			<Column ss:StyleID="s78" ss:Width="110"/> <!--- Site Portfolio --->
			<Column ss:StyleID="s78" ss:Width="100"/> <!--- date logged --->
			<Column ss:StyleID="s78" ss:Width="130"/> <!--- Days Since Last Action --->
			<Column ss:StyleID="s78" ss:Width="130"/> <!--- FCO Change Amount --->
			<Column ss:StyleID="s78" ss:Width="130"/> <!--- FCO Status --->
			<Column ss:StyleID="s78" ss:Width="130"/> <!--- Assigned To --->

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
				<Cell ss:StyleID="s88"><Data ss:Type="String">Days Since Last Action</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">FCO Change Amount</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">FCO Status</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s88"><Data ss:Type="String">Assigned To</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
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
					<cfset vDaysSinceLastAction = getChangeLogs.DaysSinceLastAction>
					<cfif getChangeLogs.Current_Status_ID EQ 4><cfset vDaysSinceLastAction = "0"></cfif>
					<Cell ss:StyleID="s74"><Data ss:Type="Number">#vDaysSinceLastAction#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfset ChangeValue = getChangeLogs.Draft_Change_Value>
					<cfif getChangeLogs.FCO_Processed EQ 3>
						<CFModule template="q_getChangeValue.cfm" CLID="#getChangeLogs.Change_Log_ID#" Return="ChangeValue">
					</cfif>
					<cfif getChangeLogs.Current_Status_ID EQ 10>
						<cfset ChangeValue = 0>
					</cfif>
					<Cell ss:StyleID="s71"><Data ss:Type="Number">#ChangeValue#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.current_status#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s77"><Data ss:Type="String">#getChangeLogs.team#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
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
  <AutoFilter x:Range="R1C1:R#expRowCount#C13" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
 </Worksheet>
</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
