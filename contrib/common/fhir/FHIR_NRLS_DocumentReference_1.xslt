<?xml version="1.0" encoding="UTF-8"?>
<!-- Validate NRLS-DocumentReference-1 resource details. -->
<!-- STU2 version updated for STU3 - January 2018                                        					    -->
<!-- Updated for 1.2.0-beta API Spec August 2018      Add validation for MasterIdentifier and RelatesTo   -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://hl7.org/fhir">
	<xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<table border="0">
			<xsl:for-each select="/DocumentReference">
				<!-- If masterIdentidier (0..1) is present then SYSTEM and VALUE are mandatory (1..1) -->
				<xsl:choose>
					<xsl:when test="(count(./masterIdentifier)  &gt; 1)">
						<tr>
							<td style="color:#900000">
								<xsl:text>ERROR:  No more than one masterIdentifier can be present. Here there are '</xsl:text>
								<xsl:value-of select="count(./indexed) "/>
								<xsl:text>' in xpath '</xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select=".[1]"/>
								</xsl:call-template>
								<xsl:text>'.</xsl:text>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="(count(./masterIdentifier) =1)">
						<!-- MI is present so test SYSTEM & VALUE -->
						<tr>
							<td style="color:#008000">
								<xsl:text>PASS:  Optional DocumentReference masterIdentifier is present'</xsl:text>
								<xsl:text>' in xpath '</xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="./masterIdentifier"/>
								</xsl:call-template>
								<xsl:text>'.</xsl:text>
							</td>
						</tr>
						<xsl:choose>
							<xsl:when test="((count(./masterIdentifier/system) = 1) and (string-length(./masterIdentifier/system/@value) &gt; 0))">
								<tr>
									<td style="color:#008000">
										<xsl:text>PASS:  masterIdentifier/system is mandatory and is populated with '</xsl:text>
										<xsl:value-of select="./masterIdentifier/system/@value"/>
										<xsl:text>' in xpath '</xsl:text>
										<xsl:call-template name="plotPath">
											<xsl:with-param name="forNode" select="./masterIdentifier/system/@value"/>
										</xsl:call-template>
										<xsl:text>'.</xsl:text>
									</td>
								</tr>
							</xsl:when>
							<xsl:otherwise>
								<!-- Not Present or Not Populated so ERROR -->
								<tr>
									<td style="color:#900000">
										<xsl:text>ERROR:  Mandatory DocumentReference masterIdentifier/system is not present or not populated  in xpath '</xsl:text>
										<xsl:call-template name="plotPath">
											<xsl:with-param name="forNode" select="."/>
										</xsl:call-template>
										<xsl:text>'.</xsl:text>
									</td>
								</tr>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="((count(./masterIdentifier/value) = 1) and (string-length(./masterIdentifier/value/@value) &gt; 0))">
								<tr>
									<td style="color:#008000">
										<xsl:text>PASS:  masterIdentifier/value is mandatory and is populated with '</xsl:text>
										<xsl:value-of select="./masterIdentifier/value/@value"/>
										<xsl:text>' in xpath '</xsl:text>
										<xsl:call-template name="plotPath">
											<xsl:with-param name="forNode" select="./masterIdentifier/value/@value"/>
										</xsl:call-template>
										<xsl:text>'.</xsl:text>
									</td>
								</tr>
							</xsl:when>
							<xsl:otherwise>
								<!-- Not Present or Not Populated so ERROR -->
								<tr>
									<td style="color:#900000">
										<xsl:text>ERROR:  Mandatory DocumentReference masterIdentifier/value is not present or not populated in xpath '</xsl:text>
										<xsl:call-template name="plotPath">
											<xsl:with-param name="forNode" select="./masterIdentifier"/>
										</xsl:call-template>
										<xsl:text>'.</xsl:text>
									</td>
								</tr>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<!-- Optional field not present, do nothing -->
					</xsl:otherwise>
				</xsl:choose>
				
				
				<!-- check  mandatory STATUS is present -->
				<xsl:variable name="status" select="./status/@value"/>
				<xsl:choose>
					<xsl:when test="$status=('current', 'superseded', 'entered-in-error')">
						<tr>
							<td style="color:#008000">
								<xsl:text>PASS:  Mandatory DocumentReference Status is present and valid '</xsl:text>
								<xsl:value-of select="$status"/>
								<xsl:text>' in xpath '</xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="./status"/>
								</xsl:call-template>
								<xsl:text>'.</xsl:text>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td style="color:#900000">
								<xsl:text>ERROR:  Mandatory DocumentReference Status is invalid or not present  '</xsl:text>
								<xsl:value-of select="$status"/>
								<xsl:text>' in xpath '</xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="."/>
								</xsl:call-template>
								<xsl:text>'.</xsl:text>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				
				
				<!-- TYPE is Mandatory (1..1) -->
				<xsl:choose>
					<xsl:when test="(count(./type)=1)">
						<tr>
							<td style="color:#008000">
								<xsl:text>PASS:  Mandatory DocumentReference Type is present '</xsl:text>
								<xsl:text>' in xpath '</xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="./type"/>
								</xsl:call-template>
								<xsl:text>'.</xsl:text>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td style="color:#900000">
								<xsl:text>ERROR:  Mandatory DocumentReference Type (1..1) is invalid or not present  '</xsl:text>
								<xsl:text>' in xpath '</xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="."/>
								</xsl:call-template>
								<xsl:text>'.</xsl:text>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				<!-- currently only one snomed code is expected so test for it CB 19June2018 -->
				<xsl:if test="(count(./type)=1)">
					<xsl:choose>
						<!--	<xsl:when test="(./type/coding/code/@value=736253002)">-->
						<xsl:when test="./type/coding/display/@value=('Mental health crisis plan (record artifact)') and ./type/coding/code/@value=736253002">
							<tr>
								<td style="color:#008000">
									<xsl:text>PASS:  Mandatory DocumentReference Type Coding and Display values are present and correct '</xsl:text>
									<xsl:value-of select="./type/coding/code/@value"/>
									<xsl:text>' and '</xsl:text>
									<xsl:value-of select="./type/coding/display/@value"/>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./type/coding"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td style="color:#900000">
									<xsl:text>ERROR:  Mandatory DocumentReference Type Coding and Display values are not correct  '</xsl:text>
									<xsl:value-of select="./type/coding/code/@value"/>
									<xsl:text>' and '</xsl:text>
									<xsl:value-of select="./type/coding/display/@value"/>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="."/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				
				
				<!-- SUBJECT is Mandatory (1..1) as is SUBJECT/ REFERENCE (1..1)-->
				<xsl:call-template name="Mandatory_Resource_And_Reference">
					<xsl:with-param name="Param_Field_Name" select=" 'Subject' "/>
					<xsl:with-param name="Param_Resource_Path" select="./subject"/>
					<xsl:with-param name="Param_URL_Value" select=" 'https://demographics.spineservices.nhs.uk/STU3/Patient/' "/>
				</xsl:call-template>
				
				
				<!-- INDEXED is mandatory (1..1) and of type instant  -->
				<xsl:choose>
					<xsl:when test="(count(./indexed)  &gt; 1)">
						<tr>
							<td style="color:#900000">
								<xsl:text>ERROR:  No more than one DocumentReference Indexed can be present. Here there are '</xsl:text>
								<xsl:value-of select="count(./indexed) "/>
								<xsl:text>' in xpath '</xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select=".[1]"/>
								</xsl:call-template>
								<xsl:text>'.</xsl:text>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="./indexed/@value castable as xs:dateTime">
						<tr>
							<td style="color:#008000">
								<xsl:text>PASS:  Mandatory DocumentReference Indexed is present and valid '</xsl:text>
								<xsl:value-of select="./indexed/@value"/>
								<xsl:text>' in xpath '</xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="./indexed/@value"/>
								</xsl:call-template>
								<xsl:text>'.</xsl:text>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td style="color:#900000">
								<xsl:text>ERROR:  Mandatory DocumentReference Indexed is invalid or not present  '</xsl:text>
								<xsl:value-of select="./indexed/@value"/>
								<xsl:text>' in xpath '</xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="."/>
								</xsl:call-template>
								<xsl:text>'.</xsl:text>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				
				
				<!-- AUTHOR is Mandatory (1..1) as is Author/ REFERENCE (1..1)-->
				<xsl:call-template name="Mandatory_Resource_And_Reference">
					<xsl:with-param name="Param_Field_Name" select=" 'Author' "/>
					<xsl:with-param name="Param_Resource_Path" select="./author"/>
					<xsl:with-param name="Param_URL_Value" select=" 'https://directory.spineservices.nhs.uk/STU3/Organization/' "/>
				</xsl:call-template>
				
				
				<!-- CUSTODIAN is Mandatory (1..1) as is CUSTODIAN/ REFERENCE (1..1)-->
				<xsl:call-template name="Mandatory_Resource_And_Reference">
					<xsl:with-param name="Param_Field_Name" select=" 'Custodian' "/>
					<xsl:with-param name="Param_Resource_Path" select="./custodian"/>
					<xsl:with-param name="Param_URL_Value" select=" 'https://directory.spineservices.nhs.uk/STU3/Organization/' "/>
				</xsl:call-template>
				
				
				<!-- RELATESTO is optional (0..*) but if present system and value must be populated. -->
				<xsl:for-each select="./relatesTo">
					<xsl:choose>
						<xsl:when test="./code/@value=('replaces')">
							<tr>
								<td style="color:#008000">
									<xsl:text>PASS:  Mandatory DocumentReference RelatesTo Code is present and valid value '</xsl:text>
									<xsl:value-of select="./code/@value"/>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./code/@value"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td style="color:#900000">
									<xsl:text>ERROR:  Mandatory DocumentReference RelatesTo Code is invalid or not present  '</xsl:text>
									<xsl:value-of select="./code/@value"/>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="."/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="((count(./target/identifier/system) = 1) and (string-length(./target/identifier/system/@value) &gt; 0))">
							<tr>
								<td style="color:#008000">
									<xsl:text>PASS:  Mandatory DocumentReference/relatesTo/target/identifier/system is mandatory and is populated with '</xsl:text>
									<xsl:value-of select="./target/identifier/system/@value"/>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./target/identifier/system/@value"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<!-- Not Present or Not Populated so ERROR -->
							<tr>
								<td style="color:#900000">
									<xsl:text>ERROR:  Mandatory DocumentReference relatesTo/target/identifier/system is not present or not populated  in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./target/identifier/system"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="((count(./target/identifier/value) = 1) and (string-length(./target/identifier/value/@value) &gt; 0))">
							<tr>
								<td style="color:#008000">
									<xsl:text>PASS:  Mandatory DocumentReference/relatesTo/target/identifier/value is mandatory and is populated with '</xsl:text>
									<xsl:value-of select="./target/identifier/value/@value"/>
									<xsl:text>' in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./target/identifier/value/@value"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<!-- Not Present or Not Populated so ERROR -->
							<tr>
								<td style="color:#900000">
									<xsl:text>ERROR:  Mandatory DocumentReference relatesTo/target/identifier/system is not present or not populated  in xpath '</xsl:text>
									<xsl:call-template name="plotPath">
										<xsl:with-param name="forNode" select="./target/identifier/value"/>
									</xsl:call-template>
									<xsl:text>'.</xsl:text>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				
				<!-- currently only one realtesTo is expected and processed. (release 1.2.1-beta), so if more are present display a warning  -->
				<xsl:if test="(count(./relatesTo) &gt; 1)">
					<tr>
						<td style="color:#886A08">
							<xsl:text>PASS:  ***WARNING*** More than one relatesTo block is present here. Only the first one will be processed by NRLS</xsl:text>
						</td>
					</tr>
				</xsl:if>
				
				
				<!-- CONTENT (1..*) must be present 	-->
				<xsl:if test="count(./content) = 0">
					<tr>
						<td style="color:#900000">
							<xsl:text>ERROR:  At least one DocumentReference Content must be present. Here there are '</xsl:text>
							<xsl:value-of select="count(./content) "/>
							<xsl:text>' in xpath '</xsl:text>
							<xsl:call-template name="plotPath">
								<xsl:with-param name="forNode" select="."/>
							</xsl:call-template>
							<xsl:text>'.</xsl:text>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="count(./content)  &gt; 0">
					<xsl:for-each select="./content">
						<!-- CONTENT (1..*) ATTACHMENT (1..1) is Mandatory -->
						<xsl:choose>
							<xsl:when test="count(./attachment) &gt; 1">
								<tr>
									<td style="color:#900000">
										<xsl:text>ERROR:  No more than one DocumentReference Content Attachment can be present. Here there are '</xsl:text>
										<xsl:value-of select="count(./attachment) "/>
										<xsl:text>' in xpath '</xsl:text>
										<xsl:call-template name="plotPath">
											<xsl:with-param name="forNode" select="."/>
										</xsl:call-template>
										<xsl:text>'.</xsl:text>
									</td>
								</tr>
							</xsl:when>
							<xsl:otherwise>
								<!-- CONTENT (1..*) ATTACHMENT (1..1) CONTENTTYPE (1..1) is Mandatory -->
								<xsl:choose>
									<xsl:when test="(count(./attachment/contentType)  &gt; 1)">
										<tr>
											<td style="color:#900000">
												<xsl:text>ERROR:  No more than one DocumentReference contentType can be present. Here there are '</xsl:text>
												<xsl:value-of select="count(./attachment/contentType) "/>
												<xsl:text>' in xpath '</xsl:text>
												<xsl:call-template name="plotPath">
													<xsl:with-param name="forNode" select="./attachment/contentType[1]"/>
												</xsl:call-template>
												<xsl:text>'.</xsl:text>
											</td>
										</tr>
									</xsl:when>
									<xsl:when test="((count(./attachment/contentType)=1) and (string-length(./attachment/contentType/@value) &gt; 0)) ">
										<tr>
											<td style="color:#008000">
												<xsl:text>PASS:  Mandatory DocumentReference contentType is present and populated '</xsl:text>
												<xsl:value-of select="./attachment/contentType/@value"/>
												<xsl:text>' in xpath '</xsl:text>
												<xsl:call-template name="plotPath">
													<xsl:with-param name="forNode" select="./attachment/contentType"/>
												</xsl:call-template>
												<xsl:text>'.</xsl:text>
											</td>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td style="color:#900000">
												<xsl:text>ERROR:  Mandatory DocumentReference contentType is invalid or not present  '</xsl:text>
												<xsl:value-of select="./attachment/contentType/@value"/>
												<xsl:text>' in xpath '</xsl:text>
												<xsl:call-template name="plotPath">
													<xsl:with-param name="forNode" select="./attachment"/>
												</xsl:call-template>
												<xsl:text>'.</xsl:text>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
								<!-- CONTENT (1..*) ATTACHMENT (1..1) URL (1..1) is Mandatory -->
								<xsl:choose>
									<xsl:when test="(count(./attachment/url)  &gt; 1)">
										<tr>
											<td style="color:#900000">
												<xsl:text>ERROR:  No more than one DocumentReference content attachment url can be present. Here there are '</xsl:text>
												<xsl:value-of select="count(./attachment/url) "/>
												<xsl:text>' in xpath '</xsl:text>
												<xsl:call-template name="plotPath">
													<xsl:with-param name="forNode" select="./attachment[1]"/>
												</xsl:call-template>
												<xsl:text>'.</xsl:text>
											</td>
										</tr>
									</xsl:when>
									<xsl:when test="((count(./attachment/url)=1) and (string-length(./attachment/url/@value) &gt; 0)) ">
										<tr>
											<td style="color:#008000">
												<xsl:text>PASS:  Mandatory DocumentReference content attachment url is present and populated '</xsl:text>
												<xsl:value-of select="./attachment/url/@value"/>
												<xsl:text>' in xpath '</xsl:text>
												<xsl:call-template name="plotPath">
													<xsl:with-param name="forNode" select="./attachment/url"/>
												</xsl:call-template>
												<xsl:text>'.</xsl:text>
											</td>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td style="color:#900000">
												<xsl:text>ERROR:  Mandatory DocumentReference content attachment url is invalid or not present  '</xsl:text>
												<xsl:value-of select="./attachment/url/@value"/>
												<xsl:text>' in xpath '</xsl:text>
												<xsl:call-template name="plotPath">
													<xsl:with-param name="forNode" select="./attachment"/>
												</xsl:call-template>
												<xsl:text>'.</xsl:text>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
								<!-- CONTENT (1..*) ATTACHMENT (1..1) CREATION (0..1) is Optional but if present MUST be a valid dateTime -->
								<xsl:if test="(./attachment/creation)">
									<xsl:choose>
										<xsl:when test="./attachment/creation/@value castable as xs:dateTime">
											<tr>
												<td style="color:#008000">
													<xsl:text>PASS:  Optional DocumentReference content attachment creation is present and populated with valid value '</xsl:text>
													<xsl:value-of select="./attachment/creation/@value"/>
													<xsl:text>' in xpath '</xsl:text>
													<xsl:call-template name="plotPath">
														<xsl:with-param name="forNode" select="./attachment/creation"/>
													</xsl:call-template>
													<xsl:text>'.</xsl:text>
												</td>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td style="color:#900000">
													<xsl:text>ERROR:  Optional DocumentReference content attachment creation is present but populated with invalid value  '</xsl:text>
													<xsl:value-of select="./attachment/creation/@value"/>
													<xsl:text>' in xpath '</xsl:text>
													<xsl:call-template name="plotPath">
														<xsl:with-param name="forNode" select="./attachment/creation"/>
													</xsl:call-template>
													<xsl:text>'.</xsl:text>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
								<!-- If present creation date must not be in the future -->
								<xsl:if test="./attachment/creation/@value castable as xs:dateTime">
									<xsl:variable name="creation_date" select="substring(./attachment/creation/@value,1,10)"/>
									<xsl:variable name="current_date" select="substring(string(current-date()),1,10)"/>
									<xsl:if test="$creation_date &gt; $current_date">
										<tr>
											<td style="color:#900000">
												<xsl:text>ERROR:  Optional DocumentReference content attachment creation date '</xsl:text>
												<xsl:value-of select="./attachment/creation/@value"/>
												<xsl:text>' in xpath '</xsl:text>
												<xsl:call-template name="plotPath">
													<xsl:with-param name="forNode" select="./attachment/creation"/>
												</xsl:call-template>
												<xsl:text>' is more recent than current system date '</xsl:text>
												<xsl:value-of select="$current_date"/>
												<xsl:text>'</xsl:text>
											</td>
										</tr>
									</xsl:if>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				
				
				<!-- Cross Field Validation - If RELATESTO is present then MasterIdentifier MUST ALSO be present -->
				<xsl:choose>
					<xsl:when test="(count(./masterIdentifier) =0) and (count(./relatesTo) !=0) ">
						<tr>
							<td style="color:#900000">
								<xsl:text>ERROR:  When relatesTo is present then masterIdentifier must also be present. There are '</xsl:text>
								<xsl:value-of select="count(./relatesTo)"/>
								<xsl:text>' relatesTo in xpath '</xsl:text>
								<xsl:call-template name="plotPath">
									<xsl:with-param name="forNode" select="."/>
								</xsl:call-template>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td style="color:#008000">
								<xsl:text>PASS:  When relatesTo is present then masterIdentifier must also be present.</xsl:text>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				
				
			</xsl:for-each>
		</table>
	</xsl:template>
	
	
	<xsl:template name="Mandatory_Resource_And_Reference">
		<xsl:param name="Param_Field_Name"/>
		<!-- Name of the Field to be validated -->
		<xsl:param name="Param_Resource_Path"/>
		<!-- Path of the resource -->
		<xsl:param name="Param_URL_Value"/>
		<!--  Value of URL expected in resource ("No" if not known") -->
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
	</xsl:template>
	<xsl:include href="FHIR_Generic_Get_Xpath_v1.0.xslt"/>
</xsl:stylesheet>
