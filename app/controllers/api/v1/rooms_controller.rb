class Api::V1::RoomsController < ApplicationController
  before_action :authenticate_api_v1_user!, only: [:index, :create, :show]

  def index
    rooms = current_api_v1_user.rooms
    render json: rooms
  end

  def show
    room = Room.find_by(token: params[:id])
    if room
      render json: {
        id: room.id,
        title: room.title,
        users: room.users,
        messages: room.messages
      }
    else
      render json: {
        status: 404,
        message: "no rooms for the token."
      }
    end
  end

  def create
    room = Room.new(
      title: room_params[:title],
      token: room_params[:token]
    )
    if room.save
        Member.new(
        user_id: current_api_v1_user.id,
        room_id: room.id,
        name: current_api_v1_user.name,
      ).save
        Member.new(
        user_id: room_params[:partner],
        room_id: room.id,
        name: User.find(room_params[:partner]).name,
      ).save
      render json: room
    else
      render json: {
        status: 400,
        message: "failed to create new room."
      }
    end
  end

  private

  def room_params
    params.permit(:title, :token, :partner)
  end
end
