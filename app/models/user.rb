class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :event_creations, foreign_key: 'administrator_id', class_name: "Event", dependent: :destroy
  has_many :event_attendances, foreign_key: 'attendee_id', class_name: "Attendance", dependent: :destroy
  has_many :events, through: :event_attendances, dependent: :destroy
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
