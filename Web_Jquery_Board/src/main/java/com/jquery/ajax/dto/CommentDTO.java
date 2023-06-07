package com.jquery.ajax.dto;

public class CommentDTO {
	
	private int board_id;
	private int reply_id;
	private String reply_content;
	
	
	public CommentDTO() {}

	public CommentDTO(int board_id, int reply_id, String reply_content) {
		super();
		this.board_id = board_id;
		this.reply_id = reply_id;
		this.reply_content = reply_content;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public int getReply_id() {
		return reply_id;
	}

	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
}
