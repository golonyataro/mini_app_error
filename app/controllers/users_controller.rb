class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    @blogs = Blog.where(user_id: current_user.id)
  end
end
