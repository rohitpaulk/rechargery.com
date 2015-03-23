require 'spec_helper'

describe Store do
  it "has a valid factory" do
    expect(FactoryGirl.create(:store)).to be_valid
  end

  describe "validations" do
    it "should not be valid without a name" do
      expect(FactoryGirl.build(:store, name: nil)).to_not be_valid
    end
    it "should not be valid without an image name" do
      expect(FactoryGirl.build(:store, image_name: nil)).to_not be_valid
    end
    it "should not be valid without a urlidentifier" do
      expect(FactoryGirl.build(:store, tracker_urlidentifier: nil)).to_not be_valid
    end
    it "should not be valid without a status" do
      expect(FactoryGirl.build(:store, status: nil)).to_not be_valid
    end

    it "should not be valid with a weird status" do
      expect(FactoryGirl.build(:store, status: 0)).to be_valid
      expect(FactoryGirl.build(:store, status: 2)).to be_valid
      expect(FactoryGirl.build(:store, status: -1)).to_not be_valid
      expect(FactoryGirl.build(:store, status: 3)).to_not be_valid
    end
  end

  describe "class methods" do
    describe "::find_by_slug" do
      before do
        Rails.application.load_seed
      end

      it "Finds a store by the slug" do
        expect(Store.find_by_slug('amazon').name).to eq('Amazon')
        expect(Store.find_by_slug('flipkart').name).to eq('Flipkart')
        expect(Store.find_by_slug('myntra').name).to eq('Myntra')
      end

      it "returns nil if slug isn't found" do
        expect(Store.find_by_slug('abcd')).to be_nil
      end
    end

    describe "::statuskeys" do
      it "returns a valid hash of status keys" do
        expect(Store.statuskeys['Beta']).to eq(1)
        expect(Store.statuskeys['Live']).to eq(2)
      end
    end

    describe "::trackertypes" do
      it "returns a valid hash of tracker types" do
        expect(Store.trackertypes['Amazon']).to eq(0)
        expect(Store.trackertypes['OMGPM']).to eq(1)
        expect(Store.trackertypes['Flipkart']).to eq(2)
      end
    end
  end

  describe "instance methods" do
    describe "#slug" do
      it "strips spaces from store name" do
        store = FactoryGirl.create(:store, name: "Store with spaces")
        expect(store.slug).to eq("store-with-spaces")
      end
    end

    describe "#beta?"
    describe "#timeperiod"

    describe "#get_redirect_url" do
      before do
        Rails.application.load_seed
      end

      it "returns a valid url for Flipkart" do
        flipkart = Store.find_by_slug('flipkart')
        finalurl = flipkart.get_redirect_url('http://www.flipkart.com', 123)
        expect(finalurl).to eq("http://www.flipkart.com?affid=rohitkuruv&affExtParam1=123")
      end

      it "returns a valid url for Amazon" do
        amazon = Store.find_by_slug('amazon')
        finalurl = amazon.get_redirect_url("http://www.amazon.in", 123)
        expect(finalurl).to eq("http://www.amazon.in?tag=rechargery-21")
      end

      it "returns a valid url for Myntra" do
        myntra = Store.find_by_slug('myntra')
        finalurl = myntra.get_redirect_url('http://www.myntra.com', 123)
        expect(finalurl).to eq("http://track.in.omgpm.com/?AID=556244&MID=349836&PID=9640&CID=4030497&WID=49514&UID=123&r=http%3A%2F%2Fwww.myntra.com")
      end
    end
  end
end


