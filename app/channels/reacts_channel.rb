class ReactsChannel < ApplicationCable::Channel
  def subscribed
    stream_for "all"
  end

  def unsubscribed() end
end
