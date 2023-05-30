package dao;

import java.security.interfaces.RSAKey;
import java.util.List;

import util.DaoHelper;
import vo.Customer;

public class CustomerDao {

	/**
	 * 전달받은 고객아이디에 해당하는 고객아이디를 삭제한다.
	 * @param id 삭제할 고객 아이디
	 */
	public void deleteCustomerById(String id) {
		DaoHelper.update("customerDao.deleteCustomerById", id);
	}
	
	/**
	 * 전달받은 고객에 해당하는 고객의 정보를 변경한다.
	 * @param id 변경할 고객 객체
	 */
	public void updateCustomer(Customer customer) {
		DaoHelper.update("customerDao.updateCustomer", customer.getPassword(),
													   customer.getTel(),
													   customer.getEmail(),
													   customer.getDisabled(),
													   customer.getPoint(),
													   customer.getId());
	}
	
	/**
	 * 전달받은 고객이메일에 해당하는 고객정보를 조회해서 반환한다.
	 * @param email 조회할 고객의 이메일
	 * @return 고객정보
	 */
	public Customer getCustomerByEmail(String email) {
		return DaoHelper.selectOne("customerDao.getCustomerByEmail", rs -> {
			Customer customer = new Customer();
			customer.setId(rs.getString("customer_id"));
			customer.setPassword(rs.getString("customer_password"));
			customer.setName(rs.getString("customer_name"));
			customer.setTel(rs.getString("customer_tel"));
			customer.setEmail(rs.getString("customer_email"));
			customer.setPoint(rs.getInt("customer_point"));
			customer.setDisabled(rs.getString("customer_disabled"));
			customer.setCreateDate(rs.getDate("customer_create_date"));
			customer.setUpdateDate(rs.getDate("customer_update_date"));
			
			return customer;
		}, email);
	}
	
	/**
	 * 전달받은 고객아이디에 해당하는 고객정보를 조회해서 반환한다.
	 * @param id 조회할 고객의 아이디
	 * @return 고객정보
	 */
	public Customer getCustomerById(String id) {
		return DaoHelper.selectOne("customerDao.getCustomerById", rs -> {
			Customer customer = new Customer();
			customer.setId(rs.getString("customer_id"));
			customer.setPassword(rs.getString("customer_password"));
			customer.setName(rs.getString("customer_name"));
			customer.setTel(rs.getString("customer_tel"));
			customer.setEmail(rs.getString("customer_email"));
			customer.setPoint(rs.getInt("customer_point"));
			customer.setDisabled(rs.getString("customer_disabled"));
			customer.setCreateDate(rs.getDate("customer_create_date"));
			customer.setUpdateDate(rs.getDate("customer_update_date"));
			
			return customer;
		}, id);
	}
	
	/**
	 * 전체 고객목록을 반환한다.
	 * @return 전체 고객목록
	 */
	public List<Customer> getCustomers() {
		return DaoHelper.selectList("customerDao.getCustomers", rs -> {
			Customer customer = new Customer();
			customer.setId(rs.getString("customer_id"));
			customer.setPassword(rs.getString("customer_password"));
			customer.setName(rs.getString("customer_name"));
			customer.setTel(rs.getString("customer_tel"));
			customer.setEmail(rs.getString("customer_email"));
			customer.setPoint(rs.getInt("customer_point"));
			customer.setDisabled(rs.getString("customer_disabled"));
			customer.setCreateDate(rs.getDate("customer_create_date"));
			customer.setUpdateDate(rs.getDate("customer_update_date"));
			
			return customer;
		});
	}	
	
	/**
	 * 새 고객정보를 전달받아서 테이블에 저장한다.
	 * @param customer 새 고객정보가 포함된 Customer객체
	 */
	public void insertCustomer(Customer customer) {
		DaoHelper.update("customerDao.insertCustomer", customer.getId(),
													   customer.getPassword(),
													   customer.getName(),
													   customer.getTel(),
													   customer.getEmail());
	}
	
}
