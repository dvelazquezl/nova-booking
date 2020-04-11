class CommentsController < ApplicationController
  def save
    if Estate.find(params[:estate_id]).present?
      comments = Comment.new
      comments.save_comment_with(params)
      comments.save!
    end
    redirect_to request.referrer
  end
end
