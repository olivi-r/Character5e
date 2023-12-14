<?xml version="1.0"?>
<xs:stylesheet version="1.0" xmlns:xs="http://www.w3.org/1999/XSL/Transform">

	<!-- Character stats -->
	<xs:variable name="characterLevel" select="sum(/character/classes/class/@level)" />
	<xs:variable name="proficiencyBonus" select="floor(($characterLevel - 1) div 4) + 2" />
	<xs:variable name="jackOfAllTradesBonus" select="floor($proficiencyBonus div 2)" />
	<xs:variable name="baseStr" select="/character/ability/str" />
	<xs:variable name="baseDex" select="/character/ability/dex" />
	<xs:variable name="baseCon" select="/character/ability/con" />
	<xs:variable name="baseInt" select="/character/ability/int" />
	<xs:variable name="baseWis" select="/character/ability/wis" />
	<xs:variable name="baseCha" select="/character/ability/cha" />
	<xs:variable name="str" select="floor($baseStr div 2) - 5" />
	<xs:variable name="dex" select="floor($baseDex div 2) - 5" />
	<xs:variable name="con" select="floor($baseCon div 2) - 5" />
	<xs:variable name="int" select="floor($baseInt div 2) - 5" />
	<xs:variable name="wis" select="floor($baseWis div 2) - 5" />
	<xs:variable name="cha" select="floor($baseCha div 2) - 5" />

	<!-- Saving throw modifiers -->
	<xs:variable name="strSave">
		<xs:choose>
			<xs:when test="/character/ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' str ')]">
				<xs:value-of select="$str + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$str" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>
	<xs:variable name="dexSave">
		<xs:choose>
			<xs:when test="/character/ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' dex ')]">
				<xs:value-of select="$dex + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$dex" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>
	<xs:variable name="conSave">
		<xs:choose>
			<xs:when test="/character/ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' con ')]">
				<xs:value-of select="$con + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$con" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>
	<xs:variable name="intSave">
		<xs:choose>
			<xs:when test="/character/ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' int ')]">
				<xs:value-of select="$int + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$int" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>
	<xs:variable name="wisSave">
		<xs:choose>
			<xs:when test="/character/ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' wis ')]">
				<xs:value-of select="$wis + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$wis" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>
	<xs:variable name="chaSave">
		<xs:choose>
			<xs:when test="/character/ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' cha ')]">
				<xs:value-of select="$cha + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$cha" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>

	<!-- Skill modifier template -->
	<xs:template name="skillMod">
		<xs:param name="skill" />
		<xs:param name="baseMod" />
		<xs:choose>
			<xs:when test="$skill[@proficient='1' or @proficient='true']">
				<xs:choose>
					<xs:when test="$skill[@expertise='1' or @expertise='true']">
						<xs:value-of select="$proficiencyBonus * 2 + $baseMod" />
					</xs:when>
					<xs:otherwise>
						<xs:value-of select="$proficiencyBonus + $baseMod" />
					</xs:otherwise>
				</xs:choose>
			</xs:when>
			<xs:otherwise>
				<xs:choose>
					<xs:when test="/character/skills[@jack-of-all-trades='1' or @jack-of-all-trades='true']">
						<xs:value-of select="$jackOfAllTradesBonus + $baseMod" />
					</xs:when>
					<xs:otherwise>
						<xs:value-of select="$baseMod" />
					</xs:otherwise>
				</xs:choose>
			</xs:otherwise>
		</xs:choose>
	</xs:template>

	<!-- Skill tip template -->
	<xs:template name="skillTip">
		<xs:param name="skill" />
		<xs:choose>
			<xs:when test="$skill[@proficient='1' or @proficient='true']">
				<xs:text> + </xs:text>
				<xs:value-of select="$proficiencyBonus" />
				<xs:choose>
					<xs:when test="$skill[@expertise='1' or @expertise='true']">
						<xs:text> * 2 (proficiency &amp; expertise)</xs:text>
					</xs:when>
					<xs:otherwise>
						<xs:text> (proficiency)</xs:text>
					</xs:otherwise>
				</xs:choose>
			</xs:when>
			<xs:otherwise>
				<xs:if test="/character/skills[@jack-of-all-trades='1' or @jack-of-all-trades='true']">
					<xs:text> + </xs:text>
						<xs:value-of select="$jackOfAllTradesBonus"></xs:value-of>
						<xs:text> (jack of all trades)</xs:text>
				</xs:if>
			</xs:otherwise>
		</xs:choose>
	</xs:template>

	<!-- Calculate skill modifiers -->
	<xs:variable name="acrobatics">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/acrobatics" />
			<xs:with-param name="baseMod" select="$dex" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="acrobaticsTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/acrobatics" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="animalHandling">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/animal-handling" />
			<xs:with-param name="baseMod" select="$wis" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="animalHandlingTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/anima-handling" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="arcana">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/arcana" />
			<xs:with-param name="baseMod" select="$int" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="arcanaTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/arcana" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="athletics">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/athletics" />
			<xs:with-param name="baseMod" select="$str" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="athleticsTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/athletics" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="deception">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/deception" />
			<xs:with-param name="baseMod" select="$cha" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="deceptionTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/deception" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="history">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/history" />
			<xs:with-param name="baseMod" select="$int" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="historyTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/history" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="insight">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/insight" />
			<xs:with-param name="baseMod" select="$wis" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="insightTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/insight" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="intimidation">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/intimidation" />
			<xs:with-param name="baseMod" select="$cha" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="intimidationTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/intimidation" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="investigation">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/investigation" />
			<xs:with-param name="baseMod" select="$int" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="investigationTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/investigation" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="medicine">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/medicine" />
			<xs:with-param name="baseMod" select="$wis" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="medicineTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/medicine" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="nature">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/nature" />
			<xs:with-param name="baseMod" select="$int" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="natureTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/nature" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="perception">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/perception" />
			<xs:with-param name="baseMod" select="$wis" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="perceptionTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/perception" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="performance">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/performance" />
			<xs:with-param name="baseMod" select="$cha" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="performanceTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/performance" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="persuasion">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/persuasion" />
			<xs:with-param name="baseMod" select="$cha" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="persuasionTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/persuasion" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="religion">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/religion" />
			<xs:with-param name="baseMod" select="$int" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="religionTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/religion" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="sleightOfHand">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/sleight-of-hand" />
			<xs:with-param name="baseMod" select="$dex" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="sleightOfHandTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/sleight-of-hand" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="stealth">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/stealth" />
			<xs:with-param name="baseMod" select="$dex" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="stealthTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/stealth" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="survival">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="/character/skills/survival" />
			<xs:with-param name="baseMod" select="$wis" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="survivalTip">
		<xs:call-template name="skillTip">
			<xs:with-param name="skill" select="/character/skills/survival" />
		</xs:call-template>
	</xs:variable>


	<!-- Output html document -->
	<xs:template match="/character">
		<html lang="en">
			<head>
				<meta charset="UTF-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<title>Character Sheet</title>
			</head>
			<body>
				<div class="sheet">
					<div class="header">
						<h1>
							<xs:value-of select="details/name" />
						</h1>
					</div>
					<div class="main-content">
						<div class="column">
							<div class="box">

								<!-- Ability scores and modifiers -->
								<div class="stats">
									<div class="stat">
										<h3>Strength</h3>
										<div class="stat-mod">
											<xs:value-of select="$str" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseStr" />
										</div>
									</div>
									<div class="stat">
										<h3>Dexterity</h3>
										<div class="stat-mod">
											<xs:value-of select="$dex" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseDex" />
										</div>
									</div>
									<div class="stat">
										<h3>Constitution</h3>
										<div class="stat-mod">
											<xs:value-of select="$con" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseCon" />
										</div>
									</div>
									<div class="stat">
										<h3>Intelligence</h3>
										<div class="stat-mod">
											<xs:value-of select="$int" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseInt" />
										</div>
									</div>
									<div class="stat">
										<h3>Wisdom</h3>
										<div class="stat-mod">
											<xs:value-of select="$wis" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseWis" />
										</div>
									</div>
									<div class="stat">
										<h3>Charisma</h3>
										<div class="stat-mod">
											<xs:value-of select="$cha" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseCha" />
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="column">
							<div class="box">
								<h2>Saving Throws</h2>
								<div class="saves">

									<!-- Saving throw modifiers -->
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

									<!-- Skill modifiers -->
									<div class="skill" title="{$dex} (dex){$acrobaticsTip}">
										<div class="skill-mod">
											<xs:value-of select="$acrobatics" />
										</div>
										<h3>Acrobatics</h3>
										<div class="skill-stat">Dex</div>
									</div>
									<div class="skill" title="{$wis} (wis){$animalHandlingTip}">
										<div class="skill-mod">
											<xs:value-of select="$animalHandling" />
										</div>
										<h3>Animal Handling</h3>
										<div class="skill-stat">Wis</div>
									</div>
									<div class="skill" title="{$int} (int){$arcanaTip}">
										<div class="skill-mod">
											<xs:value-of select="$arcana" />
										</div>
										<h3>Arcana</h3>
										<div class="skill-stat">Int</div>
									</div>
									<div class="skill" title="{$str} (str){$athleticsTip}">
										<div class="skill-mod">
											<xs:value-of select="$athletics" />
										</div>
										<h3>Athletics</h3>
										<div class="skill-stat">Str</div>
									</div>
									<div class="skill" title="{$cha} (cha){$deceptionTip}">
										<div class="skill-mod">
											<xs:value-of select="$deception" />
										</div>
										<h3>Deception</h3>
										<div class="skill-stat">Cha</div>
									</div>
									<div class="skill" title="{$int} (int){$historyTip}">
										<div class="skill-mod">
											<xs:value-of select="$history" />
										</div>
										<h3>History</h3>
										<div class="skill-stat">Int</div>
									</div>
									<div class="skill" title="{$wis} (wis){$insightTip}">
										<div class="skill-mod">
											<xs:value-of select="$insight" />
										</div>
										<h3>Insight</h3>
										<div class="skill-stat">Wis</div>
									</div>
									<div class="skill" title="{$cha} (cha){$intimidationTip}">
										<div class="skill-mod">
											<xs:value-of select="$intimidation" />
										</div>
										<h3>Intimidation</h3>
										<div class="skill-stat">Cha</div>
									</div>
									<div class="skill" title="{$int} (int){$investigationTip}">
										<div class="skill-mod">
											<xs:value-of select="$investigation" />
										</div>
										<h3>Investigation</h3>
										<div class="skill-stat">Int</div>
									</div>
									<div class="skill" title="{$wis} (wis){$medicineTip}">
										<div class="skill-mod">
											<xs:value-of select="$medicine" />
										</div>
										<h3>Medicine</h3>
										<div class="skill-stat">Wis</div>
									</div>
									<div class="skill" title="{$int} (int){$natureTip}">
										<div class="skill-mod">
											<xs:value-of select="$nature" />
										</div>
										<h3>Nature</h3>
										<div class="skill-stat">Int</div>
									</div>
									<div class="skill" title="{$wis} (wis){$perceptionTip}">
										<div class="skill-mod">
											<xs:value-of select="$perception" />
										</div>
										<h3>Perception</h3>
										<div class="skill-stat">Wis</div>
									</div>
									<div class="skill" title="{$cha} (cha){$performanceTip}">
										<div class="skill-mod">
											<xs:value-of select="$performance" />
										</div>
										<h3>Performance</h3>
										<div class="skill-stat">Cha</div>
									</div>
									<div class="skill" title="{$cha} (cha){$persuasionTip}">
										<div class="skill-mod">
											<xs:value-of select="$persuasion" />
										</div>
										<h3>Persuasion</h3>
										<div class="skill-stat">Cha</div>
									</div>
									<div class="skill" title="{$int} (int){$religionTip}">
										<div class="skill-mod">
											<xs:value-of select="$religion" />
										</div>
										<h3>Religion</h3>
										<div class="skill-stat">Int</div>
									</div>
									<div class="skill" title="{$dex} (dex){$sleightOfHandTip}">
										<div class="skill-mod">
											<xs:value-of select="$sleightOfHand" />
										</div>
										<h3>Sleight of Hand</h3>
										<div class="skill-stat">Dex</div>
									</div>
									<div class="skill" title="{$dex} (dex){$stealthTip}">
										<div class="skill-mod">
											<xs:value-of select="$stealth" />
										</div>
										<h3>Stealth</h3>
										<div class="skill-stat">Dex</div>
									</div>
									<div class="skill" title="{$wis} (wis){$survivalTip}">
										<div class="skill-mod">
											<xs:value-of select="$survival" />
										</div>
										<h3>Survival</h3>
										<div class="skill-stat">Wis</div>
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