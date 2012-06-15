require 'active_model'

class Kaui::Bundle < Kaui::Base
  define_attr :account_id
  define_attr :external_key
  define_attr :bundle_id
  has_many :subscriptions, Kaui::Subscription

  def initialize(data = {})
    super(:external_key => data['externalKey'],
          :bundle_id => data['bundleId'],
          :account_id => data['accountId'],
          :subscriptions => data['subscriptions'])
  end
end
