package vn.book.Model;

import java.util.Date;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderModel {
	private Long orderId;
	
	private Long userId;
	
	private Long storeId;
	
	private String phone;
	
	private String address;
	
	private String status;
	
	private boolean paidBefore;
	
	private double amountFromUser;
	
	private double amountToStore;
	
	private double amountToGD;
	private Date createAt;
	private Date updateAt;
	private Boolean isEdit = false;
}
