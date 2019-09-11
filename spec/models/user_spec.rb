require 'rails_helper'

RSpec.describe User, type: :model do
    subject {
    described_class.new(name: "Quoc Anh", email: "anh.truong@ethu-inc.com",
    nickname: "Enthusiastic Gamer",password: "12345678", password_confirmation: "12345678")
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid 
  end
  
  it "doesn't have long name" do
    subject.name = "a" * 51
    expect(subject).not_to be_valid
  end
  
  it "doesn't have long email" do
    subject.email = "a" * 244 + "@example.com"
    expect(subject).not_to be_valid
  end
  
  # it "can validate valid email" do
  #   valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
  #                       first.last@foo.jp alice+bob@baz.cn]
                         
  #   valid_addresses.each do |valid_address|
  #     subject.email = valid_address
  #     expect(subject).to be_valid, "#{valid_address.inspect} should be valid"
  #   end
  # end
  
  it "have unique email address" do
    duplicate_user = subject.dup
    duplicate_user.email = subject.email.upcase

    subject.save
    expect(duplicate_user).not_to be_valid
  end
  
  it "should not have blank password" do
    subject.password = subject.password_confirmation = " " * 8
    expect(subject).not_to be_valid
  end

  it "have minimum password lenght" do
    subject.password = subject.password_confirmation = "a" * 7
    expect(subject).not_to be_valid
  end
  
end