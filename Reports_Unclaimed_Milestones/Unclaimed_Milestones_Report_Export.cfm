<!-------------------------------------------
Description:
	Unclaimed Milestones Report export page

History:
	4/7/2021 - created
-------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>
<cfset expRowCount = getUnclaimedMilestones.RecordCount + 2>

<!--- store the XML data --->
<cfsavecontent variable="XMLData">
<cfoutput>
	<!--- XML declaration --->
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
			</Style>
		  <Style ss:ID="s18" ss:Name="Currency">
		   <NumberFormat ss:Format="_(&quot;$&quot;* ##,##0.00_);_(&quot;$&quot;* \(##,##0.00\);_(&quot;$&quot;* &quot;-&quot;??_);_(@_)"/>
		  </Style>
			<Style ss:ID="s63">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Top"/>
			 <Borders/>
			 <Font ss:FontName="Arial" ss:Size="9"/>
			 <Interior/>
			 <NumberFormat/>
			</Style>
			<Style ss:ID="s64">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Top"/>
			 <Borders>
			  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
			 </Borders>
			 <Font ss:FontName="Arial" ss:Size="9" ss:Bold="1"/>
			 <Interior ss:Color="##FFFF00" ss:Pattern="Solid"/>
			</Style>
		  <Style ss:ID="s69" ss:Parent="s18">
		   <Alignment ss:Vertical="Top" ss:WrapText="1"/>
		   <Borders/>
		   <Font ss:FontName="Arial" ss:Size="9"/>
		   <Interior/>
		   <NumberFormat ss:Format="&quot;$&quot;##,##0.00"/>
		  </Style>
		</Styles>

	<Worksheet ss:Name="Unclaimed Milestones">
		<Table ss:ExpandedColumnCount="16" ss:ExpandedRowCount="#expRowCount#" x:FullColumns="1" x:FullRows="1">
			<!--- define columns --->
			<Column ss:Width="130"/> <!--- site id --->
			<Column ss:Width="270"/> <!--- Site Name --->
			<Column ss:Width="180"/> <!--- Milestone --->
			<Column ss:Width="130"/> <!--- Milestone Baseline Date --->
			<Column ss:Width="115"/> <!--- Milestone Plan Date --->
			<Column ss:Width="115"/> <!--- Milestone Amount --->
			<Column ss:Width="50"/> <!--- Skipped --->
			<Column ss:Width="90"/> <!--- Delay Reason --->
			<Column ss:Width="500"/> <!--- Notes --->
			<Column ss:Width="60"/> <!--- State --->
			<Column ss:Width="70"/> <!--- zip code --->
			<Column ss:Width="70"/> <!--- Region --->
			<Column ss:Width="90"/> <!--- Site Portfolio --->
			<Column ss:Width="130"/> <!--- Site Manager --->
			<Column ss:Width="130"/> <!--- Deputy --->
			<Column ss:Width="115"/> <!--- Milestone Portfolio --->
<!---			<Column ss:Width="90"/> <!--- Milestone ID --->--->

		<!--- site header --->
			<Row>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Site ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Site Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Milestone</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Milestone Baseline Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Milestone Plan Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Milestone Amount</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Skip</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Delay Reason</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Notes</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Zip Code</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Region</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Site Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Site Manager</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Deputy</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Milestone Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
<!---				<Cell ss:StyleID="s64"><Data ss:Type="String">Milestone ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>--->
			</Row>

			<!--- data --->
			<cfloop query="getUnclaimedMilestones">
				<Row>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getUnclaimedMilestones.Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getUnclaimedMilestones.site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getUnclaimedMilestones.milestone#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#right(getUnclaimedMilestones.Milestone_Baseline_Date,2)#/#left(getUnclaimedMilestones.Milestone_Baseline_Date,4)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#right(getUnclaimedMilestones.Milestone_Plan_Date,2)#/#left(getUnclaimedMilestones.Milestone_Plan_Date,4)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s69"><Data ss:Type="Number">#getUnclaimedMilestones.Milestone_Amount#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String"><cfif getUnclaimedMilestones.Skip EQ 1>Yes<cfelse></cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getUnclaimedMilestones.Delay_Reason#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getUnclaimedMilestones.notes#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getUnclaimedMilestones.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getUnclaimedMilestones.Zip_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getUnclaimedMilestones.Region#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getUnclaimedMilestones.Site_Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getUnclaimedMilestones.SiteManager#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getUnclaimedMilestones.Deputy#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getUnclaimedMilestones.Milestone_Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
<!---					<Cell ss:StyleID="Default"><Data ss:Type="Number">#getUnclaimedMilestones.milestone_id#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>--->
				</Row>
			</cfloop>
  </Table>

  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
   <Unsynced/>
   <Print>
    <ValidPrinterInfo/>
    <HorizontalResolution>600</HorizontalResolution>
    <VerticalResolution>600</VerticalResolution>
   </Print>
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
  <AutoFilter x:Range="R1C1:R#expRowCount#C16" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
	</Worksheet>
	</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
