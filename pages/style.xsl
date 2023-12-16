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
									<div class="sub-box stat">
										<h3>Strength</h3>
										<div class="stat-mod">
											<xs:value-of select="concat(substring('+', 1, number($str >= 0) * 1), $str)" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseStr" />
										</div>
									</div>
									<div class="sub-box stat">
										<h3>Dexterity</h3>
										<div class="stat-mod">
											<xs:value-of select="concat(substring('+', 1, number($dex >= 0) * 1), $dex)" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseDex" />
										</div>
									</div>
									<div class="sub-box stat">
										<h3>Constitution</h3>
										<div class="stat-mod">
											<xs:value-of select="concat(substring('+', 1, number($con >= 0) * 1), $con)" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseCon" />
										</div>
									</div>
									<div class="sub-box stat">
										<h3>Intelligence</h3>
										<div class="stat-mod">
											<xs:value-of select="concat(substring('+', 1, number($int >= 0) * 1), $int)" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseInt" />
										</div>
									</div>
									<div class="sub-box stat">
										<h3>Wisdom</h3>
										<div class="stat-mod">
											<xs:value-of select="concat(substring('+', 1, number($wis >= 0) * 1), $wis)" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$baseWis" />
										</div>
									</div>
									<div class="sub-box stat">
										<h3>Charisma</h3>
										<div class="stat-mod">
											<xs:value-of select="concat(substring('+', 1, number($cha >= 0) * 1), $cha)" />
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
								<div class="box-content saves">

									<!-- Saving throw modifiers -->
									<div class="save">
										<div class="save-mod">
											<xs:value-of select="concat(substring('+', 1, number($strSave >= 0) * 1), $strSave)" />
										</div>
										<h3>Strength</h3>
									</div>
									<div class="save">
										<div class="save-mod">
											<xs:value-of select="concat(substring('+', 1, number($dexSave >= 0) * 1), $dexSave)" />
										</div>
										<h3>Dexterity</h3>
									</div>
									<div class="save">
										<div class="save-mod">
											<xs:value-of select="concat(substring('+', 1, number($conSave >= 0) * 1), $conSave)" />
										</div>
										<h3>Constitution</h3>
									</div>
									<div class="save">
										<div class="save-mod">
											<xs:value-of select="concat(substring('+', 1, number($intSave >= 0) * 1), $intSave)" />
										</div>
										<h3>Intelligence</h3>
									</div>
									<div class="save">
										<div class="save-mod">
											<xs:value-of select="concat(substring('+', 1, number($wisSave >= 0) * 1), $wisSave)" />
										</div>
										<h3>Wisdom</h3>
									</div>
									<div class="save">
										<div class="save-mod">
											<xs:value-of select="concat(substring('+', 1, number($chaSave >= 0) * 1), $chaSave)" />
										</div>
										<h3>Charisma</h3>
									</div>
								</div>
							</div>
							<div class="box">
								<h2>Skills</h2>
								<div class="box-content skills">

									<!-- Skill modifiers -->
									<div class="skill" title="{$dex} (dex){$acrobaticsTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($acrobatics >= 0) * 1), $acrobatics)" />
										</div>
										<h3>Acrobatics</h3>
										<div class="skill-stat">Dex</div>
									</div>
									<div class="skill" title="{$wis} (wis){$animalHandlingTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($animalHandling >= 0) * 1), $animalHandling)" />
										</div>
										<h3>Animal Handling</h3>
										<div class="skill-stat">Wis</div>
									</div>
									<div class="skill" title="{$int} (int){$arcanaTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($arcana >= 0) * 1), $arcana)" />
										</div>
										<h3>Arcana</h3>
										<div class="skill-stat">Int</div>
									</div>
									<div class="skill" title="{$str} (str){$athleticsTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($athletics >= 0) * 1), $athletics)" />
										</div>
										<h3>Athletics</h3>
										<div class="skill-stat">Str</div>
									</div>
									<div class="skill" title="{$cha} (cha){$deceptionTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($deception >= 0) * 1), $deception)" />
										</div>
										<h3>Deception</h3>
										<div class="skill-stat">Cha</div>
									</div>
									<div class="skill" title="{$int} (int){$historyTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($history >= 0) * 1), $history)" />
										</div>
										<h3>History</h3>
										<div class="skill-stat">Int</div>
									</div>
									<div class="skill" title="{$wis} (wis){$insightTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($insight >= 0) * 1), $insight)" />
										</div>
										<h3>Insight</h3>
										<div class="skill-stat">Wis</div>
									</div>
									<div class="skill" title="{$cha} (cha){$intimidationTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($intimidation >= 0) * 1), $intimidation)" />
										</div>
										<h3>Intimidation</h3>
										<div class="skill-stat">Cha</div>
									</div>
									<div class="skill" title="{$int} (int){$investigationTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($investigation >= 0) * 1), $investigation)" />
										</div>
										<h3>Investigation</h3>
										<div class="skill-stat">Int</div>
									</div>
									<div class="skill" title="{$wis} (wis){$medicineTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($medicine >= 0) * 1), $medicine)" />
										</div>
										<h3>Medicine</h3>
										<div class="skill-stat">Wis</div>
									</div>
									<div class="skill" title="{$int} (int){$natureTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($nature >= 0) * 1), $nature)" />
										</div>
										<h3>Nature</h3>
										<div class="skill-stat">Int</div>
									</div>
									<div class="skill" title="{$wis} (wis){$perceptionTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($perception >= 0) * 1), $perception)" />
										</div>
										<h3>Perception</h3>
										<div class="skill-stat">Wis</div>
									</div>
									<div class="skill" title="{$cha} (cha){$performanceTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($performance >= 0) * 1), $performance)" />
										</div>
										<h3>Performance</h3>
										<div class="skill-stat">Cha</div>
									</div>
									<div class="skill" title="{$cha} (cha){$persuasionTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($persuasion >= 0) * 1), $persuasion)" />
										</div>
										<h3>Persuasion</h3>
										<div class="skill-stat">Cha</div>
									</div>
									<div class="skill" title="{$int} (int){$religionTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($religion >= 0) * 1), $religion)" />
										</div>
										<h3>Religion</h3>
										<div class="skill-stat">Int</div>
									</div>
									<div class="skill" title="{$dex} (dex){$sleightOfHandTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($sleightOfHand >= 0) * 1), $sleightOfHand)" />
										</div>
										<h3>Sleight of Hand</h3>
										<div class="skill-stat">Dex</div>
									</div>
									<div class="skill" title="{$dex} (dex){$stealthTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($stealth >= 0) * 1), $stealth)" />
										</div>
										<h3>Stealth</h3>
										<div class="skill-stat">Dex</div>
									</div>
									<div class="skill" title="{$wis} (wis){$survivalTip}">
										<div class="skill-mod">
											<xs:value-of select="concat(substring('+', 1, number($survival >= 0) * 1), $survival)" />
										</div>
										<h3>Survival</h3>
										<div class="skill-stat">Wis</div>
									</div>
								</div>
							</div>
						</div>
						<div class="column">
							<div class="box">
								<h2>Class<xs:value-of select="substring('es', 1, number(count(classes/class) > 1) * 2)" /></h2>
								<div class="box-content">
									<xs:for-each select="classes/class">
										<h3><xs:value-of select="@name" /> level <xs:value-of select="@level" /></h3>
									</xs:for-each>
								</div>
							</div>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xs:template>
</xs:stylesheet>