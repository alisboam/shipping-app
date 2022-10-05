class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: { regular: 0, admin: 1 }

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :regular
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def description
  "#{name} | #{email}"
  end
end
