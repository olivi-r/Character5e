<?xml version="1.0"?>
<!DOCTYPE wrapper [
	<!ENTITY style SYSTEM "style.css">
]>
<xs:stylesheet version="1.0" xmlns:xs="http://www.w3.org/1999/XSL/Transform">
	<xs:template match="/character">
		<xs:variable name="characterLevel" select="sum(classlist/class/@level)" />
		<xs:variable name="proficiencyBonus" select="floor(($characterLevel - 1) div 4) + 2" />
		<xs:variable name="strAbility" select="ability/str + sum(//ability-score-increase/@str)" />
		<xs:variable name="dexAbility" select="ability/dex + sum(//ability-score-increase/@dex)" />
		<xs:variable name="conAbility" select="ability/con + sum(//ability-score-increase/@con)" />
		<xs:variable name="intAbility" select="ability/int + sum(//ability-score-increase/@int)" />
		<xs:variable name="wisAbility" select="ability/wis + sum(//ability-score-increase/@wis)" />
		<xs:variable name="chaAbility" select="ability/cha + sum(//ability-score-increase/@cha)" />
		<xs:variable name="str" select="floor($strAbility div 2) - 5" />
		<xs:variable name="dex" select="floor($dexAbility div 2) - 5" />
		<xs:variable name="con" select="floor($conAbility div 2) - 5" />
		<xs:variable name="int" select="floor($intAbility div 2) - 5" />
		<xs:variable name="wis" select="floor($wisAbility div 2) - 5" />
		<xs:variable name="cha" select="floor($chaAbility div 2) - 5" />
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
		<xs:variable name="acrobatics">
			<xs:choose>
				<xs:when test="skills/acrobatics[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/acrobatics[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $dex" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $dex" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $dex" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$dex" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="animalHandling">
			<xs:choose>
				<xs:when test="skills/animalHandling[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/animalHandling[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="arcana">
			<xs:choose>
				<xs:when test="skills/arcana[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/arcana[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $int" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$int" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="athletics">
			<xs:choose>
				<xs:when test="skills/athletics[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/athletics[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $str" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $str" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $str" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$str" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="deception">
			<xs:choose>
				<xs:when test="skills/deception[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/deception[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="history">
			<xs:choose>
				<xs:when test="skills/history[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/history[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $int" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$int" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="insight">
			<xs:choose>
				<xs:when test="skills/insight[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/insight[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="intimidation">
			<xs:choose>
				<xs:when test="skills/intimidation[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/intimidation[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="investigation">
			<xs:choose>
				<xs:when test="skills/investigation[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/investigation[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $int" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$int" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="medicine">
			<xs:choose>
				<xs:when test="skills/medicine[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/medicine[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="nature">
			<xs:choose>
				<xs:when test="skills/nature[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/nature[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $int" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$int" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="perception">
			<xs:choose>
				<xs:when test="skills/perception[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/perception[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="performance">
			<xs:choose>
				<xs:when test="skills/performance[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/performance[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="persuasion">
			<xs:choose>
				<xs:when test="skills/persuasion[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/persuasion[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="religion">
			<xs:choose>
				<xs:when test="skills/religion[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/religion[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $int" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$int" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="sleightOfHand">
			<xs:choose>
				<xs:when test="skills/sleightOfHand[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/sleightOfHand[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $dex" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $dex" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $dex" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$dex" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="stealth">
			<xs:choose>
				<xs:when test="skills/stealth[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/stealth[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $dex" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $dex" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $dex" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$dex" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="survival">
			<xs:choose>
				<xs:when test="skills/survival[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="skills/survival[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
    <html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/xhtml http://www.w3.org/2002/08/xhtml/xhtml1-strict.xsd">
			<head>
				<meta charset="UTF-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<style>&style;</style>
				<title>Character Sheet</title>
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
								<div class="stats">
									<div class="stat">
										<h3>Strength</h3>
										<div class="stat-mod">
											<xs:value-of select="$str" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$strAbility" />
										</div>
									</div>
									<div class="stat">
										<h3>Dexterity</h3>
										<div class="stat-mod">
											<xs:value-of select="$dex" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$dexAbility" />
										</div>
									</div>
									<div class="stat">
										<h3>Constitution</h3>
										<div class="stat-mod">
											<xs:value-of select="$con" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$conAbility" />
										</div>
									</div>
									<div class="stat">
										<h3>Intelligence</h3>
										<div class="stat-mod">
											<xs:value-of select="$int" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$intAbility" />
										</div>
									</div>
									<div class="stat">
										<h3>Wisdom</h3>
										<div class="stat-mod">
											<xs:value-of select="$wis" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$wisAbility" />
										</div>
									</div>
									<div class="stat">
										<h3>Charisma</h3>
										<div class="stat-mod">
											<xs:value-of select="$cha" />
										</div>
										<div class="base-stat">
											<xs:value-of select="$chaAbility" />
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