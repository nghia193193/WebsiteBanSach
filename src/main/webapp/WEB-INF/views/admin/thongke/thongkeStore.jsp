<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid">
	
		<h1 style="text-align: center; color: orange;">Biểu đồ Cột</h1>
		<div class="row">
			<div class="col-4">
				<h2>Thống kê store theo ngày</h2>
				<canvas id="barChart"></canvas>
			</div>
			<div class="col-4">
				<h2>Thống kê store theo tháng</h2>
				<canvas id="barChartm"></canvas>
			</div>
			<div class="col-4">
				<h2>Thống kê store theo năm</h2>
				<canvas id="barCharty"></canvas>
			</div>
		</div>
		
		<h1 style="text-align: center; color: orange;">Biểu đồ Đường</h1>
		<div class="row">
			<div class="col-4">
				<h2>Thống kê store theo ngày</h2>
				<canvas id="lineChart"></canvas>
			</div>
			<div class="col-4">
				<h2>Thống kê store theo tháng</h2>
				<canvas id="lineChartm"></canvas>
			</div>
			<div class="col-4">
				<h2>Thống kê store theo năm</h2>
				<canvas id="lineCharty"></canvas>
			</div>
		</div>
		
		<h1 style="text-align: center; color: orange;">Biểu đồ tròn</h1>
		<div class="row">
			<div class="col-4">
				<h2>Thống kê store theo ngày</h2>
				<canvas id="pieChart"></canvas>
			</div>
			<div class="col-4">
				<h2>Thống kê store theo tháng</h2>
				<canvas id="pieChartm"></canvas>
			</div>
			<div class="col-4">
				<h2>Thống kê store theo năm</h2>
				<canvas id="pieCharty"></canvas>
			</div>
		</div>
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

		<script>
				  const ctx = document.getElementById('pieChart');
				
				  new Chart(ctx, {
				    type: 'pie',
				    data: {
				      labels: ${day},
				      datasets: [{
				        label: 'Số cửa hàng',
				        data: ${count},
				        borderWidth: 1
				      }]
				    },
				    options: {
				      scales: {
				        y: {
				          beginAtZero: true
				        }
				      }
				    }
				  });
				</script>
		<script>
				  const ctxm = document.getElementById('pieChartm');
				
				  new Chart(ctxm, {
				    type: 'pie',
				    data: {
				      labels: ${month},
				      datasets: [{
				        label: 'Số cửa hàng',
				        data: ${countm},
				        borderWidth: 1
				      }]
				    },
				    options: {
				      scales: {
				        y: {
				          beginAtZero: true
				        }
				      }
				    }
				  });
				</script>
		<script>
				  const ctxy = document.getElementById('pieCharty');
				
				  new Chart(ctxy, {
				    type: 'pie',
				    data: {
				      labels: ${year},
				      datasets: [{
				        label: 'Số cửa hàng',
				        data: ${county},
				        borderWidth: 1
				      }]
				    },
				    options: {
				      scales: {
				        y: {
				          beginAtZero: true
				        }
				      }
				    }
				  });
				</script>
				<script>
				  const lined = document.getElementById('lineChart');
				
				  new Chart(lined, {
				    type: 'line',
				    data: {
				      labels: ${day},
				      datasets: [{
				        label: 'Số cửa hàng',
				        data: ${count},
				        borderWidth: 1
				      }]
				    },
				    options: {
				      scales: {
				        y: {
				          beginAtZero: true
				        }
				      }
				    }
				  });
				</script>
				<script>
				  const linem = document.getElementById('lineChartm');
				
				  new Chart(linem, {
				    type: 'line',
				    data: {
				      labels: ${month},
				      datasets: [{
				        label: 'Số cửa hàng',
				        data: ${countm},
				        borderWidth: 1
				      }]
				    },
				    options: {
				      scales: {
				        y: {
				          beginAtZero: true
				        }
				      }
				    }
				  });
				</script>
				<script>
				  const liney = document.getElementById('lineCharty');
				
				  new Chart(liney, {
				    type: 'line',
				    data: {
				      labels: ${year},
				      datasets: [{
				        label: 'Số cửa hàng',
				        data: ${county},
				        borderWidth: 1
				      }]
				    },
				    options: {
				      scales: {
				        y: {
				          beginAtZero: true
				        }
				      }
				    }
				  });
				</script>
				<script>
				  const bard = document.getElementById('barChart');
				
				  new Chart(bard, {
				    type: 'bar',
				    data: {
				      labels: ${day},
				      datasets: [{
				        label: 'Số cửa hàng',
				        data: ${count},
				        borderWidth: 1
				      }]
				    },
				    options: {
				      scales: {
				        y: {
				          beginAtZero: true
				        }
				      }
				    }
				  });
				</script>
				<script>
				  const barm = document.getElementById('barChartm');
				
				  new Chart(barm, {
				    type: 'bar',
				    data: {
				      labels: ${month},
				      datasets: [{
				        label: 'Số cửa hàng',
				        data: ${countm},
				        borderWidth: 1
				      }]
				    },
				    options: {
				      scales: {
				        y: {
				          beginAtZero: true
				        }
				      }
				    }
				  });
				</script>
				<script>
				  const bary = document.getElementById('barCharty');
				
				  new Chart(bary, {
				    type: 'bar',
				    data: {
				      labels: ${year},
				      datasets: [{
				        label: 'Số cửa hàng',
				        data: ${county},
				        borderWidth: 1
				      }]
				    },
				    options: {
				      scales: {
				        y: {
				          beginAtZero: true
				        }
				      }
				    }
				  });
				</script>

	</div>
</body>
</html>