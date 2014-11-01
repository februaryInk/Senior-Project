require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    test 'should get edit' do
        get :edit, :id => 1
        assert_response :success
    end

    test 'should get index' do
        get :index
        assert_response :success
        assert_select 'title', users_index_title
    end

    test 'should get new' do
        get :new
        assert_response :success
        assert_select 'title', users_new_title
    end

    test 'should get show' do
        get :show, :id => 1
        assert_response :success
        assert_select 'title', users_show_title
    end
end
