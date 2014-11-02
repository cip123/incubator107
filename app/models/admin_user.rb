class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :city
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
