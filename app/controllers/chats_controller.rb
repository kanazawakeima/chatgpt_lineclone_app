class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy ]
  before_action :set_header
  before_action :authenticate_user!

  # GET /chats or /chats.json
  def index
    def index
      @chats = current_user.chats
      @chats = Chat.search(params[:keyword]).order(created_at: :desc)
  end
  end

  # GET /chats/1 or /chats/1.json
  def show
    @comments = @chat.comments
  end

  # GET /chats/new
  def new
    @chat = Chat.new
  end

  # GET /chats/1/edit
  def edit
  end

  # POST /chats or /chats.json
  def create
    if current_user.can_create_chat?
      @chat = current_user.chats.build(chat_params)

      if @chat.save
        redirect_to chat_url(@chat)
      else
        flash.now[:alert] = "タスクの作成に失敗しました"
        render :new
      end
    else
      redirect_to new_team_path, alert: "タスクの作成制限に達しました。サブスクリプションに登録して無制限のタスク作成を利用してください。"
    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    @chat.destroy

    respond_to do |format|
      format.html { redirect_to chats_url, notice: "Chat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    def set_header
      @chats = Chat.all
    end
    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:title)
    end
end
