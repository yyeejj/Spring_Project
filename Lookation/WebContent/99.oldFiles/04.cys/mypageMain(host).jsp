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
<!-- include head -->

<title>mypageMain(host).jsp</title>
</head>
<body>
	<!-- include header_host.jsp -->
	<div>
		<c:import url="${cp}/includes/header_host.jsp"></c:import>
	</div>

	<section class="hero-wrap hero-wrap-2"
		style="background-image: url('<%=cp%>/images/bg_3.jpg');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text align-items-end">
				<div class="col-md-9 ftco-animate pb-5">
					<p class="breadcrumbs mb-2">
						<span class="mr-2"><a href="index.html">Home <i
								class="ion-ios-arrow-forward"></i></a></span> <span>Mypage <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-0 bread">마이페이지</h1>
				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section">
		<div class="container">
			<div class="row d-flex">
				<div class="col-md-4 ftco-animate">
					<div class="blog-entry align-self-stretch">
						<a href="mypageProfile(host).jsp" class="block-20 rounded"
							style="background-image: url('<%=cp%>/images/Mypage_BankAccount.png');">
						</a>
						<div class="text mt-3 text-center">
							<h3 class="heading">
								<a href="mypageProfile(host).jsp">프로필관리</a>
							</h3>
						</div>
					</div>
				</div>
				<div class="col-md-4 ftco-animate">
					<div class="blog-entry align-self-stretch">
						<a href="mypageBankAccount(host).jsp" class="block-20 rounded"
							style="background-image: url('<%=cp%>/images/Mypage_Mileage_Charge.png');">
						</a>
						<div class="text mt-3 text-center">
							<h3 class="heading">
								<a href="mypageBankAccount(host).jsp">계좌관리</a>
							</h3>
						</div>
					</div>
				</div>
				<div class="col-md-4 ftco-animate">
					<div class="blog-entry align-self-stretch">
						<a href="mypageReservaionList(host).jsp" class="block-20 rounded"
							style="background-image: url('<%=cp%>/images/Mypage_Mileage_Exchange.png');">
						</a>
						<div class="text mt-3 text-center">
							<h3 class="heading">
								<a href="mypageReservaionList(host).jsp">예약리스트</a>
							</h3>
						</div>
					</div>
				</div>

				<div class="col-md-4 ftco-animate">
					<div class="blog-entry align-self-stretch">
						<a href="mypageMileageWithdraw(host).jsp" class="block-20 rounded"
							style="background-image: url('<%=cp%>/images/image_4.jpg');">
						</a>
						<div class="text mt-3 text-center">
							<h3 class="heading">
								<a href="mypageMileageWithdraw(host).jsp">환전 신청</a>
							</h3>
						</div>
					</div>
				</div>
				<div class="col-md-4 ftco-animate">
					<div class="blog-entry align-self-stretch">
						<a href="mypageMileageHistory(host).jsp" class="block-20 rounded"
							style="background-image: url('<%=cp%>/images/image_5.jpg');">
						</a>
						<div class="text mt-3 text-center">
							<div class="meta mb-2"></div>
							<h3 class="heading">
								<a href="mypageMileageHistory(host).jsp">마일리지 내역(정산/환전)</a>
							</h3>
						</div>
					</div>
				</div>
				<div class="col-md-4 ftco-animate">
					<div class="blog-entry align-self-stretch">
						<a href="LocationMgmt.jsp" class="block-20 rounded"
							style="background-image: url('<%=cp%>/images/image_5.jpg');">
						</a>
						<div class="text mt-3 text-center">
							<div class="meta mb-2"></div>
							<h3 class="heading">
								<a href="LocationMgmt.jsp">공간관리</a>
							</h3>
						</div>
					</div>
				</div>
				<div class="col-md-4 ftco-animate">
					<div class="blog-entry align-self-stretch">
						<a href="mypageMyReviewAndQNA(host).jsp" class="block-20 rounded"
							style="background-image: url('<%=cp%>/images/image_6.jpg');">
						</a>
						<div class="text mt-3 text-center">
							<h3 class="heading">
								<a href="mypageMyReviewAndQNA(host).jsp">내가 작성한 글</a>
							</h3>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- footer.jsp -->
	<div>
		<c:import url="${cp}/includes/footer_host.jsp"></c:import>
	</div>
	
	<!-- includes_home_end -->
	<%@ include file="../includes/includes_home_end.jsp"%>

</body>
</html>