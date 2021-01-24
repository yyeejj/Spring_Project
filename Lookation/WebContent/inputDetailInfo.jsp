<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LocationDetailedInfo.jsp</title>

<c:import url="${cp}/includes/includes_home.jsp"></c:import>
<c:import url="${cp}/includes/defaults.jsp"></c:import>

<style type="text/css">
/* 대표이미지 추가 css */
.filebox input[type="file"] { 

	position: absolute; width: 70%; 
	padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; 
}
.filebox label {

	display: inline-block; padding: .5em .75em; color: #999; 
	font-size: inherit; line-height: normal; vertical-align: middle; 
	background-color: #fdfdfd; cursor: pointer; border: 1px solid #ebebeb; 
	border-bottom-color: #e2e2e2; border-radius: .25em; 
}

/* named upload */ 
.filebox .upload-name { 

	display: inline-block; padding: .5em .75em; 

	/* label의 패딩값과 일치 */ 
	font-size: inherit; font-family: inherit; line-height: normal; 
	vertical-align: middle; background-color: #f5f5f5; 
	border: 1px solid #ebebeb; border-bottom-color: #e2e2e2; 
	border-radius: .25em; -webkit-appearance: none; 
	
	/* 네이티브 외형 감추기 */ 

	-moz-appearance: none; appearance: none; 

}
</style>

<script type="text/javascript">
	
	$(function() {

		$('#inputMinPeople').on("keyup", function ()
		{
			var inputMin = setMinPeople($('#inputMinPeople'), 1, 10, '최소 수용인원');

			var err = $(this).next();
			err.css("display", "none");
			
				var inputMax = setMaxPeople($('#inputMaxPeople'), inputMin, 30, '최대 수용인원');
				
				if (inputMax != null && inputMin > inputMax) {
						
					err.html("최대 수용인원이 최소 수용인원 보다 작습니다.").css("display", "inline");
					err.css("color", "red");
				
			}
		});
		
		// 썸네일 이미지 등록
		/* $(document).ready(function(){ 
			
			<c:forEach var="i" begin="0" end="10">
			$('.filebox${i} .upload-hidden').on('change', function(){ // 값이 변경되면 
				
				var filename = '';
				// modern browser
				if(window.FileReader) { 
					filename = $(this)[0].files[0].name; 
				} 
			
				// old IE
				
				else { 
				
					filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
				} 
				
			
				// 추출한 파일명 삽입 
				$(this).parent('div').children('.upload-name').val(filename); 
				
			});
			</c:forEach>
		}); */			
	});
				
	
	
	// 최소 수용인원 수 제약 functiond
	function setMinPeople(target, minNum, maxNum, name){
		
		target.on("keyup", function() {
			
			var err = $(this).next();
			err.css("display", "none");
			
			
			if (target.val()=='') {
				
				err.html.hide();
				return false;
			}
			
			// 글자 수 제한, 색 변경
			else if (parseInt(target.val()) < minNum || parseInt(target.val()) > maxNum ) {
				
				err.html("" + name + "은 " + minNum + " 이상 ~ " + maxNum + " 이하로 설정해야합니다.").css("display","inline");
				err.css("color", "red");
				return;
				
			} else {
				
				err.html("사용 가능한 " + name + "입니다.").css("display","inline");
				err.css("color","green");
				return target;
			}
		});
	}
	
	// 최대 수용인원 수 제약 function
	function setMaxPeople(target, minNum, maxNum, name){
		
		target.on("keyup", function() {
			
			var err = $(this).next();
			err.css("display", "none");
			
			// 1. 최소가 입력되지않았을 경우(min.val() == '')
			//	1-1. 기존의 최대값의 수 제한(최소값을 입력해주세요 html)
			//		
			//  1-2. 
			
			// 2. 최소가 입력되었을 경우(min.val() != '')
			//	2-1. 최소값을 받아와 최대값의 수 제한(입력받은 최소값 ~ 최대값 html)
			//		2-1-1. 입력값이 최소값보다 작은경우(최소값보다 작습니다.)
			//		2-1-2. 입력값이 최대값보다 큰 경우(30)
			//		→ 가능하면 분기 x, 통일(최소값이하 || 최대값초과)
			//  2-2. 최소값을 받아와 
			
			if (target.val()=='') {
				
				err.html.hide();
				return false;
			}
			
			else if (target.val()=="" || parseInt(target.val()) < minNum || parseInt(target.val()) > maxNum ) {
				
				err.html("" + name + "은 " + minNum + " 이상 ~ " + maxNum + " 이하로 설정해야합니다.").css("display","inline");
				err.css("color", "red");
				return;
				
			} else {
				
				err.html("사용 가능한 " + name + "입니다.").css("display","inline");
				err.css("color","green");
				return target;
			}
		});
	}
	  
	// 입력한 최대 수용인원보다 최소 수용인원이 더 큰 경우 처리 function
	function maxTest() {
		
		var inputMin = parseInt($.trim($('#inputMinPeople').val()));

		return inputMin;
	} 
	
	// 취소 버튼 클릭시 기존 작성내용을 저장하지 않고 메인 홈페이지로 이동하는 function
	function cancel() {
		
		var con = confirm("작성을 취소하고 메인 페이지로 돌아가시겠습니까?                        "
						+ "(기존 작성 내용은 저장되지 않습니다.)");
		
		if (con == true) {
			location.href = "mainHost.jsp";
			return;
		} else {
			return;
		}
		
	}
	

</script>
	
