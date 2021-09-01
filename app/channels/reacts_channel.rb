class ReactsChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_for "all"
  end

  def unsubscribed() end
end
