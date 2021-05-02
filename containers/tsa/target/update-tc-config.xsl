<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str">

    <xsl:param name="nodes" />

    <xsl:template match="//servers/server">
        <xsl:variable name="server" select="." />
        <xsl:for-each select="str:tokenize($nodes, ',')">
            <server>
                <xsl:attribute name="name"><xsl:value-of select="normalize-space()" /></xsl:attribute>
                <xsl:attribute name="host"><xsl:value-of select="normalize-space()" /></xsl:attribute>
                <xsl:apply-templates select="$server/node()" />
            </server>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