</head>
<body>
	<div>
		<c:import url="${cp}/includes/header_host.jsp"></c:import>
	</div>
	
	
   <!-- 타이틀 -->
   <section class="hero-wrap hero-wrap-2"
      style="background-image: url('images/bg_3.jpg');"
      data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      
      <!-- 타이틀 내용 -->
      <div class="container">
         <div class="row no-gutters slider-text align-items-end">
            <div class="col-md-9 ftco-animate pb-5">
               <p class="breadcrumbs mb-2">
                  <span class="mr-2"> 
                  	<a href="index.html">Home 
                  		<i class="ion-ios-arrow-forward"></i>
                  	</a>
                  </span> 
                   
                  <span>공간 등록 
                  	<i class="ion-ios-arrow-forward"></i>
                  </span>
               </p>
               <h1 class="mb-0 bread">상세정보 입력</h1>
            </div>
         </div>
      </div>
   </section>
   <!-- END 타이틀 -->

   <!-- 본문 -->
<!-- container 시작 -->

<div class="container">

	<br><br>
   
   <!-- Page Heading -->
   <h1 class="mb-2 text-gray-800">상세정보 입력</h1>
   <p class="mb-4"> 상세정보를 입력하세요. <a target="_blank" href="#">이전으로</a>.</p>
      
      <!-- 필요하다면 마이페이지로 돌아가는 왼쪽 사이드바 -->
      
      
      <div class="card shadow mb-4">
         <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-default">상세정보 입력</h6>
         </div>


	<!-- form start --------------------------------------------->
	<form style="width: 80%; margin: 120px;" id="inputDetailInfo"  enctype="multipart/form-data"
		  action="inputdetailinfo.action" method="POST">	
		
		<!-- 1. 이미지 --><!-- ※ 보류 -->
		
		<div id="locDetailImg">
		
			<span style="font-size: 14pt; font-weight: bold;">이미지 <span style="color: red">*</span></span>
			<br><br>
			
		<c:forEach var="i" begin="0" end="10">
				<div class="filebox${i }">
						<!-- <input class="upload-name" name="inputThumbnail" 
							   placeholder="이미지 등록" disabled="disabled" style="width: 70%"> -->
						<!-- <label for="ex_filename"><span class="glyphicon fa fa-upload"></span></label> --> 
						<input type="file" name="detailImage${i }" id="ex_filename" class="upload-hidden">
				</div>
		</c:forEach>
				<br><br>
				<span style="color: gray">* 최소/최대 1장, 최대 5MB, 최대해상도 2048*1158</span>
		</div>
	
	<br><br><br>
	
		<!-- 2. 최소 수용인원 -->
		
		<div id="minPeople">
		
			<span style="font-size: 14pt; font-weight: bold;">최소 수용인원 <span style="color: red">*</span></span>
			<br><br>
			<input type="text" required="required" class="form-control"
					placeholder="최소 수용인원을 입력하세요.[최소 1명 이상 ~ 최대 10명 이하]"
					id="inputMinPeople" name="inputMinPeople"
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					<!-- oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"--> 
			<span id="err" style="font-weight: bold;"></span>
			
		</div>
	
	<br><br><br>
		
		
		<!-- 3. 최대 수용인원 -->
			
		<div id="maxPeople">
		
			<span style="font-size: 14pt; font-weight: bold;">최대 수용인원 <span style="color: red">*</span></span>
			<br><br>
			<input type="text" required="required" class="form-control"
					placeholder="최대 수용인원을 입력하세요.[최소 수용인원 이상, 최대 30명 이하]"
					id="inputMaxPeople" name="inputMaxPeople"
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					<!-- oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); -->
			<span style="font-weight: bold;"></span>
		</div>
	
	<br><br><br>
	
		<!-- 4. 웹 url -->
		
		<div id="webUrl">
			
			<span style="font-size: 14pt; font-weight: bold;">웹 사이트<span style="color: red">*</span></span>
			<br><br>
			<input type="text" required="required" class="form-control"
					placeholder="웹사이트 url 을 입력하세요."
					id="inputWebUrl" name="inputWebUrl">
			
			<span style="font-weight: bold;"></span>
		</div>
	
	<br><br><br>
	
	<!-- 다음 버튼(공통) : 다음 입력페이지로 넘어가고, DB에 저장된다.
						   (필수항목을 입력하지 않았을 경우,
							입력하지않은 항목 중 가장 첫번째 항목을 focus()하고
						    alert("필수항목을 입력해야합니다")된다.
							그리고 입력하는 textbox로 입력커서가 이동한다. 
							또한 다음페이지로 submit 되지 않는다.
							
							※ 다음 버튼 이동 순서
							※ xxxUpdate.jsp 다음버튼 이동 순서 
							   기본정보 → 연락처정보 → 사업자정보
						    → 이용정보  → 상세정보  → 패키지정보 -->
	
		<div class="container" style="text-align: center;">
			<input type="submit" value="다음" class="btn btn-warning" 
				   style="width:45%; border-color: gray;">
			
		<!-- 취소 버튼 -->
			<input type="button" class="btn btn-default" style="align-content:center; width:45%; border-color: gray;" 
					id="detailInfo" value="취소" onclick="cancel()">		
		</div>	

	
	<br><br><br><br>

	</form>
</div>
</div>

<div>
		<c:import url="${cp}/includes/footer_host.jsp"></c:import>
		<c:import url="${cp}/includes/includes_home_end.jsp"></c:import>
</div>
</body>
</html>