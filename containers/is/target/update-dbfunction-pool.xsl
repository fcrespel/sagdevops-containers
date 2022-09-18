<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="poolAlias" />

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="record/node()[@name='connPoolAlias']">
        <value name="connPoolAlias"><xsl:value-of select="$poolAlias"/></value>
    </xsl:template>

</xsl:stylesheet>
