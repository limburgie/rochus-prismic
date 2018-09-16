<h2>Wat is klepschieten?</h2>

<#assign klepschieten = api.query("wat_is_klepschieten").findOne()>
<article id="klepschieten" data-c3s-id="${klepschieten.id}">
	${klepschieten.getRichText("wat_is_klepschieten").html}
</article>