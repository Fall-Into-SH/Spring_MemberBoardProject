<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>스폰지밥!</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="resources/assets/img/favicon.png" rel="icon">
<link href="resources/assets/img/apple-touch-icon.png"
	rel="apple-touch-icon">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="resources/assets/vendor/animate.css/animate.min.css"
	rel="stylesheet">
<link href="resources/assets/vendor/aos/aos.css" rel="stylesheet">
<link href="resources/assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="resources/assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="resources/assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link href="resources/assets/vendor/glightbox/css/glightbox.min.css"
	rel="stylesheet">
<link href="resources/assets/vendor/swiper/swiper-bundle.min.css"
	rel="stylesheet">

<!-- Template Main CSS File -->
<link href="resources/assets/css/index.css" rel="stylesheet">

<style>
@import url(//fonts.googleapis.com/earlyaccess/jejumyeongjo.css);

.text {
	font-family: 'Jeju Myeongjo', serif;
	font-weight: bold;
}
</style>

<!-- =======================================================
  * Template Name: Restaurantly - v3.9.1
  * Template URL: https://bootstrapmade.com/restaurantly-restaurant-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

	<!-- ======= Top Bar ======= -->
	<div id="topbar" class="d-flex align-items-center fixed-top">
		<div
			class="container d-flex justify-content-center justify-content-md-between">
		</div>
	</div>

	<!-- ======= Header ======= -->
	<header id="header" class="fixed-top d-flex align-items-cente">
		<div
			class="container-fluid container-xl d-flex align-items-center justify-content-lg-between">

			<h1 class="logo me-auto me-lg-0">
				<a href="index.html">집게월드</a>
			</h1>
			<!-- Uncomment below if you prefer to use an image logo -->
			<!-- <a href="index.html" class="logo me-auto me-lg-0"><img src="resources/assets/img/logo.png" alt="" class="img-fluid"></a>-->



			<nav id="navbar" class="navbar order-last order-lg-0">
				<ul>
					<li><a class="nav-link scrollto " href="index">Home</a></li>
					<c:if test="${mode == 'admin'}">
						<li><a class="nav-link scrollto" href="mList">회원목록</a></li>
					</c:if>
					<li class="dropdown"><a href="boList?boMode=all"><span>게시판</span>
							<i class="bi bi-chevron-down"></i></a>
						<ul id="board">
						</ul></li>
					<li><a class="nav-link scrollto active" href="boSponView">스폰지밥!</a></li>
				</ul>
				<i class="bi bi-list mobile-nav-toggle"></i>
			</nav>
			<!-- .navbar -->

			<c:choose>
				<c:when test="${loginId == null}">
					<a href="mLoginForm"
						class="book-a-table-btn scrollto d-none d-lg-flex">로그인</a>
				</c:when>
				<c:otherwise>
					<div>
						<ul>
							<li style="display: inline-block;"><a
								href="mView?memId=${loginId}"
								class="book-a-table-btn scrollto d-none d-lg-flex">&nbsp;계&nbsp;
									정</a></li>
							<li style="display: inline-block;"><a href="mLogOut"
								class="book-a-table-btn scrollto d-none d-lg-flex">로그아웃</a></li>
						</ul>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</header>
	<!-- End Header -->

	<!-- ======= Hero Section ======= -->
	<section id="hero"
		style="padding-top: 50px; background-image: url('resources/assets/img/hero-bg.jpg'); background-repeat: 2">
		<div class="container position-relative text-center text-lg-start"
			data-aos="zoom-in" data-aos-delay="100">
			<div class="row">

				<h2 class="text">스폰지 밥!</h2>
				<div style="size: 30px">
					<c:if test="${mode == 'admin'}">
						<ul style="float: right;">
							<li style="display: inline-block;"><a href="boVideoForm"
								class="book-a-table-btn scrollto d-none d-lg-flex">새 영상</a></li>
						</ul>
					</c:if>
				</div>
				<c:forEach var="list" items="${pagingList}">
					<div>
						<h2 class="text">${list.boTitle}</h2>
						<br /> <a href="${list.boUrl}" class="glightbox play-btn"
							style="width: 400px; height: 200px; background: radial-gradient(#cda45e 50%, rgba(205, 164, 94, 0.4) 52%); border-radius: 0%; display: block; position: relative; overflow: hidden; background-image: url('resources/videoImg/${list.boFileName}'); background-size: 400px 200px;"></a>
						<hr />
					</div>
				</c:forEach>
				<div>
					<table>
						<tr>
							<td>
								<!-- 페이징 처리 --> <!-- [처음]페이지에 대한 처리 --> <c:if
									test="${paging.page <= 1}">
									<c:out value="<< 처음" />
								</c:if> <c:if test="${paging.page > 1}">
									<a href="boSponView?vpage=1&vlimit=${paging.limit}"><c:out
											value="<< 처음" /></a>
								</c:if> <!-- [이전]페이지에 대한 처리 --> <c:if test="${paging.page <= 1}">
									<c:out value="< 이전" />

								</c:if> <c:if test="${paging.page > 1}">
									<a href="boSponView?vpage=${paging.page-1}&vlimit=${paging.limit}"><c:out
											value="< 이전" /></a>
								</c:if> <!-- [페이지번호]페이지에 대한 처리 --> <c:forEach var="i"
									begin="${paging.startPage}" end="${paging.endPage}">

									<c:choose>

										<c:when test="${paging.page == i}">
											<span class="space1">[${i}]</span>
										</c:when>

										<c:otherwise>
											<span class="space1"><a
												href="boSponView?vpage=${i}&vlimit=${paging.limit}">${i}</a></span>
										</c:otherwise>

									</c:choose>

								</c:forEach> <!-- [다음]페이지에 대한 처리 --> <c:if
									test="${paging.page >= paging.maxPage}">
									<c:out value="다음 >" />
								</c:if> <c:if test="${paging.page < paging.maxPage}">
									<a href="boSponView?vpage=${paging.page+1}&vlimit=${paging.limit}"><c:out
											value="다음 >" /></a>

								</c:if> <!-- [마지막]페이지에 대한 처리 --> <c:if
									test="${paging.page >= paging.maxPage}">
									<c:out value="마지막 >>" />
								</c:if> <c:if test="${paging.page < paging.maxPage}">
									<a href="boSponView?vpage=${paging.maxPage}&vlimit=${paging.limit}"><c:out
											value="마지막 >>" /></a>

								</c:if>
							</td>
						</tr>
					</table>
				</div>

			</div>
		</div>
	</section>
	<!-- End Hero -->


	<div id="preloader"></div>
	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script src="resources/assets/vendor/aos/aos.js"></script>
	<script
		src="resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script
		src="resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script src="resources/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="resources/assets/js/main.js"></script>

</body>
<script src="https://code.jquery.com/jquery-3.6.1.js"
	integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI="
	crossorigin="anonymous">
	
	</script>
<script>

// 게시판 목록 불러오기
$.ajax({
	type : "GET",
	url : "boardList",
	data : {
	},
	dataType : "json",
	success : function(result){
		boardList(result);
	},
	error : function(){
		alert("게시판 불러오기 통신 실패")
	}
});

// 게시판 목록 불러오기 함수
function boardList(result){
	let output = "";
	

	if(${mode == 'admin'}){
	output+="<li><a href='boardAdmin'>게시판 관리</a></li>";
	}
	
	for(let i in result){
		output+="<li><a href='boList?boMode="+result[i].boMode+"'>"+result[i].boMode+ " 게시판</a></li>";
	}
	
	document.getElementById("board").innerHTML = output;
	
}

</script>
<script>
	function changeLimit(limit) {
		location.href = "boList?limit=" + limit;
	}
</script>
</html>