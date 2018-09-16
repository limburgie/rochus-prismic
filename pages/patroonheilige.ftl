<h2>Onze patroonheilige</h2>

<#assign patroonheilige = api.query("onze_patroonheilige").findOne()>
<article id="patroonheilige" data-c3s-id="${patroonheilige.id}">
	${patroonheilige.getRichText("onze_patroonheilige").html}
</article>