require 'test_helper'

class Admin::NewsReportsControllerTest < ActionController::TestCase

    def setup
        @admin_user = users( :admin_user )
        @news_report = news_reports( :news_report_1 )
        @test_user = users( :test_user )
    end
    
    # CREATE
    
    test 'should create a new news report' do
        sign_in_as_admin @admin_user
        assert_difference 'NewsReport.count', 1 do
            post :create, :news_report => { :content => 'Beta.', :title => 'Alpha' }
        end
        assert_equal 'Alpha', NewsReport.last.title
    end
    
    test 'should redirect from create if the signed in user is not an admin' do
        sign_in_as @test_user
        assert_no_difference 'NewsReport.count' do
            post :create, :news_report => { :content => 'Beta.', :title => 'Alpha' }
        end
        assert_redirected_to admin_signin_path
    end
    
    test 'should redirect from create if no user is signed in' do
        assert_no_difference 'NewsReport.count' do
            post :create, :news_report => { :content => 'Beta.', :title => 'Alpha' }
        end
        assert_redirected_to admin_signin_path
    end
    
    test 'should give errors with invalid create information' do
        sign_in_as_admin @admin_user
        assert_no_difference 'NewsReport.count' do
            post :create, :news_report => { :content => '', :title => 'Alpha' }
        end
        assert_template 'news_reports/_form.html.haml'
    end
    
    # DESTROY
    
    test 'should destroy the news report' do
        sign_in_as_admin @admin_user
        assert_difference 'NewsReport.count', -1 do
            delete :destroy, :id => @news_report.id
        end
        assert_not NewsReport.exists?( @news_report.id )
    end
    
    test 'should redirect from destroy if the signed in user is not an admin' do
        sign_in_as @test_user
        assert_no_difference 'NewsReport.count' do
            post :destroy, :id => @news_report.id
        end
        assert_redirected_to admin_signin_path
    end
    
    test 'should redirect from destroy if no user is signed in' do
        assert_no_difference 'NewsReport.count' do
            post :destroy, :id => @news_report.id
        end
        assert_redirected_to admin_signin_path
    end
    
    # EDIT
    
    test 'should get edit' do
        sign_in_as_admin @admin_user
        get :edit, :id => @news_report.id
        assert_response :success
        assert_template 'news_reports/edit'
    end
    
    test 'should redirect from edit if the signed in user is not an admin' do
        sign_in_as @test_user
        get :edit, :id => @news_report.id
        assert_redirected_to admin_signin_path
    end
    
    test 'should redirect from edit if no user is signed in' do
        get :edit, :id => @news_report.id
        assert_redirected_to admin_signin_path
    end
    
    # INDEX
    
    test 'should get index' do
        sign_in_as_admin @admin_user
        get :index
        assert_response :success
        assert_template 'news_reports/index'
    end
    
    test 'should redirect from index if the signed in user is not an admin' do
        sign_in_as @test_user
        get :index
        assert_redirected_to admin_signin_path
    end
    
    test 'should redirect from index if no user is signed in' do
        get :index
        assert_redirected_to admin_signin_path
    end
    
    # NEW
    
    test 'should get new' do
        sign_in_as_admin @admin_user
        get :new
        assert_response :success
        assert_template 'news_reports/new'
    end
    
    test 'should redirect from new if the signed in user is not an admin' do
        sign_in_as @test_user
        get :new
        assert_redirected_to admin_signin_path
    end
    
    test 'should redirect from new if no user is signed in' do
        get :new
        assert_redirected_to admin_signin_path
    end
    
    # UPDATE
    
    test 'should update the news_report' do
        sign_in_as_admin @admin_user
        post :update, :id => @news_report.id, :news_report => { :title => 'New Title' }
        @news_report.reload
        assert_equal 'New Title', @news_report.title
    end
    
    test 'should redirect from update if the signed in user is not an admin' do
        sign_in_as @test_user
        post :update, :id => @news_report.id, :news_report => { :title => 'New Title' }
        @news_report.reload
        assert_not_equal @news_report.title, 'New Title'
        assert_redirected_to admin_signin_path
    end
    
    test 'should redirect from update if no user is signed in' do
        post :update, :id => @news_report.id, :news_report => { :title => 'New Title' }
        @news_report.reload
        assert_not_equal @news_report.title, 'New Title'
        assert_redirected_to admin_signin_path
    end
    
    test 'should give errors with invalid update information' do
        sign_in_as_admin @admin_user
        post :update, :id => @news_report.id, :news_report => { :title => '' }
        @news_report.reload
        assert_not_equal @news_report.title, ''
        assert_template 'news_reports/_form.html.haml'
    end
end
