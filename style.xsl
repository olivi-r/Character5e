<?xml version="1.0"?>

<!-- CSS base stylesheet -->
<!DOCTYPE xs:stylesheet [
	<!ENTITY base_style SYSTEM "base.css">
]>

<xs:stylesheet version="1.0" xmlns:xs="http://www.w3.org/1999/XSL/Transform">
	<xs:import href="none.xsl" />

	<!-- Character stats -->
	<xs:variable name="characterLevel" select="sum(/character/classes/class/@level)" />
	<xs:variable name="proficiencyBonus" select="floor(($characterLevel - 1) div 4) + 2" />
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
			<xs:when test="ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' str ')]">
				<xs:value-of select="$str + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$str" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>
	<xs:variable name="dexSave">
		<xs:choose>
			<xs:when test="ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' dex ')]">
				<xs:value-of select="$dex + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$dex" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>
	<xs:variable name="conSave">
		<xs:choose>
			<xs:when test="ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' con ')]">
				<xs:value-of select="$con + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$con" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>
	<xs:variable name="intSave">
		<xs:choose>
			<xs:when test="ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' int ')]">
				<xs:value-of select="$int + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$int" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>
	<xs:variable name="wisSave">
		<xs:choose>
			<xs:when test="ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' wis ')]">
				<xs:value-of select="$wis + $proficiencyBonus" />
			</xs:when>
			<xs:otherwise>
				<xs:value-of select="$wis" />
			</xs:otherwise>
		</xs:choose>
	</xs:variable>
	<xs:variable name="chaSave">
		<xs:choose>
			<xs:when test="ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' cha ')]">
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
						<xs:value-of select="floor($proficiencyBonus div 2) + $baseMod" />
					</xs:when>
					<xs:otherwise>
						<xs:value-of select="$baseMod" />
					</xs:otherwise>
				</xs:choose>
			</xs:otherwise>
		</xs:choose>
	</xs:template>

	<!-- Calculate skill modifiers -->
	<xs:variable name="acrobatics">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/acrobatics" />
			<xs:with-param name="baseMod" select="$dex" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="animalHandling">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/animal-handling" />
			<xs:with-param name="baseMod" select="$wis" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="arcana">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/arcana" />
			<xs:with-param name="baseMod" select="$int" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="athletics">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/athletics" />
			<xs:with-param name="baseMod" select="$str" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="deception">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/deception" />
			<xs:with-param name="baseMod" select="$cha" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="history">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/history" />
			<xs:with-param name="baseMod" select="$int" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="insight">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/insight" />
			<xs:with-param name="baseMod" select="$wis" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="intimidation">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/intimidation" />
			<xs:with-param name="baseMod" select="$cha" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="investigation">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/investigation" />
			<xs:with-param name="baseMod" select="$int" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="medicine">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/medicine" />
			<xs:with-param name="baseMod" select="$wis" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="nature">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/nature" />
			<xs:with-param name="baseMod" select="$int" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="perception">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/perception" />
			<xs:with-param name="baseMod" select="$wis" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="performance">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/performance" />
			<xs:with-param name="baseMod" select="$cha" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="persuasion">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/persuasion" />
			<xs:with-param name="baseMod" select="$cha" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="religion">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/religion" />
			<xs:with-param name="baseMod" select="$int" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="sleightOfHand">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/sleight-of-hand" />
			<xs:with-param name="baseMod" select="$dex" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="stealth">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/stealth" />
			<xs:with-param name="baseMod" select="$dex" />
		</xs:call-template>
	</xs:variable>
	<xs:variable name="survival">
		<xs:call-template name="skillMod">
			<xs:with-param name="skill" select="skills/survival" />
			<xs:with-param name="baseMod" select="$wis" />
		</xs:call-template>
	</xs:variable>


	<!-- Output html document -->
	<xs:template match="/character">
		<html lang="en">
			<head>
				<meta charset="UTF-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<title>Character Sheet</title>
				<style>&base_style;</style>
				<style>
					<xs:call-template name="theme" />
				</style>
			</head>
			<body>
				<div class="character-sheet">
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
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$acrobatics" />
										</div>
										<h3>Acrobatics</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$animalHandling" />
										</div>
										<h3>Animal Handling</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$arcana" />
										</div>
										<h3>Arcana</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$athletics" />
										</div>
										<h3>Athletics</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$deception" />
										</div>
										<h3>Deception</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$history" />
										</div>
										<h3>History</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$insight" />
										</div>
										<h3>Insight</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$intimidation" />
										</div>
										<h3>Intimidation</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$investigation" />
										</div>
										<h3>Investigation</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$medicine" />
										</div>
										<h3>Medicine</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$nature" />
										</div>
										<h3>Nature</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$perception" />
										</div>
										<h3>Perception</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$performance" />
										</div>
										<h3>Performance</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$persuasion" />
										</div>
										<h3>Persuasion</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$religion" />
										</div>
										<h3>Religion</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$sleightOfHand" />
										</div>
										<h3>Sleight of Hand</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$stealth" />
										</div>
										<h3>Stealth</h3>
									</div>
									<div class="skill">
										<div class="skill-mod">
											<xs:value-of select="$survival" />
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