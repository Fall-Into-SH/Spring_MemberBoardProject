<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>회원가입</title>
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
<link href="resources/assets/css/mjoin.css" rel="stylesheet">
<style>
body {
	background-image: url("resources/assets/img/background/mjoinbg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
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
    <div class="container-fluid container-xl d-flex align-items-center justify-content-lg-between">

      <h1 class="logo me-auto me-lg-0"><a href="index.html">집게월드</a></h1>
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
			
			
      <a href="mLoginForm" class="book-a-table-btn scrollto d-none d-lg-flex">로그인</a>

    </div>
  </header><!-- End Header -->


	<form action="mJoin" method="post" name="joinForm"
		enctype="multipart/form-data">
		
		<div class="member" style="color: black;">
			<br /> <br /> <br /> <br /> <br /> <br /> <br />


			<div class="field">
				<b>아이디</b> <span><input type="text" name="memId" Id="memId"
						onkeyup="checkId()"><span id="check1"></span></span>
			</div>
			<div class="field">
				<b>비밀번호</b> <input class="userpw" type="password" name="memPw" id="memPw"
						onkeyup="pwRegexp()"> <br /> <span id="pwResult1"></span>
			</div>
			<div class="field">
				<b>비밀번호 재확인</b> <input class="userpw-confirm" type="password" id="checkPw" onkeyup="pwCheck()">
				<br /> <span id="pwResult2"></span>
			</div>
			<div class="field">
				<b>이름</b> <input type="text" name="memName">
			</div>


			<div class="field birth">
				<b>생년월일</b>
				<div>
					<input type="number" placeholder="년(4자)" name="memBirth1"> <select name="memBirth2">
						<option value="">월</option>
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
					</select> <input type="number" placeholder="일" name="memBirth3">
				</div>
			</div>

			<!-- 4. 필드(성별) -->
			<div class="field gender">
				<b>성별</b>
				<div>
					<label><input type="radio" name="memGender" value="남">남자</label> <label><input
						type="radio" name="memGender" value="여">여자</label> <label><input
						type="radio" name="memGender" value="무">선택안함</label>
				</div>
			</div>

			<!-- 5. 이메일_전화번호_사진 -->
			<div class="field">
				<b>본인 확인 이메일</b> <input type="email" placeholder="이메일 입력" name="memEmail" id="memEmail"/> 
				<span id="confEmail"><input type="button" value="인증번호 발송"
							onclick="checkEmail()" style="background-color: orange; color: white"></span>
			</div>

			<div class="field tel-number">
				<b>휴대전화</b>
				<div>
					<input type="tel" placeholder="전화번호 입력" name="memPhone">
				</div>
			</div>

			<div class="field">
				<b>주소</b> <input type="text" id="sample6_postcode"
					placeholder="우편번호" name="addr1"> <input type="button"
					onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="background-color: orange; color: white"> <input
					type="text" id="sample6_address" placeholder="주소" name="addr2"><br>
				<input type="text" id="sample6_detailAddress" placeholder="상세주소"
					name="addr3">
			</div>
			
			<div class="field">
					<b>프로필 사진</b>
					<input type="file" name="memProfile" />
			</div>

			<!-- 6. 가입하기 버튼 -->
			<input type="button" onclick="checkConfirm()" value="가입하기" style="background-color: orange; color: white">


		</div>
	</form>


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
	crossorigin="anonymous"></script>
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

	// 아이디 중복체크 및 적합성 체크
	function checkId() {
		let memId = document.getElementById("memId").value;
		let spc = memId.search(/\s/);
		let spe = memId.search(/[`~!@#$%^&*|\\\'\":;\/?]/);
		let check1 = document.getElementById("check1");
		let conf = false;
		
 	if(memId==null || memId==""){
			alert('아이디를 입력해주세요');
		}else if(spc != -1){
			alert('아이디에 공백을 제거해 주세요');
		}else if(spe != -1){
			alert('아이디에 특수문자를 제거해 주세요');
		}else{
			//location.href='mIdCheck?memId='+ memId;
			$.ajax({
				type : "POST",
				url : "idoverlap",
				data : {
					"memId" : memId
				},
				async : false,
				dataType : "text", 
				success : function(result){
					if(result=="OK"){
						// 사용할 수 있는 아이디일 경우 실행
						check1.innerHTML = "사용가능한 아이디";
						check1.style.color = "#0000ff";
						conf = true;
						console.log("확인1 : "+conf);
					} else {
						// 사용할 수 없는 아이디일 경우 실행
						check1.innerHTML = "이미 사용중인 아이디";
						check1.style.color = "#ff0000";
					}
				},
				error : function(){
					alert("idoverlap함수 통신실패!");
				}
				
			});
				
 		}
 	return conf;
	}

	// 가입버튼
	function checkConfirm() {
		
		
		if(checkId() && pwRegexp() && pwCheck() && checkEmail2()){
			
			joinForm.submit();
			
		} else if(!checkId()){
			
			alert('아이디 중복체크를 확인해주세요.');
			
		} else if(!checkEmail2()){
			alert('이메일 인증을 해주세요');
		}else {
			
			alert('비밀번호를 확인하세요.');
			
		}

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
	
	// 이메일 인증
	function checkEmail(){
		
		
		let memEmail = $("#memEmail").val();
		
		$.ajax({
			type : "POST",
			url : "mCheckEmail",
			data : { "memEmail" : memEmail },
			dataType : "text",
			success : function(uuid){
				console.log("이메일 인증번호1 : " + uuid);
				$("#confEmail").html("<br/><input type='text' id='uuidCheck'/>"
						+" <input type='hidden' value='"+ uuid +"' id='uuid'/>"
						+" <input type='button' value='인증' onclick=\"checkEmail2()\" style='background-color: orange; color: white'/>");
			},
			error : function(){
				alert('이메일 인증 통신 실패!');
			}
		});
	}


	function checkEmail2(){
		let uuid = $("#uuid").val();
		console.log("이메일 인증번호2 : " + uuid);
		
		let uuidCheck = $("#uuidCheck").val();
		console.log("입력한 인증번호 : " + uuidCheck);
		
		if(uuid != null){
			
		if(uuid == uuidCheck){
			alert('인증성공!');
			return true;
		} else {
			alert('인증실패!');
			return false;
		}
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