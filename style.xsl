<?xml version="1.0"?>
<xs:stylesheet version="1.0" xmlns:xs="http://www.w3.org/1999/XSL/Transform">
	<xs:template xmlns:ns="http://github.com/olivi-r/characters/raw/main/schema.xsd" match="/ns:player">
		<xs:variable name="playerLevel" select="sum(ns:classlist/ns:class/@level)" />
		<xs:variable name="proficiencyBonus" select="floor(($playerLevel - 1) div 4) + 2" />
		<xs:variable name="strAbility" select="ns:ability/ns:str + sum(//ns:ability-score-increase/@str)" />
		<xs:variable name="dexAbility" select="ns:ability/ns:dex + sum(//ns:ability-score-increase/@dex)" />
		<xs:variable name="conAbility" select="ns:ability/ns:con + sum(//ns:ability-score-increase/@con)" />
		<xs:variable name="intAbility" select="ns:ability/ns:int + sum(//ns:ability-score-increase/@int)" />
		<xs:variable name="wisAbility" select="ns:ability/ns:wis + sum(//ns:ability-score-increase/@wis)" />
		<xs:variable name="chaAbility" select="ns:ability/ns:cha + sum(//ns:ability-score-increase/@cha)" />
		<xs:variable name="str" select="floor($strAbility div 2) - 5" />
		<xs:variable name="dex" select="floor($dexAbility div 2) - 5" />
		<xs:variable name="con" select="floor($conAbility div 2) - 5" />
		<xs:variable name="int" select="floor($intAbility div 2) - 5" />
		<xs:variable name="wis" select="floor($wisAbility div 2) - 5" />
		<xs:variable name="cha" select="floor($chaAbility div 2) - 5" />
		<xs:variable name="strSave">
			<xs:choose>
				<xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' str ')]">
					<xs:value-of select="$str + $proficiencyBonus" />
				</xs:when>
				<xs:otherwise>
					<xs:value-of select="$str" />
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="dexSave">
			<xs:choose>
				<xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' dex ')]">
					<xs:value-of select="$dex + $proficiencyBonus" />
				</xs:when>
				<xs:otherwise>
					<xs:value-of select="$dex" />
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="conSave">
			<xs:choose>
				<xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' con ')]">
					<xs:value-of select="$con + $proficiencyBonus" />
				</xs:when>
				<xs:otherwise>
					<xs:value-of select="$con" />
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="intSave">
			<xs:choose>
				<xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' int ')]">
					<xs:value-of select="$int + $proficiencyBonus" />
				</xs:when>
				<xs:otherwise>
					<xs:value-of select="$int" />
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="wisSave">
			<xs:choose>
				<xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' wis ')]">
					<xs:value-of select="$wis + $proficiencyBonus" />
				</xs:when>
				<xs:otherwise>
					<xs:value-of select="$wis" />
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="chaSave">
			<xs:choose>
				<xs:when test="ns:ability[contains(concat(' ', normalize-space(@saving-throws), ' '), ' cha ')]">
					<xs:value-of select="$cha + $proficiencyBonus" />
				</xs:when>
				<xs:otherwise>
					<xs:value-of select="$cha" />
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
		<xs:variable name="acrobatics">
			<xs:choose>
				<xs:when test="ns:skills/ns:acrobatics[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:acrobatics[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $dex" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $dex" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:animalHandling[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:animalHandling[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:arcana[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:arcana[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $int" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:athletics[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:athletics[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $str" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $str" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:deception[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:deception[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:history[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:history[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $int" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:insight[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:insight[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:intimidation[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:intimidation[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:investigation[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:investigation[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $int" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:medicine[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:medicine[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:nature[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:nature[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $int" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:perception[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:perception[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:performance[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:performance[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:persuasion[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:persuasion[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $cha" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $cha" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:religion[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:religion[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $int" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $int" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:sleightOfHand[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:sleightOfHand[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $dex" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $dex" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:stealth[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:stealth[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $dex" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $dex" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
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
				<xs:when test="ns:skills/ns:survival[@proficient='1' or @proficient='true']">
					<xs:choose>
						<xs:when test="ns:skills/ns:survival[@expertise='1' or @expertise='true']">
							<xs:value-of select="$proficiencyBonus * 2 + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$proficiencyBonus + $wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:when>
				<xs:otherwise>
					<xs:choose>
						<xs:when test="ns:skills/@jack-of-all-trades='1'">
							<xs:value-of select="floor($proficiencyBonus div 2) + $wis" />
						</xs:when>
						<xs:otherwise>
							<xs:value-of select="$wis" />
						</xs:otherwise>
					</xs:choose>
				</xs:otherwise>
			</xs:choose>
		</xs:variable>
			<html lang="en">
			<head>
				<meta charset="UTF-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<style>
					body {
						font-family: 'Arial', sans-serif;
						margin: 0;
						padding: 0;
						background-color: #f2f2f2;
					}

					.character-sheet {
						max-width: 600px;
						margin: 20px auto;
						background-color: #fff;
						padding: 20px;
						box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
					}

					.header {
						display: flex;
						justify-content: space-between;
						align-items: center;
						margin-bottom: 20px;
					}

					.header h1, .header p {
						margin: 0.3em;
					}

					.main-content, .column {
						display: flex;
					}

					.column {
						flex-direction: column;
						margin-right: 10px;
					}

					.box {
						width: 100%;
						align-self: flex-start;
						border: 2px solid #00CBFF;
						border-radius: 10px;
						margin-bottom: 10px;
						text-align: center;
					}

					.box h2 {
						font-size: 1em;
					}

					.stats {
						margin: 10px;
					}

					.stats h3 {
						margin: 0;
						font-size: 0.6em;
					}

					.stat {
						border: 2px solid #4CAF50;
						border-radius: 10px;
						padding: 10px;
						margin-bottom: 10px;
						position: relative;
						text-align: center;
					}

					.stat-mod {
						font-size: 1.5em;
						color: #4CAF50;
						font-weight: bold;
					}

					.base-stat {
						font-size: 1.2em;
						color: #555;
						margin-top: 5px;
					}

					.saves {
						text-align: center;
						margin-top: 5px;
						margin-bottom: 5px;
					}

					.saves h3 {
						margin: 0;
						font-size: 0.75em;
						margin-left: 10px;
					}

					.save {
						display: flex;
						align-items: center;
						margin-bottom: 5px;
						margin-right: 10px;
					}

					.save-mod {
						width: 1em;
						font-size: 0.75em;
						text-align: right;
						margin-left: 10px;
					}

					.skills {
						margin-top: 5px;
						margin-bottom: 5px;
					}

					.skills h3 {
						margin: 0;
						font-size: 0.75em;
						margin-left: 10px;
					}

					.skill {
						display: flex;
						align-items: center;
						margin-bottom: 5px;
						margin-right: 10px;
					}

					.skill-mod {
						width: 1em;
						font-size: 0.75em;
						text-align: right;
						margin-left: 10px;
					}
				</style>
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