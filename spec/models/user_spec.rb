require 'spec_helper'

describe User do

  before do
    @user = FactoryGirl.create(:user)
  end


  describe "attributes" do

    it "should respond to " do
      expect(@user).to respond_to(:name)
      expect(@user).to respond_to(:email)
      expect(@user).to respond_to(:password_digest)
      expect(@user).to respond_to(:password)
      expect(@user).to respond_to(:password_confirmation)
      expect(@user).to respond_to(:remember_token)
      expect(@user).to respond_to(:authenticate)
      expect(@user).to respond_to(:admin)
    end

    it "should not be valid withouth email" do
      @user.email = " "
      expect(@user).not_to be_valid
    end

    it "should not be valid with a name too long" do
      @user.name = "a" * 51
      expect(@user).not_to be_valid
    end

    it "should not be valid without a correct email" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end

    it  "should be valid with correct email set" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end

    it "should not be valid when email address is already taken" do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      expect(user_with_same_email).not_to be_valid
    end

    it "should not be valid when password is not present" do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
      expect(@user).not_to be_valid
    end

    it "should not be valid when passwords don't match" do
      @user.password_confirmation = "mismatch"
      expect(@user).not_to be_valid
    end

    it "should not be valid with a password that's too short" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user).not_to be_valid
    end

  end

  describe "roles " do

    before do
      @city = FactoryGirl.create(:city)
      super_admin_role = FactoryGirl.create(:role, name: :super_admin)
      local_admin_role = FactoryGirl.create(:role, name: :local_admin)
      @super_admin_user = FactoryGirl.create(:super_admin, role_id: super_admin_role.id)
      @local_admin_user = FactoryGirl.create(:local_admin, role_id: local_admin_role.id)
      FactoryGirl.create(:city_admin, city_id: @city.id, user_id: @local_admin_user.id )
    end

    it "should have the correct roles set" do
      expect(@super_admin_user.super_admin?).to eq(true)
      expect(@local_admin_user.local_admin? @city ).to eq(true)
    end

  end

  describe "return value of authenticate method" do

    before { @user.save }

    let(:found_user) { User.find_by(email: @user.email) }
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it "should authenticate the user" do
      expect(@user).to eq found_user.authenticate(@user.password) 
    end

    it "should not authenticate with invalid password" do
      expect(user_for_invalid_password).to be_false 
    end
  
    it "should have a valid token" do
      @user.save
      expect(@user.remember_token).not_to be_blank 
    end
  end
  


end
