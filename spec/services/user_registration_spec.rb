require 'rails_helper'

RSpec.describe UserRegistration, :type => :service do
  before do
    @auth_hash = {
      'provider' => nil,
      'uid' => '12345',
      'info' => {
        'name' => 'John McFoo',
        'email'=> 'john@example.com'
      }
    }
  end

  describe 'new' do
    it 'should have the correct name' do
      expect(UserRegistration.new(@auth_hash).user.name).to eq (@auth_hash['info']['name'])
    end

    it 'should have the correct email' do
      expect(UserRegistration.new(@auth_hash).user.email).to eq (@auth_hash['info']['email'])
    end
  end
end
