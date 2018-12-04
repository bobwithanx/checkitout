class WelcomeController < ApplicationController

  def index
    @borrowers = Member.with_loans
  end
end
