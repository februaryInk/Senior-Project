class UsersController < ApplicationController
    layout 'default.html'
    include AuthorizationFilters
    
    before_action :signed_in_user, :only => [ :destroy, :edit, :index, :update ]
    before_action :admin_user, :only => [ :destroy, :index ]
    before_action :correct_user, :only => [ :edit, :update ]
    
    def create
        @user = User.new( user_params )
        if @user.save
            signin @user
            redirect_to user_url( @user )
        else
            @news_reports = NewsReport.all
            # used redirect_to because render loaded the user stylesheet, 
            # not the core_pages stylesheet. however, redirect_to does 
            # not keep the error messages. pass them via flash.
            redirect_to root_url, :flash => { :user_errors => @user.errors.full_messages }
        end
    end
    
    def destroy
        User.find( params[ :id ] ).destroy
        redirect_to users_url
    end
    
    def edit
        @user = User.find( params[ :id ] )
    end

    def index
        @letter = params[ :letter ] || 'a'
        @users = User.where( "username LIKE :first", :first => "#{ @letter }%" ).order( 'username ASC' ).paginate( :page => params[ :page ] )
    end

    def new
        @user = User.new
    end

    def show
        @account_tab = true
        @user = User.find( params[ :id ] )
    end
    
    def social
        @comments = current_user.comments.order( 'created_at DESC' ).paginate( :page => params[ :page ], :per_page => 7 )
        @conversations = current_user.conversations.order( 'created_at DESC' ).paginate( :page => params[ :page ], :per_page => 7 )
    end
    
    def update
        @user = User.find( params[ :id ] )
        if @user.update_attributes( user_params )
            redirect_to user_url( @user )
        else
            render 'edit'
        end
    end
    
    private
    
        def correct_user
            @user = User.find( params[ :id ] )
            redirect_to( root_url ) unless current_user?( @user )
        end
    
        def user_params
            params.require( :user ).permit( :email, :password, :password_confirmation, :username )
        end
end
