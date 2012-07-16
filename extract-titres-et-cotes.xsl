<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="text" omit-xml-declaration="yes"/>
  <xsl:template match="/">"NumNotice"#"Titre"#"Cote";

<xsl:for-each select="//Ex">"<xsl:value-of select="normalize-space(../@NumNot)"/>"#"<xsl:value-of select="normalize-space(../Tit1)"/>"#"<xsl:value-of select="normalize-space(Cote)"/>"
</xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
