class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :learn, :about, :shop]
end
