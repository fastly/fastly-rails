# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
if rails_4?
  Dummy::Application.config.secret_key_base = 'e77943c9d96c3346198a6cd36077fbc6e1a047599fc2cc7d04c77bffe53decb7d9abb99688a285fe28671f5f9c291480672921d56585b5a222cef54d4fae249b'
else
  Dummy::Application.config.secret_token = 'e77943c9d96c3346198a6cd36077fbc6e1a047599fc2cc7d04c77bffe53decb7d9abb99688a285fe28671f5f9c291480672921d56585b5a222cef54d4fae249b'
end
