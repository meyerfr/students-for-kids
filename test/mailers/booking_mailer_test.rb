require 'test_helper'

class BookingMailerTest < ActionMailer::TestCase
  test "sitter_found" do
    mail = BookingMailer.sitter_found
    assert_equal "Sitter found", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "customer_found" do
    mail = BookingMailer.customer_found
    assert_equal "Customer found", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "sitter_thanks" do
    mail = BookingMailer.sitter_thanks
    assert_equal "Sitter thanks", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
