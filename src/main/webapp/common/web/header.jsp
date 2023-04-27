<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<nav class="navbar navbar-icon-top navbar-expand-lg navbar-dark bg-dark">
	<a class="navbar-brand" href="#"><img src="/templates/images/boker-high-resolution-logo-color-on-transparent-background.png" width="65" height="auto"></a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="/"> <i
					class="fa fa-home"></i> Home <span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="/listByPage"> <i
					class="fa fa-envelope-o"> <span class="badge badge-danger"></span>
				</i> Sản phẩm
			</a></li>
			<li class="nav-item"><a class="nav-link " href="/storeListByPage"> <i
					class="fa fa-envelope-o"> <span class="badge badge-warning"></span>
				</i> Cửa hàng
			</a></li>
		</ul>
		<ul class="navbar-nav ">
			<li class="nav-item"><a class="nav-link" href="/login"> <i
					class="fa fa-bell"> <span class="badge badge-info"></span>
				</i> Order
			</a></li>
		</ul>
	</div>
</nav>