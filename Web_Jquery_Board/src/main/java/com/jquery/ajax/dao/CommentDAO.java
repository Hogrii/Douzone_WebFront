package com.jquery.ajax.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jquery.ajax.dto.CommentDTO;
import com.jquery.ajax.utils.ConnectionHelper;

public class CommentDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	// 전체조회
	public List<CommentDTO> selectReply(int board_id) {
		List<CommentDTO> commentlist = new ArrayList<>();
		try {
			conn = ConnectionHelper.getConnection("oracle");
			String sql = "select reply_id, reply_content from reply where board_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setBoard_id(board_id);
				dto.setReply_id(rs.getInt("reply_id"));
				dto.setReply_content(rs.getString("reply_content"));
				commentlist.add(dto);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			ConnectionHelper.close(rs);
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}

		return commentlist;
	}

	// 입력
	public void insertReply(CommentDTO dto) {
		String sql = "insert into reply(board_id, reply_id, reply_content) values(?, reply_id.nextval, ?)";
		try {
			conn = ConnectionHelper.getConnection("oracle");
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getBoard_id());
			pstmt.setString(2, dto.getReply_content());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
	}

	// 수정
	public void updateReply(int reply_id, String reply_content) {
		String sql = "update reply set reply_content = ? where reply_id = ?";

		try {
			conn = ConnectionHelper.getConnection("oracle");
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reply_content);
			pstmt.setInt(2, reply_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
	}

	// 삭제
	public int deleteReply(int reply_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		int num = 0;

		try {
			conn = ConnectionHelper.getConnection("oracle");
			String sql = "delete from reply where reply_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reply_id);

			num = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		return num;
	}
}