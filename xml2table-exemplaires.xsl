<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="/">
  <html>
    <head><title>Notices Passiflores</title></head>
    <body>
      <table border="1">
        <tr valign="top">
          <th>N° Biblio</th>
          <th>Titre</th>
          <th>Auteur(s)</th>
          <th>Editeur - Collection</th>
          <th>Date de publication</th>
          <th>ISBN</th>
          <th>Description</th>
          <th>Sujet</th>
          <th>Cote</th>
          <th>N° d'inventaire</th>
          <th>Code-barres</th>
          <th>Nb d'exemplaires</th>
          <th>N° Aleph</th>
          <th style="font-weight: bold; color: #ff0000;">Désherbage ?</th>
          <th style="font-weight: bold; color: #ff0000;">PPN</th>
          <th>PPN 1</th>
          <th>PPN 2</th>
          <th>PPN 3</th>
          <th>OCN 1</th>
          <th>OCN 2</th>
          <th>OCN 3</th>
          <th>PPN 4</th>
          <th>PPN 5</th>
          <th>PPN 6</th>
          <th>PPN 7</th>
          <th>PPN 8</th>
          <th>PPN 9</th>
          <th>PPN 10</th>
          <th>PPN 11</th>
          <th>PPN 12</th>
          <th>PPN 13</th>
          <th>OCN 4</th>
          <th>OCN 5</th>
          <th>OCN 6</th>
          <th>OCN 7</th>
          <th>OCN 8</th>
        </tr>
        <xsl:for-each select="//Ex"><xsl:call-template name="exemplaire"/></xsl:for-each>
      </table>
    </body>
  </html>
  </xsl:template>
  
<xsl:template name="exemplaire">
<xsl:variable name="title"><xsl:value-of select="normalize-space(../Tit1)"/><xsl:if test="../Tit2"><xsl:text> : </xsl:text><xsl:value-of select="normalize-space(../Tit2)"/></xsl:if></xsl:variable>
<xsl:variable name="author">
      <xsl:choose>
                <xsl:when test="../MenResp"><xsl:value-of select="normalize-space(../MenResp)"/></xsl:when>
                <xsl:otherwise>
                    <xsl:if test="../Aut21">
                    <xsl:value-of select="normalize-space(../Aut21)"/>
                    <xsl:if test="../Aut22">, <xsl:value-of select="normalize-space(../Aut22)"/></xsl:if>
                    <xsl:if test="../AutIC">, <xsl:value-of select="normalize-space(../AutIC)"/></xsl:if>
                    </xsl:if>
                    <xsl:if test="../Aut1">
                    <xsl:value-of select="normalize-space(../Aut1)"/>
                            <xsl:if test="../AutS1">, <xsl:value-of select="normalize-space(../AutS1)"/></xsl:if>
                            <xsl:if test="../AutS2">, <xsl:value-of select="normalize-space(../AutS2)"/></xsl:if>
                    </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
</xsl:variable>
<xsl:variable name="publisher">
  <xsl:value-of select="../Edi1[1]/Edi"/>
  <xsl:if test="../Edi2"> - <xsl:value-of select="../Edi2[1]/Edi"/></xsl:if>
  <xsl:if test="../Edi3"> - <xsl:value-of select="../Edi3[1]/Edi"/></xsl:if>
  <xsl:if test="../Col"> (<xsl:value-of select="../Col"/><xsl:if test="../IssnCol"> - <xsl:value-of select="../IssnCol"/></xsl:if>)</xsl:if>
</xsl:variable>
<xsl:variable name="pdate">
  <xsl:value-of select="../Edi1[1]/Dat"/>
</xsl:variable>
<xsl:variable name="desc">
<xsl:if test="../Notes"><xsl:value-of select="../Notes"/></xsl:if>
</xsl:variable>
<xsl:variable name="sujet">
  <xsl:choose>
    <xsl:when test="../Mcl"><xsl:for-each select="../Mcl">
      <xsl:if test="position() != 1">, </xsl:if><xsl:value-of select="."/>
    </xsl:for-each></xsl:when>
    <xsl:otherwise>
      <xsl:if test="../*//subject"><xsl:for-each select=".//subject">
      <xsl:if test="position() != 1">, </xsl:if><xsl:value-of select="."/></xsl:for-each></xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<tr valign="top">
