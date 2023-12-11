# t.string :username
# t.string :email
# t.string :password_digest

class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
    has_one :client, dependent: :destroy
    has_many :user_service_provider_accesses, dependent: :destroy
    has_many :service_providers, through: :user_service_provider_accesses

    attr_accessor :is_client, :is_service_provider

    validates_uniqueness_of :email
end
