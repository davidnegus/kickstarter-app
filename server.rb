require "sinatra"
require "sinatra/activerecord"
require_relative "./lib/kickstarter.rb"

class Server < Sinatra::Base

    enable :sessions

    before do
        puts params
        puts session[:user]
        if session[:user].nil? && request.path != "/users/new"
            
            unless params["name"]
                redirect "/users/new"
            end
        end

    end

    get "/users/new" do
        erb :user
    end

    post "/users" do
        user = User.create(params)
        session[:user] = user #key value pair, a ruby hash
        erb :index, locals: {projects: Project.all}, layout: :layout
    end

    get /\/|\/projects/ do
        erb :index, locals: {projects: Project.all}, layout: :layout
    end

    get "/projects/new" do
        erb :create, layout: :layout
    end

    post "/projects" do
        Project.create(params)
        erb :index, locals: {projects: Project.all}, layout: :layout
    end

    get "/projects/:id/delete" do |id|
        Project.delete(id)
        erb :index, locals: {projects: Project.all}, layout: :layout
    end

    get "/projects/:id/edit" do |id|
        erb :edit, locals: {project: Project.find(id)}, layout: :layout
    end

    post "/projects/:id" do |id|
        project = Project.find(id)
        project.update(params)
        erb :index, locals: {projects: Project.all}, layout: :layout
    end

    get "/projects/:id" do |id|
        project = Project.find(id)
        
        erb :project, locals: {project: Project.find(id)}, layout: :layout
    end

    post "/projects/:id/donate" do |id|
        project = Project.find(id)
        project.pledges.create(user_id: session[:user].id, amount: params["amount"])
        erb :project, locals: {project: project}, layout: :layout
    end

    get "/users/logout" do
        session[:user] = nil
        erb :index, locals: {projects: Project.all}, layout: :layout
    end
end