<!DOCTYPE html>
<html lang="nl">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Bridge Club Lanaken">
	<meta name="author" content="Web Factor">
	<link rel="icon" href="/assets/img/favicon.png">

	<title>${site.name} - ${request.page.name}</title>

	<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Fira+Sans">
	<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:400,700">
	<link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.css" integrity="sha256-HAaDW5o2+LelybUhfuk0Zh2Vdk8Y2W2UeKmbaXhalfA=" crossorigin="anonymous">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.0/css/all.css">

	<link href="/assets/css/style.css" rel="stylesheet">
</head>

<body>
	<header>
		<div class="container">
			<nav class="navbar navbar-expand-lg navbar-light">
				<a class="navbar-brand mb-0 h1" href="/">
					<img src="/assets/img/favicon.png" width="200" height="200" class="align-top d-none d-sm-inline-block navbar-brand-logo" alt=""> <span class="navbar-brand-title d-sm-none d-lg-inline-block">${site.name}</span>
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span> <span class="navbar-toggler-label d-none d-sm-inline-block">Menu</span>
				</button>
				<div class="collapse navbar-collapse mt-lg-5" id="navbarNavAltMarkup">
					<ul class="navbar-nav ml-auto mt-lg-5 mt-3">
					<#list site.pages as page>
						<li class="nav-item <#if page == request.page || page.children?seq_contains(request.page)>active</#if> <#if page.children?has_content>dropdown</#if>">
							<#if page.children?has_content>
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									${page.name} <#if page.friendlyUrl == "seizoen">${.now?string('yyyy')}</#if>
								</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown">
									<#list page.children as subpage>
										<a class="dropdown-item" href="/${subpage.friendlyUrl}">${subpage.name}</a>
									</#list>
								</div>
							<#else>
								<a class="nav-link" href="/${page.friendlyUrl}">${page.name}</a>
							</#if>
						</li>
					</#list>
					</ul>
				</div>
			</nav>

			${inserts.jumbotron!}
		</div>

		<svg style="position: absolute; bottom: -2px; width: 100%; height: 25px" class="d-none d-sm-block" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 50 50" preserveAspectRatio="none">
			<polygon points="0,50 50,50 50,0" style="fill:#ffffff; stroke-width: 0"></polygon>
		</svg>
	</header>

	<div class="container">
		${inserts.body}
	</div>

	<footer>
		<svg style="position: absolute; top: -2px; width: 100%; height: 25px" class="d-none d-sm-block" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 50 50" preserveAspectRatio="none">
			<polygon points="0,0 50,0 50,50" style="fill:#ffffff; stroke-width: 0"></polygon>
		</svg>
		<div class="container">
			<div class="row mx-1">
				<#list site.pages as page>
					<div class="col-sm-6 col-lg-3">
						<ul class="sitemap-item">
							<li>
								<span>${page.name} <#if page.friendlyUrl == "seizoen">${.now?string('yyyy')}</#if></span>
								<#list page.children>
									<ul>
										<#items as subpage>
											<li><a href="/${subpage.friendlyUrl}">${subpage.name}</a></li>
										</#items>
									</ul>
								</#list>
							</li>
						</ul>
					</div>
				</#list>
			</div>
			<p class="mx-3">&copy; ${.now?string('yyyy')} Web Factor</p>
		</div>
	</footer>

	<script src="//code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="//cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="//stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.min.js" integrity="sha256-Y1rRlwTzT5K5hhCBfAFWABD4cU13QGuRN6P5apfWzVs=" crossorigin="anonymous"></script>

	<script type="text/javascript">
		$(document).on('click', '[data-toggle="lightbox"]', function(event) {
			event.preventDefault();
			$(this).ekkoLightbox();
		});
	</script>
</body>
</html>