class MixpanelTrackJob
  include SuckerPunch::Job
  def mixpanel
    @mixpanel ||= Mixpanel::Tracker.new(ENV['MIXPANEL_KEY'])
  end
  # The perform method is in charge of our code execution when enqueued.
  def perform(user_id, event, details, ip)
  	mixpanel.track(user_id, event, details,ip) unless Rails.env.test?
  end
end
