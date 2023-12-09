<?xml version="1.0"?>
<xs:stylesheet version="1.0" xmlns:xs="http://www.w3.org/1999/XSL/Transform">
    <xs:param name="cssPath" />
    <xs:template xmlns:ns="http://github.com/olivi-r/characters/raw/main/schema.xsd" match="/ns:player">
        <xs:variable name="playerLevel" select="sum(ns:classlist/ns:class/@level)" />
        <xs:variable name="proficiencyBonus" select="floor(($playerLevel - 1) div 4) + 2" />
        <xs:variable name="str" select="floor(ns:ability/ns:str div 2) - 5" />
        <xs:variable name="dex" select="floor(ns:ability/ns:dex div 2) - 5" />
        <xs:variable name="con" select="floor(ns:ability/ns:con div 2) - 5" />
        <xs:variable name="int" select="floor(ns:ability/ns:int div 2) - 5" />
        <xs:variable name="wis" select="floor(ns:ability/ns:wis div 2) - 5" />
        <xs:variable name="cha" select="floor(ns:ability/ns:cha div 2) - 5" />
        <xs:variable name="strSave">
            <xs:choose>
                <xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' str ')]">
                    <xs:value-of select="$str + $proficiencyBonus" />
                </xs:when>
                <xs:otherwise>
                    <xs:copy-of select="$str" />
                </xs:otherwise>
            </xs:choose>
        </xs:variable>
        <xs:variable name="dexSave">
            <xs:choose>
                <xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' dex ')]">
                    <xs:copy-of select="$dex + $proficiencyBonus" />
                </xs:when>
                <xs:otherwise>
                    <xs:copy-of select="$dex" />
                </xs:otherwise>
            </xs:choose>
        </xs:variable>
        <xs:variable name="conSave">
            <xs:choose>
                <xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' con ')]">
                    <xs:copy-of select="$con + $proficiencyBonus" />
                </xs:when>
                <xs:otherwise>
                    <xs:copy-of select="$con" />
                </xs:otherwise>
            </xs:choose>
        </xs:variable>
        <xs:variable name="intSave">
            <xs:choose>
                <xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' int ')]">
                    <xs:copy-of select="$int + $proficiencyBonus" />
                </xs:when>
                <xs:otherwise>
                    <xs:copy-of select="$int" />
                </xs:otherwise>
            </xs:choose>
        </xs:variable>
        <xs:variable name="wisSave">
            <xs:choose>
                <xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' wis ')]">
                    <xs:copy-of select="$wis + $proficiencyBonus" />
                </xs:when>
                <xs:otherwise>
                    <xs:copy-of select="$wis" />
                </xs:otherwise>
            </xs:choose>
        </xs:variable>
        <xs:variable name="chaSave">
            <xs:choose>
                <xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' cha ')]">
                    <xs:copy-of select="$cha + $proficiencyBonus" />
                </xs:when>
                <xs:otherwise>
                    <xs:copy-of select="$cha" />
                </xs:otherwise>
            </xs:choose>
        </xs:variable>
        <html lang="en">
            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <style></style>
                <title>Character Sheet</title>
            </head>
            <body>
                <div class="character-sheet">
                    <div class="header">
                        <h1>
                            <xs:value-of select="ns:details/ns:name" />
                        </h1>
                    </div>

                    <div class="main-content">
                        <div class="column">
                            <div class="box">
                                <div class="stats">
                                    <div class="stat">
                                        <h3>Strength</h3>
                                        <div class="stat-mod">
                                            <xs:value-of select="floor(ns:ability/ns:str div 2) - 5" />
                                        </div>
                                        <div class="base-stat">
                                            <xs:value-of select="ns:ability/ns:str" />
                                        </div>
                                    </div>
                                    <div class="stat">
                                        <h3>Dexterity</h3>
                                        <div class="stat-mod">
                                            <xs:value-of select="floor(ns:ability/ns:dex div 2) - 5" />
                                        </div>
                                        <div class="base-stat">
                                            <xs:value-of select="ns:ability/ns:dex" />
                                        </div>
                                    </div>
                                    <div class="stat">
                                        <h3>Constitution</h3>
                                        <div class="stat-mod">
                                            <xs:value-of select="floor(ns:ability/ns:con div 2) - 5" />
                                        </div>
                                        <div class="base-stat">
                                            <xs:value-of select="ns:ability/ns:con" />
                                        </div>
                                    </div>
                                    <div class="stat">
                                        <h3>Intelligence</h3>
                                        <div class="stat-mod">
                                            <xs:value-of select="floor(ns:ability/ns:int div 2) - 5" />
                                        </div>
                                        <div class="base-stat">
                                            <xs:value-of select="ns:ability/ns:int" />
                                        </div>
                                    </div>
                                    <div class="stat">
                                        <h3>Wisdom</h3>
                                        <div class="stat-mod">
                                            <xs:value-of select="floor(ns:ability/ns:wis div 2) - 5" />
                                        </div>
                                        <div class="base-stat">
                                            <xs:value-of select="ns:ability/ns:wis" />
                                        </div>
                                    </div>
                                    <div class="stat">
                                        <h3>Charisma</h3>
                                        <div class="stat-mod">
                                            <xs:value-of select="floor(ns:ability/ns:cha div 2) - 5" />
                                        </div>
                                        <div class="base-stat">
                                            <xs:value-of select="ns:ability/ns:cha" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="column">
                            <div class="box">
                                <h2>Saving Throws</h2>
                                <div class="saves">
                                    <div class="save">
                                        <div class="save-mod">
                                            <xs:value-of select="$strSave" />
                                        </div>
                                        <h3>Strength</h3>
                                    </div>
                                    <div class="save">
                                        <div class="save-mod">
                                            <xs:value-of select="$dexSave" />
                                        </div>
                                        <h3>Dexterity</h3>
                                    </div>
                                    <div class="save">
                                        <div class="save-mod">
                                            <xs:value-of select="$conSave" />
                                        </div>
                                        <h3>Constitution</h3>
                                    </div>
                                    <div class="save">
                                        <div class="save-mod">
                                            <xs:value-of select="$intSave" />
                                        </div>
                                        <h3>Intelligence</h3>
                                    </div>
                                    <div class="save">
                                        <div class="save-mod">
                                            <xs:value-of select="$wisSave" />
                                        </div>
                                        <h3>Wisdom</h3>
                                    </div>
                                    <div class="save">
                                        <div class="save-mod">
                                            <xs:value-of select="$chaSave" />
                                        </div>
                                        <h3>Charisma</h3>
                                    </div>
                                </div>
                            </div>

                            <div class="box">
                                <h2>Skills</h2>
                                <div class="skills">
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$dex" />
                                        </div>
                                        <h3>Acrobatics</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$wis" />
                                        </div>
                                        <h3>Animal Handling</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$int" />
                                        </div>
                                        <h3>Arcana</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$str" />
                                        </div>
                                        <h3>Athletics</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$cha" />
                                        </div>
                                        <h3>Deception</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$int" />
                                        </div>
                                        <h3>History</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$wis" />
                                        </div>
                                        <h3>Insight</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$cha" />
                                        </div>
                                        <h3>Intimidation</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$int" />
                                        </div>
                                        <h3>Investigation</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$wis" />
                                        </div>
                                        <h3>Medicine</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$int" />
                                        </div>
                                        <h3>Nature</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$wis" />
                                        </div>
                                        <h3>Perception</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$cha" />
                                        </div>
                                        <h3>Performance</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$cha" />
                                        </div>
                                        <h3>Persuasion</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$int" />
                                        </div>
                                        <h3>Religion</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$dex" />
                                        </div>
                                        <h3>Sleight of Hand</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$dex" />
                                        </div>
                                        <h3>Stealth</h3>
                                    </div>
                                    <div class="skill">
                                        <div class="skill-mod">
                                            <xs:value-of select="$wis" />
                                        </div>
                                        <h3>Survival</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xs:template>
</xs:stylesheet>