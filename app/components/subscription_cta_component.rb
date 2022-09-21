class SubscriptionCTAComponent < ApplicationComponent
  private attr_reader :user

  def initialize(user:, developers:)
    @user = user
    @developers = developers
  end

  def developers
    SignificantFigure.new(@developers).rounded
  end

  def render?
    Feature.enabled?(:paywalled_search_results) && !customer?
  end

  def customer?
    Businesses::Permission.new(user&.subscriptions).active_subscription?
  end
end