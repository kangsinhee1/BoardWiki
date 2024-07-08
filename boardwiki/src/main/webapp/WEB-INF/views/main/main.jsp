<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 메인 시작 -->
<div class="page-main">
	<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
    <a href="#">
      <img class="d-block w-500" src="${pageContext.request.contextPath}/images/main-1.png" alt="First slide">
    </a>
    </div>
    <div class="carousel-item">
    <a href="#">
      <img class="d-block w-500" src="${pageContext.request.contextPath}/images/main-2.png" alt="Second slide">
    </a>
    </div>
    <div class="carousel-item">
    <a href="#">
      <img class="d-block w-500" src="${pageContext.request.contextPath}/images/main-3.png" alt="Third slide">
    </a>
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
</div>
<!-- 메인 끝 -->