<h2>Geschiedenis</h2>

<#assign geschiedenis = api.query("geschiedenis").findOne()>
<article data-c3s-id="${geschiedenis.id}">
	${geschiedenis.getRichText("geschiedenis").html}
</article>