require 'spec_helper'

describe TrackingController do
  describe "GET #redirect" do
    before do
      Rails.application.load_seed
    end

    context "without user ID tracking" do
      it "returns proper url for Myntra" do
        get :redirect, url: "http://www.myntra.com"
        expect(response).to redirect_to("http://track.in.omgpm.com/?AID=556244&MID=349836&PID=9640&CID=4030497&WID=49514&UID=1&r=http%3A%2F%2Fwww.myntra.com")
      end

      it "returns proper url for Amazon" do
        get :redirect, url: "http://www.amazon.in"
        expect(response).to redirect_to("http://www.amazon.in?tag=rechargery-21")
      end

      it "returns proper url for Flipkart" do
        get :redirect, url: "http://www.flipkart.com"
        expect(response).to redirect_to("http://www.flipkart.com?affid=rohitkuruv&affExtParam1=1")
      end

      it "creates tracker" do
        get :redirect, url: "http://myntra.com"
        expect(Tracking.count).to eq(1)
        expect(Tracking.last.url).to eq("http://myntra.com")
      end

      it "redirects if URL is invalid" do
        get :redirect, url: "http://amazon.com"
        expect(response).to redirect_to(url_for(controller: "users", action: "dashboard", only_path: true))
      end
    end

    context "with user ID tracking" do
      it "returns proper url for Myntra" do
        get :redirect, url: "http://myntra.com", user: 3
        expect(response).to redirect_to("http://track.in.omgpm.com/?AID=556244&MID=349836&PID=9640&CID=4030497&WID=49514&UID=1&r=http%3A%2F%2Fmyntra.com")
      end

      it "returns proper url for Amazon" do
        get :redirect, url: "http://amazon.in", user: 3
        expect(response).to redirect_to("http://amazon.in?tag=rechargery-21")
      end

      it "returns proper url for Flipkart" do
        get :redirect, url: "http://flipkart.com", user: 3
        expect(response).to redirect_to("http://flipkart.com?affid=rohitkuruv&affExtParam1=1")
        get :redirect, url: "http://flipkart.com", user: 3
        expect(response).to redirect_to("http://flipkart.com?affid=rohitkuruv&affExtParam1=2")
      end

      it "creates tracker" do
        get :redirect,url: "http://myntra.com",user: 3
        expect(Tracking.last.url).to eq("http://myntra.com")
        expect(Tracking.count).to eq(1)
        expect(Tracking.last.user_id).to eq(3)
      end

      it "redirects if URL is invalid" do
        get :redirect, url: "http://amazon.com", user: 3
        expect(response).to redirect_to(url_for(:controller => "users", :action => "dashboard", :only_path => true))
      end
    end
  end
end
