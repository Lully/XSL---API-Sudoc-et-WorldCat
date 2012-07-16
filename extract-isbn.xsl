<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output omit-xml-declaration="yes" indent="no"/>
  <xsl:template match="/"><xsl:for-each select="//Isbn">"<xsl:value-of select="parent::Livre/@NumNot"/>";"<xsl:value-of select="normalize-space(.)"/>"<xsl:text>&#xA;</xsl:text></xsl:for-each></xsl:template>
</xsl:stylesheet>