<td><a><xsl:attribute name="href"><xsl:value-of select="concat('http://www.unice.fr/cgi-bin/passiflores/client.cgi?NumNot=', ../@NumNot, '-O&amp;FMT=GEN')"/></xsl:attribute><xsl:value-of select="../@NumNot"/></a></td>
<td><xsl:value-of select="$title"/></td>
<td><xsl:value-of select="$author"/></td>
<td><xsl:value-of select="$publisher"/></td>
<td><xsl:value-of select="$pdate"/></td>
<td><span style="font-size: 0.9em;"><xsl:value-of select="../IsbnPropre"/></span></td>
<td><xsl:value-of select="$desc"/></td>
<td><span style="font-size: 0.9em;"><xsl:value-of select="$sujet"/></span></td>
<td><strong><xsl:value-of select="Cote"/></strong></td>
<td><xsl:value-of select="NumInv"/></td>
<td><xsl:value-of select="CB"/></td>
<td><xsl:value-of select="count(../Ex)"/></td>
<td>
  <xsl:for-each select="../aleph">
    <xsl:if test="position() != 1">, </xsl:if>
    <strong>
    <xsl:choose>
      <xsl:when test="contains(no, '$$')"><xsl:value-of select="substring-before(no, '$$')"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="no"/></xsl:otherwise>
    </xsl:choose>
</strong>
- PPN <xsl:value-of select="@ppn"/>
     (<xsl:value-of select="nb_items"/>) - <xsl:for-each select="loc"><xsl:if test="position() != 1"> ## </xsl:if><xsl:value-of select="."/></xsl:for-each> -- // 
      <xsl:choose>
        <xsl:when test=".//last_return= ''"><u>jamais emprunté</u> (ou non empruntable)</xsl:when>
        <xsl:otherwise><u>Dernier retour :</u><xsl:text> </xsl:text><xsl:for-each select=".//last_return"><xsl:if test="position() != 1">, </xsl:if><xsl:value-of select="."/></xsl:for-each></xsl:otherwise>
      </xsl:choose>
     
  </xsl:for-each>
</td>

<td></td>

<td style="color: #ff0000;">
  <xsl:choose>
    <xsl:when test="count(../aleph) = 1"><xsl:value-of select="../aleph/@ppn"/></xsl:when>
    <xsl:when test="count(../ppn) = 1"><xsl:value-of select="../ppn/no"/></xsl:when>
    <xsl:otherwise/>
  </xsl:choose>
</td>

<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[1]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[2]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[3]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="../ocn[1]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="../ocn[2]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="../ocn[3]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[4]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[5]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[6]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[7]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[8]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[9]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[10]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[11]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[12]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="../ppn[13]"/></xsl:with-param>
  </xsl:call-template>
</td>


<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="../ocn[4]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="../ocn[5]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="../ocn[6]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="../ocn[7]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="../ocn[8]"/></xsl:with-param>
  </xsl:call-template>
</td>


</tr>
</xsl:template>

<xsl:template name="ppn">
<xsl:param name="value"/>
<xsl:if test="$value != ''">
<a><xsl:attribute name="href"><xsl:value-of select="concat('http://www.sudoc.abes.fr/', $value//no)"/></xsl:attribute>
  <strong><xsl:value-of select="$value//no"/></strong>
  (<xsl:value-of select="$value//nb_libraries"/>)
  <xsl:if test="$value//@ocn"> [<xsl:value-of select="$value//@ocn"/>]</xsl:if>
  </a>
</xsl:if>
</xsl:template>

<xsl:template name="ocn">
<xsl:param name="value"/>
<xsl:if test="$value != ''">
<xsl:variable name="ocn"><xsl:value-of select="concat('http://www.worldcat.org/oclc/', $value//no)"/></xsl:variable>
<a href="{$ocn}">
  <xsl:value-of select="$value"/>
  </a>
  </xsl:if>
