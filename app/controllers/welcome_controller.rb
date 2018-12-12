class WelcomeController < ApplicationController

  def index
    @borrowers = Member.with_loans.includes('loans')
  end
end
