<#assign intro = api.query("introductie").findOne()>

<div class="row justify-content-between introduction mb-lg-3 d-none d-lg-flex">
	<div class="col-md-5 col-lg-6 col-xl-6 mt-3 mt-sm-4 mt-lg-5 align-self-center">
	${intro.getRichText("introductietekst").html}
	</div>
	<div class="col-md-7 col-lg-5 col-xl-5 mt-4 align-self-center">
		<img class="img-fluid" src="${intro.getImage("groepsfoto").url}"/>
	</div>
</div>