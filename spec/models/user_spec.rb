require_relative '../spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  describe "validations" do
    it "is invalid without a name" do
      FactoryGirl.build(:user, name: nil).should_not be_valid
    end

    it "is invalid without a password" do
      FactoryGirl.build(:user, password: nil).should_not be_valid
    end

    it "is invalid with weird phone numbers" do
      FactoryGirl.build(:user, phone: "919501499829").should_not be_valid
      FactoryGirl.build(:user, phone: "abcd").should_not be_valid
    end

    it "is invalid with weird phone operators" do
      FactoryGirl.build(:user, phone_operator: -1).should_not be_valid
      FactoryGirl.build(:user, phone_operator: 15).should_not be_valid
    end

    it "is invalid with a weird email address" do
      FactoryGirl.build(:user, email: "rohit").should_not be_valid
    end

    it "has a unique email" do
      FactoryGirl.create(:user, email: "rohitkuruvilla@yahoo.co.in")
      FactoryGirl.build(:user, email: "rohitkuruvilla@yahoo.co.in").should_not be_valid
    end
  end

  describe "instance methods" do
    let(:user) { FactoryGirl.create(:user, password: "secret123") }

    describe "#check_password" do
      it "returns true if password is correct" do
        expect(user.check_password("secret123")).to eq(true)
      end

      it "returns false if password is incorrect" do
        expect(user.check_password("WrongPassword")).to eq(false)
      end
    end

    describe "#reload" do
      it "refreshes user attributes" do
        dup_user = User.find_by_email(user.email)
        dup_user.email = "newemail@gmail.com"
        dup_user.save!
        user = self.user.reload
        expect(user.email).to eq("newemail@gmail.com")
      end

      it "refreshes the password" do
        dup_user = User.find_by_email(user.email)
        dup_user.password = "newpassword"
        dup_user.save!
        user = self.user.reload
        expect(user.check_password("newpassword")).to be_true
      end
    end
  end
end

