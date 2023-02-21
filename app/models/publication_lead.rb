# frozen_string_literal: true

class PublicationLead
  include Mongoid::Document
  include Mongoid::Timestamps

  validates :provider, :message, presence: true

  field :provider, type: String
  field :additional_data, type: Hash
  field :region, type: String
  field :message, type: String
  field :user_data, type: Hash
end
