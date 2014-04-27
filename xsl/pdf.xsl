<?xml version='1.0'?>
 
<!--
	Copyright 2007 Red Hat, Inc.
	License: GPL
	Author: Jeff Fearn <jfearn@redhat.com>
	Author: Tammy Fox <tfox@redhat.com>
	Author: Andy Fitzsimon <afitzsim@redhat.com>
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY lowercase "'abcdefghijklmnopqrstuvwxyz'">
<!ENTITY uppercase "'ABCDEFGHIJKLMNOPQRSTUVWXYZ'">
 ]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version='1.0'
		xmlns="http://www.w3.org/TR/xhtml1/transitional"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		exclude-result-prefixes="#default">

<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/docbook.xsl"/>
<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/graphics.xsl"/>
<xsl:import href="../../../xsl/pdf.xsl"/>

<xsl:param name="title.color">#23838c</xsl:param>
<xsl:param name="admon.graphics.extension" select="'.svg'"/>

<xsl:attribute-set name="remark.properties">
	<xsl:attribute name="font-style">italic</xsl:attribute>
	<xsl:attribute name="background-color">#ffff00</xsl:attribute>
</xsl:attribute-set>

<xsl:param name="body.font.family">wqy-microhei</xsl:param>
<xsl:param name="monospace.font.family">wqy-microhei</xsl:param>
<xsl:param name="title.font.family">wqy-microhei</xsl:param>
<xsl:param name="dingbat.font.family">wqy-microhei</xsl:param>
<xsl:param name="symbol.font.family">wqy-microhei</xsl:param>
<xsl:param name="sans.font.family">wqy-microhei</xsl:param>


<xsl:template name="front.cover">
  <xsl:call-template name="page.sequence">
    <xsl:with-param name="master-reference">titlepage</xsl:with-param>
    <xsl:with-param name="content">
      <fo:block text-align="center" >
        <fo:external-graphic src="Common_Content/images/EayunOS_Doc_Cover.svg" />
      </fo:block>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>
<xsl:template name="back.cover">
  <xsl:call-template name="page.sequence">
    <xsl:with-param name="master-reference">titlepage</xsl:with-param>
    <xsl:with-param name="content">
      <fo:block text-align="center" >
        <fo:external-graphic src="Common_Content/images/EayunOS_Doc_Back_Cover.svg" />
      </fo:block>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>
<!--段落缩进 -->
<xsl:attribute-set name="normal.para.spacing"/> 
<xsl:param name="body.start.indent">0pt</xsl:param> <!--正文不缩进-->
<xsl:param name="draft.mode" select="'no'"/>

<!--
     针对emphasis标记自定义字体和style。
-->
<xsl:template match="emphasis">
    <fo:inline font-family="Droid Sans" font-weight="bold">
        <xsl:apply-templates/>
    </fo:inline>
</xsl:template>

<xsl:param name="section.autolabel" select="1"/>
<!--更改每个章节的标题样式，比如颜色、字体、大小等-->
<xsl:attribute-set name="chapter.titlepage.recto.style">
        <xsl:attribute name="color">#CCFFCC</xsl:attribute>
        <xsl:attribute name="background-color">white</xsl:attribute>
        <xsl:attribute name="font-size">
                <xsl:choose>
                        <xsl:when test="$l10n.gentext.language = 'ja-JP' or $l10n.gentext.language = 'zh-CN'">
                                <xsl:value-of select="$body.font.master * 1.7"/>
                                <xsl:text>pt</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:text>24pt</xsl:text>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <!--xsl:attribute name="wrap-option">no-wrap</xsl:attribute-->
        <xsl:attribute name="padding-left">1em</xsl:attribute>
        <xsl:attribute name="padding-right">1em</xsl:attribute>
</xsl:attribute-set>
<!--
From: fo/pagesetup.xsl
Reason: Custom Header
Version: 1.72
-->
<xsl:template name="header.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>
	<xsl:param name="title-limit" select="'30'"/>
<!--
  <fo:block>
    <xsl:value-of select="$pageclass"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$sequence"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$position"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$gentext-key"/>
  </fo:block>
