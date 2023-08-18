<!--------------------------------------------------------------
Description:
	Project Setup report excel file

History:
	6/21/2019 - created
--------------------------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>
<cfset vExpandedRowCount = (getSiteMilestones.RecordCount + 4)>
<cfset filterRowCount = getSiteMilestones.RecordCount>
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
   <NumberFormat ss:Format="0.00"/>
  </Style>
 </Styles>
<cfoutput>
 <Worksheet ss:Name="Milestones">
  <Names>
   <NamedRange ss:Name="_FilterDatabase" ss:RefersTo="=Milestones!R2C1:R#filterRowCount#C18" ss:Hidden="1"/>
  </Names>
  <Table ss:ExpandedColumnCount="18" ss:ExpandedRowCount="#vExpandedRowCount#" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="14.4">
   <Column ss:Width="60"/>
   <Column ss:Width="60"/>
   <Column ss:Width="200"/>
   <Column ss:Width="200"/>
   <Column ss:Width="100"/>
   <Column ss:Width="60"/>
   <Column ss:Width="150"/> <!--- site manager --->
	 <Column ss:Width="200"/> <!--- milestone --->
   <Column ss:Width="120"/> <!--- Milestone Portfolio --->
   <Column ss:Width="100"/> <!--- ACS --->
   <Column ss:Width="90"/> <!--- amount --->
   <Column ss:Width="100"/> <!--- fco --->
   <Column ss:Width="100"/> <!--- Plan Date --->
   <Column ss:Width="100"/> <!--- baseline Date --->
   <Column ss:Width="70"/> <!--- claimed --->
   <Column ss:Width="70"/> <!--- Skip --->
   <Column ss:Width="300"/> <!--- notes --->
   <Column ss:Width="150"/> <!--- reserve --->
   <Row>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Record ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Site ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Site Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Address</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">City</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Site Manager</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		<Cell ss:StyleID="s17"><Data ss:Type="String">Milestone</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Milestone Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">ACS Milestone</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Amount</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">FCO</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Plan Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Baseline Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Claimed</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Skip</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Notes</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Reserve</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
   </Row>
	 <cfloop query="getSiteMilestones">
	   <Row>
	   	<cfset ACSMilestone = "">
		  <cfif getSiteMilestones.ACS_Milestone EQ 1><cfset ACSMilestone = "Yes"><cfelseif getSiteMilestones.ACS_Milestone EQ 0><cfset ACSMilestone = "No"></cfif>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getSiteMilestones.ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getSiteMilestones.Admin_Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s19"><Data ss:Type="String">#getSiteMilestones.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s19"><Data ss:Type="String">#getSiteMilestones.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getSiteMilestones.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String"><cfif len(getSiteMilestones.State_Abbreviation) and getSiteMilestones.State_Abbreviation NEQ "NA">#getSiteMilestones.State_Abbreviation#</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getSiteMilestones.SM_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			<Cell ss:StyleID="s16"><Data ss:Type="String">#getSiteMilestones.Milestone#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getSiteMilestones.Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
 			<Cell ss:StyleID="s25"><Data ss:Type="String">#ACSMilestone#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s26"><Data ss:Type="Number">#getSiteMilestones.Milestone_Amount#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="Default"><Data ss:Type="String">#getSiteMilestones.FCO#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			<cfset Plan_Month = right(getSiteMilestones.Milestone_Plan_Date,2)>
			<cfset Plan_Year = left(getSiteMilestones.Milestone_Plan_Date,4)>
	    <Cell ss:StyleID="s25"><Data ss:Type="String">#Plan_Month#/#Plan_Year#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			<cfif len(getSiteMilestones.Milestone_Baseline_Date)>
				<cfset Baseline_Month = right(getSiteMilestones.Milestone_Baseline_Date,2)>
				<cfset Baseline_Year = left(getSiteMilestones.Milestone_Baseline_Date,4)>
				<Cell ss:StyleID="s25"><Data ss:Type="String">#Baseline_Month#/#Baseline_Year#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			<cfelse>
				<Cell ss:StyleID="s25"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			</cfif>
			<Cell ss:StyleID="s25"><Data ss:Type="String"><cfif getSiteMilestones.Claim EQ 1>Yes<cfelse>No</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			<Cell ss:StyleID="s25"><Data ss:Type="String"><cfif getSiteMilestones.Skip EQ 1>Yes<cfelse>No</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="Default"><Data ss:Type="String">#getSiteMilestones.Notes#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="Default"><Data ss:Type="String">#getSiteMilestones.Settles_To#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
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
  <AutoFilter x:Range="R1C1:R#filterRowCount#C18" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
 </Worksheet>
</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
