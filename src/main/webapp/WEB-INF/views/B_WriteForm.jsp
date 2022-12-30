<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>회원목록</title>
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

table {
	width: 50%;
}

td, th {
	padding: 10;
	height: 50px;
}

th {
	width: 200px;
}

td {
	width: 300px;
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
					<li><a class="nav-link scrollto" href="boSponView">스폰지밥!</a></li>
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
	<section id="hero" style="padding-top: 50px;">
		<div class="container position-relative text-center text-lg-start"
			data-aos="zoom-in" data-aos-delay="100">
			<div class="row" style="text-align: center;">
				<form action="boWrite" method="POST" enctype="multipart/form-data">
					<h1 class="text">게시글 작성</h1>

					<div class="field">
						<div id="board1">
							<select style="float: right;" name="boMode" >
								<option value="${boardMode}">${boardMode}</option>
							</select>
							<h2 class="text" style="float: right;">게시판 선택:</h2>
						</div>
						<br/>
						<table
							style="margin-left: auto; margin-right: auto; font-size: 20px;">
							<thead>
								<tr>
									<th>항목</th>
									<th>내용</th>
								</tr>

							</thead>

							<tbody>
								<tr>
									<th>작성자</th>
									<td>${loginId}<input type="hidden" name="boWriter"
										value="${loginId}" /></td>
								</tr>
								<tr>
									<th>제목</th>
									<td><input type="text" name="boTitle" style="width: 100%;" /></td>
								</tr>
								<tr>
									<th>내용</th>
									<td style="height: 100px;"><textarea name="boContent"
											style="width: 100%; height: 100%;"></textarea></td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td><input type="file" name="boFile" /></td>
								</tr>
							</tbody>

							<tfoot>
								<tr>
									<th></th>
									<td><input
										style="background-color: orange; color: white; float: right;"
										type="submit" value="작성완료"></td>
								</tr>
							</tfoot>
						</table>
					</div>
				</form>
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
	let output1 = "";

	if(${mode == 'admin'}){
	output+="<li><a href='boardAdmin'>게시판 관리</a></li>";
	}
	
	for(let i in result){
		output+="<li><a href='boList?boMode="+result[i].boMode+"'>"+result[i].boMode+ " 게시판</a></li>";
	}
	
	document.getElementById("board").innerHTML = output;
	




	// 글작성시 게시판 선택
	output1+="	<select style='float: right;' name='boMode'>";
	output1+="<option value='${boardMode}'>${boardMode}</option>";
	for(let i in result){
		output1+="<option value="+result[i].boMode+">"+result[i].boMode+"</option>";
	}
	output1+="</select>"
	output1+="<h2 class='text' style='float: right;'>게시판 선택 &nbsp;:&nbsp;</h2>"
	document.getElementById("board1").innerHTML = output1;
	
}

</script>
<script>

</script>

<c:if test="${loginId eq null}">
	<script>
	alert("로그인후 사용하세요");
	location.href="mLoginForm";
</script>
</c:if>
</html>