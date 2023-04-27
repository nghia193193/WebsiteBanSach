package vn.book.Model;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import vn.book.Config.Annotation.EnumValidator;
import vn.book.Util.UserRole;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserModel {
	private Long userId;
	
	@Length(max = 20, message = "Tên không được quá 20 kí tự")
	private String firstName;
	
	@Length(max = 50, message = "Họ và tên lót không được quá 50 kí tự")
	private String lastName;
	//@Email(message = "Email không hợp lệ", regexp = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
	@NotEmpty(message = "Email không được để trống")
	private String email;
	@Length(min = 9, max = 12, message = "SĐT không hợp lệ")
	private String phone;
	@Length(min = 20, max = 500, message = "Địa chỉ phải nhiều hơn 20 và bé hơn 500 kí tự")
	private String address;
	
	private String avatar;
	private MultipartFile avatarFile;
	@NotEmpty(message = "Tên đăng nhập không được để trống")
	@Length(min = 5, max = 20, message = "Tên đăng nhập phải nhiều hơn 5 và ít hơn 20 kí tự")
	private String username;
	@Length(max = 25, message = "Mật khẩu phải ít hơn 20 kí tự")
	private String password;
	
	private String role;
	private boolean isDelete = false;
	private Date createAt;
	private Date updateAt;
	private Boolean isEdit = false;
	
}
