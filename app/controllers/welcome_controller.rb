class WelcomeController < ApplicationController
  def index
    @loans = Loan.active.all
  end
end
