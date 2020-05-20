class Offer < ApplicationRecord
  extend Enumerize

  belongs_to :estate
  has_many :offer_details, dependent: :destroy
  accepts_nested_attributes_for :offer_details, allow_destroy: true,
                                reject_if: :all_blank
  delegate :name, :to => :estate, :prefix => true
  delegate :images, :to => :estate, :prefix => true

  validates_presence_of :description, :date_start, :date_end, :date_creation

  validate :start_date_cannot_be_in_the_past, :end_date_cannot_be_less_than_start_date

  def start_date_cannot_be_in_the_past
    if !date_start.blank? and date_start < Date.today
      errors.add(:date_start, "can't be in the past")
    end
  end

  def end_date_cannot_be_less_than_start_date
    if !date_end.blank? and !date_start.blank? and date_end < date_start
      errors.add(:date_end, "can't be less than start date")
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
      where("date_end < cast(current_date - interval '1 day' as date)")
    when /^in_progress/
      where("date_end >= cast(current_date - interval '1 day' as date)")
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
