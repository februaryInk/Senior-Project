require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase

    def setup
        @admin_user = users( :admin_user )
        @forum = forums( :life_and_stuff )
        @conversation = conversations( :chit_chat )
        @test_user = users( :test_user )
    end
    
    # CREATE
    
    test 'should create a new conversation' do
        sign_in_as @test_user
        assert_difference 'Conversation.count', 1 do
            post :create, :conversation => { :forum_id => @forum.id, :name => 'Test Conversation', :comments_attributes => { '0' => { :content => 'alpha', :user_id => @test_user.id } } }
        end
        assert_equal Comment.last.content, 'alpha'
    end
    
    test 'should create a new comment' do
        sign_in_as @test_user
        assert_difference 'Comment.count', 1 do
            post :create, :conversation => { :forum_id => @forum.id, :name => 'Test Conversation', :comments_attributes => { '0' => { :content => 'alpha', :user_id => @test_user.id } } }
        end
        assert_equal Conversation.last.id, Comment.last.conversation_id
    end
    
    test 'should redirect if a user is not signed in' do
        assert_no_difference 'Comment.count' do
            post :create, :conversation => { :forum_id => @forum.id, :name => 'Test Conversation', :comments_attributes => { '0' => { :content => 'alpha', :user_id => @test_user.id } } }
        end
        assert_redirected_to signin_path
    end
    
    # DESTROY
    
    test 'should delete a conversation' do
        sign_in_as @admin_user
        assert_difference 'Conversation.count', -1 do
            delete :destroy, :forum_id => @conversation.forum_id, :id => @conversation.id
        end
    end
    
    test 'should redirect if the user is not an admin' do
        sign_in_as @test_user
        assert_no_difference 'Conversation.count' do
            delete :destroy, :forum_id => @conversation.forum_id, :id => @conversation.id
        end
        assert_redirected_to user_path( @test_user.id )
    end
    
    # NEW

    test 'should get new' do
        sign_in_as @test_user
        get :new
        assert_response :success
        assert_template 'conversations/new'
        assert_select 'title', conversations_new_title
    end
    
    test 'should redirect if no user is signed in' do
        get :new
        assert_response 302
        assert_redirected_to signin_path
    end
    
    # SHOW

    test 'should get show' do
        get :show, :forum_id => @conversation.forum_id, :id => @conversation.id
        assert_response :success
        assert_template 'conversations/show'
        assert_select 'title', conversations_show_title( @conversation )
    end
end
