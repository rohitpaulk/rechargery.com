class MixpanelPeopleJob
  include SuckerPunch::Job
  def mixpanel
    @mixpanel ||= Mixpanel::Tracker.new(ENV['MIXPANEL_KEY'])
  end
  # The perform method is in charge of our code execution when enqueued.
  def perform(user_id,details,ip)

  	mixpanel.people.set(user_id,details,ip)
  end
end
