class MembersController < ApplicationController
  def index
    @members = Member.all

    # @members = if params[:search]
    #              Member.search(params[:search]).order('created_at DESC')
    #              if !@members.empty? && @members.count == 1
    #                flash.now[:alert] = 'Your book was not found'
    #
    #                # render 'show'
    #                #   @member = Member.find(params[:search])
    #                # else
    #                #   Member.all
    #              end
    #            end
  end

  def show
    set_tab :members
    @member = if params[:search]
                Member.find_by_id_number(params[:search])
              else
                Member.find_by_id params[:id]
              end
    if @member.blank?
      flash[:danger] = "Member ID not found."
      redirect_to(welcome_index_path)
      return
    end
    @loans = @member.loans.order('returned_at, created_at DESC').all
    @loan_dates = @loans.group_by(&:short_date)
  end

  def search
    render 'show'
    # @member = Member.find_by_id_number(params[:search])
  end

  def borrow
    @loan = Loan.new
    @loan.member = Member.find(params[:member_id])
    @loan.item = Item.find_by_inventory_tag(params[:inventory_tag])

    @loan.save
    redirect_to @loan.member
    # @member = Member.find_by_id_number(params[:search])
  end

  def return
    @loan = Loan.find(params[:id])
    @loan.returned_at = Time.now

    loan.save
    render members_index
    # @member = Member.find_by_id_number(params[:search])
  end

  def new
    @member = Member.new
  end

  def edit
    @member = Member.find_by_id params[:id]
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to members_path
    else
      render 'new'
    end
  end

  def update
    @member = Member.find_by_id params[:id]

    if @member.update(member_params)
      redirect_to members_path
    else
      render 'edit'
    end
  end

  def destroy
    @member = Member.find_by_id params[:id]
    @member.destroy

    redirect_to members_path
  end

  private

  def member_params
    params.require(:member).permit(:first_name, :last_name, :id_number, :group, :group_id)
  end
end
