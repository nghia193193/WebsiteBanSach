<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<h1>Dash Board</h1>
<div><p>Số sản phẩm của cửa hàng: </p>${totalBook}</div>
<div>
<form action="" method="get">
	  <label for="from">Từ ngày:</label>
	  <input type="date" id="fromday" name="fromday">
	  <label for="to">Đến ngày:</label>
	  <input type="date" id="today" name="today">
	  <input type="submit" value="Thống kê" />
	  
</form>
              
    <div class="flexWrapper">
    	<canvas id="chartElement" width="200" height="50"></canvas>
    </div>
</div>
