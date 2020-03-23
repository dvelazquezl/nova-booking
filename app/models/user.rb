class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one :owner

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true, message: 'no es valido, solo debe contener caracteres alfanumericos'
  validates_length_of :username, minimum: 5, maximum: 20
  validate :validate_username
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
  attr_writer :login
  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end
end
