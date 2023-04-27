package vn.book.Entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "CartItems")
public class CartItem {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;
	@ManyToOne
	@JoinColumn(name = "cartId", referencedColumnName = "cartId")
	private Cart cart;
	@ManyToOne
	@JoinColumn(name = "bookId", referencedColumnName = "bookId")
	private Book book;
	@Column(name = "count")
	private int count;
	@Column(name = "createAt", columnDefinition = "date")
	private Date createAt;
	@Column(name = "updateAt", columnDefinition = "date")
	private Date updateAt;
//	@Column(name = "user")
//	private User user;
	
}
