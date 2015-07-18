require 'test_helper'

class ForumsControllerTest < ActionController::TestCase

    def setup
        @forum = forums( :life_and_stuff )
    end

    test 'should get index' do
        get :index
        assert_response :success
    end

    test "should get show" do
        get :show, :id => @forum.id
        assert_response :success
    end
end
