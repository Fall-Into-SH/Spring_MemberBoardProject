<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>회원수정</title>
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
	background-repeat: 2;
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


	<c:if test="${loginId == modify.memId || loginId == 'admin'}">
		<div class="member">
			<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
			<br /> <br /> <br />
			<form action="mModify" method="post" name="modifyForm"
				enctype="multipart/form-data">
				<div style="background: #d8d8ff;">
					<h1 class="logintext">회원 수정</h1>
				</div>

				<div class="field" style="background: #d8d8ff;">
					<ul>
						<li style="display: inline-block;">
							<h3 class="logintext">아이디 :</h3> <input type="hidden"
							name="memId" value="${modify.memId}" /> <input type="hidden"
							name="DFileName" value="${modify.DFileName}" />
							<input type="hidden"
							name="memEmail" value="${modify.memEmail}" />
						</li>
						<li style="display: inline-block;">
							<h3 class="logintext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${modify.memId}</h3>
						</li>
					</ul>
					<ul>
						<li style="display: inline-block;">
							<h3 class="logintext">비밀번호 :</h3>
						</li>
						<li style="display: inline-block;">
							<h3 class="logintext">
								&nbsp;&nbsp;<input type="hidden" name="memPw"
									value="${modify.memPw}" /> <input type="button"
									value="비밀번호 변경" onclick="chagePw('${modify.memId}')">
							</h3>
						</li>
					</ul>
					<ul>
						<li style="display: inline-block;">
							<h3 class="logintext">프로필사진 :</h3>
						</li>
						<li style="display: inline-block;"><input type="file"
							name="memProfile" /></li>
						<li style="display: inline-block;"><img
							src="resources/profileImg/${modify.memProfileName}" width="100%" />
						</li>
					</ul>
					<ul>
						<li style="display: inline-block;">
							<h3 class="logintext">이름 :</h3>
						</li>
						<li style="display: inline-block;">
							<h3 class="logintext">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
							<div class="field">
								<input type="text" name="memName" value="${modify.memName}">
							</div>
						</li>
					</ul>
					<ul>
						<li style="display: inline-block;">
							<h3 class="logintext">생년월일 :</h3>
						</li>
						<li style="display: inline-block;">
							<div class="field birth">
								<div>
									<input type="number" placeholder="년(4자)" name="memBirth1"
										value="${modify.memBirth1}"> <select name="memBirth2">
										<option value="${modify.memBirth2}">${modify.memBirth2}월</option>
										<option value="01">1월</option>
										<option value="02">2월</option>
										<option value="03">3월</option>
										<option value="04">4월</option>
										<option value="05">5월</option>
										<option value="06">6월</option>
										<option value="07">7월</option>
										<option value="08">8월</option>
										<option value="09">9월</option>
										<option value="10">10월</option>
										<option value="11">11월</option>
										<option value="12">12월</option>
									</select> <input type="number" placeholder="일" name="memBirth3"
										value="${modify.memBirth3}">
								</div>
							</div>
						</li>
					</ul>
					<ul>
						<li style="display: inline-block;">
							<h3 class="logintext">성별 :</h3>
						</li>
						<li style="display: inline-block;"><c:choose>
								<c:when test="${modify.memGender == '남'}">
									<div>
										<label><input type="radio" name="memGender" value="남"
											checked>남자</label> <label><input type="radio"
											name="memGender" value="여">여자</label> <label><input
											type="radio" name="memGender" value="무">선택안함</label>
									</div>
								</c:when>
								<c:when test="${modify.memGender == '여'}">
									<div>
										<label><input type="radio" name="memGender" value="남">남자</label>
										<label><input type="radio" name="memGender" value="여"
											checked>여자</label> <label><input type="radio"
											name="memGender" value="무">선택안함</label>
									</div>
								</c:when>
								<c:when test="${modify.memGender == '무'}">
									<div>
										<label><input type="radio" name="memGender" value="남">남자</label>
										<label><input type="radio" name="memGender" value="여">여자</label>
										<label><input type="radio" name="memGender" value="무"
											checked>선택안함</label>
									</div>
								</c:when>

							</c:choose></li>
					</ul>
					<ul>
						<li style="display: inline-block;">
							<h3 class="logintext">이메일 :</h3>
						</li>
						<li style="display: inline-block;">
							<h3 class="logintext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${modify.memEmail}</h3>
						</li>
					</ul>
					<ul>
						<li style="display: inline-block;">
							<h3 class="logintext">연락처 :</h3>
						</li>
						<li style="display: inline-block;">
							<h3 class="logintext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
							<div class="field tel-number">
								<div>
									<input type="tel" placeholder="전화번호 입력" name="memPhone"
										value="${modify.memPhone}" />
								</div>
							</div>
						</li>
					</ul>
					<ul>
						<li style="display: inline-block;">
							<h3 class="logintext">주소 :</h3>
						</li>
					</ul>
					<ul>
						<li style="display: inline-block;"><input type="text"
							id="sample6_postcode" placeholder="우편번호" name="addr1"
							value="${modify.addr1}"> <input type="button"
							onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" id="sample6_address" placeholder="주소"
							name="addr2" value="${modify.addr2}"><br> <input
							type="text" id="sample6_detailAddress" placeholder="상세주소"
							name="addr3" value="${modify.addr3}"></li>
					</ul>



				</div>
				<div class="field" style="text-align: center;">
					<input type="button" value="정보수정"
							onclick="checkConFirm()">
				</div>
			</form>
		</div>
	</c:if>


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
	<c:when test="${loginId == modify.memId || loginId == 'admin'}">

	</c:when>
	<c:when test="${loginId eq null}">
		<script>
		alert("로그인후 사용하세요");
		location.href = "mLoginForm";
	</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("수정권한이 없습니다.");
			location.href = "index";
		</script>
	</c:otherwise>
