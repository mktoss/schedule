class ApplicationController < ActionController::Base
  def home
    render html: "hello world"
  end
end
