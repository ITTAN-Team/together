class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :event_users, dependent: :destroy
  has_many :events, through: :event_users

  mount_uploader :image, ImageUploader

  validates :email, {presence: true, uniqueness: true, length: {maximum: 255}}
  validates :encrypted_password, {presence: true, length: {maximum: 255}}
  validates :name, {presence: true, length: {maximum: 255}}

  def self.validateInvitation email
    User.find_by(email: email)
  end
end