</c:choose>

<script>	
	// 비밀번호에서 알맞은 값이 나와야 제출
	function checkConFirm() {

			modifyForm.submit();
	}

// 비밀번호 바꾸고 싶어염
function chagePw(memid) {
	location.href='mChangePw?memId='+memid;

}

	// 가입버튼
	function checkConfirm() {
		alert('아이디 중복체크를 실행해주세요!');
	}
	
	// 비밀번호 정규식
	function pwRegexp(){
		let memPw = document.getElementById("memPw").value;
		let pwResult1 = document.getElementById("pwResult1");
		
		// search는 찾은 갯수를 나타내며 찾지못하면 -1으로 표시된다.
		let num = memPw.search(/[0-9]/);
		let eng = memPw.search(/[a-z]/);
		let spe = memPw.search(/[`~!@#$%^&*|\\\'\":;\/?]/);
		// 특수문자 : `~!@#$%^&*|\\\'\":;\/?
		let spc = memPw.search(/\s/);
		if(memPw.length < 8 || memPw.length > 16){
			pwResult1.style.color = "#ff0000";
			pwResult1.innerHTML = "비밀번호는 8자리에서 16자리 이내로 입력해주세요.";
			return false;
			
		} else if(spc != -1){
			pwResult1.style.color = "#ff0000";
			pwResult1.innerHTML = "비밀번호는 공백없이 입력해주세요.";
			return false;
		
		} else if(num < 0 || eng < 0 || spe < 0){
			pwResult1.style.color = "#ff0000";
			pwResult1.innerHTML = "영문, 숫자, 특수문자를 혼합하여 입력해주세요.";
			return false;
		
		} else {
			pwResult1.style.color = "#0000ff";
			pwResult1.innerHTML = "사용가능한 비밀번호 입니다.";
			return true;
		}
		

	}
	
	// 비밀번호가 일치하는가?
	function pwCheck() {
		let memPw = document.getElementById("memPw").value;
		let checkPw = document.getElementById("checkPw").value;
		let pwResult2 = document.getElementById("pwResult2");
		
		if(memPw==checkPw){
			pwResult2.style.color = "#0000ff";
			pwResult2.innerHTML = "비밀번호가 일치합니다.";
			return true;	
		} else{
			pwResult2.style.color = "#ff0000";
			pwResult2.innerHTML = "비밀번호가 일치하지 않습니다."
			return false;
		}
	}
</script>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

</html>