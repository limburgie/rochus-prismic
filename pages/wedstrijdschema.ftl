<h2>Aankomende wedstrijden</h2>

<p>
	Onderstaand overzicht toont alle aankomende wedstrijden voor het huidige seizoen.
</p>

<#if request.params[0]??>
	<#assign from = request.params[0]?number>
<#else>
	<#assign from = 1>
</#if>

<#assign itemsPerPage = 20>
<#assign query = api.query("wedstrijd").withDateInFuture("datum")>

<#assign total = query.count()>
<#assign wedstrijden = query.orderByAsc("datum").findAll(from, itemsPerPage)>

<#list wedstrijden>
	<table class="table table-light table-striped">
		<thead class="thead-dark">
			<tr>
				<th class="d-none d-md-table-cell">Datum</th>
				<th class="d-none d-md-table-cell">Club</th>
				<th class="d-none d-md-table-cell">Type</th>
			</tr>
		</thead>
		<tbody>
		<#items as wedstrijd>
			<#assign schutterij = wedstrijd.getReference("organisator")>
			<#assign datum = wedstrijd.getDate("datum").format("EEEE d MMMM 'om' HH'u'mm").withLocale("nl_BE")?cap_first>
			<tr>
				<td class="d-none d-md-table-cell">
					${datum}
				</td>
				<td>
					<div class="d-md-none">${datum}<br/></div>
					<a href="/schutterijen/${schutterij.uid}">
						${schutterij.getText("naam")}
					</a>
					<div class="d-md-none"><@type wedstrijd.getText("type")/></div>
				</td>
				<td class="d-none d-md-table-cell">
					<@type wedstrijd.getText("type")/>
				</td>
			</tr>
		</#items>
		</tbody>
	</table>

	<div class="row">
		<div class="col-auto mr-auto">
			<#if from gt 1>
				<p>
					<a href="/wedstrijdschema/${from - 1}" class="btn btn-primary">Vroeger</a>
				</p>
			</#if>
		</div>
		<div class="col-auto">
			<#if total gt (from * itemsPerPage)>
				<p>
					<a href="/wedstrijdschema/${from + 1}" class="btn btn-primary">Later</a>
				</p>
			</#if>
		</div>
	</div>
</#list>

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