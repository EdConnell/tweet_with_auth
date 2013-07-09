get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/tweet' do
  Twitter.update(params[:tweet])
end
