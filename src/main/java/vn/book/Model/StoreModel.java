package vn.book.Model;

import java.util.Date;

import org.hibernate.validator.constraints.Length;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreModel {
	private Long storeId;
	@Length(min = 2, max = 30, message = "Tên shop không được nhỏ hơn 2 và quá 30 ký tự")
	private String storeName;
	@Length(max = 400, message = "Mô tả không được vượt quá 400 ký tự")
	private String description;
	
	private Long ownerId;
	
	private String avatar;
	private MultipartFile avatarFile;
	private boolean active;
	
	private boolean open;
	
	private Date createAt;
	private Date updateAt;
	private Boolean isEdit = false;
}
