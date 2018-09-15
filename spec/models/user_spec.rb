require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let(:incomplete_user) {User.new(username: '')}

  it "validates presence of username" do
    expect(incomplete_user).not_to be_valid
  end

  it { should validate_presence_of(:username) }

  # let(:incomplete_user1) {User.new(username: 'etre')}
  #
  # it { should validate_uniqueness_of(:username) }
end
