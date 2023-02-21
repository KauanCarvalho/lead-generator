# frozen_string_literal: true

class CustomLead
  EMAIL_REGEXP = /\A[a-zA-Z0-9._\+-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]{2,}\z/

  include Mongoid::Document
  include Mongoid::Timestamps

  validates :first_name, :last_name, presence: true
  validates :email, format: { with: EMAIL_REGEXP }, presence: true, uniqueness: true

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
end
