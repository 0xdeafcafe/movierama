class User < BaseModel
  include Ohm::Timestamps

  attribute :name

  # Unique email attribute for the user
  attribute :email
  unique    :email

  # Unique identifier for this user, in the form "{provider}|{provider-id}"
  attribute :uid
  index     :uid
  unique    :uid

  # Session token
  attribute :token
  index     :token

  # Submitted movies
  collection :movies, :Movie
end
