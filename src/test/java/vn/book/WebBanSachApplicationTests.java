package vn.book;

import java.util.Date;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import vn.book.Model.StoreRevenueReport;
import vn.book.Service.IOrderItemService;

@SpringBootTest
class WebBanSachApplicationTests {
	
	@Autowired
	IOrderItemService orderItemSer;

	@Test
	void contextLoads() {
		Date date = new Date(System.currentTimeMillis());
		Long storeId = (long) 2;
		List<StoreRevenueReport> report = orderItemSer.storeRevenueReport(storeId, "2022-1-1",date.toString());
		System.out.print(report);
	}

}