</xsl:template>  
  
  
<xsl:template name="livre">
<xsl:variable name="title"><xsl:value-of select="normalize-space(Tit1)"/><xsl:if test="Tit2"><xsl:text> : </xsl:text><xsl:value-of select="normalize-space(Tit2)"/></xsl:if></xsl:variable>
<xsl:variable name="author">
      <xsl:choose>
                <xsl:when test="MenResp"><xsl:value-of select="normalize-space(MenResp)"/></xsl:when>
                <xsl:otherwise>
                    <xsl:if test="Aut21">
                    <xsl:value-of select="normalize-space(Aut21)"/>
                    <xsl:if test="Aut22">, <xsl:value-of select="normalize-space(Aut22)"/></xsl:if>
                    <xsl:if test="AutIC">, <xsl:value-of select="normalize-space(AutIC)"/></xsl:if>
                    </xsl:if>
                    <xsl:if test="Aut1">
                    <xsl:value-of select="normalize-space(Aut1)"/>
                            <xsl:if test="AutS1">, <xsl:value-of select="normalize-space(AutS1)"/></xsl:if>
                            <xsl:if test="AutS2">, <xsl:value-of select="normalize-space(AutS2)"/></xsl:if>
                    </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
</xsl:variable>
<xsl:variable name="publisher">
  <xsl:value-of select="Edi1[1]/Edi"/>
  <xsl:if test="Edi2"> - <xsl:value-of select="Edi2[1]/Edi"/></xsl:if>
  <xsl:if test="Edi3"> - <xsl:value-of select="Edi3[1]/Edi"/></xsl:if>
  <xsl:if test="Col"> (<xsl:value-of select="Col"/><xsl:if test="IssnCol"> - <xsl:value-of select="IssnCol"/></xsl:if>)</xsl:if>
</xsl:variable>
<xsl:variable name="pdate">
  <xsl:value-of select="Edi1[1]/Dat"/>
</xsl:variable>
<xsl:variable name="desc">
<xsl:if test="Notes"><xsl:value-of select="Notes"/></xsl:if>
</xsl:variable>
<xsl:variable name="sujet">
  <xsl:choose>
    <xsl:when test="Mcl"><xsl:for-each select="Mcl">
      <xsl:if test="position() != 1">, </xsl:if><xsl:value-of select="."/>
    </xsl:for-each></xsl:when>
    <xsl:otherwise>
      <xsl:if test=".//subject"><xsl:for-each select=".//subject">
      <xsl:if test="position() != 1">, </xsl:if><xsl:value-of select="."/></xsl:for-each></xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<tr valign="top">
<td><a><xsl:attribute name="href"><xsl:value-of select="concat('http://www.unice.fr/cgi-bin/passiflores/client.cgi?NumNot=', @NumNot, '-O&amp;FMT=GEN')"/></xsl:attribute><xsl:value-of select="@NumNot"/></a></td>
<td><xsl:value-of select="$title"/></td>
<td><xsl:value-of select="$author"/></td>
<td><xsl:value-of select="$publisher"/></td>
<td><xsl:value-of select="$pdate"/></td>
<td><xsl:value-of select="IsbnPropre"/></td>
<td><xsl:value-of select="$desc"/></td>
<td><xsl:value-of select="$sujet"/></td>
<td><xsl:value-of select="cote"/></td>
<td>
  <xsl:for-each select="aleph">
    <xsl:if test="position() != 1">, </xsl:if>
    <strong>
    <xsl:choose>
      <xsl:when test="contains(no, '$$')"><xsl:value-of select="substring-before(no, '$$')"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="no"/></xsl:otherwise>
    </xsl:choose>
</strong>
     (<xsl:value-of select="nb_items"/>) - <xsl:for-each select="loc"><xsl:value-of select="."/></xsl:for-each> -- // <u>Dernier retour :</u><xsl:text> </xsl:text><xsl:for-each select=".//last_return"><xsl:if test="position() != 1">, </xsl:if><xsl:value-of select="."/></xsl:for-each>
  </xsl:for-each>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[1]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[2]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[3]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="ocn[1]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="ocn[2]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="ocn[3]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[4]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[5]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[6]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[7]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[8]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[9]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[10]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[11]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[12]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ppn">
    <xsl:with-param name="value"><xsl:copy-of select="ppn[13]"/></xsl:with-param>
  </xsl:call-template>
</td>


<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="ocn[4]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="ocn[5]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="ocn[6]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="ocn[7]"/></xsl:with-param>
  </xsl:call-template>
</td>
<td>
  <xsl:call-template name="ocn">
    <xsl:with-param name="value"><xsl:copy-of select="ocn[8]"/></xsl:with-param>
  </xsl:call-template>
</td>


</tr>
</xsl:template>

  
</xsl:stylesheet>
