Rails.application.routes.draw do

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api do
    
    namespace :user_management do
      resources :students
      post 'auth/signup', to: 'auth#signup'
      delete 'auth/logout', to: 'auth#logout'
      post 'auth/login', to: 'auth#login'
      post 'auth/getotp', to: 'auth#get_otp'

      post 'auth/sign_up', to: 'students#create'
      post 'auth/get_otp', to: 'students#get_otp'
      put 'students/update', to: 'students#update'
    end

    namespace :meta do
      resources :boards
      resources :grades
      resources :subjects
      resources :chapters
    end

    namespace :content_management do
      resources :contents
      resources :chapter_contents
      resources :pdfs
      resources :videos
      resources :votes
      resources :notes
      resources :student_completes
    end

    namespace :exercise_management do
      resources :exercises
      resources :questions
      resources :attempts
      resources :answers
      post '/get_result', to: 'answers#get_result'
    end

  end
  
  devise_for :students
  post 'api/user_management/auth/login', to: 'doorkeeper/tokens#create'
  post 'api/user_management/auth/logout', to: 'doorkeeper/tokens#revoke'

end
