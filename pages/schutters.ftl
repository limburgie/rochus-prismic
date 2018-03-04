<#if request.params[0]??>
	<#assign schutter = api.query("schutter").with("uid", request.params[0]).findFirst()>
	<#assign naam = '${schutter.getText("voornaam")} ${schutter.getText("achternaam")}'>

	<h2>${naam}</h2>

	<div class="row">
		<div class="col-sm-4 col-md-4">
			<p>
				<img class="img-fluid" src="${schutter.getImage("foto").url}"/>
			</p>
		</div>
		<div class="col-sm-8 col-md-8">
			<p>
				${schutter.getText("voornaam")} is aangesloten bij de club sinds <strong>${schutter.getNumber("aansluitingsjaar").format("0")}.</strong>
			</p>

			<#assign m = schutter.getText("geslacht") == "Man">

			<#list api.query("koningskoppel").with(m?then("koning", "koningin"), schutter).orderByDesc("jaar").findAll()>
				${m?then("Hij", "Ze")} werd ${m?then("koning", "koningin")} in:
				<ul>
				<#items as koningskoppel>
					<#if koningskoppel.getReference(m?then("koningin", "koning"))??>
						<#assign partner = koningskoppel.getReference(m?then("koningin", "koning"))>
						<#assign partnerName = '${partner.getText("voornaam")} ${partner.getText("achternaam")}'>
					<#else>
						<#assign partnerName = koningskoppel.getText(m?then("koningin_ex", "koning_ex"))>
					</#if>
					<li>
						<a href="/koningskoppels/${koningskoppel.getText("jaar")}">
							<strong>${koningskoppel.getText("jaar")}</strong> met <strong>${partnerName}</strong>
						</a>
					</li>
				</#items>
				</ul>
			</#list>


			<#list api.query("hall_of_fame_item").with("winnaar", naam).orderByDesc("jaar").findAll()>
				${m?then("Hij", "Ze")} behaalde volgende prijzen:
				<ul>
					<#items as item>
						<li>
							<strong>${item.getText("jaar")}</strong>: ${item.getText("prijs")}
						</li>
					</#items>
				</ul>
			</#list>
		</div>
	</div>

	<p>
		<a href="javascript:window.history.back()" class="btn btn-primary">Terug</a>
	</p>
<#else>
	<h2>Schutters</h2>
	<p>Hier vind je een overzicht van alle actieve leden van onze schutterij. Klik op de naam of foto van een schutter om meer over hem of haar te lezen.</p>
	<@schutters "Schutter" true/>

	<h2>Aanstormend talent</h2>
	<p>Deze schuttertjes zijn momenteel nog iets te jong, maar ze worden nu al klaargestoomd om de oudere generatie met glans op te volgen!</p>
	<@schutters "Talentje" false/>

	<h2>Supporters</h2>
	<p>Wat is een schutterij zonder haar die-hard supporters?</p>
	<@schutters "Supporter" false/>
</#if>

<#macro schutters type linked>
	<div class="row">
		<#list api.query("schutter").with("type", type).with("actief", "Ja").orderByAsc("aansluitingsjaar").findAll() as schutter>
			<div class="col-6 col-sm-4 col-md-3 col-lg-2 card-wrapper">
				<#if linked>
				<a href="/schutters/${schutter.uid}">
				</#if>
					<div class="card mb-4">
						<img class="card-img-top" src="${schutter.getImage("foto").url}" alt="${schutter.getText("voornaam")}">
						<div class="card-body">
							<p class="card-text">
								${schutter.getText("voornaam")}
							</p>
						</div>
					</div>
				<#if linked>
				</a>
				</#if>
			</div>
		</#list>
	</div>
</#macro>