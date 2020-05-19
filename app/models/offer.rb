class Offer < ApplicationRecord
  extend Enumerize

  belongs_to :estate
  has_many :offer_details, dependent: :destroy
  accepts_nested_attributes_for :offer_details, allow_destroy: true,
                                reject_if: :all_blank
  delegate :name, :to => :estate, :prefix => true
  delegate :images, :to => :estate, :prefix => true
  validate :offer_date_range

  def offer_date_range
    offers = OfferDetail.joins(:offer).where("date_start <= ?  AND date_end >= ?",date_start,date_start)
    offers.each do |offer|
      offer_details.each do |offer_detail|
        if(offer_detail.room_id == offer.room_id)
          room = Room.find(offer.room_id).description
          errors.add(room, "ya existe una oferta de esta habitación dentro del rango de fecha")
        end
      end
    end
  end

  enumerize :offer_status, in: [:in_progress, :finished]
  self.per_page = 5

  filterrific(
      available_filters: [
          :search_status
      ]
  )

  scope :search_status, -> (option) {
    case option.to_s
    when /^finished/
      where("date_end < now()")
    when /^in_progress/
      where("date_end >= now()")
    end
  }

  scope :offers_by_owner, -> (current_owner_id) {
    joins(:estate).where('estates.owner_id = ?', current_owner_id)
  }

  def is_available_for?(date_start, date_end)
    (self.date_start..self.date_end).cover?(date_start) or
        (self.date_start..self.date_end).cover?(date_end) or
        ((self.date_start > date_start) and
        (self.date_end < date_end))
  end

  # returns all offers with average discount for each offer details
  scope :offer_with_avg_discount, -> {
    joins(:offer_details)
        .select('offers.*, AVG(offer_details.discount) AS avg_discount')
        .group('offers.id')
        .order('avg_discount desc')
  }

  def set_default_date
    self.date_start = DateTime.now.strftime("%Y-%m-%d")
    self.date_end = DateTime.now.next_day().strftime("%Y-%m-%d")
  end

  #End of offer is within a range of a month Today + 1 month
  def is_available_for_month?
    (self.date_end >= Date.today && self.date_end <= Date.today+31)
  end
end
