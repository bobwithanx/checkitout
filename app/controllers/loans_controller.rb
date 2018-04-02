class LoansController < ApplicationController
  def index
    @loans = Loan.all
  end

  def destroy
    @loan = Loan.find(params[:id])
    @loan.destroy

    redirect_to loans_path
  end

  def show
    @loan = Loan.find(params[:id])
    render layout: 'modal'
  end


  def undo_link
    view_context.link_to('undo', revert_version_path(@loan.versions.last), :method=> :post)
  end

  def borrow
    @loan = Loan.new
    @loan.member = Member.find(params[:member_id])
    @loan.item = Item.find_by_inventory_tag(params[:inventory_tag])

    if @loan.save
      flash[:success] = "Item borrowed. #{undo_link}"
    else
      flash[:danger] = "Error - item was not assigned."
    end
    redirect_to @loan.member
    # @member = Member.find_by_id_number(params[:search])
  end

  def complete
    @loan = Loan.find(params[:loan_id])
    @loan.returned_at = Time.zone.now

    if @loan.save
      flash[:notice] = "Item returned. #{undo_link}"
    else
      flash[:notice] = "Did not save."
    end
    redirect_to @loan.member

    # @member = Member.find_by_id_number(params[:search])
  end
end
