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
	width: 100%;
}

td, th {
	padding: 10;
	height: 50px;
}

th {
	width: 100px;
}

td {
	width: 200px;
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
	<section id="hero" class="d-flex align-items-center">
		<div class="container position-relative text-center text-lg-start"
			data-aos="zoom-in" data-aos-delay="100">
			<div class="row">

				<!-- 내용 시작지점 -->

				<c:if test="${loginId != null || boardMode == '자유'}">
					<h2 class="text">${view.boTitle}</h2>
					<table id="tab">
						<caption style="font-size: 30px;"></caption>
						<tr>
							<th>작성자 : <c:if test="${view.boMode == '익명'}">익명</c:if> <c:if
									test="${view.boMode != '익명'}">
									<a href='boSearch?category=BOWRITER&keyword=${view.boWriter}'>${view.boWriter}</a>
								</c:if> | ${view.boDate}
							</th>
							<th style="text-align: right;">조회 ${view.boHit} | 추천 ㅁㅁ | <a
								href='#cmt'>댓글</a></th>
						</tr>
						<tr>
							<c:if test="${loginId == view.boWriter || loginId == 'admin'}">
								<th colspan="2" style="text-align: right;"><input
									type="button" value="수정"
									onclick="location.href='boModifyForm?boNum=${view.boNum}&boMode=${view.boMode}'" />
									<input type="button" value="삭제"
									onclick="location.href='boDelete?boNum=${view.boNum}&boMode=${view.boMode}'" /></th>
							</c:if>
						</tr>
						<tr>
							<td><br />${view.boContent}</td>
						</tr>
						<tr>

							<td><br /> <br /> <img
								src="resources/boardImg/${view.boFileName}" width="300px" /></td>
						</tr>



					</table>
					<br />
					<br />
					<div>
						<br />
						<h2 class="text" id='cmt'>댓글</h2>
						<hr />
					</div>
					<div id="cmtArea"></div>

					<div style="float: right;">
						<h2 class="text">
							작성자 :
							<c:if test="${view.boMode == '익명'}">익명</c:if>
							<c:if test="${view.boMode != '익명'}">${loginId}</c:if>
						</h2>
					</div>
					<div>
						<input type="hidden" value="${view.boNum}" id="cbNum" /> <input
							type="hidden" value="${loginId}" id="cmtWriter" />
						<textarea style="float: right; width: 100%;" rows="2" cols="100"
							id="cmtContent" onfocus="checkLogin()"></textarea>
						<br />
					</div>
					<div>
						<button onclick="cmtWrite()" style="float: right;">댓글입력</button>
					</div>

				</c:if>

				<!-- 내용끝지점 -->
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


<c:if test="${loginId eq null}">
	<script>
		alert("로그인후 사용하세요");
		location.href = "mLoginForm";
	</script>

</c:if>

<script src="https://code.jquery.com/jquery-3.6.1.js"
	integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI="
	crossorigin="anonymous">
	
	</script>
<script>
//게시판 목록 불러오기
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

let cbNum = ${view.boNum};

$.ajax({
	type : "GET",
	url : "comment/commentList",
	data : {
		"cbNum" : cbNum
	},
	dataType : "json",
	success : function(result){
		commentList(result);
	},
	error : function(){
		alert("댓글 불러오기 통신 실패")
	}
});

// 댓글 불러오기 함수
function commentList(result){
	let output = "";
	
	output +="<table>";
	output +="<tr>";
	output +="<th>작성자</th>";
	output +="<th>내용</th>";
	output +="<th>작성일</th>";
	if('${loginId}'== '${view.boWriter}' || ${loginId eq 'admin'}){
	output +="<th>삭제/수정</th>";
	}
	output +="</tr>";
	
	
	for(let i in result){
		output +="<tr>";
		if(${view.boMode=='익명'}){
			output +="<td>익명</td>";
		}else{
			output +="<td>"+result[i].cmtWriter+"</td>";
		}
		
		output +="<td id="+result[i].cmtNum+'table'+result[i].cbNum+">"+result[i].cmtContent+"<input type='hidden' value='"+result[i].cmtContent+"' id="+result[i].cmtNum+'old'+result[i].cbNum+" /></td>";
		output +="<td>"+result[i].cmtDate+"</td>";
		console.log(result[i].cmtWriter)
		if('${loginId}'== result[i].cmtWriter||${loginId eq 'admin'})
			{
		output +="<td id="+result[i].cmtNum+'butt'+result[i].cbNum+"><button onclick='cmtDelete("+result[i].cmtNum+", "+result[i].cbNum+")'>삭제</button>";
		output +="<button onclick='cmtModify("+result[i].cmtNum+", "+result[i].cbNum+")'>수정</button></td>";
			}
		output +="</tr>";
	}
	
	output +="</table>"
	document.getElementById("cmtArea").innerHTML = output;
	
}

// 댓글 삭제
function cmtDelete(cmtNum, cbNum){
	console.log(cmtWriter);
	$.ajax({
		type : "POST",
		url : "comment/cmtDelete",
		data : {
			"cmtNum" : cmtNum,
			"cbNum" : cbNum
		},
		dataType : "json",
		success : function(list){
			commentList(list);
		},
		error : function(){
			alert('댓글 작성 통신 실패!');
		}
	});
}

// 댓글 입력
function cmtWrite(){
	let cmtWriter = document.getElementById("cmtWriter").value;
	let cmtContent = $("#cmtContent").val();
	let cbNum = $("#cbNum").val();
	
	$.ajax({
		type : "POST",
		url : "comment/cmtWrite",
		data : {
			"cbNum" : cbNum,
			"cmtWriter" : cmtWriter,
			"cmtContent" : cmtContent
		},
		dataType : "json",
		success : function(list){
			commentList(list);
		},
		error : function(){
			alert('댓글 작성 통신 실패!');
		}
	});
}

// 댓글 수정 폼
function cmtModify(cmtNum, cbNum){
	// 기존 댓글 아이디
	let id = cmtNum+"old"+cbNum;
	
	// 댓글 수정 할 공간으로 기존 댓글있던 자리에 띄움
	let area = cmtNum+"table"+cbNum;
	//console.log("id : "+id);
	
	// 기존 댓글 내용
	let modi = $("#"+id).val();
	//console.log("수정 : "+modi);
	
	let output ="<textarea rows='5' cols='20' id='"+cmtNum+"ch"+cbNum+"'>"+modi+"</textarea>";
	document.getElementById(area).innerHTML = output;
	document.getElementById(cmtNum+"butt"+cbNum).innerHTML = "<button onclick='cmtModify1("+cmtNum+','+cbNum+")'>수정</button>";
	
}
// 댓글 수정 실행
function cmtModify1(cmtNum, cbNum){
	let cmtContent = $("#"+cmtNum+"ch"+cbNum).val();
	//console.log(cmtContent);
	$.ajax({
		type : "POST",
		url : "comment/cmtModify",
		data : {
			"cbNum" : cbNum,
			"cmtNum" : cmtNum,
			"cmtContent" : cmtContent
		},
		dataType : "json",
		success : function(list){
			commentList(list);
		},
		error : function(){
			alert('댓글 작성 통신 실패!');
		}
	});
}

// 댓글 로그인 확인
function checkLogin(){
	// console.log("확인");
	if(${loginId == null}){
		$("#cmtContent").blur();
		alert('로그인 후 사용해주세요');
		location.href="mLoginForm";
	}
}
</script>


</html>