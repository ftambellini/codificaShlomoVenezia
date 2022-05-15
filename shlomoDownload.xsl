<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="text" encoding="UTF-8" indent="yes" />
	<xsl:template match="tei:teiHeader" />

	<xsl:template name="main" match="/">
    <xsl:result-document href="#trascrizioneAudio">
        <br /> <br />
        <xsl:apply-templates select="//tei:text[@type='source']/tei:body/tei:div/tei:u" />
    </xsl:result-document>
	</xsl:template>
    <!-- template per output in riga-->
    <xsl:template match="//tei:text[@type='source']/tei:body/tei:div/tei:u">
		<span class="frasi">
		<xsl:attribute name="idF">
        	<xsl:value-of select="@xml:id"/>
    	</xsl:attribute>
		<xsl:value-of select="substring-after(@who, '#')"/>
		<xsl:text>: </xsl:text>
		<xsl:apply-templates/>
		</span>
		<br />
    </xsl:template>
</xsl:stylesheet>
   
