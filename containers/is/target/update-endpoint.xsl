<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="host" />
    <xsl:param name="port" />

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="record[@name='transportInfo']/value[@name='host']/text()"><xsl:value-of select="$host"/></xsl:template>
    <xsl:template match="record[@name='transportInfo']/value[@name='port']/text()"><xsl:value-of select="$port"/></xsl:template>

</xsl:stylesheet>
