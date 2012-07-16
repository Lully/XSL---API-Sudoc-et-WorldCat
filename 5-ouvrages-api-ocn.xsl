<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:psi="http://www.oclcpica.org/xml/" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:oclcterms="http://purl.org/oclc/terms/" xmlns:opensearch="http://a9.com/-/spec/opensearch/1.1/" version="2.0">
<xsl:output indent="yes"/>
<xsl:param name="OclcApiKey"/>
  <xsl:template match="/">
    <Livres>
      <xsl:for-each select="//Livre">
        <xsl:choose>
          <xsl:when test="ppn">
            <xsl:copy-of select="."/>
          </xsl:when>
          <xsl:when test="IsbnPropre">
            <xsl:variable name="isbn" select="IsbnPropre"/>
            <xsl:variable name="titre"><xsl:value-of select="normalize-space(Tit1[1])"/><xsl:if test="Tit2"><xsl:text> </xsl:text><xsl:value-of select="normalize-space(Tit2[1])"/></xsl:if></xsl:variable>
            <xsl:variable name="auteur" select="normalize-space(Aut1[1])"/>
            <xsl:variable name="date" select="normalize-space(Edi1[1]/Dat1[1])"/>
            <xsl:variable name="url_isbn" select="concat('http://www.worldcat.org/webservices/catalog/search/opensearch?q=', $isbn, '&amp;wskey=', $OclcApiKey)"/>
            <xsl:variable name="results_file_isbn">
              <xsl:copy-of select="document($url_isbn)//atom:feed"/>
            </xsl:variable>
            <xsl:variable name="ocn">
              <xsl:choose>
                <xsl:when test="count($results_file_isbn//atom:entry) = 1">
                  <ocn>
                    <xsl:value-of select="$results_file_isbn//atom:entry/oclcterms:recordIdentifier"/>
                  </ocn>
                </xsl:when>
                <xsl:when test="count($results_file_isbn//atom:entry) &gt; 0 and count($results_file_isbn//atom:entry) &lt; 9">
                  <xsl:for-each select="$results_file_isbn//atom:entry">
                    <ocn>
                      <xsl:value-of select="oclcterms:recordIdentifier"/>
                    </ocn>
                  </xsl:for-each>
                </xsl:when>
                <xsl:when test="count($results_file_isbn//atom:entry) = 0 ">
                  <xsl:variable name="url_titre" select="concat('http://www.worldcat.org/webservices/catalog/search/opensearch?q=', $titre, '+', $auteur, '+', $date, '&amp;wskey=', $OclcApiKey)"/>
                  <xsl:variable name="results_file_titre">
                    <xsl:copy-of select="document($url_titre)//atom:feed"/>
                  </xsl:variable>
                  <xsl:choose>
                    <xsl:when test="count($results_file_titre//atom:entry) = 1">
                      <ocn>
                        <xsl:value-of select="$results_file_titre//atom:entry/oclcterms:recordIdentifier"/>
                      </ocn>
                    </xsl:when>
                    <xsl:when test="count($results_file_titre//atom:entry) &gt; 0 and count($results_file_titre//atom:entry) &lt; 9">
                      <xsl:for-each select="$results_file_titre//atom:entry">
                        <ocn>
                          <xsl:value-of select="oclcterms:recordIdentifier"/>
                        </ocn>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise/>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise/>
              </xsl:choose>
            </xsl:variable>
            <Livre>
              <xsl:attribute name="NumNot">
                <xsl:value-of select="@NumNot"/>
              </xsl:attribute>
              <xsl:copy-of select="*"/>
              <xsl:copy-of select="$ocn"/>
            </Livre>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="titre"><xsl:value-of select="normalize-space(Tit1[1])"/><xsl:if test="Tit2"><xsl:text> </xsl:text><xsl:value-of select="normalize-space(Tit2[1])"/></xsl:if></xsl:variable>
            <xsl:variable name="auteur" select="normalize-space(Aut1[1])"/>
            <xsl:variable name="date" select="normalize-space(Edi1[1]/Dat1[1])"/>
            <xsl:variable name="url_titre" select="concat('http://www.worldcat.org/webservices/catalog/search/opensearch?q=', $titre, '+', $auteur, '+', $date, '&amp;wskey=', $OclcApiKey)"/>
            <xsl:variable name="results_file_titre">
              <xsl:copy-of select="document($url_titre)//atom:feed"/>
            </xsl:variable>
            <xsl:variable name="ocn">
            <xsl:choose>
              <xsl:when test="count($results_file_titre//atom:entry) = 1">
                <ocn>
                  <xsl:value-of select="$results_file_titre//atom:entry/oclcterms:recordIdentifier"/>
                </ocn>
              </xsl:when>
              <xsl:when test="count($results_file_titre//atom:entry) &gt; 0 and count($results_file_titre//atom:entry) &lt; 9">
                <xsl:for-each select="$results_file_titre//atom:entry">
                  <ocn>
                    <xsl:value-of select="oclcterms:recordIdentifier"/>
                  </ocn>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
            </xsl:variable>
            <Livre>
              <xsl:attribute name="NumNot">
                <xsl:value-of select="@NumNot"/>
              </xsl:attribute>
              <xsl:copy-of select="*"/>
              <xsl:copy-of select="$ocn"/>
            </Livre>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </Livres>
  </xsl:template>
</xsl:stylesheet>
