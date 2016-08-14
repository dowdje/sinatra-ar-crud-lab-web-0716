require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    Post.create(name: params[:name], content: params[:content])
    @posts = Post.all
    erb :index
  end

  get '/posts' do
    if params[:message]
      @message = params[:message]
      end 
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do 
    @post = Post.update(params[:id], content: params[:content], name: params[:name])
    redirect to "/posts/#{@post.id}"
  end

  delete '/posts/:id/delete' do 
    @deleted_post = Post.find(params[:id]).name
    Post.destroy(params[:id])
    redirect to "/posts?message=#{@deleted_post}"
  end

  get '/' do 
    @posts = Post.all
    erb :index
  end


end