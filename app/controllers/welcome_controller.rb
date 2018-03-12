class WelcomeController < ApplicationController
  def index
    @borrowers = Member.where('active_loans_count>0').order(active_loans_count: :desc)
  end
end
