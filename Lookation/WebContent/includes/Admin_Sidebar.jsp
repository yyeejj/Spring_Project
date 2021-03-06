<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- Sidebar -->
	<ul
		class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
		id="accordionSidebar">

		<!-- Sidebar - Brand -->
		<a class="sidebar-brand d-flex align-items-center justify-content-center"
			href="adminmain.action">
			<div class="sidebar-brand-icon rotate-n-15">
				<i class="fas fa-laugh-wink"></i>
			</div>
			<div class="sidebar-brand-text mx-3">
				Pfinder Admin <sup></sup>
			</div>
		</a>

		<!-- Divider -->
		<hr class="sidebar-divider my-0">

		<!-- Nav Item - Dashboard -->
		<li class="nav-item"><a class="nav-link" href="adminmain.action"> <i
				class="fas fa-fw fa-tachometer-alt"></i> <span>main</span></a></li>

		<!-- Divider -->
		<hr class="sidebar-divider">

		<!-- Heading -->
		<div class="sidebar-heading">관리</div>


		<!-- 공지 관리 -->
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item">
			<a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages1"
				aria-expanded="true" aria-controls="collapsePages"> 
			<i class="fas fa-fw fa-folder"></i> 
				<span>공지관리</span>
			</a>
			<div id="collapsePages1" class="collapse"
				aria-labelledby="headingPages" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">도움말:</h6>
					<a class="collapse-item" href="helpmanager.action">도움말 목록</a>
					<a class="collapse-item" href="helpinsertform.action">도움말 등록</a>
					<div class="collapse-divider"></div>
					<h6 class="collapse-header">공지사항:</h6>
					<a class="collapse-item" href="noticemanager.action">공지사항 목록</a>
					<a class="collapse-item" href="noticeinsertform.action">공지사항 등록</a>
				</div>
			</div></li>

		<!-- 신고관리 -->
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item"><a class="nav-link collapsed" href="#"
			data-toggle="collapse" data-target="#collapsePages2"
			aria-expanded="true" aria-controls="collapsePages"> <i
				class="fas fa-fw fa-folder"></i> <span>신고관리</span>
		</a>
			<div id="collapsePages2" class="collapse"
				aria-labelledby="headingPages" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">신고:</h6>
					<a class="collapse-item" href="reportlist.action">신고내역</a>
					<a class="collapse-item" href="blindmanager.action">블라인드 관리</a>
				</div>
			</div></li>
			
		<!-- 회원관리 -->
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item"><a class="nav-link collapsed" href="#"
			data-toggle="collapse" data-target="#collapsePages3"
			aria-expanded="true" aria-controls="collapsePages"> <i
				class="fas fa-fw fa-folder"></i> <span>회원관리</span>
		</a>
			<div id="collapsePages3" class="collapse"
				aria-labelledby="headingPages" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">게시글관리:</h6>
					<a class="collapse-item" href="userqnamanager.action">Q&A관리</a>
					<a class="collapse-item" href="userreviewmanager.action">리뷰관리</a>
					<a class="collapse-item" href="hostqnamanager.action">Q&A답글관리</a>
					<a class="collapse-item" href="hostreviewmanager.action">리뷰답글관리</a>
					<h6 class="collapse-header">회원관리:</h6>
					<a class="collapse-item" href="memberblackmanager.action">이용자관리</a>
					<a class="collapse-item" href="hostblackmanager.action">호스트관리</a>
				</div>
			</div></li>

		<!-- 마일리지 관리 -->
		<li class="nav-item"><a class="nav-link collapsed" href="#"
			data-toggle="collapse" data-target="#collapsePages4"
			aria-expanded="true" aria-controls="collapsePages"> <i
				class="fas fa-fw fa-folder"></i> <span>마일리지 관리</span>
		</a>
			<div id="collapsePages4" class="collapse"
				aria-labelledby="headingPages" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">마일리지관리:</h6>
					<a class="collapse-item" href="loadmgr.action">충전관리</a>
				</div>
			</div></li>
			
		<!-- 공간 관리 -->
		<li class="nav-item"><a class="nav-link collapsed" href="#"
			data-toggle="collapse" data-target="#collapsePages5"
			aria-expanded="true" aria-controls="collapsePages"> <i
				class="fas fa-fw fa-folder"></i> <span>공간 관리</span>
		</a>
			<div id="collapsePages5" class="collapse"
				aria-labelledby="headingPages" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">공간관리:</h6>
					<a class="collapse-item" href="inspectmanager.action">공간검수</a>
				</div>
			</div></li>
			
		

		<!-- Divider -->
		<hr class="sidebar-divider d-none d-md-block">

		<!-- Sidebar Toggler (Sidebar) -->
		<div class="text-center d-none d-md-inline">
			<button class="rounded-circle border-0" id="sidebarToggle"></button>
		</div>

	</ul>
	<!-- End of Sidebar -->


</body>
</html>