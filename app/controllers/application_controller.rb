class ApplicationController < ActionController::Base
require "openai"
require 'dotenv'
Dotenv.load

  before_action :set_common_variable

  private

  # APIキーを設定
  def set_common_variable
    @client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])
  end
end