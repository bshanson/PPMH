<!-------------------------------------------
Description:
	Client review report

History:
	3/26/2020 - created
-------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>
<cfset expRowCount = getReviewSites.RecordCount + 27>

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
			 <Protection/>
			</Style>
			<Style ss:ID="s18" ss:Name="Currency">
			 <NumberFormat ss:Format="_(&quot;$&quot;* ##,##0.00_);_(&quot;$&quot;* \(##,##0.00\);_(&quot;$&quot;* &quot;-&quot;??_);_(@_)"/>
			</Style>
			<Style ss:ID="s20" ss:Name="Percent">
			 <NumberFormat ss:Format="0%"/>
			</Style>
			<Style ss:ID="s71" ss:Name="Hyperlink">
			 <Font ss:FontName="Arial" ss:Size="9" ss:Color="##0563C1" ss:Underline="Single"/>
			</Style>
			<Style ss:ID="s62">
			 <NumberFormat ss:Format="&quot;$&quot;##,##0.00"/>
			</Style>
			<Style ss:ID="s63">
			 <NumberFormat ss:Format="&quot;$&quot;##,##0.00"/>
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
			 <Interior ss:Color="##D9D9D9" ss:Pattern="Solid"/>
			</Style>
			<Style ss:ID="s65">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Top"/>
			 <Borders>
			  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
			 </Borders>
			 <Font ss:FontName="Arial" ss:Size="9" ss:Bold="1"/>
			 <Interior ss:Color="##D9D9D9" ss:Pattern="Solid"/>
			 <NumberFormat ss:Format="0"/>
			</Style>
			<Style ss:ID="s66">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Top"/>
			 <Borders>
			  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
			 </Borders>
			 <Font ss:FontName="Arial" ss:Size="9" ss:Bold="1"/>
			 <Interior ss:Color="##D9D9D9" ss:Pattern="Solid"/>
			 <NumberFormat ss:Format="&quot;$&quot;##,##0.00"/>
			</Style>
			<Style ss:ID="s69" ss:Parent="s18">
			 <Alignment ss:Vertical="Top" ss:WrapText="1"/>
			 <Borders/>
			 <Font ss:FontName="Arial" ss:Size="9"/>
			 <Interior/>
			 <NumberFormat ss:Format="0"/>
			 <Protection/>
			</Style>
			<Style ss:ID="s70">
			 <Font ss:FontName="Arial" ss:Size="9"/>
			</Style>
			<Style ss:ID="s72" ss:Parent="s71">
			 <Alignment ss:Vertical="Top" ss:WrapText="1"/>
			 <Borders/>
			 <Interior/>
			 <NumberFormat/>
			 <Protection/>
			</Style>
			<Style ss:ID="s73" ss:Parent="s18">
			 <Alignment ss:Vertical="Top" ss:WrapText="1"/>
			 <Borders/>
			 <Font ss:FontName="Arial" ss:Size="9"/>
			 <Interior/>
			 <NumberFormat ss:Format="&quot;$&quot;##,##0.00"/>
			 <Protection/>
			</Style>
			<Style ss:ID="s87">
			 <NumberFormat ss:Format="0"/>
			</Style>
			<Style ss:ID="m308512896">
			 <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
			 <Borders>
			  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			 </Borders>
			</Style>
			<Style ss:ID="m308512916">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			 <Borders>
			  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
			 </Borders>
			</Style>
			<Style ss:ID="s162">
			 <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="22" ss:Color="##000000" ss:Bold="1"/>
			</Style>
			<Style ss:ID="s163">
			 <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
			</Style>
			<Style ss:ID="s164">
			 <NumberFormat ss:Format="_([$$-409]* ##,##0_);_([$$-409]* \(##,##0\);_([$$-409]* &quot;-&quot;??_);_(@_)"/>
			</Style>
			<Style ss:ID="s165">
			 <NumberFormat ss:Format="_([$$-409]* ##,##0.00_);_([$$-409]* \(##,##0.00\);_([$$-409]* &quot;-&quot;??_);_(@_)"/>
			</Style>
			<Style ss:ID="s166">
			 <NumberFormat ss:Format="Fixed"/>
			</Style>
			<Style ss:ID="s167">
			 <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
			</Style>
			<Style ss:ID="s168">
			 <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
			</Style>
			<Style ss:ID="s169">
			 <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##FF0000" ss:Bold="1"/>
			</Style>
			<Style ss:ID="s170">
			 <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##000000" ss:Bold="1"/>
			</Style>
			<Style ss:ID="s171">
			 <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##FF0000"/>
			</Style>
			<Style ss:ID="s172">
			 <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
			 <Borders>
			  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			 </Borders>
			</Style>
			<Style ss:ID="s179">
			 <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
			 <Borders>
			  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			 </Borders>
			 <NumberFormat
			  ss:Format="_([$$-409]* ##,##0.00_);_([$$-409]* \(##,##0.00\);_([$$-409]* &quot;-&quot;??_);_(@_)"/>
			</Style>
			<Style ss:ID="s180">
			 <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
			 <Borders>
			  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="##000000"/>
			 </Borders>
			 <NumberFormat ss:Format="Fixed"/>
			</Style>
			<Style ss:ID="s181">
			 <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
			 <NumberFormat ss:Format="Fixed"/>
			</Style>
			<Style ss:ID="s188">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Top"/>
			 <Borders>
			  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
			  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
			 </Borders>
			 <Font ss:FontName="Arial" ss:Size="9" ss:Bold="1"/>
			 <Interior ss:Color="##D9D9D9" ss:Pattern="Solid"/>
			</Style>
			<Style ss:ID="s189">
			 <Alignment ss:Vertical="Top" ss:WrapText="1"/>
			</Style>
			<Style ss:ID="s132">
			 <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##FF0000"/>
			</Style>
			<Style ss:ID="s133">
			 <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##000000" ss:Italic="1"/>
			 <NumberFormat ss:Format="&quot;$&quot;##,##0.00"/>
			</Style>
			<Style ss:ID="s134">
			 <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##FF0000" ss:Bold="1"/>
			</Style>
			<Style ss:ID="s138">
			 <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##FF0000"/>
			 <NumberFormat ss:Format="&quot;$&quot;##,##0.00"/>
			</Style>
			<Style ss:ID="s139" ss:Parent="s20">
			 <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##FF0000"/>
			</Style>
			<Style ss:ID="s153">
			 <Interior/>
			 <NumberFormat ss:Format="&quot;$&quot;##,##0.00"/>
			</Style>
			<Style ss:ID="s154">
			 <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##000000" ss:Bold="1"/>
			 <Interior/>
			 <NumberFormat ss:Format="&quot;$&quot;##,##0.00"/>
			</Style>
		</Styles>

	<Worksheet ss:Name="Client Review">
		<Table ss:ExpandedColumnCount="17" ss:ExpandedRowCount="#expRowCount#" x:FullColumns="1" x:FullRows="1">
			<!--- define columns --->
			<Column ss:Width="110"/> <!--- site id --->
			<Column ss:Width="150"/> <!--- address--->
			<Column ss:Width="80"/> <!--- city --->
			<Column ss:Width="55"/> <!--- state --->
			<Column ss:Width="70"/> <!--- zip code --->
			<Column ss:Width="120"/> <!--- ops lead --->
			<Column ss:Width="55"/> <!--- contract line no --->
			<Column ss:Width="200"/> <!--- milestone --->
			<Column ss:Width="80"/> <!--- MGC Code --->
			<Column ss:Width="130"/> <!--- SAP Charge Code --->
			<Column ss:Width="130"/> <!--- ERP --->
			<Column ss:Width="190"/> <!--- Clarifying notes as needed --->
			<Column ss:Width="120"/> <!--- tax base --->
			<Column ss:StyleID="s87" ss:Width="65"/> <!--- quant --->
			<Column ss:StyleID="s87" ss:Width="90"/> <!--- fee --->
			<Column ss:StyleID="s63" ss:Width="115"/> <!--- r quant--->
			<Column ss:StyleID="s87" ss:Width="125"/> <!--- t fee--->

