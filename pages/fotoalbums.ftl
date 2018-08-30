<#if request.params[0]??>
	<#assign param = request.params[0]>
	<#attempt>
		<#assign from = param?number>
	<#recover>
		<#assign albumId = param>
	</#attempt>
<#else>
	<#assign from = 1>
</#if>

<#if albumId??>
	<#assign album = api.query("fotoalbum").with("uid", albumId).findOne()>

	<h2>${album.getText("naam")}</h2>
	<#if album.getText("beschrijving")??>
		<p>${album.getText("beschrijving")}</p>
	</#if>

	<div id="gallery">
		<#list album.getGroup("fotos") as foto>
			<a href="${foto.getImage("foto").url}" data-toggle="lightbox" data-gallery="gallery">
				<img src="${foto.getImage("foto").url}"/>
			</a>
		</#list>
	</div>

	<p>
		<a href="javascript:window.history.back()" class="btn btn-primary">Terug</a>
	</p>
<#else>
	<h2>Fotoalbums</h2>
	<p>In dit overzicht kan je alle kiekjes van vroeger en nu bekijken. Klik op een album om de foto's te bekijken.</p>
	<div class="row">
		<#assign query = api.query("fotoalbum")>

		<#assign total = query.count()>
		<#assign albums = query.orderByDesc("datum").findAll(from, 12)>

		<#list albums as album>
			<div class="col-sm-6 col-lg-4 col-xl-3 card-wrapper">
				<a href="/fotoalbums/${album.uid}">
					<div class="card mb-5">
						<img class="card-img-top" src="${album.getImage("voorbeeldfoto").url}">
						<div class="card-body">
							<p class="card-text">
								<strong>${album.getText("naam")}</strong><br/>
								<#if album.getDate("datum")??>
									${album.getDate("datum").format("MMMM yyyy").withLocale("nl_BE")}
								</#if>
							</p>
						</div>
					</div>
				</a>
			</div>
		</#list>
	</div>

	<div class="row">
		<div class="col-auto mr-auto">
		<#if from gt 1 && albums?size gt 0>
			<p>
				<a href="/fotoalbums/${from - 1}" class="btn btn-primary">Later</a>
			</p>
		</#if>
		</div>
		<div class="col-auto">
		<#if total gt (from * 12)>
			<p>
				<a href="/fotoalbums/${from + 1}" class="btn btn-primary">Vroeger</a>
			</p>
		</#if>
		</div>
	</div>
</#if>