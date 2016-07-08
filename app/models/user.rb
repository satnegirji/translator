class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :discussions

  def profile_name
    self[:email] || "Empty"
  end

  def admin?
    self[:admin] || email == "tuomasj@gmail.com"
  end

end
