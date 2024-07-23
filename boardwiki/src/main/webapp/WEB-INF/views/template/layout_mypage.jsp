<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/main.css" type="text/css">
<jsp:include page="/WEB-INF/views/template/css_plugins.jsp" />
<jsp:include page="/WEB-INF/views/template/js_plugins.jsp" />
<tiles:insertAttribute name="css" ignore="true" />
</head>
<body>
	<div id="main">
		<div id="main_header">
			<tiles:insertAttribute name="header" />
		</div>
		<section class="page-top-section set-bg"
			data-setbg="/img/page-top-bg/4.jpg">
			<div class="page-info">
				<h2>Mypage</h2>
			</div>
		</section>
		<section class="blog-page">
			<div class="container">
				<div class="side-height">
					<div id="page_nav">
						<tiles:insertAttribute name="nav" />
					</div>
					<div id="page_body">
						<tiles:insertAttribute name="body" />
					</div>
				</div>
			</div>
		</section>
		<div id="main_footer" class="page-clear">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>