<cfset Attn = "Jaclyn Wilkins">
<cfset ReferenceNumber = "">
<cfset ChevronClosure = "">
<cfset ReferenceName = "">
<cfset ServiceOrderNumber = "">

<cfif getReviewSites.portfolio_id EQ 39>
	<cfset Attn = "Jaclyn Wilkins">
	<cfset ReferenceNumber = "DEMCLOSURE2.0.2020.9997">
	<cfset ChevronClosure = "COP 2">
	<cfset ServiceOrderNumber = "SO## 0015329072">
</cfif>

<cfif getReviewSites.portfolio_id EQ 40>
	<cfif getReviewSites.COP_Region_ID EQ 1>
		<cfset Attn = "Henry Stremlau">
		<cfset ServiceOrderNumber = "SO## 0015342174">
		<cfset ChevronClosure = "COP 3 - East Region">
	</cfif>
	<cfif getReviewSites.COP_Region_ID EQ 2>
		<cfset Attn = "Jason Michelson">
		<cfset ServiceOrderNumber = "SO## 0015342206">
		<cfset ChevronClosure = "COP 3 - Central Region">
	</cfif>
	<cfif getReviewSites.COP_Region_ID EQ 3>
		<cfset Attn = "Bradley Rogers">
		<cfset ServiceOrderNumber = "SO## 0015342175">
		<cfset ChevronClosure = "COP 3 - West Region">
	</cfif>
