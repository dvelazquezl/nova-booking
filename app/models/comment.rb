class Comment < ApplicationRecord
  belongs_to :estate

  def isRatingDanger
    self.rating < 5
  end

  def isRatingWarning
    self.rating > 4 && self.rating <8
  end

  def save_comment_with(params)
    self.description = params[:description]
    self.client_email = params[:client_email]
    self.client_name = params[:client_name]
    self.rating = params[:rating]
    self.estate_id = params[:estate_id]
  end

end
