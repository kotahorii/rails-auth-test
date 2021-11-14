class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_api_v1_user!, only: [:create]

  def create
    message = Message.new(
      room_id: message_params[:room_id],
      user_id: current_api_v1_user.id,
      content: message_params[:content]
    )
    room = Room.find(message_params[:room_id])
    if message.save
      render json: room
    else
      render json: {
        status: 400,
        message: "failed to create new message."
      }
    end
  end

  private

  def message_params
    params.permit(:room_id, :content, :user_id)
  end
end
