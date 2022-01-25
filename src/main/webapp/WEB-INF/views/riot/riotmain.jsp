<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Dev등록" name="title" />
</jsp:include>
<br>
<style type="text/css">
@font-face {
	font-family: 'CookieRun-Regular';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/CookieRun-Regular.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

#nadaumgg {
	text-align: center;
}

#nadaumgg h1 {
	font-family: 'CookieRun-Regular';
	color: #00f0f7
}

#aaa {
	text-align: center;
}

#bbb {
	width: 500px;
	height: 500px;
	position: absolute;
	right: 5%;
}

input[type="text"] {
	width: 70%;
	height: 100%;
	font-size: 1em;
	padding-left: 5px;
	font-style: oblique;
	display: inline;
	box-sizing: border-box;
	color: black;
}

input[type=button] {
	width: 30%;
	height: 100%;
	background-color: lightgray;
	border: none;
	background-color: white;
	font-size: 1em;
	color: #042AaC;
	outline: none;
	display: inline;
	margin-left: -10px;
	box-sizing: border-box;
}

input[type=button]:hover {
	background-color: lightgray;
}
</style>

<div id="nadaumgg">
	<h1>Nadaum.gg</h1>
</div>

<div id="aaa">
	<div id="bbb">
		<form id="riotnick" method="GET">
			<input type="text" id="nickname" name="nickname"
				placeholder="소환사명을 입력하세요" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-lg" />
			<button type="button" onclick="submit('riot1')"
				class="btn btn-sm btn-outline-secondary">전적검색</button>

		</form>

	</div>
</div>
<br>
<br>

<div class="jumbotron p-3 p-md-3 text-white rounded bg-blue">
	<div class="col-md-6 px-0">
		<img alt="아이콘" src=${ img} style="width: 200px">
	</div>
	<div class="col-md-6 px-0">
		<h1 class="display-4 font-italic">${summoner.name}</h1>
	</div>
</div>

<div class="row mb-2">
	<div class="col-md-6">
		<div
			class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
			<div class="col-auto d-none d-lg-block">
				<c:choose>
					<c:when test="${leagueentry.tier != null}">
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/${leagueentry.tier}.png"
							style="width: 200px">
					</c:when>
					<c:otherwise>
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/unranked.png"
							style="width: 200px; height: 229.3px;">
					</c:otherwise>
				</c:choose>
				
			</div>
			<div class="col p-4 d-flex flex-column position-static">
				<h3 class="d-inline-block mb-2 text-dark">솔로랭크</h3>
				<h3 class="mb-2 text-primary">${leagueentry.tier}
					${leagueentry.rank} ${leagueentry.leaguePoints} LP</h3>

				<h3 class="mb-0">${leagueentry.wins}승${leagueentry.losses}패</h3>

			</div>
		</div>
	</div>
	<div class="col-md-6">
		<div
			class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
			<div class="col-auto d-none d-lg-block">
				<c:choose>
					<c:when test="${leagueentries.tier != null}">
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/${leagueentries.tier}.png"
							style="width: 200px">
					</c:when>
					<c:otherwise>
						<img alt="랭크"
							src="${pageContext.request.contextPath}/resources/images/riot/unranked.png"
							style="width: 200px; height: 229.3px;">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col p-4 d-flex flex-column position-static">
				<h3 class="d-inline-block mb-2 text-dark">자유랭크</h3>
				<h3 class="mb-2 text-primary">${leagueentries.tier}
					${leagueentries.rank} ${leagueentries.leaguePoints} LP</h3>

				<h3 class="mb-0">${leagueentries.wins}승${leagueentries.losses}패</h3>

			</div>
		</div>
	</div>

</div>



