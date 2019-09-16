require "sinatra"
require "sinatra/activerecord"
require_relative "./lib/kickstarter.rb"

class Server < Sinatra::Base

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
end