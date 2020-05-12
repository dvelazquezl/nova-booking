class CommentsController < ApplicationController

  def index
    @comments = Comment.where(client_email: current_user.try(:email))
                    .paginate(page: params[:page], per_page: 5)
  end

  def save
    if Estate.find(params[:estate_id]).present?
      comments = Comment.new
      comments.save_comment_with(params, current_user.try(:email), current_user.try(:name))
    end
    redirect_to request.referrer
  end
end
