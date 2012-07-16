<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="text" omit-xml-declaration="yes"/>
  <xsl:template match="/">
<xsl:for-each select="//*"><xsl:value-of select="parent::node()/name()"/>/<xsl:value-of select="name()"/><xsl:text>&#xA;</xsl:text></xsl:for-each>
<xsl:for-each select="//@*"><xsl:value-of select="parent::node()/name()"/>/@<xsl:value-of select="name()"/><xsl:text>&#xA;</xsl:text></xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
