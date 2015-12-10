require 'test_helper'

class NewsReportsControllerTest < ActionController::TestCase

    def setup
        @admin_user = users( :admin_user )
        @news_report = news_reports( :news_report_1 )
        @test_user = users( :test_user )
    end
    
    # CREATE
    
    test 'should create a new news_report' do
        sign_in_as @admin_user
        assert_difference 'NewsReport.count', 1 do
            post :create, :news_report => { :content => 'Beta.', :title => 'Alpha', :user_id => @admin_user.id }, :format => 'js'
        end
        assert_equal 'Alpha', NewsReport.first.title
    end
    
    test 'should redirect if the signed in user is not an admin' do
        sign_in_as @test_user
        assert_no_difference 'NewsReport.count' do
            post :create, :news_report => { :content => 'Beta.', :title => 'Alpha', :user_id => @admin_user.id }, :format => 'js'
        end
        assert_redirected_to user_path( @test_user.id )
    end
    
    test 'should redirect if no user is signed in' do
        assert_no_difference 'NewsReport.count' do
            post :create, :news_report => { :content => 'Beta.', :title => 'Alpha', :user_id => @admin_user.id }, :format => 'js'
        end
        assert_redirected_to signin_path
    end
    
    test 'should give errors with invalid information' do
        sign_in_as @admin_user
        assert_no_difference 'NewsReport.count' do
            post :create, :news_report => { :content => '', :title => 'Alpha', :user_id => @admin_user.id }, :format => 'js'
        end
        assert_template 'news_reports/_form.html.haml'
    end
    
    # DESTROY
    
    test 'should destroy the news_report' do
        sign_in_as @admin_user
        assert_difference 'NewsReport.count', -1 do
            delete :destroy, :id => @news_report.id
        end
        assert_not NewsReport.exists?( @news_report.id )
    end
    
    test 'should redirect if current_user is not an admin' do
        sign_in_as @test_user
        assert_no_difference 'NewsReport.count' do
            delete :destroy, :id => @news_report.id
        end
        assert_redirected_to user_path( @test_user.id )
    end
    
    # EDIT
    
    test 'should get edit' do
        sign_in_as @admin_user
        get :edit, :id => @news_report.id
        assert_template 'news_reports/edit'
        assert_response :success
    end
end
