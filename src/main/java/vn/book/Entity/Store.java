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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Stores")
public class Store {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "storeId")
	private Long storeId;
	@Column(name = "storeName", columnDefinition = "nvarchar(50)")
	private String storeName;
	@Column(name = "description", columnDefinition = "nvarchar(500)")
	private String description;
	//kết nối 1 to 1 với User
	@OneToOne
	@JoinColumn(name = "ownerId", referencedColumnName = "userId")
	private User owner;
	@Column(name = "avatar", columnDefinition = "varchar(max)")
	private String avatar;
	@Column(name = "isActive")
	private boolean active;
	@Column(name = "isOpen")
	private boolean open;
	@Column(name = "createAt", columnDefinition = "date")
	private Date createAt;
	@Column(name = "updateAt", columnDefinition = "date")
	private Date updateAt;
	
	@OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
	private Set<Book> books;
	
	@OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
	private Set<Cart> carts;
	
	@OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
	private Set<Order> orders;
}