<main role="main" class="container">
	<div class="row">
		<div class="col-md-8 blog-main">
			<h3 class="pb-4 mb-4 font-italic border-bottom">From the
				Firehose</h3>

			<div class="blog-post">
				<h2 class="blog-post-title">Sample blog post</h2>
				<p class="blog-post-meta">
					January 1, 2014 by <a href="#">Mark</a>
				</p>

				<p>This blog post shows a few different types of content that’s
					supported and styled with Bootstrap. Basic typography, images, and
					code are all supported.</p>
				<hr>
				<p>
					Yeah, she dances to her own beat. Oh, no. You could've been the
					greatest. 'Cause, baby, <a href="#">you're a firework</a>. Maybe a
					reason why all the doors are closed. Open up your heart and just
					let it begin. So très chic, yeah, she's a classic.
				</p>
				<blockquote>
					<p>
						Bikinis, zucchinis, Martinis, no weenies. I know there will be
						sacrifice but that's the price. <strong>This is how we do
							it</strong>. I'm not sticking around to watch you go down. You think
						you're so rock and roll, but you're really just a joke. I know one
						spark will shock the world, yeah yeah. Can't replace you with a
						million rings.
					</p>
				</blockquote>
				<p>
					Trying to connect the dots, don't know what to tell my boss. Before
					you met me I was alright but things were kinda heavy. You just
					gotta ignite the light and let it shine. Glitter all over the room
					<em>pink flamingos</em> in the pool.
				</p>
				<h2>Heading</h2>
				<p>Suiting up for my crowning battle. If you only knew what the
					future holds. Bring the beat back. Peach-pink lips, yeah, everybody
					stares.</p>
				<h3>Sub-heading</h3>
				<p>You give a hundred reasons why, and you say you're really
					gonna try. Straight stuntin' yeah we do it like that. Calling out
					my name. ‘Cause I, I’m capable of anything.</p>
				<pre>
					<code>Example code block</code>
				</pre>
				<p>Before you met me I was alright but things were kinda heavy.
					You just gotta ignite the light and let it shine.</p>
				<h3>Sub-heading</h3>
				<p>You got the finest architecture. Passport stamps, she's
					cosmopolitan. Fine, fresh, fierce, we got it on lock. Never planned
					that one day I'd be losing you. She eats your heart out.</p>
				<ul>
					<li>Got a motel and built a fort out of sheets.</li>
					<li>Your kiss is cosmic, every move is magic.</li>
					<li>Suiting up for my crowning battle.</li>
				</ul>
				<p>Takes you miles high, so high, 'cause she’s got that one
					international smile.</p>
				<ol>
					<li>Scared to rock the boat and make a mess.</li>
					<li>I could have rewrite your addiction.</li>
					<li>I know you get me so I let my walls come down.</li>
				</ol>
				<p>After a hurricane comes a rainbow.</p>
			</div>
			<!-- /.blog-post -->

			<div class="blog-post">
				<h2 class="blog-post-title">Another blog post</h2>
				<p class="blog-post-meta">
					December 23, 2013 by <a href="#">Jacob</a>
				</p>

				<p>
					I am ready for the road less traveled. Already <a href="#">brushing
						off the dust</a>. Yeah, you're lucky if you're on her plane. I used to
					bite my tongue and hold my breath. Uh, She’s a beast. I call her
					Karma (come back). Black ray-bans, you know she's with the band. I
					can't sleep let's run away and don't ever look back, don't ever
					look back.
				</p>
				<blockquote>
					<p>
						Growing fast into a <strong>bolt of lightning</strong>. Be careful
						Try not to lead her on
					</p>
				</blockquote>
				<p>I'm intrigued, for a peek, heard it's fascinating. Oh oh!
					Wanna be a victim ready for abduction. She's got that international
					smile, oh yeah, she's got that one international smile. Do you ever
					feel, feel so paper thin. I’m gon’ put her in a coma. Sun-kissed
					skin so hot we'll melt your popsicle.</p>
				<p>This is transcendental, on another level, boy, you're my
					lucky star.</p>
			</div>
			<!-- /.blog-post -->

			<div class="blog-post">
				<h2 class="blog-post-title">New feature</h2>
				<p class="blog-post-meta">
					December 14, 2013 by <a href="#">Chris</a>
				</p>

				<p>From Tokyo to Mexico, to Rio. Yeah, you take me to utopia.
					I'm walking on air. We'd make out in your Mustang to Radiohead. I
					mean the ones, I mean like she's the one. Sun-kissed skin so hot
					we'll melt your popsicle. Slow cooking pancakes for my boy, still
					up, still fresh as a Daisy.</p>
				<ul>
					<li>I hope you got a healthy appetite.</li>
					<li>You're never gonna be unsatisfied.</li>
					<li>Got a motel and built a fort out of sheets.</li>
				</ul>
				<p>
					Don't need apologies. Boy, you're an alien your touch so foreign,
					it's <em>supernatural</em>, extraterrestrial. Talk about our future
					like we had a clue. I can feel a phoenix inside of me.
				</p>
			</div>
			<!-- /.blog-post -->

			<nav class="blog-pagination">
				<a class="btn btn-outline-primary" href="#">Older</a> <a
					class="btn btn-outline-secondary disabled">Newer</a>
			</nav>

		</div>
		<!-- /.blog-main -->

		<div id="ccc">
			<p>${summoner.name}</p>
			<img alt="아이콘" src=${ img}>
			<p>${leagueentry.tier}${leagueentry.rank}</p>
			<img alt="랭크"
				src="${pageContext.request.contextPath}/resources/images/riot/${leagueentry.tier}.png">
		</div>



		<script>
const submit => {
	$(riotnick)
		.attr("action", `${pageContext.request.contextPath}/riot/\${name}.do`)
		.submit();
		


};



</script>



		<jsp:include page="/WEB-INF/views/common/footer.jsp" />