</cfif>

<cfif getReviewSites.portfolio_id EQ 41>
	<cfif getReviewSites.COP_Region_ID EQ 1>
		<cfset Attn = "Shaun Barrow">
		<cfset ReferenceNumber = "COP4East">
		<cfset ChevronClosure = "COP 4 - East Region">
		<cfset ServiceOrderNumber = "SO## 0015342208">
	</cfif>
	<cfif getReviewSites.COP_Region_ID EQ 2>
		<cfset Attn = "Jason Michelson">
		<cfset ReferenceNumber = "COP4Cent">
		<cfset ChevronClosure = "COP 4 - Central Region">
		<cfset ServiceOrderNumber = "SO## 0015342026">
	</cfif>
	<cfif getReviewSites.COP_Region_ID EQ 3>
		<cfset Attn = "Susan Erickson">
		<cfset ReferenceNumber = "COP4West">
		<cfset ChevronClosure = "COP 4 - West Region">
		<cfset ServiceOrderNumber = "SO## 0015342207">
	</cfif>
</cfif>

<cfif getReviewSites.portfolio_id EQ 42>
	<cfif getReviewSites.COP_Region_ID EQ 1>
		<cfset Attn = "Henry Stremlau">
		<cfset ChevronClosure = "COP 5 - East Region">
		<cfset ServiceOrderNumber = "SO## 0015342522">
	</cfif>
	<cfif getReviewSites.COP_Region_ID EQ 2>
		<cfset Attn = "Jason Michelson">
		<cfset ChevronClosure = "COP 5 - Central Region">
		<cfset ServiceOrderNumber = "SO## 0015342521">
	</cfif>
	<cfif getReviewSites.COP_Region_ID EQ 3>
		<cfset Attn = "Jaclyn Wilkins">
		<cfset ChevronClosure = "COP 5 - West Region">
		<cfset ServiceOrderNumber = "SO## 0015342523">
	</cfif>
</cfif>

<cfif getReviewSites.portfolio_id EQ 64>
		<cfset Attn = "Hector Narez">
		<cfset ChevronClosure = "">
		<cfset ReferenceName = "PCN Management">
		<cfset ServiceOrderNumber = "0060617221">
		<cfset ReferenceNumber = "30148094">
