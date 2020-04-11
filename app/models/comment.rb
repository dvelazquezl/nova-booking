class Comment < ApplicationRecord
  belongs_to :estate

  def isRatingDanger
    self.rating < 5
  end

  def isRatingWarning
    self.rating > 4 && self.rating <8
  end
end
