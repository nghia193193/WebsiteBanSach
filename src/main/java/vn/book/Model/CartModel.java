package vn.book.Model;

import java.util.Date;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartModel {
	private Long cartId;
	
	private Long userId;
	
	private Long storeId;
	
	private Date createAt;
	
	private Date updateAt;
	private Boolean isEdit = false;
}
