<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>회원정보</title>
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
<link href="resources/assets/css/mview2.css" rel="stylesheet">

<style>
@import url(//fonts.googleapis.com/earlyaccess/jejumyeongjo.css);

body {
	background-image: url("resources/assets/img/background/mviewbg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}

.logintext {
	font-family: 'Jeju Myeongjo', serif;
	text-align: center;
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
					<li><a class="nav-link scrollto" href="index">Home</a></li>
					<c:if test="${mode == 'admin'}">
						<li><a class="nav-link scrollto" href="mList">회원목록</a></li>
					</c:if>
					<li class="dropdown"><a href="boList?boMode=all"><span>게시판</span>
							<i class="bi bi-chevron-down"></i></a>
						<ul id="board">
						</ul></li>
					<li><a class="nav-link scrollto" href="boSponView">스폰지밥!</a></li>
				</ul>
				<i class="bi bi-list mobile-nav-toggle"></i>
			</nav>
			<!-- .navbar -->


			<c:choose>
				<c:when test="${loginId == null}">
					<a href="mLoginForm"
						class="book-a-table-btn scrollto d-none d-lg-flex">회원 정보</a>
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



	<div class="member">
		<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
		<br /> <br /> <br />

		<div style="background: #d8d8ff;">
			<h1 class="logintext">회원 정보</h1>
		</div>
		<div style="size: 30px">
			<ul style="float: right;">
				<li style="display: inline-block;"><a href='boSearch?category=BOWRITER&keyword=${view.memId}'
					class="book-a-table-btn scrollto d-none d-lg-flex">내가쓴 글</a></li>
			</ul>
		</div>
		<div class="field" style="background: #d8d8ff;">
			<ul>
				<li style="display: inline-block;">
					<h3 class="logintext">아이디 :</h3>
				</li>
				<li style="display: inline-block;">
					<h3 class="logintext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${view.memId}</h3>
				</li>
			</ul>
			<ul>
				<li style="display: inline-block;">
					<h3 class="logintext">프로필사진 :</h3>
				</li>
				<li style="display: inline-block;"><img
					src="resources/profileImg/${view.memProfileName}" width="100%" />
				</li>
			</ul>
			<ul>
				<li style="display: inline-block;">
					<h3 class="logintext">이름 :</h3>
				</li>
				<li style="display: inline-block;">
					<h3 class="logintext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${view.memName}</h3>
				</li>
			</ul>
			<ul>
				<li style="display: inline-block;">
					<h3 class="logintext">생년월일 :</h3>
				</li>
				<li style="display: inline-block;">
					<h3 class="logintext">&nbsp;&nbsp;${view.memBirth}</h3>
				</li>
			</ul>
			<ul>
				<li style="display: inline-block;">
					<h3 class="logintext">성별 :</h3>
				</li>
				<li style="display: inline-block;">
					<h3 class="logintext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${view.memGender}</h3>
				</li>
			</ul>
			<ul>
				<li style="display: inline-block;">
					<h3 class="logintext">이메일 :</h3>
				</li>
				<li style="display: inline-block;">
					<h3 class="logintext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${view.memEmail}</h3>
				</li>
			</ul>
			<ul>
				<li style="display: inline-block;">
					<h3 class="logintext">연락처 :</h3>
				</li>
				<li style="display: inline-block;">
					<h3 class="logintext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${view.memPhone}</h3>
				</li>
			</ul>
			<ul>
				<li style="display: inline-block;">
					<h3 class="logintext">주소 :</h3>
				</li>
				<li style="display: inline-block;">
					<h4 class="logintext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${view.memAddr}</h4>
				</li>
			</ul>



		</div>
		<div class="field" style="text-align: center;">
			<ul>
				<li style="display: inline-block;"><input type="button"
					value="수정"
					onclick="location.href='mModifyForm?memId=${view.memId}'" /></li>
				<li style="display: inline-block;"><input type="button"
					value="삭제" onclick="mdelete('${view.memId}')" /></li>


			</ul>
		</div>
	</div>


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

<c:choose>

	<c:when test="${loginId == view.memId || loginId == 'admin'}">
		<script>
			function mdelete(loginId) {
				let conf = confirm('정말 삭제 하겠습니까?');

				if (conf) {
					alert('삭제 했습니다.');
					location.href = "mDelete?memId=" + loginId;
				} else {
					alert('삭제를 취소했습니다.');
				}

			}
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("타인의정보는 볼 수 없습니다.");
			location.href = "index";
		</script>
	</c:otherwise>
</c:choose>

</html>