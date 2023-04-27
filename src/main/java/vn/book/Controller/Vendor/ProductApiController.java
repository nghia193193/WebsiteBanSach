package vn.book.Controller.Vendor;

import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import vn.book.Entity.Book;
import vn.book.Model.BookModel;
import vn.book.Service.IBookService;

@RestController
@RequestMapping("vendor/api/product")
public class ProductApiController {
	@Autowired
	IBookService bookSer;
	
	@GetMapping("get/{bookId}")
	public BookModel getBook(@PathVariable("bookId") Long bookId) {
		Optional<Book> option = bookSer.findById(bookId);
		BookModel book = new BookModel();
		if(option.isPresent()) {
			Book bookEntity = option.get();
			BeanUtils.copyProperties(bookEntity, book);
			book.setIsEdit(true);
			return book;
		}
		return null;
	}
}
