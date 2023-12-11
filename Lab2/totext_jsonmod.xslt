<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <xsl:output version="1.0" encoding="UTF-8" indent="yes" method="text"/>
    
    <xsl:template match="root">
        <xsl:variable name="sortOrder" select="' mon tue wed thu fri sat sun '" />
        <xsl:for-each select="//item[not(day=preceding::item/day)]/day">
            <xsl:sort data-type="number" select="string-length(
                substring-before($sortOrder, concat(' ', self::node(), ' ')))" />
             <xsl:variable name="DAY" select="self::node()"/>
             <xsl:if test="$DAY='mon'">&#xa;Понедельник:&#xa;</xsl:if>
             <xsl:if test="$DAY='tue'">&#xa;Вторник:&#xa;</xsl:if>
             <xsl:if test="$DAY='wed'">&#xa;Среда:&#xa;</xsl:if>
             <xsl:if test="$DAY='thu'">&#xa;Четверг:&#xa;</xsl:if>
             <xsl:if test="$DAY='fri'">&#xa;Пятница:&#xa;</xsl:if>
             <xsl:if test="$DAY='sat'">&#xa;Суббота:&#xa;</xsl:if>
             <xsl:if test="$DAY='sun'">&#xa;Воскресенье:&#xa;</xsl:if>
             <xsl:for-each select="//item[day=$DAY]">
                <xsl:sort select="start"/>
                <xsl:text>&#xa;&#09;</xsl:text>
                <xsl:value-of select="subject"/>
                <xsl:text>&#xa;&#09;&#09;</xsl:text>
                <xsl:value-of select="concat('Аудитория: ', classroom)"/>
                <xsl:text>&#xa;&#09;&#09;</xsl:text>
                <xsl:value-of select="concat('Преподаватель: ', instructor)"/>
                <xsl:text>&#xa;&#09;&#09;</xsl:text>
                <xsl:value-of select="concat(start, '-', end)"/>
                <xsl:text>&#xa;&#09;&#09;</xsl:text>
                <xsl:if test="type='lecture'">Лекция</xsl:if>
                <xsl:if test="type='seminar'">Семинар</xsl:if>
                <xsl:text>&#xa;</xsl:text>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>