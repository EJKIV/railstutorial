require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = User.create(name: "Test User", email: "test@example.com",
                       password: "foobar", password_confirmation: "foobar")
    mail = UserMailer.account_activation(user)
    assert_equal "Activate Your F#ckton Account", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["jim.kernan@gmail.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

test "password_reset" do
    user = users(:michael)
    user.create_reset_digest
    mail = UserMailer.password_reset(user)
    assert_equal "Hey Forgetful, here is your password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["jim.kernan@gmail.com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
  
end