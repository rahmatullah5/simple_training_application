require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "UserMailerView" do
    mail = UserMailer.UserMailerView
    assert_equal "Usermailerview", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
