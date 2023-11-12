class ChatController < ApplicationController
  def chat
    @user_message = params[:message]
    @chatbot_response = ChatGPTService.new(@user_message).get_response
  end
end
