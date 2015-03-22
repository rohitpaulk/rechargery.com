require 'spec_helper'

describe TrackingController do
	describe "GET #redirect" do
		before do
			Store.create(
				:name => "Myntra", 
				:status => 2,
				:tracker_type => 1,
				:tracker_urlidentifier => "myntra.com",
				:tracker_storeurl => "http://www.myntra.com",			
				:tracker_baseurl => "http://track.in.omgpm.com/?AID=556244&MID=349836&PID=9640&CID=4030497&WID=49514",			
				:tracker_deeplinker => "&r=",
				:tracker_afftag => ""
			)
			Store.create(
				:name => "Flipkart", 
				:status => 2,
				:tracker_type => 2,
				:tracker_urlidentifier => "flipkart.com",
				:tracker_storeurl => "http://www.flipkart.com",			
				:tracker_afftag => "&affid=rohitkuruv",			
			)
			Store.create(
				:name => "Amazon", 
				:status => 2,
				:tracker_type => 0,
				:tracker_urlidentifier => "amazon.in",
				:tracker_storeurl => "http://www.amazon.in",			
				:tracker_afftag => "&tag=rechargery-21",			
			)
		end
		context "without user ID tracking" do
			it "returns proper url for Myntra" do
				get :redirect,url: "http://www.myntra.com"
				expect(response).to redirect_to("http://track.in.omgpm.com/?AID=556244&MID=349836&PID=9640&CID=4030497&WID=49514&UID=1&r=http%3A%2F%2Fwww.myntra.com")
			end
			it "returns proper url for Amazon" do
				get :redirect,url: "http://www.amazon.in"
				expect(response).to redirect_to("http://www.amazon.in?tag=rechargery-21")
			end
			it "returns proper url for Flipkart" do
				get :redirect,url: "http://www.flipkart.com"
				expect(response).to redirect_to("http://www.flipkart.com?affid=rohitkuruv&affExtParam1=1")
			end
			it "creates tracker" do
				get :redirect,url: "http://myntra.com"
				expect(Tracking.count).to eq(1)
				expect(Tracking.last.url).to eq("http://myntra.com")
			end
			it "redirects if URL is invalid" do
				get :redirect,url: "http://amazon.com"
				expect(response).to redirect_to(url_for(:controller => "users",:action => "dashboard",:only_path => true))
			end
		end
		context "with user ID tracking" do
			it "returns proper url for Myntra" do
				get :redirect,url: "http://myntra.com",user: 3
				expect(response).to redirect_to("http://track.in.omgpm.com/?AID=556244&MID=349836&PID=9640&CID=4030497&WID=49514&UID=1&r=http%3A%2F%2Fmyntra.com")
			end
			it "returns proper url for Amazon" do
				get :redirect,url: "http://amazon.in",user: 3
				expect(response).to redirect_to("http://amazon.in?tag=rechargery-21")
			end
			it "returns proper url for Flipkart" do
				get :redirect,url: "http://flipkart.com",user: 3
				expect(response).to redirect_to("http://flipkart.com?affid=rohitkuruv&affExtParam1=1")
				get :redirect,url: "http://flipkart.com",user: 3
				expect(response).to redirect_to("http://flipkart.com?affid=rohitkuruv&affExtParam1=2")
			end
			it "creates tracker" do
				get :redirect,url: "http://myntra.com",user: 3
				expect(Tracking.last.url).to eq("http://myntra.com")
				expect(Tracking.count).to eq(1)
				expect(Tracking.last.user_id).to eq(3)
			end
			it "redirects if URL is invalid" do
				get :redirect,url: "http://amazon.com",user: 3
				expect(response).to redirect_to(url_for(:controller => "users",:action => "dashboard",:only_path => true))
			end
		end		
	end
end