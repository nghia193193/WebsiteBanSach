package vn.book.Entity;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import vn.book.Config.Annotation.EnumValidator;
import vn.book.Util.UserRole;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "userId")
	private Long userId;
	@Column(name = "firstName", columnDefinition = "nvarchar(20)")
	private String firstName;
	@Column(name = "lastName", columnDefinition = "nvarchar(50)")
	private String lastName;
	@Column(name = "email", columnDefinition = "varchar(100)")
	private String email;
	@Column(name = "phone", columnDefinition = "varchar(12)")
	private String phone;
	@Column(name = "address", columnDefinition = "nvarchar(500)")
	private String address;
	@Column(name = "avatar", columnDefinition = "varchar(max)")
	private String avatar;
	@Column(name = "username", columnDefinition = "varchar(20)", unique = true)
	private String username;
	@Column(name = "password", columnDefinition = "varchar(150)")
	private String password;
	@Column(name = "role", columnDefinition = "varchar(10)")
	@EnumValidator(enumClazz = UserRole.class)
	private String role;
	@Column(name = "isDelete")
	private boolean isDelete;
	@Column(name = "createAt", columnDefinition = "date")
	private Date createAt;
	@Column(name = "updateAt", columnDefinition = "date")
	private Date updateAt;
	@Column(name = "reset_password_token")
    private String resetPasswordToken;
	//kết nối 1 to 1 với Store
	@OneToOne(mappedBy = "owner", cascade = CascadeType.ALL)
	private Store store;
	
	@OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
	private Cart cart;
	
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	private Set<Order> orders;
	
}
