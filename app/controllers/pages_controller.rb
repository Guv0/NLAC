class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :instructions ]

  def home
  end

  def instructions
  end

  def image
   send_file "app/assets/images/NLAC.png", type: 'image/png', disposition: 'inline'
  end
end