</cfif>

	 <!--- invoice header --->
   <Row ss:AutoFitHeight="0" ss:Height="33.450000000000003">
    <Cell ss:StyleID="s162"><Data ss:Type="String">INVOICE</Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"/>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s167"><Data ss:Type="String">Chevron Environmental Management Company</Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"><Data ss:Type="String">Arcadis U.S., Inc.</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s171"><Data ss:Type="String">Attn: Henry Stremlau</Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"><Data ss:Type="String">Bank of America</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s169"><Data ss:Type="String">Invoice Date: </Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"><Data ss:Type="String">Acct: 8188093937</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s169"><Data ss:Type="String">Arcadis Invoice No.: </Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"><Data ss:Type="String">ACH.071 000 039 Wire: 026009 593</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s170"><Data ss:Type="String">Payment Term: 60 Days</Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"><Data ss:Type="String">SWIFT: BOFAUS3N</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s169"><Data ss:Type="String">Due Date: </Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"><Data ss:Type="String">Remit-mailbox@arcadis-us.com</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s167"><Data ss:Type="String">Arcadis Reference Number: #ReferenceNumber#</Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"><Data ss:Type="String">62638 Collections Center Drive</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s167"><Data ss:Type="String">Arcadis Reference Name: #ReferenceName#</Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"><Data ss:Type="String">Chicago, IL 60693-0626</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s171"><Data ss:Type="String">Services Through: </Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"/>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s171"><Data ss:Type="String">Service Order Number: #ServiceOrderNumber#</Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"/>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s167"><Data ss:Type="String">#ChevronClosure#</Data></Cell>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"/>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s168"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"/>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s168"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/>
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"/>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:StyleID="s168"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/>
    <Cell ss:StyleID="s163"/> <!--- state --->
    <Cell ss:StyleID="s163"/> <!--- zip code --->
    <Cell ss:StyleID="s163"/> <!--- ops lead --->
    <Cell ss:StyleID="s163"/> <!--- contract line no --->
    <Cell ss:StyleID="s164"/> <!--- milestone --->
    <Cell ss:StyleID="s163"/> <!--- MGC Code --->
    <Cell ss:StyleID="s163"/> <!--- SAP Charge Code --->
    <Cell ss:StyleID="s163"/> <!--- ERP --->
    <Cell ss:StyleID="s163"/> <!--- Clarifying notes as needed --->
    <Cell ss:StyleID="s164"/> <!--- Taxation Base --->
    <Cell ss:StyleID="s165"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s166"/>
    <Cell ss:StyleID="s168"/>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="12" ss:StyleID="m308512896"><Data ss:Type="String">Invoice</Data></Cell>
   </Row>
		<!--- site header --->
			<Row>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Site ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Address</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">City</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Zip Code</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Ops Lead</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">CLN</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Milestone</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">MGC Code</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">SAP Charge Code</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">ERP</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Clarifying notes as needed</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s64"><Data ss:Type="String">Taxation Base</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s65"><Data ss:Type="String">Quantity</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s66"><Data ss:Type="String">Milestone Fee</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s65"><Data ss:Type="String">Remaining Quantity</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="s66"><Data ss:Type="String">Total Remaining Fees</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			</Row>

			<!--- data --->
			<cfloop query="getReviewSites">
				<cfset ERPClass = "Default">
				<cfset MonthQuantity = "">
				<cfset remainingSiteMilestones = "">
				<cfset InvoiceAmount = "">
				<cfset remainingSiteMilestoneFees = "">
				<cfif len(getReviewSites.MID)>
					<cfif isDefined("form.MilestonePortfolioToFind") and form.MilestonePortfolioToFind NEQ "0"><cfset PID = form.MilestonePortfolioToFind><cfelse><cfset PID = getReviewSites.Portfolio_ID></cfif>
					<!--- count milestones --->
					<cfmodule template="../components/q_countSiteMilestones.cfm" MID="#getReviewSites.MID#" Year="#getReviewSites.Year#" AdminSiteID="#getReviewSites.ID#" PID="#PID#" countMilestones="countSiteMilestones">
					<!--- count used milestones --->
					<cfmodule template="../components/q_countSiteUsedMilestones.cfm" MID="#getReviewSites.MID#" Year="#getReviewSites.Year#" AdminSiteID="#getReviewSites.ID#" PID="#PID#" countUsedMilestones="countSiteUsedMilestones">
					<!--- set remaining milestones --->
					<cfset remainingSiteMilestones = countSiteMilestones.cntMilestone - countSiteUsedMilestones.cntUsedMilestone>
					<!--- set remaining milestones fees --->
					<cfset remainingSiteMilestoneFees = countSiteMilestones.totalMilestoneFee - countSiteUsedMilestones.usedMilestoneFee>
					<cfset Skipped = 1>
					<cfif getReviewSites.Skip EQ 1><cfset Skipped = .2></cfif>
					<cfset InvoiceAmount = getReviewSites.Milestone_Amount * Skipped>
					<cfset MonthQuantity = 1>
				</cfif>
				<Row>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getReviewSites.Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getReviewSites.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getReviewSites.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getReviewSites.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getReviewSites.Zip_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getReviewSites.OpsLead#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<!--- contract line no --->
					<cfif getReviewSites.MID EQ 39><cfset ssType = "Number"><cfset CLN = "1"></cfif>
					<cfif getReviewSites.MID EQ 41><cfset ssType = "Number"><cfset CLN = "3"></cfif>
					<cfif (getReviewSites.MID NEQ 39 and getReviewSites.MID NEQ 41)>
						<cfif not len(getReviewSites.Contract_Line_Number)>
							<cfset ssType = "String">
							<cfset CLN = "">
						<cfelse>
							<cfset ssType = "Number">
							<cfset CLN = getReviewSites.Contract_Line_Number>
						</cfif>
					</cfif>
					<Cell ss:StyleID="Default"><Data ss:Type="#ssType#">#CLN#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfset MGCAribaCodes = getReviewSites.MGC_Ariba_Codes>
					<cfif getReviewSites.State_Abbreviation EQ "WA"><cfset MGCAribaCodes = MGCAribaCodes & ", F24"></cfif>
					<cfif getReviewSites.State_Abbreviation EQ "NM" and getReviewSites.City EQ "Navajo"><cfset MGCAribaCodes = "A30"></cfif>
					<cfif getReviewSites.State_Abbreviation EQ "AK" and getReviewSites.City EQ "Juneau"><cfset MGCAribaCodes = "A30"></cfif>
					<cfif getReviewSites.State_Abbreviation EQ "AK" and getReviewSites.City EQ "Kenai"><cfset MGCAribaCodes = "A30"></cfif>
					<cfif getReviewSites.State_Abbreviation EQ "AK" and getReviewSites.City EQ "Anchor Point"><cfset MGCAribaCodes = "A30"></cfif>
					<cfif getReviewSites.State_Abbreviation EQ "AK" and getReviewSites.City EQ "Petersburg"><cfset MGCAribaCodes = "A30"></cfif>
					<cfif getReviewSites.State_Abbreviation EQ "AK" and getReviewSites.City EQ "Petersburg Borough"><cfset MGCAribaCodes = "A30"></cfif>
					<cfif getReviewSites.State_Abbreviation EQ "AK" and getReviewSites.City EQ "Hoonah"><cfset MGCAribaCodes = "A30"></cfif>
					<cfif getReviewSites.State_Abbreviation EQ "AK" and getReviewSites.City EQ "Tenakee Springs"><cfset MGCAribaCodes = "A30"></cfif>
					<cfif getReviewSites.State_Abbreviation EQ "AK" and getReviewSites.City EQ "Sitka"><cfset MGCAribaCodes = "A30"></cfif>
					<cfif getReviewSites.Site_ID EQ "PMG00252"><cfset MGCAribaCodes = "A30"></cfif>
					<cfif len(MonthQuantity)>
						<!--- milestone --->
						<cfif len(Milestone_Doc)>
							<Cell ss:StyleID="s72" ss:HRef="#Request.Protocol#//#HTTP.Server_Name#/#Request.MileStonePath#/#getReviewSites.Milestone_Doc#"><Data ss:Type="String">#getReviewSites.Milestone# <cfif getReviewSites.Portfolio_ID NEQ 64>(#left(getReviewSites.Milestone_Plan_Date,4)#)</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<cfelse>
							<Cell ss:StyleID="s69"><Data ss:Type="String">#getReviewSites.Milestone# <cfif getReviewSites.Portfolio_ID NEQ 64>(#left(getReviewSites.Milestone_Plan_Date,4)#)</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						</cfif>
						<!--- MGC Code --->
						<Cell ss:StyleID="Default"><Data ss:Type="String">#MGCAribaCodes#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- SAP Charge Code --->
						<cfset SAPChargeCode = "No Change">
						<cfif len(getReviewSites.SAP_Charge_Code) and len(getReviewSites.SAP_Charge_Code) GT 14>
							<cfloop from="1" to="#len(getReviewSites.SAP_Charge_Code)#" index="p">
								<cfif find("-", getReviewSites.SAP_Charge_Code, p) or find(" ", getReviewSites.SAP_Charge_Code, p)>
									<cfset pos = p>
								</cfif>
							</cfloop>
							<cfset SAPChargeCode = left(getReviewSites.SAP_Charge_Code,pos-1)>
						<cfelse>
							<cfset SAPChargeCode = getReviewSites.SAP_Charge_Code>
						</cfif>
						<cfif not len(getReviewSites.SAP_Charge_Code)><cfset SAPChargeCode = "No Change"></cfif>
						<cfif getReviewSites.Portfolio_ID EQ 64><cfset SAPChargeCode = getReviewSites.SAP_Charge_Code></cfif>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#SAPChargeCode#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- ERP --->
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getReviewSites.ERP_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- Clarifying notes --->
						<cfset ClarifyingNotes = "">
						<cfif getReviewSites.Portfolio_ID EQ 64><cfset ClarifyingNotes = "For Services (#monthasstring(right(Milestone_Plan_Date,2))#, #left(Milestone_Plan_Date,4)#)"></cfif>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#ClarifyingNotes#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getReviewSites.Bill_Set#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s69"><Data ss:Type="Number">#MonthQuantity#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s73"><Data ss:Type="Number">#InvoiceAmount#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s69"><Data ss:Type="Number">#remainingSiteMilestones#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s73"><Data ss:Type="Number">#remainingSiteMilestoneFees#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfelse>
						<!--- milestone --->
						<Cell ss:StyleID="s72"><Data ss:Type="String">#getReviewSites.Milestone#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- MGC Code --->
						<Cell ss:StyleID="Default"><Data ss:Type="String">#MGCAribaCodes#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- SAP Charge Code --->
						<Cell ss:StyleID="Default"><Data ss:Type="String"><cfif len(getReviewSites.SAP_Charge_Code)>#getReviewSites.SAP_Charge_Code#<cfelse>No Change</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- ERP --->
						<Cell ss:StyleID="Default"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<!--- Clarifying notes --->
						<Cell ss:StyleID="Default"><Data ss:Type="String"></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getReviewSites.Bill_Set#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s69"><Data ss:Type="String">#MonthQuantity#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s73"><Data ss:Type="String">#InvoiceAmount#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s69"><Data ss:Type="String">#remainingSiteMilestones#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s73"><Data ss:Type="String">#remainingSiteMilestoneFees#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					</cfif>
				</Row>
			</cfloop>

	<!--- footer --->
   <Row ss:AutoFitHeight="0">
    <Cell ss:Index="14" ss:StyleID="s132"><Data ss:Type="String">Subtotal </Data><NamedCell ss:Name="_FilterDatabase"/><NamedCell ss:Name="Print_Area"/></Cell>
    <Cell ss:StyleID="s153" ss:Formula="=SUBTOTAL(9,R[-#getReviewSites.RecordCount#]C:R[-1]C)"><Data ss:Type="Number">0</Data><NamedCell ss:Name="_FilterDatabase"/><NamedCell ss:Name="Print_Area"/></Cell>
   </Row>

   <Row ss:AutoFitHeight="0">
    <Cell ss:Index="14" ss:StyleID="s133"><Data ss:Type="String">Tax Total</Data><NamedCell ss:Name="_FilterDatabase"/><NamedCell ss:Name="Print_Area"/></Cell>
    <Cell ss:StyleID="s153"><Data ss:Type="Number"></Data><NamedCell ss:Name="_FilterDatabase"/><NamedCell ss:Name="Print_Area"/></Cell>
   </Row>

   <Row ss:AutoFitHeight="0">
    <Cell ss:Index="14" ss:StyleID="s134"><Data ss:Type="String">Total </Data><NamedCell ss:Name="_FilterDatabase"/><NamedCell ss:Name="Print_Area"/></Cell>
    <Cell ss:StyleID="s154" ss:Formula="=R[-1]C+R[-2]C"><Data ss:Type="Number">0</Data><NamedCell ss:Name="_FilterDatabase"/><NamedCell ss:Name="Print_Area"/></Cell>
   </Row>

   <Row ss:AutoFitHeight="0">
    <Cell ss:Index="14" ss:StyleID="s134"><Data ss:Type="String"></Data><NamedCell ss:Name="Print_Area"/></Cell>
    <Cell ss:StyleID="s134"><Data ss:Type="String"></Data><NamedCell ss:Name="Print_Area"/></Cell>
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
   <SplitHorizontal>17</SplitHorizontal>
   <TopRowBottomPane>17</TopRowBottomPane>
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
  <AutoFilter x:Range="R17C1:R#expRowCount#C17" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
	</Worksheet>
	</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
