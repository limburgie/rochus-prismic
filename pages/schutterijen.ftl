<#if request.params[0]??>
	<#assign schutterij = api.query("schutterij").with("uid", request.params[0]).findFirst()>
	<#assign schietstand = schutterij.getReference("schietstand")>
	<#assign lat = schietstand.getNumber("latitude").format("0.000000")>
	<#assign lon = schietstand.getNumber("longitude").format("0.000000")>

	<h2>${schutterij.getText("naam")}</h2>

	<div class="row">
		<div class="col-lg-6">
			<p>
				${schietstand.getText("adres")}
			</p>
			<iframe width="100%"
					height="450"
					frameborder="0" style="border:0; margin-bottom: 10px"
					src="https://www.google.com/maps/embed/v1/place?key=AIzaSyCqPNGxsnsAHYu6ntBN5EJhsnmGtiPBwao&q=${lat},${lon}&zoom=16" allowfullscreen>
			</iframe>
			<p>
				<a href="${schutterij.getText("website_url")}" target="_blank">${schutterij.getText("website_url")}</a>
			</p>
			<p>
				<a href="javascript:window.history.back()" class="btn btn-primary">Terug</a>
			</p>
		</div>
	</div>

<#else>
	<h2>Schutterijen</h2>

	<p>
		In het huidige seizoen is dit de reeksindeling van de schutterijen van het Schuttersverbond Zand- en Leemstreek.
		Klik op een schutterij om de contactinformatie en een plannetje te bekijken.
	</p>

	<div class="row justify-content-between">
		<@reeks "A"/>
		<@reeks "B"/>
		<@reeks "C"/>
	</div>
</#if>

<#macro reeks reeksIndex>
	<div class="col-lg-4">
		<#assign schutterijen = api.query("schutterij").with("reeks", reeksIndex).findAll()>
		<#list schutterijen>
		<table class="table table-light table-striped mt-4">
			<thead class="thead-dark">
			<tr>
				<th>Reeks ${reeksIndex}</th>
			</tr>
			</thead>
			<tbody>
			<#items as schutterij>
			<tr>
				<td>
					<a href="/schutterijen/${schutterij.uid}">
						${schutterij.getText("naam")}
					</a>
				</td>
			</tr>
			</#items>
			</tbody>
		</table>
		</#list>
	</div>
</#macro>