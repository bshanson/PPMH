<!-------------------------------------------
Description:
	Site report

History:
	3/26/2020 - created
-------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>
<cfset expRowCount = getReviewSites.RecordCount + 3>
<cfset filterRowCount = getReviewSites.RecordCount + 1>

<!--- store the XML data --->
<cfsavecontent variable="XMLData">
	<cfoutput>
		<?xml version="1.0"?>
		<?mso-application progid="Excel.Sheet"?>
		<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
		 xmlns:o="urn:schemas-microsoft-com:office:office"
		 xmlns:x="urn:schemas-microsoft-com:office:excel"
		 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
		 xmlns:html="http://www.w3.org/TR/REC-html40">
		 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
		  <Author>Greenly, Allison</Author>
		  <LastAuthor>bhanson</LastAuthor>
		  <Created>2021-06-25T15:37:57Z</Created>
		  <LastSaved>2021-06-25T21:19:36Z</LastSaved>
		  <Version>16.00</Version>
		 </DocumentProperties>
		 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
		  <AllowPNG/>
		 </OfficeDocumentSettings>
		 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
		  <WindowHeight>6012</WindowHeight>
		  <WindowWidth>17256</WindowWidth>
		  <WindowTopX>32767</WindowTopX>
		  <WindowTopY>32767</WindowTopY>
		  <ActiveSheet>1</ActiveSheet>
		  <FirstVisibleSheet>1</FirstVisibleSheet>
		  <ProtectStructure>False</ProtectStructure>
		  <ProtectWindows>False</ProtectWindows>
		 </ExcelWorkbook>
		 <Styles>
		  <Style ss:ID="Default" ss:Name="Normal">
		   <Alignment ss:Vertical="Bottom"/>
		   <Borders/>
		   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##000000"/>
		   <Interior/>
		   <NumberFormat/>
		   <Protection/>
		  </Style>
		  <Style ss:ID="s62">
		   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
		   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##000000" ss:Bold="1"/>
		   <Interior ss:Color="##FFFF00" ss:Pattern="Solid"/>
		  </Style>
		  <Style ss:ID="s63">
		   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
		  </Style>
		  <Style ss:ID="s64">
		   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
		   <NumberFormat ss:Format="@"/>
		  </Style>
		  <Style ss:ID="s65">
		   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom" ss:WrapText="1"/>
		  </Style>
		  <Style ss:ID="s68">
		   <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
		  </Style>
		 </Styles>
		 <Worksheet ss:Name="Sites">
		  <Names>
		   <NamedRange ss:Name="_FilterDatabase" ss:RefersTo="=Sites!R1C1:R#filterRowCount#C21" ss:Hidden="1"/>
		  </Names>
		  <Table ss:ExpandedColumnCount="21" ss:ExpandedRowCount="#expRowCount#" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="14.55">
		   <Column ss:Width="128"/>
		   <Column ss:Width="369"/>
		   <Column ss:Width="369"/>
		   <Column ss:Width="329"/>
		   <Column ss:Width="99"/>
		   <Column ss:Width="59"/>
		   <Column ss:Width="70"/>
		   <Column ss:Width="79"/>
		   <Column ss:Width="99"/>
		   <Column ss:Width="99"/>
		   <Column ss:Width="138"/>
		   <Column ss:Width="138"/>
		   <Column ss:Width="118"/>
		   <Column ss:Width="90"/>
		   <Column ss:Width="90"/>
		   <Column ss:Width="442"/>
		   <Column ss:Width="334"/>
		   <Column ss:Width="144"/>
		   <Column ss:Width="150"/>
			 <Column ss:Width="100"/> <!--- Locus ID --->
			 <Column ss:Width="120"/> <!--- Strategic Grouping ID --->

			<!--- column header --->
			<Row ss:AutoFitHeight="0">
				<Cell ss:StyleID="s62"><Data ss:Type="String">Site ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Site Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Colloquial Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Address</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">City</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Zip Code</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Country</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Program</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Deputy</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Ops Lead</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Facility Type</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">COP - Region</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Inside OERB</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Regulatory Agency</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Agency Contact</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Reimbursement Eligible</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">EIM ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Locus ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s62"><Data ss:Type="String">Strategic Grouping</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			</Row>

			<cfloop query="getReviewSites" >
				<!--- data --->
				<Row ss:AutoFitHeight="0">
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s64"><Data ss:Type="String">#getReviewSites.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s64"><Data ss:Type="String">#getReviewSites.Colloquial_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s64"><Data ss:Type="String">#getReviewSites.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.Zip_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.Country#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.Program#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.Deputy_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.Ops_Lead#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.Facility_Type#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfif len(getReviewSites.Portfolio) and findnocase("cop",getReviewSites.Portfolio)>
						<Cell ss:StyleID="s63"><Data ss:Type="String">#right(getReviewSites.Portfolio,3)# - #getReviewSites.Region#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfelse>
						<Cell ss:StyleID="s63"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					</cfif>
					<Cell ss:StyleID="s65"><Data ss:Type="String"><cfif len(getReviewSites.Inside_OERB)>#YesNoFormat(getReviewSites.Inside_OERB)#</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfinclude template="q_getSiteAgencyInfo.cfm" >
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getSiteAgencyInfo.Regulatory_Agency#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getSiteAgencyInfo.Agency_Person#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s65"><Data ss:Type="String"><cfif len(getReviewSites.Reimbursement_Eligible)>#YesNoFormat(getReviewSites.Reimbursement_Eligible)#</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.EIM_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.Locus_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s63"><Data ss:Type="String">#getReviewSites.SG_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				</Row>
			</cfloop>

			 <!--- footer --->
		   <Row ss:Index="#expRowCount#" ss:AutoFitHeight="0">
		    <Cell ss:MergeAcross="1" ss:StyleID="s68"><Data ss:Type="String">Report Date: #timestamp#</Data></Cell>
		   </Row>
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
		     <ActiveRow>3</ActiveRow>
		    </Pane>
		    <Pane>
		     <Number>2</Number>
		     <ActiveRow>0</ActiveRow>
		    </Pane>
		   </Panes>
		   <ProtectObjects>False</ProtectObjects>
		   <ProtectScenarios>False</ProtectScenarios>
		  </WorksheetOptions>
		  <AutoFilter x:Range="R1C1:R#filterRowCount#C21" xmlns="urn:schemas-microsoft-com:office:excel">
		  </AutoFilter>
		 </Worksheet>
		</Workbook>
	</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