body, blank, left, chapter
-->
    <!-- sequence can be odd, even, first, blank -->
    <!-- position can be left, center, right -->
    <xsl:choose>
      <!--xsl:when test="($sequence='blank' and $position='left' and $gentext-key='chapter')">
			<xsl:variable name="text">
				<xsl:call-template name="component.title.nomarkup"/>
			</xsl:variable>
	      <fo:inline keep-together.within-line="always" font-weight="bold">
  			  <xsl:choose>
		  		<xsl:when test="string-length($text) &gt; '33'">
					<xsl:value-of select="concat(substring($text, 0, $title-limit), '...')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$text"/>
				</xsl:otherwise>
			  </xsl:choose>
		  </fo:inline>
      </xsl:when-->
      <xsl:when test="$confidential = 1 and (($sequence='odd' and $position='left') or
                                             ($sequence='even' and $position='right') or
                                             ($sequence='blank' and $position='right') or
                                             ($sequence='first' and $position='left') )">
        <fo:inline keep-together.within-line="always" font-weight="bold">
	  <xsl:value-of select="$confidential.text"/>
	</fo:inline>
      </xsl:when>
	  <xsl:when test="$sequence = 'blank'">
      </xsl:when>
 	  <!-- Extracting 'Chapter' + Chapter Number from the full Chapter title, with a dirty, dirty hack -->
  		<xsl:when test="($sequence='first' and $position='center' and $gentext-key='chapter')">
		<xsl:variable name="text">
			<xsl:call-template name="component.title.nomarkup"/>
		</xsl:variable>
		<xsl:variable name="chapt">
			<xsl:value-of select="substring-before($text, '&#xA0;')"/>
		</xsl:variable>
		<xsl:variable name="remainder">	<xsl:value-of select="substring-after($text, '&#xA0;')"/>
		</xsl:variable>
                  <!--没章节的第一页仅显示“第x章”-->
		<xsl:variable name="chapt-middle"><xsl:value-of select="substring-after($remainder, '&#xA0;')"/>
		</xsl:variable>
		<xsl:variable name="chapt-zhang"><xsl:value-of select="substring-before($chapt-middle, '&#xA0;')"/>
		</xsl:variable>
		<xsl:variable name="chapt-num">
			<xsl:value-of select="substring-before($remainder, '&#xA0;')"/>
		</xsl:variable>
		<xsl:variable name="text1">
			<xsl:value-of select="concat($chapt, '&#xA0;', $chapt-num,'&#xA0;', $chapt-zhang)"/>
		</xsl:variable>
        <fo:inline keep-together.within-line="always" font-weight="bold">
 		  <xsl:value-of select="$text1"/>
		</fo:inline>
      </xsl:when> 
     <!--xsl:when test="($sequence='odd' or $sequence='even') and $position='center'"-->
      <xsl:when test="($sequence='even' and $position='left')">
        <!--xsl:if test="$pageclass != 'titlepage'"-->
	      <fo:inline keep-together.within-line="always" font-weight="bold">
				<xsl:call-template name="component.title.nomarkup"/>
		  </fo:inline>
        <!--xsl:if-->
      </xsl:when>
      <xsl:when test="($sequence='odd' and $position='right')">
        <!--xsl:if test="$pageclass != 'titlepage'"-->
	      <fo:inline keep-together.within-line="always"><fo:retrieve-marker retrieve-class-name="section.head.marker" retrieve-position="first-including-carryover" retrieve-boundary="page-sequence"/></fo:inline>
        <!--/xsl:if-->
      </xsl:when>
	  <xsl:when test="$position='left'">
        <!-- Same for odd, even, empty, and blank sequences -->
        <xsl:call-template name="draft.text"/>
      </xsl:when>
      <xsl:when test="$position='center'">
        <!-- nothing for empty and blank sequences -->
      </xsl:when>
      <xsl:when test="$position='right'">
        <!-- Same for odd, even, empty, and blank sequences -->
        <xsl:call-template name="draft.text"/>
      </xsl:when>
      <xsl:when test="$sequence = 'first'">
        <!-- nothing for first pages -->
      </xsl:when>
      <xsl:when test="$sequence = 'blank'">
        <!-- nothing for blank pages -->
      </xsl:when>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>

