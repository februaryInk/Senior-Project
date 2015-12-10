require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
    
    def setup
        @conversation = conversations( :chit_chat )
        @test_user = users( :test_user )
    end
    
    # CREATE
    
    test 'should create a comment' do
        sign_in_as @test_user
        assert_difference 'Comment.count', 1 do
            post :create, :forum_id => @conversation.forum_id, :conversation_id => @conversation.id, :comment => { :content => 'alpha', :conversation_id => @conversation.id, :user_id => @test_user.id }, :format => 'js'
        end
        assert_equal 'alpha', Comment.last.content
    end
    
    test 'should redirect if no user is signed in' do
        assert_no_difference 'Comment.count' do
            post :create, :forum_id => @conversation.forum_id, :conversation_id => @conversation.id, :comment => { :content => 'alpha', :conversation_id => @conversation.id, :user_id => @test_user.id }, :format => 'js'
        end
        assert_redirected_to signin_path
    end
    
    test 'should assert errors with incomplete information' do
        sign_in_as @test_user
        assert_no_difference 'Comment.count' do
            post :create, :forum_id => @conversation.forum_id, :conversation_id => @conversation.id, :comment => { :content => '', :conversation_id => @conversation.id, :user_id => @test_user.id }, :format => 'js'
        end
        assert_template 'comments/_form.html.haml'
    end
end
