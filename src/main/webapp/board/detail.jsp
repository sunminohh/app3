<%@page import="dao.CommentDao"%>
<%@page import="vo.Comment"%>
<%@page import="java.util.List"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 URL - http://localhost/app3/board/detail.jsp?no=xxx
	
	// 요청 파라미터 조회
	int no = Integer.parseInt(request.getParameter("no"));

	//업무로직 수행 - 요청파라미터로 전달받은 게시글번호에 해당하는 게시글 상세정보 조회하기
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.getBoardByNo(no);
	
	CommentDao commentDao = new CommentDao();
	
	// 해당 게시글의 모든 커멘트목록 조회하기
	List<Comment> commentList = commentDao.getCommentsByBoardNo(no);
	
	// 세션에서 로그인된 사용자 정보 조회하기
	String loginId = (String) session.getAttribute("loginId");
%>
<!doctype html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style type="text/css">
	.btn.btn-xs {--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;}
</style>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="게시글"/>
</jsp:include>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light fs-4 p-2">게시글 상세 정보</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<p>게시글 상세정보를 확인하세요.</p>
			<table class="table table-bordered">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="10%">
					<col width="40%">
				</colgroup>
				<tbody>
					<tr>
						<th class="table-dark">제목</th>
						<td><%=board.getTitle() %></td>
						<th class="table-dark">작성자</th>
						<td><%=board.getCustomer().getName() %></td>
					</tr>
					<tr>
						<th class="table-dark">조회수</th>
						<td><%=board.getReadCnt() %></td>
						<th class="table-dark">댓글갯수</th>
						<td><%=board.getCommentCnt() %></td>
					</tr>
					<tr>
						<th class="table-dark">등록일</th>
						<td><%=board.getCreateDate() %></td>
						<th class="table-dark">최종수정일자</th>
						<td><%=board.getUpdateDate() %></td>
					</tr>
						 <th class="table-dark">첨부파일</th>
	                 	 <td colspan="3">
	                 	 
<% if (board.getFilename() != null) { %>	                 	 
	                 	 
	                 	 <%=board.getOriginalFilename() %>
	                 	 <a href="download?no=<%=board.getNo() %>" class="btn btn-outline-primary btn-xs ms-3">다운로드</a>
	                 	 
<% } %>	                 	 
	                 	 
	                 	 </td>
              		</tr>
					</tr>
						 <th class="table-dark">내용</th>
	                 	 <td colspan="4" style="height: 100px;"><%=board.getContent() %></td>
              		</tr>
				</tbody>
			</table>
			<div class="text-end">

<%  if (board.getCustomer().getId().equals(loginId)) { %>	
		
				<a href="delete.jsp?no=<%=board.getNo() %>" class="btn btn-danger btn-sm">삭제</a>
				<a href="modifyform.jsp?no=<%=board.getNo() %>" class="btn btn-warning btn-sm">수정</a>
			
<% } %>		
			
				<a href="list.jsp" class="btn btn-primary btn-sm">목록</a>
			</div>
		</div>
	</div>
	<div class="row mb-3">
   		<div class="col-12">
			<form class="border bg-light p-2" method="post" action="insertComment.jsp">
				<input type="hidden" name="boardNo" value="<%=board.getNo() %>" />
 				<div class="row">
					<div class="col-11">
						<textarea rows="2" class="form-control" name="content"></textarea>
					</div>
					<div class="col-1">
						<button class="btn btn-outline-primary h-100">등록</button>
					</div>
				</div>
			</form>   	
   		</div>
   	</div>
	<div class="row mb-3">
   		<div class="col-12">
   		
<% for (Comment comment : commentList) { %>   		
   		
   			<div class="border p-2 mb-2">
	   			<div class="d-flex justify-content-between mb-1">
	   				<span><%=comment.getCustomer().getName() %></span> <span class="text-muted"><%=comment.getCreateDate() %></span>
	   			</div>
	   			<div>
	   				<%=comment.getContent() %>
	   				
<%  if (comment.getCustomer().getId().equals(loginId)) { %>	   				
	   				<a href="deleteComment.jsp?no=<%=no %>&cno=<%=comment.getNo() %>" 
	   					class="btn btn-link text-danger text-decoration-none float-end"><i class="bi bi-trash"></i></a>
	   					
<%  } %>	 
	 
	   			</div>   			
   			</div>
   	
<% } %>	   	
   		</div>
   	</div>
</div>
</body>
</html>