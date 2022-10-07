class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, format: { with: /.*@sistemadefrete\.com\.br/ }

  enum role: { user: 0, admin: 1 }  
  
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  def description
  "#{name} | #{email}"
  end
end
