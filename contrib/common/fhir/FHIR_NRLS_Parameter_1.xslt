<?xml version="1.0" encoding="UTF-8"?>
<!-- Validate NRLS-Parameter-1 resource details. -->
<!-- Added to NRLS validator code for Phase II			    -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://hl7.org/fhir">
	<xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<table border="0">
			<xsl:for-each select="/Parameters">
				<xsl:for-each select="./parameter">
				
					<!-- Within each paramter, name is mandatory (1..1)  -->
					<xsl:choose>
						<xsl:when test="((count(./name) = 1) and (./name/@value = 'operation'))">
							<tr>
								<td style="color:#008000">
									<xsl:text>PASS:  parameter/name is mandatory and is populated correctly with '</xsl:text>
									<xsl:value-of select="./name/@value"/>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./name"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<!-- Not Present or Not Populated so ERROR -->
							<tr>
								<td style="color:#900000">
									<xsl:text>ERROR:  parameter/name is mandatory but is not present or not populated correctly in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="."/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
					
					<!-- Fhir Resource Rule  A parameter must have one and only one of (type, path, value)  -->
					<xsl:choose>
						<xsl:when test="(count(./part/name[@value='type']) =1) and (count(./part/name[@value='path']) =1) and (count(./part/name[@value='value']) =1)">
							<tr>
								<td style="color:#008000">
									<xsl:text>PASS:  A parameter must have one and only one part of each of (type, path, value)'</xsl:text>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="."/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<!-- Not Present or too many so ERROR -->
							<tr>
								<td style="color:#900000">
									<xsl:text>ERROR:  A parameter must have one and only one part of each of (type, path, value) in xpath'</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./part[1]"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
					
					
					
					<!-- Check contents of parameter parts --> <!-- type = replaces -->
					<xsl:choose>
						<xsl:when test="./part/name[@value='type']/../valueCode/@value = 'replace' ">
							<tr>
								<td style="color:#008000">
									<xsl:text>PASS: The 'type' parameter part must have a valueCode of 'replace' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./part[1]"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td style="color:#900000">
									<xsl:text>ERROR:   The 'type' parameter part has an invalid valueCode of '</xsl:text>
									<xsl:value-of select="./part/name[@value='type']/../valueCode/@value"/>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./part[1]"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
					
					<!-- path = DocumentReference.status  -->
					<xsl:choose>
						<xsl:when test="./part/name[@value='path']/../valueString/@value = 'DocumentReference.status' ">
							<tr>
								<td style="color:#008000">
									<xsl:text>PASS: The 'path' parameter part must have a valueString of 'DocumentReference.status' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./part[1]"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td style="color:#900000">
									<xsl:text>ERROR:   The 'path' parameter part has an invalid valueString of '</xsl:text>
									<xsl:value-of select="./part/name[@value='path']/../valueString/@value"/>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./part[1]"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
					
					<!--  value = entered-in-error   -->
					<xsl:choose>
						<xsl:when test="./part/name[@value='value']/../valueString/@value = 'entered-in-error' ">
							<tr>
								<td style="color:#008000">
									<!--<xsl:text>PASS: The 'value' parameter part must have a valueString of 'entered-in-error' in xpath '</xsl:text>-->
									<xsl:text>PASS: The 'value' parameter part must have a valid valueString in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./part[1]"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td style="color:#900000">
									<xsl:text>ERROR:   The 'value' parameter part has an invalid valueString of '</xsl:text>
									<xsl:value-of select="./part/name[@value='value']/../valueString/@value"/>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./part[1]"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
					
					
					
				</xsl:for-each>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	
	<!-- <xsl:template name="Mandatory_Resource_And_Reference">
		<xsl:param name="Param_Field_Name"/>
	
		<xsl:param name="Param_Resource_Path"/>
		
		<xsl:param name="Param_URL_Value"/>
		
		<xsl:variable name="param_url_length" select="string-length($Param_URL_Value)"/>
		<xsl:choose>
			<xsl:when test="(count(./subject) &gt; 1)">
				<tr>
					<td style="color:#900000">
						<xsl:text>ERROR:  No more than one DocumentReference </xsl:text>
						<xsl:value-of select="$Param_Field_Name"/>
						<xsl:text> can be present. Here there are '</xsl:text>
						<xsl:value-of select="count($Param_Resource_Path)"/>
						<xsl:text>' in xpath '</xsl:text>
						<xsl:call-template name="plotPath">
							<xsl:with-param name="forNode" select=".[1]"/>
						</xsl:call-template>
						<xsl:text>'.</xsl:text>
					</td>
				</tr>
			</xsl:when>
			<xsl:when test="(count($Param_Resource_Path) = 1)">
				<tr>
					<td style="color:#008000">
						<xsl:text>PASS:  Mandatory DocumentReference </xsl:text>
						<xsl:value-of select="$Param_Field_Name"/>
						<xsl:text> is present in xpath '</xsl:text>
						<xsl:call-template name="plotPath">
							<xsl:with-param name="forNode" select="."/>
						</xsl:call-template>
						<xsl:text>'.</xsl:text>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td style="color:#900000">
						<xsl:text>ERROR:   DocumentReference </xsl:text>
						<xsl:value-of select="$Param_Field_Name"/>
						<xsl:text> is mandatory  in xpath '</xsl:text>
						<xsl:call-template name="plotPath">
							<xsl:with-param name="forNode" select="."/>
						</xsl:call-template>
						<xsl:text>'.</xsl:text>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="$Param_Resource_Path">
			<xsl:choose>
				<xsl:when test="(count(./reference) &gt; 1)">
					<tr>
						<td style="color:#900000">
							<xsl:text>ERROR:  No more than one DocumentReference </xsl:text>
							<xsl:value-of select="$Param_Field_Name"/>
							<xsl:text>/Reference can be present. Here there are '</xsl:text>
							<xsl:value-of select="count(./reference)"/>
							<xsl:text>' References in xpath '</xsl:text>
							<xsl:call-template name="plotPath">
								<xsl:with-param name="forNode" select="./reference[1]"/>
							</xsl:call-template>
							<xsl:text>'.</xsl:text>
						</td>
					</tr>
				</xsl:when>
				<xsl:when test="((count(./reference) = 1) and (string-length(./reference/@value) &gt; 0) and ($Param_URL_Value = 'No')) ">
					<tr>
						<td style="color:#008000">
							<xsl:text>PASS:  Mandatory DocumentReference</xsl:text>
							<xsl:value-of select="$Param_Field_Name"/>
							<xsl:text>/Reference is present with value '</xsl:text>
							<xsl:value-of select="./reference/@value"/>
							<xsl:text>' in xpath '</xsl:text>
							<xsl:call-template name="plotPath">
								<xsl:with-param name="forNode" select="./reference"/>
							</xsl:call-template>
							<xsl:text>'.</xsl:text>
						</td>
					</tr>
				</xsl:when>
				<xsl:when test="((count(./reference) = 1) and (string-length(./reference/@value) &gt; 0) and ($Param_URL_Value = substring(./reference/@value,1,$param_url_length))) ">
					<tr>
						<td style="color:#008000">
							<xsl:text>PASS:  Mandatory DocumentReference</xsl:text>
							<xsl:value-of select="$Param_Field_Name"/>
							<xsl:text>/Reference is present with expected value of '</xsl:text>
							<xsl:value-of select="./reference/@value"/>
							<xsl:text>' in xpath '</xsl:text>
							<xsl:call-template name="plotPath">
								<xsl:with-param name="forNode" select="./reference"/>
							</xsl:call-template>
							<xsl:text>'.</xsl:text>
						</td>
					</tr>
				</xsl:when>
				<xsl:when test="((count(./reference) = 1) and (string-length(./reference/@value) &gt; 0) and ($Param_URL_Value != substring(./reference/@value,1,$param_url_length))) ">
					<tr>
						<td style="color:#900000">
							<xsl:text>ERROR:  Mandatory DocumentReference</xsl:text>
							<xsl:value-of select="$Param_Field_Name"/>
							<xsl:text>/Reference is present but value of '</xsl:text>
							<xsl:value-of select="./reference/@value"/>
							<xsl:text>' is not as expected in xpath '</xsl:text>
							<xsl:call-template name="plotPath">
								<xsl:with-param name="forNode" select="./reference"/>
							</xsl:call-template>
							<xsl:text>'. Expected value starts with </xsl:text>
							<xsl:value-of select="$Param_URL_Value"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td style="color:#900000">
							<xsl:text>ERROR:   DocumentReference </xsl:text>
							<xsl:value-of select="$Param_Field_Name"/>
							<xsl:text>/Reference is mandatory in xpath '</xsl:text>
							<xsl:call-template name="plotPath">
								<xsl:with-param name="forNode" select="."/>
							</xsl:call-template>
							<xsl:text>'.</xsl:text>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template> -->
	<xsl:include href="FHIR_Generic_Get_Xpath_v1.0.xslt"/>
</xsl:stylesheet>
