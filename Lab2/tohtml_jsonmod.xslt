<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <xsl:output version="1.0" encoding="UTF-8" indent="yes" method="html"/>
    <xsl:template match="root">
        <html>
            <h1>Расписание</h1>
            <body>
                <table bgcolor="#CACCCE">
                    <thead>
                    <tr>
                      <th width="200px" bgcolor="#86888A">Понедельник</th>
                      <th width="200px" bgcolor="#86888A">Вторник</th>
                      <th width="200px" bgcolor="#86888A">Среда</th>
                      <th width="200px" bgcolor="#86888A">Четверг</th>
                      <th width="200px" bgcolor="#86888A">Пятница</th>
                      <th width="200px" bgcolor="#86888A">Суббота</th>
                      <th width="200px" bgcolor="#86888A">Воскресенье</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="(//node())[60 >= position()]">
                        <tr>
                            <xsl:variable name="currTime" select="31800+600*position()"/>
                            <xsl:variable name="currTimeAsNum" 
                                select="
                                floor($currTime div 3600)*10000+
                                floor($currTime mod 3600 div 60)*100+
                                $currTime mod 60"/>
                            <xsl:call-template name="fillCells">
                                <xsl:with-param name="DAY" select="'mon'"/>
                                <xsl:with-param name="currTimeAsNum" select="$currTimeAsNum"/>
                            </xsl:call-template>
                            <xsl:call-template name="fillCells">
                                <xsl:with-param name="DAY" select="'tue'"/>
                                <xsl:with-param name="currTimeAsNum" select="$currTimeAsNum"/>
                            </xsl:call-template>
                            <xsl:call-template name="fillCells">
                                <xsl:with-param name="DAY" select="'wed'"/>
                                <xsl:with-param name="currTimeAsNum" select="$currTimeAsNum"/>
                            </xsl:call-template>
                            <xsl:call-template name="fillCells">
                                <xsl:with-param name="DAY" select="'thu'"/>
                                <xsl:with-param name="currTimeAsNum" select="$currTimeAsNum"/>
                            </xsl:call-template>
                            <xsl:call-template name="fillCells">
                                <xsl:with-param name="DAY" select="'fri'"/>
                                <xsl:with-param name="currTimeAsNum" select="$currTimeAsNum"/>
                            </xsl:call-template>
                            <xsl:call-template name="fillCells">
                                <xsl:with-param name="DAY" select="'sat'"/>
                                <xsl:with-param name="currTimeAsNum" select="$currTimeAsNum"/>
                            </xsl:call-template>
                            <xsl:call-template name="fillCells">
                                <xsl:with-param name="DAY" select="'sun'"/>
                                <xsl:with-param name="currTimeAsNum" select="$currTimeAsNum"/>
                            </xsl:call-template>
                        </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="fillCells">
        <xsl:param name="DAY"/>
        <xsl:param name="currTimeAsNum"/>
        <xsl:for-each select="//item[day=$DAY]">
            <xsl:variable name="startAsNum" select="number(translate(start, ':', ''))"/>
            <xsl:variable name="endAsNum" select="number(translate(end, ':', ''))"/>
            <xsl:if test="$startAsNum=$currTimeAsNum">
                <td bgcolor="#89CFEF" rowspan="8">
                    <xsl:value-of select="subject"/><br/>
                    <xsl:value-of select="classroom"/><br/>
                    <xsl:value-of select="start"/>-<xsl:value-of select="end"/>
                </td>
            </xsl:if>
         </xsl:for-each>
         <xsl:if test="count(//item[day=$DAY and number(translate(start, ':', '')) &lt;= $currTimeAsNum and 
            number(translate(end, ':', '')) &gt;= $currTimeAsNum])=0">
            <td bgcolor="#CACCCE"></td>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>