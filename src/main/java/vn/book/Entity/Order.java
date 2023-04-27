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
@Table(name = "Orders")
public class Order {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "orderId")
	private Long orderId;
	@ManyToOne
	@JoinColumn(name = "userId", referencedColumnName = "userId")
	private User user;
	@ManyToOne
	@JoinColumn(name = "storeId", referencedColumnName = "storeId")
	private Store store;
	@Column(name = "phone", columnDefinition = "varchar(12)")
	private String phone;
	@Column(name = "address", columnDefinition = "nvarchar(500)")
	private String address;
	@Column(name = "status", columnDefinition = "nvarchar(50)")
	private String status;
	@Column(name = "isPaidBefore")
	private boolean paidBefore;
	@Column(name = "amountFromUser", columnDefinition = "float")
	private double amountFromUser;
	@Column(name = "amountToStore", columnDefinition = "float")
	private double amountToStore;
	@Column(name = "amountToGD", columnDefinition = "float")
	private double amountToGD;
	@Column(name = "createAt", columnDefinition = "date")
	private Date createAt;
	@Column(name = "updateAt", columnDefinition = "date")
	private Date updateAt;
	
	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
	private Set<OrderItem> orderItems;
}
