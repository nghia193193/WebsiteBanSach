package vn.book.Model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderItemModel {
	private Long id;
	
	private Long orderId;
	
	private Long bookId;
	
	private int count;
	
	private Date createAt;
	
	private Date updateAt;
	private Boolean isEdit = false;
}
