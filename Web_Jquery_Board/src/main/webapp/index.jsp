<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jquery.ajax.dao.CommentDAO"%>
<%@ page import="com.jquery.ajax.dto.CommentDTO"%>
<%@ page import="java.util.List"%>
<%
	int board_id = 1;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CommentLIST</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 데이터 출력
		function PrintData(data){
			$('#container').find("table tr").not(":first").remove();
			$.each(data, function(){
				//console.log(this);
				$('#container').find("table tr:last").after(
					  "<tr>"
					+ " <td>" + this.reply_id + "</td>"
					+ " <td><input type='text' value='" + this.reply_content + "' readonly></td>"
					+ " <td><button id='delBtn' seq='" + this.reply_id +"'>삭제</button></td>"
					+ " <td><button id='updateBtn' seq='" + this.reply_id +"'>수정</button></td>"
					+ "</tr>"
				);
			});
			$('#comment').val();
		}

		// 댓글 출력
		function SelectReply() {
			$.ajax(
				{
					url : "/Web_Jquery_Board/select.reply",
					data : {"board_id" : <%=board_id%>},
					dataType : "JSON",
					success : function(data) {
						PrintData(data);
					},
					error : function(xhr){
						console.log(xhr.status);
					}
				}
			);
		}
		// 처음 화면 실행시 비동기로 리스트 출력
		SelectReply();
		
		// 데이터 추가
		$('#addBtn').on("click", function() {
			if ($.trim($('#reply_content').val()) == "") {
				alert("덧글을 입력하세여");
				$('#reply_content').focus();
				return false;
			}
			
			var data2 = {
				board_id : $("#board_id").html(),
				reply_content : $.trim($('#reply_content').val())
			};

			$.ajax(
				{
					url : "/Web_Jquery_Board/insert.reply",
					dataType : "text",
					async : true,
					type : "POST",
					data : data2,
					success : function(data) {
						SelectReply();
						$('#reply_content').val("");
						$('#reply_content').focus();
					},
					error : function(xhr) {
						console.log(xhr.status);
					}
				}
			);
		});
		
		//데이터 수정 
		$(document).on("click",'#updateBtn',function(){ //메모리 올리고
			const pppce = $(this).parent().prev().prev().children().eq(0); //children() 배열로 들어오니까 자기자신 0인덱스
			if($('#updateBtn').text()=="수정"){
				$(this).text("완료");
				pppce.removeAttr('readonly');
			}else if($('#updateBtn').text()=="완료"){
				$(this).text("수정");
				pppce.attr('readonly','readonly');
				//console.log(pppce.val()); //input태그는 text가 없다.
				let data2 = {reply_id:$(this).attr("seq"), reply_content:pppce.val()}
				$.ajax(
					{
						url:"/Web_Jquery_Board/update.reply",
						data : data2,
						dataType:'text',
						//데이터가 없어도 string으로 나올 수 있기때문에 typeof 찍어보기~
						success:function(data){
							SelectReply();
						},
						error : function(xhr) {
							console.log(xhr.status);
						}
					}
				);
			}
		})
		
		// 댓글 삭제
		$(document).on('click', '#delBtn', function(){
			console.log("삭제 시작");
			$.ajax(
				{
					url:"/Web_Jquery_Board/delete.reply",						
					data : { "reply_id": $(this).attr("seq") },
				 	success : function (data) {
				 		SelectReply();
					},
					error:function(xhr){
						console.log(xhr.status);
					}			
				}
			);
	  	}); 
	});
</script>
</head>
<body>
	<table width="700px" border="1">
		<tr>
			<th width="200px">번호</th>
			<td id="board_id">1</td>
		</tr>
		<tr>
			<th width="200px">제목</th>
			<td>Jquery 종합 과제</td>
		</tr>
		<tr>
			<th width="200px">내용</th>
			<td>MVC 패턴으로 적용시키기</td>
		</tr>
	</table>
	<br>
	<!-- 덧글 입력  -->
	<div>
		<input type="text" name="reply_content" id="reply_content" style="width: 600px;"
			placeholder="덧글을 입력하세요">
		<button id="addBtn">댓글등록</button>
		<br>
		<div id="container">
			<table border="1">
				<tr>
					<td>순번</td>
					<td>내용</td>
					<td>삭제</td>
					<td>수정</td>
				</tr>
			</table>
		</div>
	</div>
	<hr>
	<table id="tbllist" border="1">
	</table>
</body>
</html>










