# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.find(params[:chat_id])
    @comment = @chat.comments.build(comment_params)
    @comment.user = current_user
    @comment.gpt_response = fetch_gpt_response(@comment.content)

    if @comment.save
      redirect_to @chat, notice: 'コメントを投稿しました。'
    else
      redirect_to @chat, alert: 'コメントの投稿に失敗しました。'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def fetch_gpt_response(user_input)
    @content = params[:content]

    response = @client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          messages: [{ role: "user", content: user_input }],
      })

    @chats = response.dig("choices", 0, "message", "content")
  end
end
