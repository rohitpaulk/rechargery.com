class GoBackToBcryptPasswords < ActiveRecord::Migration
  def change
    User.where.not(:rawpass => nil).each do |user|
      user.password = user.rawpass
      user.save!
    end
  end
end
