<h2>Wedstrijduitslagen</h2>

<p>
	Onderstaand overzicht toont de uitslagen van alle reeds afgelopen wedstrijden.
</p>

<#if request.params[0]??>
	<#assign from = request.params[0]?number>
<#else>
	<#assign from = 1>
</#if>

<#assign itemsPerPage = 20>
<#assign query = api.query("wedstrijd").withDateInPast("datum")>

<#assign total = query.count()>
<#assign wedstrijden = query.orderByDesc("datum").findAll(from, itemsPerPage)>

<#list wedstrijden>
	<table class="table table-light table-striped">
		<thead class="thead-dark">
		<tr>
			<th class="d-none d-md-table-cell">Datum</th>
			<th class="d-none d-md-table-cell">Club</th>
			<th class="d-none d-md-table-cell">Type</th>
			<th class="d-none d-md-table-cell text-center">A</th>
			<th class="d-none d-md-table-cell text-center">B</th>
			<th class="d-none d-md-table-cell"></th>
		</tr>
		</thead>
		<tbody>
		<#items as wedstrijd>
			<#assign schutterij = wedstrijd.getReference("organisator")>
			<#assign datum = wedstrijd.getDate("datum").format("EEE d MMMM yyyy")?cap_first>
			<tr>
				<td class="d-none d-md-table-cell">
					${datum}
				</td>
				<td>
					<div class="d-md-none">${datum}</div>
					<a href="/schutterijen/${schutterij.uid}">
						${schutterij.getText("naam")}
					</a>
					<div class="d-md-none"><@type wedstrijd.getText("type")/></div>
				</td>
				<td class="d-md-none">
					<div>${resultaat(wedstrijd, "A", true)}</div>
					<div>${resultaat(wedstrijd, "B", true)}</div>
				</td>
				<td class="d-none d-md-table-cell">
					<@type wedstrijd.getText("type")/>
				</td>
				<td class="d-none d-md-table-cell text-center">
					${resultaat(wedstrijd, "A", false)}
				</td>
				<td class="d-none d-md-table-cell text-center">
					${resultaat(wedstrijd, "B", false)}
				</td>
				<td>
					<span data-c3s-id="${wedstrijd.id}"></span>
				</td>
			</tr>
		</#items>
		</tbody>
	</table>

	<div class="row">
		<div class="col-auto mr-auto">
			<#if from gt 1>
				<p>
					<a href="/uitslagen/${from - 1}" class="btn btn-primary">Vroeger</a>
				</p>
			</#if>
		</div>
		<div class="col-auto">
			<#if total gt (from * itemsPerPage)>
				<p>
					<a href="/uitslagen/${from + 1}" class="btn btn-primary">Later</a>
				</p>
			</#if>
		</div>
	</div>
</#list>

<#function resultaat wedstrijd ploeg toonPloeg>
	<#if wedstrijd.getGroup("uitslagen")??>
		<#list wedstrijd.getGroup("uitslagen") as uitslag>
			<#if uitslag.getText("ploeg")! == ploeg>
				<#assign result = "<nobr>">
				<#if toonPloeg>
					<#assign result = "${result}${ploeg}: ">
				</#if>
				<#return result + "<strong>" + uitslag.getNumber("treffers").format("0") + "</strong></nobr>">
			</#if>
		</#list>
	</#if>
	<#return "">
</#function>

<#macro type type>
	<#switch type>
		<#case "Officiële wedstrijd">
			<i class="fas fa-trophy"></i>
			<#break>
		<#case "Provinciale wedstrijd">
			<i class="fas fa-globe"></i>
			<#break>
		<#case "Juweel Kampioen">
		<#case "Juweel Kampioene">
			<i class="fab fa-servicestack"></i>
	</#switch>
	${type}
</#macro>