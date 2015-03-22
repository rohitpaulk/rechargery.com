class MixpanelTrackJob
  include SuckerPunch::Job
  def mixpanel
    if Rails.env.production?
      if ENV["STAGING_APP"]=="true"
        @mixpanel ||= Mixpanel::Tracker.new("7f4f23328ed63e8f0483d333de628742")
      else
        @mixpanel ||= Mixpanel::Tracker.new("c4da83b45d7ca8db65855bafd497b54f")
      end
    elsif Rails.env.test?
      @mixpanel ||= Mixpanel::Tracker.new("b4dd9e747f80783b43498da6ecd19beb")
    elsif Rails.env.development?
      @mixpanel ||= Mixpanel::Tracker.new("7f4f23328ed63e8f0483d333de628742")
    end
  end
  # The perform method is in charge of our code execution when enqueued.
  def perform(user_id,event,details,ip)
  	mixpanel.track(user_id,event,details,ip)
  end

end