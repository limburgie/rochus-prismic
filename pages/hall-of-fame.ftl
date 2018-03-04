<h2>Hall of fame</h2>

<p>
	Doorheen de jaren hebben onze schutterij en haar leden heel wat prijzen binnengehaald.
	Hieronder volgt een overzicht van onze prijzenkast, gerangschikt op datum.
</p>

<#if request.params[0]??>
	<#assign from = request.params[0]?number>
<#else>
	<#assign from = 1>
</#if>

<#assign query = api.query("hall_of_fame_item")>

<#assign total = query.count()>
<#assign items = query.orderByDesc("jaar").findAll(from, 20)>

<#list items>
	<table class="table table-light table-striped">
		<thead class="thead-dark">
		<tr>
			<th>Jaar</th>
			<th>Prijs</th>
			<th>Behaald door</th>
		</tr>
		</thead>
		<tbody>
		<#items as item>
		<tr>
			<td>${item.getText("jaar")}</td>
			<td>${item.getText("prijs")}</td>
			<td>${item.getText("winnaar")}</td>
		</tr>
		</#items>
		</tbody>
	</table>

	<div class="row">
		<div class="col-auto mr-auto">
			<#if from gt 1 && items?size gt 0>
				<p>
					<a href="/hall-of-fame/${from - 1}" class="btn btn-primary">Later</a>
				</p>
			</#if>
		</div>
		<div class="col-auto">
			<#if total gt (from * 20)>
				<p>
					<a href="/hall-of-fame/${from + 1}" class="btn btn-primary">Vroeger</a>
				</p>
			</#if>
		</div>
	</div>
</#list>