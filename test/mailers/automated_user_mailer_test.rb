require 'test_helper'

class AutomatedUserMailerTest < ActionMailer::TestCase

    def setup
        test_user = users( :test_user )
    end

    test 'account_activation' do
        test_user = users( :test_user )
        test_user.activation_token = User.create_token
        mail = AutomatedUserMailer.account_activation( test_user )
        assert_equal "#{ site_name } Account Activation", mail.subject
        assert_equal [ test_user.email ], mail.to
        assert_equal [ "#{ site_name.downcase }.com" ], mail.from
        assert_match test_user.username, mail.body.encoded
        assert_match test_user.activation_token, mail.body.encoded
    end

    #test "password_reset" do
    #    mail = AutomatedUserMailer.password_reset
    #    assert_equal "Password reset", mail.subject
    #    assert_equal ["to@example.org"], mail.to
    #    assert_equal ["from@example.com"], mail.from
    #    assert_match "Hi", mail.body.encoded
    #end
end