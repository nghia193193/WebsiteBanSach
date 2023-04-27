package vn.book.Entity;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Books")
public class Book {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "bookId")
	private Long bookId;
	@Column(name = "bookName", columnDefinition = "nvarchar(300)")
	private String bookName;
	@Column(name = "author", columnDefinition = "nvarchar(100)")
	private String author;
	@Column(name = "publisher", columnDefinition = "nvarchar(200)")
	private String publisher;
	@Column(name = "language", columnDefinition = "nvarchar(50)")
	private String language;
	@Column(name = "image", columnDefinition = "varchar(max)")
	private String image;
	@Column(name = "price", columnDefinition = "float")
	private double price;
	@Column(name = "promotionalPrice", columnDefinition = "float")
	private double promotionalPrice;
	@Column(name = "quantity")
	private int quantity;
	@Column(name = "sold")
	private int sold;
	@Column(name = "isSelling")
	private boolean selling;
	@ManyToOne
	@JoinColumn(name = "categoryId", referencedColumnName = "categoryId")
	private Category category;
	@ManyToOne
	@JoinColumn(name = "storeId", referencedColumnName = "storeId")
	private Store store;
	@Column(name = "rating")
	private int rating;
	@Column(name = "createAt", columnDefinition = "date")
	private Date createAt;
	@Column(name = "updateAt", columnDefinition = "date")
	private Date updateAt;
	
	@OneToMany(mappedBy = "book", cascade = CascadeType.ALL)
	private Set<CartItem> cartItems;
}
