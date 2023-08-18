<!--------------------------------------------------------------
Description:
	Uncommitted Milestone report excel file

History:
	7/15/2022 - created
--------------------------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>
<cfset vExpandedRowCount = (getWatchlistMilestones.RecordCount + 4)>
<cfset filterRowCount = getWatchlistMilestones.RecordCount>
<cfset row = 0>

<!--- store the XML data --->
<cfsavecontent variable="XMLData">
<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <Author></Author>
  <LastAuthor></LastAuthor>
  <Created></Created>
  <LastSaved></LastSaved>
  <Version>16.00</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <AllowPNG/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>9420</WindowHeight>
  <WindowWidth>17280</WindowWidth>
  <WindowTopX>1884</WindowTopX>
  <WindowTopY>1884</WindowTopY>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
	 <Alignment ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
	 <Font ss:FontName="Arial" ss:Size="9"/>
   <Interior/>
   <NumberFormat/>
  </Style>
  <Style ss:ID="s20" ss:Name="Percent">
   <NumberFormat ss:Format="0%"/>
  </Style>
  <Style ss:ID="s70" ss:Parent="s20">
   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom" ss:WrapText="1"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
  </Style>
  <Style ss:ID="s16">
   <Alignment ss:WrapText="1"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
  </Style>
  <Style ss:ID="s17">
   <Alignment ss:Horizontal="Center"/>
   <Font ss:FontName="Arial" ss:Size="9" ss:Bold="1"/>
   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s19">
   <Alignment ss:WrapText="1"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <NumberFormat ss:Format="@"/>
  </Style>
  <Style ss:ID="s24">
   <Alignment ss:Horizontal="Left"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
  </Style>
  <Style ss:ID="s25">
   <Alignment ss:Horizontal="Center" ss:WrapText="1"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
  </Style>
  <Style ss:ID="s26">
   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom" ss:WrapText="1"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <NumberFormat ss:Format="&quot;$&quot;#,##0.00"/>
  </Style>
 </Styles>
<cfoutput>
 <Worksheet ss:Name="Uncommitted Milestones">
  <Names>
   <NamedRange ss:Name="_FilterDatabase" ss:RefersTo="=Uncommitted Milestones!R2C1:R#filterRowCount#C13" ss:Hidden="1"/>
  </Names>
  <Table ss:ExpandedColumnCount="13" ss:ExpandedRowCount="#vExpandedRowCount#" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="14.4">
   <Column ss:Width="60"/> <!--- Site ID --->
   <Column ss:Width="200"/> <!--- Site Name --->
   <Column ss:Width="200"/> <!--- Address --->
   <Column ss:Width="100"/> <!--- city --->
   <Column ss:Width="55"/> <!--- state --->
   <Column ss:Width="70"/> <!--- Portfolio --->
   <Column ss:Width="150"/> <!--- site manager --->
   <Column ss:Width="150"/> <!--- deputy --->
	 <Column ss:Width="140"/> <!--- milestone --->
   <Column ss:Width="90"/> <!--- amount --->
   <Column ss:Width="90"/> <!--- probability --->
   <Column ss:Width="140"/> <!--- Anticipated Claim Date --->
   <Column ss:Width="300"/> <!--- notes --->
   <Row>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Site ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Site Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Address</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">City</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Site Manager</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Deputy</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		<Cell ss:StyleID="s17"><Data ss:Type="String">Milestone</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Amount</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Probability</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Anticipated Claim Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Notes</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
   </Row>
	 <cfloop query="getWatchlistMilestones">
	   <Row>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getWatchlistMilestones.Admin_Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s19"><Data ss:Type="String">#getWatchlistMilestones.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s19"><Data ss:Type="String">#getWatchlistMilestones.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getWatchlistMilestones.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String"><cfif len(getWatchlistMilestones.State_Abbreviation) and getWatchlistMilestones.State_Abbreviation NEQ "NA">#getWatchlistMilestones.State_Abbreviation#</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getWatchlistMilestones.Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getWatchlistMilestones.SM_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getWatchlistMilestones.Deputy_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			<Cell ss:StyleID="s16"><Data ss:Type="String">#getWatchlistMilestones.Milestone#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s26"><Data ss:Type="Number">#getWatchlistMilestones.Milestone_Amount#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			<cfset Probability = getWatchlistMilestones.Watchlist_Probability / 100>
	    <Cell ss:StyleID="s70"><Data ss:Type="Number">#Probability#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			<Cell ss:StyleID="s25"><Data ss:Type="String"><cfif getWatchlistMilestones.Anticipated_Claim_Month NEQ 999>#getWatchlistMilestones.Anticipated_Claim_Month#/</cfif>#getWatchlistMilestones.Anticipated_Claim_Year#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="Default"><Data ss:Type="String">#getWatchlistMilestones.Notes#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	   </Row>
	 </cfloop>
   <Row>
    <Cell ss:StyleID="s24"><Data ss:Type="String"></Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="1" ss:StyleID="s24"><Data ss:Type="String">Report Date: #DateFormat(Now(),"mm/dd/yyyy")# #TimeFormat(Now(),"HH:mm:ss")#</Data></Cell>
   </Row>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
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
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
  <AutoFilter x:Range="R1C1:R#filterRowCount#C13" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
 </Worksheet>
</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
