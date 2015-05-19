require 'test_helper'

class PostsControllerTest < ActionController::TestCase

    def setup
        @post = posts( :post_1 )
        @other_post = posts( :post_4 )
        @test_user = users( :test_user )
    end
    
    test 'should redirect a create action if no user is signed in' do
        assert_no_difference 'Post.count' do
            post :create, :user_id => 2, :post => { :content => 'alpha beta gamma' }
        end
        assert_redirected_to signin_path
    end
    
    test 'should redirect a destroy action if no user is signed in' do
        assert_no_difference 'Post.count' do
            post :destroy, :user_id => 2, :id => @post.id
        end
        assert_redirected_to signin_path
    end
    
    test 'should redirect a destroy action if the user is not the owner' do
        sign_in_as @test_user
        assert_no_difference 'Post.count' do
            delete :destroy, :user_id => 3, :id => @other_post.id
        end
        assert_redirected_to root_path
    end
end
