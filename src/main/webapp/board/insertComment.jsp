<%@page import="dao.BoardDao"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Customer"%>
<%@page import="vo.Board"%>
<%@page import="vo.Comment"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 파라미터값 조회
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String content = request.getParameter("content");
	
	// 세션에 속성으로 저장된 로그인한 고객의 아이디 조회하기
	String loginId = (String) session.getAttribute("loginId");
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job="+URLEncoder.encode("커멘트", "utf-8"));
		return;
	} 
		
	// Comment객체를 생성해서 요청파라미터 값 밑 고객정보 저장하기
	Comment comment = new Comment();
	comment.setContent(content);
	comment.setBoard(new Board(boardNo));
	comment.setCustomer(new Customer(loginId));
	
	// Comment객체에 저장된 커멘트정보를 테이블에 저장시킨다.
	CommentDao commentDao = new CommentDao();
	commentDao.insertComment(comment);
	
	// 글번호로 게시글 정보 조회
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.getBoardByNo(boardNo);
	// 게시글의 댓글 갯수를 증가시켜
	board.setCommentCnt(board.getCommentCnt()+1);
	// 게시글 정보를 update
	boardDao.updateBoard(board);
	
	// detail.jsp를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("detail.jsp?no=" +boardNo);
%>











