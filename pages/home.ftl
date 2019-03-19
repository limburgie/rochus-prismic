<div class="row justify-content-between">
	<div class="col-lg-5 col-md-6">
		<#assign todaysGame = api.query("wedstrijd").withDateToday("datum").findOne()!>

		<#if todaysGame?has_content>
			<@wedstrijd "Wedstrijd vandaag" todaysGame true/>
		</#if>

		<#assign nextGame = api.query("wedstrijd").withDateAfterToday("datum").orderByAsc("datum").findOne()!>
		<#if nextGame?has_content>
			<@wedstrijd "Volgende wedstrijd" nextGame false/>
		</#if>

		<#assign previousGame = api.query("wedstrijd").withDateBeforeToday("datum").orderByDesc("datum").findOne()!>
		<#if previousGame?has_content>
			<@wedstrijd "Laatste wedstrijd" previousGame true/>
		</#if>
	</div>

	<#assign klassement = api.query("klassement").findOne()>
	<#list klassement.getGroup("stand")>
	<div class="col-md-6" data-c3s-id="${klassement.id}">
		<h2>Klassement Reeks ${klassement.getText("reeks")}</h2>
		<table class="table table-light table-striped table-klassement">
			<thead class="thead-dark">
			<tr>
				<th></th>
				<th>Club</th>
				<th>Treffers</th>
			</tr>
			</thead>
			<tbody>
			<#items as standItem>
			<tr <#if standItem.getReference("schutterij").getText("naam") == "St.-Rochus Zutendaal">style = "font-weight: 700;"</#if>>
				<td>${standItem_index + 1}.</td>
				<td>${standItem.getReference("schutterij").getText("naam")}</td>
				<td>${standItem.getNumber("treffers").format("0")}</td>
			</tr>
			</#items>
			</tbody>
		</table>
		<div class="last-updated">Laatste update: ${klassement.getModified("d MMMM 'om' HH'u'mm")}</div>
	</div>
	</#list>
</div>

<#macro wedstrijd title wedstrijd metUitslagen>
	<#assign organisator = wedstrijd.getReference("organisator")>
	<h2>${title}</h2>
	<div class="game-box">
		<a href="/schutterijen/${organisator.uid}">
			<div class="container">
				<div class="row justify-content-between">
					<div class="col-sm-3 game-date text-sm-center mb-3 mb-sm-0 align-self-center">
						<span>${wedstrijd.getDate("datum").format("EE dd/MM")}</span>
						<span class="d-md-none d-lg-block">om</span>
						<span>${wedstrijd.getDate("datum").format("HH':'mm")}</span>
					</div>
					<div class="col-sm-8 align-self-center" data-c3s-id="${wedstrijd.id}">
						<h3 class="game-location">${organisator.getText("naam")}</h3>
						<span class="game-type">${wedstrijd.getText("type")}</span>
					</div>
				</div>
				<#if metUitslagen>
					<#assign uitslagen = wedstrijd.getGroup("uitslagen")>
					<#if uitslagen[0]?? && uitslagen[0].getText("ploeg")?has_content>
						<#list uitslagen>
							<div class="row">
								<#items as uitslag>
									<div class="col text-center">
										<div class="team-result">
											<span class="team">${uitslag.getText("ploeg")}</span>
											<span class="result">${uitslag.getNumber("treffers").format("0")}</span>
										</div>
									</div>
								</#items>
							</div>
						</#list>
					</#if>
				</#if>
			</div>
		</a>
	</div>
</#macro>