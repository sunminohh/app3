package dao;

import java.util.List;

import util.DaoHelper;
import vo.Board;
import vo.Comment;
import vo.Customer;

public class CommentDao {

	public void insertComment(Comment comment) {
		DaoHelper.update("commentDao.insertComment", comment.getContent(),
													 comment.getCustomer().getId(),
													 comment.getBoard().getNo());
	}
	
	public List<Comment> getCommentsByBoardNo (int boardNo){
		
		return DaoHelper.selectList("commentDao.getCommentsByBoardNo", rs -> {
			Comment comment = new Comment();
			comment.setNo(rs.getInt("comment_no"));
			comment.setContent(rs.getString("comment_content"));
			comment.setCreateDate(rs.getDate("comment_create_date"));
			
			Customer customer = new Customer();
			customer.setId(rs.getString("cust_id"));
			customer.setName(rs.getString("customer_name"));
			
			comment.setCustomer(customer);
			
			return comment;
		}, boardNo);
	}
	
	public Comment getCommentByNo(int commentNo) {
		return DaoHelper.selectOne("commentDao.getCommentByNo", rs -> {
			Comment comment = new Comment();
			comment.setNo(rs.getInt("comment_no"));
			comment.setContent(rs.getString("comment_content"));
			comment.setCreateDate(rs.getDate("comment_create_date"));
			
			Customer customer = new Customer();
			customer.setId(rs.getString("cust_id"));
			comment.setCustomer(customer);
			
			Board board = new Board();
			board.setNo(rs.getInt("board_no"));
			comment.setBoard(board);
			
			return comment;
		}, commentNo);
	}
	
	public void deleteCommentByNo(int commentNo) {
		DaoHelper.update("commentDao.deleteCommentByNo", commentNo);
	}
}







