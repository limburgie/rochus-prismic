<#if request.params[0]??>
	<#assign param = request.params[0]?number>
	<#if param gt 1000>
		<#assign jaar = param?string["0"]>
	<#else>
		<#assign from = param?number>
	</#if>
<#else>
	<#assign from = 1>
</#if>

<#if from??>
	<h2>Koningskoppels</h2>

	<#assign query = api.query("koningskoppel")>

	<#assign total = query.count()>
	<#assign koningskoppels = query.orderByDesc("jaar").findAll(from, 12)>

	<div class="row">
		<#list koningskoppels as koningskoppel>
			<div class="col-md-6 col-xl-4 card-wrapper">
				<a href="/koningskoppels/${koningskoppel.getText("jaar")}">
					<div class="card mb-4">
						<#if koningskoppel.getImage("foto")??>
							<img class="card-img-top" src="${koningskoppel.getImage("foto").url}" alt="${koningskoppel.getText("jaar")}">
						</#if>
						<div class="card-body">
							<p class="card-text">
								${koningskoppel.getText("jaar")}
							</p>
						</div>
					</div>
				</a>
			</div>
		</#list>
	</div>

	<div class="row">
		<div class="col-auto mr-auto">
			<#if from gt 1 && koningskoppels?size gt 0>
				<p>
					<a href="/koningskoppels/${from - 1}" class="btn btn-primary">Later</a>
				</p>
			</#if>
		</div>
		<div class="col-auto">
			<#if total gt (from * 12)>
				<p>
					<a href="/koningskoppels/${from + 1}" class="btn btn-primary">Vroeger</a>
				</p>
			</#if>
		</div>
	</div>
<#elseif jaar??>
	<h2>Koningskoppel ${jaar}</h2>

	<#assign koningskoppel = api.query("koningskoppel").with("jaar", jaar).findOne()>

	<div class="row">
		<div class="col-sm-6">
			<p>
				<img class="img-fluid" src="${koningskoppel.getImage("foto").url}"/>
			</p>
		</div>
		<div class="col-sm-6">
			<p>
				Koning: <strong><@koningsschutter koningskoppel true/></strong><br/>
				Koningin: <strong><@koningsschutter koningskoppel false/></strong>
			</p>
		</div>
	</div>

	<p>
		<a href="javascript:window.history.back()" class="btn btn-primary">Terug</a>
	</p>
</#if>

<#macro koningsschutter koningskoppel m>
	<#if koningskoppel.getReference(m?then("koning", "koningin"))??>
		<#assign schutter = koningskoppel.getReference(m?then("koning", "koningin"))>
		<a href="/schutters/${schutter.uid}">${schutter.getText("voornaam")} ${schutter.getText("achternaam")}</a>
	<#else>
		${koningskoppel.getText(m?then("koning_ex", "koningin_ex"))}
	</#if>
</#macro>