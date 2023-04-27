package vn.book.Model;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryModel {
	private Long categoryId;
	@NotEmpty
	@Length(min = 5, max = 50, message = "Tên danh mục phải lớn hơn 5 và bé hơn 50 kí tự")
	private String categoryName;
	
	private String image;
	private MultipartFile imageFile;
	private boolean delete;
	private Date createAt;
	private Date updateAt;
	private Boolean isEdit = false;
}
