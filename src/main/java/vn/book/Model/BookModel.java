package vn.book.Model;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookModel {
	private Long bookId;
	
	private String bookName;
	
	private String author;
	
	private String publisher;
	
	private String language;
	
	private String image;
	private MultipartFile imageFile;
	private double price;
	
	private double promotionalPrice;
	
	private int quantity;
	
	private int sold;
	
	private boolean selling;
	
	private Long categoryId;
	
	private Long storeId;
	
	private int rating;
	
	private Date createAt;
	
	private Date updateAt;
	private Boolean isEdit = false;
}
