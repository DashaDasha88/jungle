require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'password is required' do
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:password]).to include('can\'t be blank')
    end

    it 'password and password confirmation need to match' do
      user1 = User.new
      user1.first_name = "Joe"
      user1.last_name = "Mama"
      user1.email = "joe@test.com"
      user1.password = "lollipop"
      user1.password_confirmation = "lollipop"
      user1.save

      user2 = User.new
      user2.first_name = "Joe"
      user2.last_name = "House"
      user2.email = "joe@test.com"
      user2.password = "lollipop"
      user2.password_confirmation = "lollylops"
      user2.save

      expect(full_user.password).to eq(full_user.password_confirmation)
      expect(full_user2.password).to_not eq(full_user2.password_confirmation)    
    end

    it 'email is required' do
      user = User.new(email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")

      user.email = 'test@test.com' # valid state
      user.valid?
      expect(user.errors[:email]).not_to include("can't be blank")
    end

    it 'email must be unique' do
      user1 = User.new
      user1.first_name = 'Jim'
      user1.last_name = 'Bob'
      user1.email = 'jim@test.com'
      user1.password = 'bloo'
      user1.password_confirmation = 'bloo'

      user1.save

      user2 = User.new
      user2.first_name = 'Jim'
      user2.last_name = 'Blob'
      user2.email = 'jim@test.com'
      user2.password = 'bloo'
      user2.password_confirmation = 'bloo'

      user2.save
    
      expect(u.errors[:email].first).to eq('email already taken')
    end

    it 'first name is required' do
      user = User.new(first_name: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:first_name]).to include('can\'t be blank')

      user.first_name = 'first_name'
      user.valid?
      expect(user.errors[:first_name]).not_to include("can\t be blank")
    end

    it 'last name is required' do
      user = User.new(last_name: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:last_name]).to include('can\'t be blank')

      user.last_name = 'last_name'
      user.valid?
      expect(user.errors[:last_name]).not_to include("can\t be blank")
    end

    it 'password must have minimum length of 5 charactes' do
      user = User.new
      user.first_name = 'Mary'
      user.last_name = 'Bary'
      user.email = 'mary@test.com'
      user.password = '1234'
      user.password_confirmation = '1234'
      expect(user).to be_invalid
    end
  end

  describe '.authentication_with_credentials' do

    it 'should pass if email and password are valid' do
      user = User.new
      user.first_name = "Joe"
      user.last_name = "Mama"
      user.email = "joe@test.com"
      user.password = "lollipop"
      user.password_confirmation = "lollipop"
      user.save

      valid_user = User.authenticate_with_credentials("joe@test.com", "lollipop")

      expect(valid_user).to eq(user)

    end

    it 'should not pass if email and password are invalid' do
      user = User.new
      user.first_name = "Joe"
      user.last_name = "Mama"
      user.email = "joe@test.com"
      user.password = "lollipop"
      user.password_confirmation = "lollipop"
      user.save

      invalid_user = User.authenticate_with_credentials("jane@test.com", "lollipop")

      expect(invalid_user).to_not eq(user)
    end

    it 'should pass with spaces in the email' do
      user = User.new
      user.first_name = "Joe"
      user.last_name = "Mama"
      user.email = "joe@test.com"
      user.password = "lollipop"
      user.password_confirmation = "lollipop"
      user.save

      valid_user = User.authenticate_with_credentials(" joe@test.com ", "lollipop")

      expect(valid_user).to eq(user)
    end

    if 'should pass with uppsercase letters in the email' do
      user = User.new
      user.first_name = "Joe"
      user.last_name = "Mama"
      user.email = "joe@test.com"
      user.password = "lollipop"
      user.password_confirmation = "lollipop"
      user.save

      valid_user = User.authenticate_with_credentials("JOE@test.com", "lollipop")

      expect(valid_user).to eq(user)
    end

  end

end