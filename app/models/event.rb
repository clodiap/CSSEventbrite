class Event < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :attendees, class_name: "User", through: :attendances, dependent: :destroy
  belongs_to :administrator, foreign_key: 'administrator_id', class_name: "User"
  validates :start_date, presence: true
  validate :start_date_must_be_in_the_future
  validates :duration, presence: true, numericality: {greater_than: 0, only_integer:true}
  validate :duration_is_multiple_of_five
  validates :title, presence: true, length: { in: 5..140}
  validates :description, presence: true, length: { in: 20..1000}
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 1000, only_integer:true}
  validates :location, presence: true

   def start_date_must_be_in_the_future
    errors.add(:start_date, "must be before end time") unless start_date.present? && self.start_date.to_i > Time.now.to_i
  end

  def duration_is_multiple_of_five
    errors.add(:duration, "must be a multiple of 5") unless self.duration % 5 == 0
  end

  def self.end_date(id)
    self.find(id).start_date + (self.find(id).duration)*60
  end
  
end
